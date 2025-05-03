package test

import (
	"io/ioutil"
	"os"
	"path/filepath"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestBranchProtectionRestrictionsBlockFails(t *testing.T) {
	// Do not run in parallel to avoid polluting the module cache and fixture

	t.Skip("Skipping branch protection restrictions tests for now")
	token := os.Getenv("GITHUB_TOKEN")
	if token == "" {
		t.Fatal("GITHUB_TOKEN is not set in the environment")
	}

	owner := os.Getenv("GITHUB_OWNER")
	if owner == "" {
		t.Fatal("GITHUB_OWNER is not set in the environment")
	}

	// Copy the module directory to a temp dir
	tempDir, err := ioutil.TempDir("", "github-repo-module-")
	if err != nil {
		t.Fatalf("Failed to create temp dir: %v", err)
	}
	defer os.RemoveAll(tempDir)

	srcDir := "../modules/github-repo"
	err = copyDir(srcDir, tempDir)
	if err != nil {
		t.Fatalf("Failed to copy module dir: %v", err)
	}

	// Uncomment the restrictions block in the copied main.tf
	mainPath := filepath.Join(tempDir, "main.tf")
	input, err := os.ReadFile(mainPath)
	if err != nil {
		t.Fatalf("Failed to read copied main.tf: %v", err)
	}
	content := string(input)
	uncommented := strings.Replace(content,
		"# restrictions {", "restrictions {", 1)
	uncommented = strings.Replace(uncommented,
		"#   users = var.branch_protection_users", "  users = var.branch_protection_users", 1)
	uncommented = strings.Replace(uncommented,
		"#   teams = var.branch_protection_teams", "  teams = var.branch_protection_teams", 1)
	uncommented = strings.Replace(uncommented,
		"#   apps  = var.branch_protection_apps", "  apps  = var.branch_protection_apps", 1)
	uncommented = strings.Replace(uncommented,
		"# }", "}", 1)
	err = os.WriteFile(mainPath, []byte(uncommented), 0644)
	if err != nil {
		t.Fatalf("Failed to write uncommented main.tf: %v", err)
	}

	// Update the test fixture to point to the temp module dir
	fixturePath := "../test/fixtures/restrictions_test/main.tf"
	fixtureInput, err := os.ReadFile(fixturePath)
	if err != nil {
		t.Fatalf("Failed to read fixture file: %v", err)
	}
	fixtureContent := strings.Replace(string(fixtureInput),
		"source = \"../../../modules/github-repo\"",
		"source = \""+mainPath[:len(mainPath)-7]+"\"", // remove /main.tf
		1)
	tempFixture := fixturePath + ".temp"
	err = os.WriteFile(tempFixture, []byte(fixtureContent), 0644)
	if err != nil {
		t.Fatalf("Failed to write temp fixture file: %v", err)
	}
	defer os.Remove(tempFixture)

	terraformOptions := &terraform.Options{
		TerraformDir: "../test/fixtures/restrictions_test",
		EnvVars: map[string]string{
			"GITHUB_TOKEN": token,
		},
		Vars: map[string]interface{}{
			"name":  "terratest-restrictions-fail",
			"owner": owner,
			// Set restriction vars to trigger the block
			"branch_protection_users": []string{"octocat"},
			"branch_protection_teams": []string{"my-team"},
			"branch_protection_apps":  []string{"my-app"},
		},
		MaxRetries:         15,                 // Increase retries for slow API
		TimeBetweenRetries: 15 * 1_000_000_000, // 15 seconds
	}

	// Move the temp fixture into place
	backupFixture := fixturePath + ".bak"
	os.Rename(fixturePath, backupFixture)
	os.Rename(tempFixture, fixturePath)
	defer func() {
		os.Rename(fixturePath, tempFixture)
		os.Rename(backupFixture, fixturePath)
	}()

	// Run Terraform and expect failure
	_, err = terraform.InitAndApplyE(t, terraformOptions)
	assert.Error(t, err, "Terraform should fail when restrictions block is uncommented")
}

// Helper to copy a directory recursively
func copyDir(src string, dst string) error {
	entries, err := ioutil.ReadDir(src)
	if err != nil {
		return err
	}
	for _, entry := range entries {
		srcPath := filepath.Join(src, entry.Name())
		dstPath := filepath.Join(dst, entry.Name())
		if entry.IsDir() {
			if err := os.MkdirAll(dstPath, entry.Mode()); err != nil {
				return err
			}
			if err := copyDir(srcPath, dstPath); err != nil {
				return err
			}
		} else {
			if err := copyFile(srcPath, dstPath, entry.Mode()); err != nil {
				return err
			}
		}
	}
	return nil
}

// Helper to copy a single file
func copyFile(srcPath, dstPath string, mode os.FileMode) error {
	data, err := os.ReadFile(srcPath)
	if err != nil {
		return err
	}
	if err := os.WriteFile(dstPath, data, mode); err != nil {
		return err
	}
	return nil
}
