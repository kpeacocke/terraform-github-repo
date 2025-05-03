package test

import (
	"os"
	"path/filepath"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

// State Cleanup Strategy:
// - TestMain ensures all test fixture directories are cleaned before and after test runs
// - Each individual test calls SetupTerraformTest() to clean state and initialize
// - Each test's defer function calls CleanTerraformState() after destroy to ensure cleanup
// This ensures that tests start with a clean slate and don't interfere with each other

// TestMain ensures clean state before and after all tests
func TestMain(m *testing.M) {
	// Clean all known test fixture directories before running tests
	cleanAllTestFixtures()

	// Run tests
	code := m.Run()

	// Clean all known test fixture directories after running tests
	cleanAllTestFixtures()

	os.Exit(code)
}

// cleanAllTestFixtures removes state from all known test fixture directories
func cleanAllTestFixtures() {
	fixtures := []string{
		"fixtures/minimal_repo",
		"fixtures/restrictions_test",
		"../", // Root directory for e2e tests
	}

	for _, fixture := range fixtures {
		if _, err := os.Stat(fixture); err == nil {
			_ = os.RemoveAll(filepath.Join(fixture, ".terraform"))
			_ = os.RemoveAll(filepath.Join(fixture, ".terraform.lock.hcl"))
			_ = os.RemoveAll(filepath.Join(fixture, "terraform.tfstate"))
			_ = os.RemoveAll(filepath.Join(fixture, "terraform.tfstate.backup"))
			_ = os.RemoveAll(filepath.Join(fixture, ".terraform.tfstate.lock.info"))
		}
	}
}

// CleanTerraformState removes any existing Terraform state and cache files
// from the specified directory to ensure tests start with a clean slate
func CleanTerraformState(t *testing.T, terraformDir string) {
	t.Helper()

	// Remove .terraform directory (contains providers, modules, etc.)
	_ = os.RemoveAll(filepath.Join(terraformDir, ".terraform"))

	// Remove .terraform.lock.hcl file
	_ = os.RemoveAll(filepath.Join(terraformDir, ".terraform.lock.hcl"))

	// Remove any state files
	_ = os.RemoveAll(filepath.Join(terraformDir, "terraform.tfstate"))
	_ = os.RemoveAll(filepath.Join(terraformDir, "terraform.tfstate.backup"))

	// Remove any .terraform.tfstate.lock.info files
	_ = os.RemoveAll(filepath.Join(terraformDir, ".terraform.tfstate.lock.info"))

	t.Logf("Cleaned Terraform state in: %s", terraformDir)
}

// SetupTerraformTest prepares a clean Terraform environment for testing
func SetupTerraformTest(t *testing.T, terraformDir string, options *terraform.Options) {
	t.Helper()

	// Clean any existing state
	CleanTerraformState(t, terraformDir)

	// Initialize Terraform
	terraform.Init(t, options)
}
