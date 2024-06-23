package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestMinimalRepo(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir: "../test/fixtures/minimal_repo",
		EnvVars: map[string]string{
			"GITHUB_TOKEN": "your_token_here",
		},
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	repoName := terraform.Output(t, terraformOptions, "repository_name")
	assert.Equal(t, "terratest-minimal", repoName)
}
