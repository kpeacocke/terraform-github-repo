package test

import (
	"context"
	"fmt"
	"os"
	"path/filepath"
	"runtime"
	"strings"
	"testing"
	"time"

	"github.com/google/go-github/v55/github"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
	"golang.org/x/oauth2"
)

// TestE2E_GitHubRepoModule performs an end-to-end test by creating a real GitHub repository
// using the module, validating settings, and then destroying it.
func TestE2E_GitHubRepoModule(t *testing.T) {
	t.Parallel()

	// Requirements: set GITHUB_TOKEN and GITHUB_OWNER env vars
	token := os.Getenv("GITHUB_TOKEN")
	if token == "" {
		t.Fatal("GITHUB_TOKEN must be set for E2E tests")
	}
	owner := os.Getenv("GITHUB_OWNER")
	if owner == "" {
		t.Fatal("GITHUB_OWNER must be set for E2E tests")
	}
	// Ensure GITHUB_OWNER is a GitHub username/org, not an email
	if strings.Contains(owner, "@") {
		t.Fatal("GITHUB_OWNER should be a GitHub username or organization, not an email address")
	}

	repoName := fmt.Sprintf("test-repo-%d", time.Now().Unix())

	// Run E2E against the root module
	// Determine root module directory based on this test file location
	_, filename, _, _ := runtime.Caller(0)
	testDir := filepath.Dir(filename)
	rootDir := filepath.Dir(testDir)
	tfOptions := &terraform.Options{
		TerraformDir: rootDir,
		Vars: map[string]interface{}{
			"name":   repoName,
			"owners": []string{owner},
		},
		EnvVars: map[string]string{
			"GITHUB_TOKEN": token,
			"GITHUB_OWNER": owner,
			// Increase Terraform apply parallelism to speed up resource creation
			"TF_CLI_ARGS_apply": "-parallelism=20",
		},
	}

	// Clean up resources
	defer terraform.Destroy(t, tfOptions)

	// Deploy
	_, err := terraform.InitAndApplyE(t, tfOptions)
	require.NoError(t, err, "Terraform apply failed")

	// GitHub client
	ctx := context.Background()
	ts := oauth2.StaticTokenSource(&oauth2.Token{AccessToken: token})
	tc := oauth2.NewClient(ctx, ts)
	client := github.NewClient(tc)

	// Verify token scopes to avoid permission errors
	_, resp, err := client.Users.Get(ctx, "")
	require.NoError(t, err, "Failed to authenticate with GitHub")
	scopes := resp.Response.Header.Get("X-OAuth-Scopes")
	t.Logf("GITHUB_TOKEN scopes: %s", scopes)
	if scopes == "" {
		t.Log("Warning: X-OAuth-Scopes header is empty. Assuming fine-grained PAT; skipping scope check")
	} else {
		require.Contains(t, scopes, "repo", "GITHUB_TOKEN must have 'repo' scope")
		require.Contains(t, scopes, "workflow", "GITHUB_TOKEN must have 'workflow' scope")
	}

	// Verify repository exists
	repo, _, err := client.Repositories.Get(ctx, owner, repoName)
	require.NoError(t, err, "Failed to get repository from GitHub")
	assert.Equal(t, "private", repo.GetVisibility())
	assert.Equal(t, repoName, repo.GetName())

	// Verify branch protection on 'main'
	bp, _, err := client.Repositories.GetBranchProtection(ctx, owner, repoName, "main")
	require.NoError(t, err, "Failed to get branch protection for 'main'")
	assert.True(t, bp.GetEnforceAdmins().Enabled)

	// Verify workflow files exist
	_, files, _, err := client.Repositories.GetContents(ctx, owner, repoName, ".github/workflows", nil)
	require.NoError(t, err, "Failed to list workflow files")
	expected := []string{"build.yml", "ci-enforcement.yml", "release.yml"}
	found := make(map[string]bool)
	for _, f := range files {
		found[f.GetName()] = true
	}
	for _, name := range expected {
		assert.Contains(t, found, name, fmt.Sprintf("Expected workflow %s", name))
	}

	// Verify CODEOWNERS contains the owner
	coFile, _, _, err := client.Repositories.GetContents(ctx, owner, repoName, ".github/CODEOWNERS", nil)
	require.NoError(t, err, "Failed to fetch CODEOWNERS file")
	content, err := coFile.GetContent()
	assert.NoError(t, err)
	assert.Contains(t, content, owner)
}
