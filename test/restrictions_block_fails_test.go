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

func TestVariableValidationFailures(t *testing.T) {
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

	// Test cases for different validation failures
	testCases := []struct {
		name           string
		vars           map[string]interface{}
		expectedError  string
		description    string
	}{
		{
			name: "empty_owners_list",
			vars: map[string]interface{}{
				"name":         fmt.Sprintf("test-empty-owners-%d", time.Now().Unix()),
				"owners":       []string{}, // Empty list should fail validation
				"github_token": token,
				"github_owner": owner,
			},
			expectedError: "Missing required variable 'owners'",
			description:   "Should fail when owners list is empty",
		},
		{
			name: "invalid_visibility",
			vars: map[string]interface{}{
				"name":         fmt.Sprintf("test-invalid-vis-%d", time.Now().Unix()),
				"owners":       []string{owner},
				"visibility":   "internal", // Invalid visibility
				"github_token": token,
				"github_owner": owner,
			},
			expectedError: "Visibility must be either 'private' or 'public'",
			description:   "Should fail when visibility is not private or public",
		},
		{
			name: "invalid_license",
			vars: map[string]interface{}{
				"name":         fmt.Sprintf("test-invalid-license-%d", time.Now().Unix()),
				"owners":       []string{owner},
				"license":      "LGPL", // Invalid license
				"github_token": token,
				"github_owner": owner,
			},
			expectedError: "License must be one of: MIT, Apache-2.0, GPL-3.0, BSD-3-Clause, MPL-2.0",
			description:   "Should fail when license is not in the allowed list",
		},
	}

	for _, tc := range testCases {
		t.Run(tc.name, func(t *testing.T) {
			// Create a unique test directory for this subtest  
			_, filename, _, _ := runtime.Caller(0)
			testDir := filepath.Dir(filename)
			fixtureDir := filepath.Join(testDir, "fixtures", "minimal_repo")

			terraformOptions := &terraform.Options{
				TerraformDir: fixtureDir,
				EnvVars: map[string]string{
					"GITHUB_TOKEN": token,
					"GITHUB_OWNER": owner,
				},
				Vars: tc.vars,
			}

			// Clean state and initialize
			SetupTerraformTest(t, fixtureDir, terraformOptions)

			// Run terraform plan and expect it to fail with validation error
			_, err := terraform.PlanE(t, terraformOptions)
			assert.Error(t, err, tc.description)

			// Check that the error contains the expected validation message
			if err != nil {
				assert.Contains(t, err.Error(), tc.expectedError, 
					"Expected validation error message not found. Got: %s", err.Error())
			}
		})
	}
}

func TestSuccessfulValidation(t *testing.T) {
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

	// Test that valid configuration passes validation
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
			"name":         fmt.Sprintf("test-valid-config-%d", time.Now().Unix()),
			"owners":       []string{owner},
			"visibility":   "private",    // Valid visibility
			"license":      "MIT",        // Valid license
			"github_token": token,
			"github_owner": owner,
		},
	}

	// Clean state and initialize
	SetupTerraformTest(t, fixtureDir, terraformOptions)

	// Run terraform plan and expect it to succeed
	_, err := terraform.PlanE(t, terraformOptions)
	assert.NoError(t, err, "Valid configuration should pass validation")
}
