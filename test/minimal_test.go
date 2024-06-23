package test

import (
	"os"
	"testing"

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

	terraformOptions := &terraform.Options{
		TerraformDir: "../test/fixtures/minimal_repo",
		EnvVars: map[string]string{
			"GITHUB_TOKEN": token,
		},
		Vars: map[string]interface{}{
			"name":         "terratest-minimal",
			"github_owner": owner,
		},
		MaxRetries:         15,                 // Increase retries for slow API
		TimeBetweenRetries: 15 * 1_000_000_000, // 15 seconds
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	repoName := terraform.Output(t, terraformOptions, "repository_name")
	assert.Equal(t, "terratest-minimal", repoName)
}
