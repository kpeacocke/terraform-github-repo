package test

import (
	"fmt"
	"os"
	"path/filepath"
	"runtime"
	"strings"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestMinimalRepo(t *testing.T) {

	token := os.Getenv("GITHUB_TOKEN")
	if token == "" {
		t.Fatal("GITHUB_TOKEN is not set in the environment")
	}

	owner := os.Getenv("GITHUB_OWNER")
	if owner == "" {
		t.Fatal("GITHUB_OWNER is not set in the environment")
	}
	// If an email is provided for GITHUB_OWNER, extract the username (before '@')
	if strings.Contains(owner, "@") {
		parts := strings.SplitN(owner, "@", 2)
		owner = parts[0]
	}

	// Generate a unique repo name using a timestamp
	repoName := "terratest-minimal-" + fmt.Sprintf("%d", time.Now().Unix())

	// Determine fixture directory based on this test file location
	_, filename, _, _ := runtime.Caller(0)
	testDir := filepath.Dir(filename)
	fixtureDir := filepath.Join(testDir, "fixtures", "minimal_repo")
	terraformOptions := &terraform.Options{
		TerraformDir: fixtureDir,
		EnvVars: map[string]string{
			"GITHUB_TOKEN": token,
			"GITHUB_OWNER": owner,
		},
		Vars: map[string]interface{}{
			"name":   repoName,
			"owners": []string{owner},
		},
		MaxRetries:         15,                 // Increase retries for slow API
		TimeBetweenRetries: 15 * 1_000_000_000, // 15 seconds
	}

	defer terraform.Destroy(t, terraformOptions)
	_, err := terraform.InitAndApplyE(t, terraformOptions)
	if err != nil {
		t.Fatalf("Failed to apply Terraform: %v", err)
	}

	outputRepoName := terraform.Output(t, terraformOptions, "repository_name")
	assert.Equal(t, repoName, outputRepoName)
}
