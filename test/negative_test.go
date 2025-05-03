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

// Test that the CodeQL workflow is not created when enable_codeql is false

func TestDisableCodeQLWorkflow(t *testing.T) {
	_ = godotenv.Load()
	token := os.Getenv("GITHUB_TOKEN")
	if token == "" {
		t.Fatal("GITHUB_TOKEN is not set in the environment")
	}
	owner := os.Getenv("GITHUB_OWNER")
	if owner == "" {
		t.Fatal("GITHUB_OWNER is not set in the environment")
	}
	if strings.Contains(owner, "@") {
		parts := strings.SplitN(owner, "@", 2)
		owner = parts[0]
	}
	repoName := fmt.Sprintf("terratest-disable-codeql-%d-%d", time.Now().Unix(), time.Now().Nanosecond())

	_, filename, _, _ := runtime.Caller(0)
	fixtureDir := filepath.Join(filepath.Dir(filename), "fixtures", "minimal_repo")

	terraformOptions := &terraform.Options{
		TerraformDir: fixtureDir,
		EnvVars: map[string]string{
			"GITHUB_TOKEN": token,
			"GITHUB_OWNER": owner,
		},
		Vars: map[string]interface{}{
			"name":          repoName,
			"owners":        []string{owner},
			"languages":     []string{"go"},
			"enable_codeql": false,
			"github_token":  token,
			"github_owner":  owner,
		},
	}

	// Clean state and initialize Terraform
	SetupTerraformTest(t, fixtureDir, terraformOptions)

	// Now plan immediately without polling
	planOutput, err := terraform.PlanE(t, terraformOptions)
	assert.NoError(t, err, "Expected terraform plan to succeed")
	// Ensure the CodeQL workflow resource is not in the plan output
	assert.NotContains(t, planOutput, "github_repository_file.codeql_workflow", "Expected no CodeQL workflow when enable_codeql is false")
}

// Test that invalid visibility causes Terraform validation to fail
func TestInvalidVisibility(t *testing.T) {
	token := os.Getenv("GITHUB_TOKEN")
	if token == "" {
		t.Fatal("GITHUB_TOKEN is not set in the environment")
	}
	owner := os.Getenv("GITHUB_OWNER")
	if owner == "" {
		t.Fatal("GITHUB_OWNER is not set in the environment")
	}
	if strings.Contains(owner, "@") {
		parts := strings.SplitN(owner, "@", 2)
		owner = parts[0]
	}
	repoName := fmt.Sprintf("terratest-invalid-visibility-%d-%d", time.Now().Unix(), time.Now().Nanosecond())

	_, filename, _, _ := runtime.Caller(0)
	fixtureDir := filepath.Join(filepath.Dir(filename), "fixtures", "minimal_repo")

	terraformOptions := &terraform.Options{
		TerraformDir: fixtureDir,
		EnvVars: map[string]string{
			"GITHUB_TOKEN": token,
			"GITHUB_OWNER": owner,
		},
		Vars: map[string]interface{}{
			"name":         repoName,
			"owners":       []string{owner},
			"visibility":   "foobar",
			"github_token": token,
			"github_owner": owner,
		},
	}

	// Expect an error during init or apply due to validation
	// Clean state and setup, but expect failure
	CleanTerraformState(t, filepath.Join(filepath.Dir(filename), "fixtures", "minimal_repo"))
	_, err := terraform.InitAndApplyE(t, terraformOptions)
	assert.Error(t, err, "Expected error when using invalid visibility value")
}
