package test

import (
	"fmt"
	"net/http"
	"os"
	"path/filepath"
	"runtime"
	"strings"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestBranchProtectionRestrictionsVarsIgnored(t *testing.T) {
	// Do not run in parallel to avoid polluting the module cache and fixture

	// Clean local Terraform state to ensure correct module path
	_, filename, _, _ := runtime.Caller(0)
	testDir := filepath.Dir(filename)
	fixtureDir := filepath.Join(testDir, "fixtures", "restrictions_test")
	_ = os.RemoveAll(filepath.Join(fixtureDir, ".terraform"))
	_ = os.RemoveAll(filepath.Join(fixtureDir, ".terraform.lock.hcl"))
	_ = os.RemoveAll(filepath.Join(fixtureDir, ".terraform", "modules"))

	// Explicitly re-initialize Terraform modules after cleaning
	terraformOptionsInit := &terraform.Options{
		TerraformDir: fixtureDir,
		EnvVars: map[string]string{
			"GITHUB_TOKEN": os.Getenv("GITHUB_TOKEN"),
			"GITHUB_OWNER": os.Getenv("GITHUB_OWNER"),
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
	// If an email is provided for GITHUB_OWNER, extract the username (before '@')
	if strings.Contains(owner, "@") {
		parts := strings.SplitN(owner, "@", 2)
		owner = parts[0]
	}

	// Generate a unique repo name using a timestamp
	repoName := "terratest-restrictions-" + fmt.Sprintf("%d", time.Now().Unix())

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

	defer func() {
		_, err := terraform.DestroyE(t, terraformOptions)
		if err != nil {
			if strings.Contains(err.Error(), "Could not resolve to a node with the global id") {
				t.Logf("[WARN] Ignoring destroy error: %v", err)
			} else {
				t.Errorf("Terraform destroy failed: %v", err)
			}
		}
	}()
	// Wait for repo to be fully available using GitHub API before applying (robust polling)
	maxWait := 180 // seconds
	apiUrl := fmt.Sprintf("https://api.github.com/repos/%s/%s", owner, repoName)
	client := &http.Client{Timeout: 5 * time.Second}
	found := false
	var lastStatus int
	var lastBody string
	for i := 0; i < maxWait; i++ {
		resp, err := client.Get(apiUrl)
		if err == nil {
			lastStatus = resp.StatusCode
			body := make([]byte, 4096)
			n, _ := resp.Body.Read(body)
			lastBody = string(body[:n])
			resp.Body.Close()
			if resp.StatusCode == 200 {
				found = true
				break
			}
		}
		if err != nil {
			t.Logf("[DEBUG] Error polling GitHub API: %v", err)
		} else {
			t.Logf("[DEBUG] GitHub API status: %d, body: %s", lastStatus, lastBody)
		}
		t.Logf("Waiting for GitHub repo to be available via API (%d/%d)...", i+1, maxWait)
		time.Sleep(time.Duration(2*i+1) * time.Second) // Exponential-ish backoff
	}
	if !found {
		t.Fatalf("Repository was not available via GitHub API after %d seconds. Last status: %d, body: %s", maxWait, lastStatus, lastBody)
	}

	_, err := terraform.InitAndApplyE(t, terraformOptions)
	if err != nil {
		t.Fatalf("Failed to apply Terraform: %v", err)
	}

	outputRepoName := terraform.Output(t, terraformOptions, "repository_name")
	assert.Equal(t, repoName, outputRepoName)
}
