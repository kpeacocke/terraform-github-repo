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
	"github.com/joho/godotenv"
	"github.com/stretchr/testify/assert"
)

func TestMinimalRepo(t *testing.T) {
	_ = godotenv.Load()

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
	repoName := fmt.Sprintf("terratest-minimal-%d-%d", time.Now().Unix(), time.Now().Nanosecond())

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
			"name":         repoName,
			"owners":       []string{owner},
			"github_token": token,
			"github_owner": owner,
		},
		MaxRetries:         20,               // Increase retries for slow API
		TimeBetweenRetries: 20 * time.Second, // 20 seconds
	}

	// Clean state and initialize Terraform
	SetupTerraformTest(t, fixtureDir, terraformOptions)

	defer func() {
		_, err := terraform.DestroyE(t, terraformOptions)
		if err != nil {
			if strings.Contains(err.Error(), "Could not resolve to a node with the global id") {
				t.Logf("[WARN] Ignoring destroy error: %v", err)
			} else {
				t.Errorf("Terraform destroy failed: %v", err)
			}
		}
		// Clean up state files after destroy
		CleanTerraformState(t, fixtureDir)
	}()

	// Now apply Terraform and verify output
	_, err := terraform.ApplyE(t, terraformOptions)
	if err != nil {
		t.Fatalf("Failed to apply Terraform: %v", err)
	}
	outputRepoName := terraform.Output(t, terraformOptions, "repository_name")
	assert.Equal(t, repoName, outputRepoName)
}
