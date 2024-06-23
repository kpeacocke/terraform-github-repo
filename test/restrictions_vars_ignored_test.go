package test

import (
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestBranchProtectionRestrictionsVarsIgnored(t *testing.T) {
	// Do not run in parallel to avoid polluting the module cache and fixture

	// Clean the .terraform directory, .terraform.lock.hcl, and .terraform/modules to ensure the correct module is used
	testDir := "../test/fixtures/restrictions_test"
	_ = os.RemoveAll(testDir + "/.terraform")
	_ = os.RemoveAll(testDir + "/.terraform.lock.hcl")
	_ = os.RemoveAll(testDir + "/.terraform/modules")

	// Explicitly re-initialize Terraform modules after cleaning
	terraformOptionsInit := &terraform.Options{
		TerraformDir: "../test/fixtures/restrictions_test",
		EnvVars: map[string]string{
			"GITHUB_TOKEN": os.Getenv("GITHUB_TOKEN"),
		},
	}
	terraform.Init(t, terraformOptionsInit)

	token := os.Getenv("GITHUB_TOKEN")
	if token == "" {
		t.Fatal("GITHUB_TOKEN is not set in the environment")
	}

	owner := os.Getenv("GITHUB_OWNER")
	if owner == "" {
		t.Fatal("GITHUB_OWNER is not set in the environment")
	}

	terraformOptions := &terraform.Options{
		TerraformDir: "../test/fixtures/restrictions_test",
		EnvVars: map[string]string{
			"GITHUB_TOKEN": token,
		},
		Vars: map[string]interface{}{
			"name":  "terratest-restrictions",
			"owner": owner,
			// Set restriction vars, but they should be ignored since block is commented out
			"branch_protection_users": []string{"octocat"},
			"branch_protection_teams": []string{"my-team"},
			"branch_protection_apps":  []string{"my-app"},
		},
		MaxRetries:         15,                 // Increase retries for slow API
		TimeBetweenRetries: 15 * 1_000_000_000, // 15 seconds
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	repoName := terraform.Output(t, terraformOptions, "repository_name")
	assert.Equal(t, "terratest-restrictions", repoName)
}
