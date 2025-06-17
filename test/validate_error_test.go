package test

import (
	"encoding/json"
	"fmt"
	"os/exec"
	"path/filepath"
	"strings"
	"testing"

	"github.com/joho/godotenv"
)

type ValidateOutput struct {
	Diagnostics []struct {
		Severity string `json:"severity"`
		Summary  string `json:"summary"`
		Detail   string `json:"detail"`
	} `json:"diagnostics"`
}

type PlanLogEntry struct {
	Level      string `json:"@level"`
	Message    string `json:"@message"`
	Diagnostic struct {
		Severity string `json:"severity"`
		Summary  string `json:"summary"`
		Detail   string `json:"detail"`
	} `json:"diagnostic"`
	Type string `json:"type"`
}

// Helper function to temporarily move tfvars files
func backupTfvarsFiles(modulePath string) ([]string, error) {
	tfvarsFiles := []string{
		filepath.Join(modulePath, "terraform.tfvars"),
		filepath.Join(modulePath, "test/fixtures/minimal_repo/github.auto.tfvars"),
	}
	var movedFiles []string
	for _, tfvarsPath := range tfvarsFiles {
		backup := tfvarsPath + ".bak"
		if _, err := exec.Command("test", "-f", tfvarsPath).Output(); err == nil {
			if err := exec.Command("mv", tfvarsPath, backup).Run(); err != nil {
				return movedFiles, err
			}
			movedFiles = append(movedFiles, tfvarsPath)
		}
	}
	return movedFiles, nil
}

// Helper function to restore backed up files
func restoreTfvarsFiles(movedFiles []string) {
	for _, tfvarsPath := range movedFiles {
		backup := tfvarsPath + ".bak"
		_ = exec.Command("mv", backup, tfvarsPath).Run()
	}
}

// Helper function to run terraform init
func runTerraformInit(modulePath string) error {
	cmdInit := exec.Command("terraform", "init", "-backend=false")
	cmdInit.Dir = modulePath
	out, err := cmdInit.CombinedOutput()
	if err != nil {
		return fmt.Errorf("terraform init failed: %s\nOutput: %s", err, string(out))
	}
	return nil
}

// Helper function to run terraform plan and get diagnostics
func getTerraformPlanDiagnostics(modulePath string) ([]struct {
	Severity string `json:"severity"`
	Summary  string `json:"summary"`
	Detail   string `json:"detail"`
}, error) {
	cmdVal := exec.Command("terraform", "plan", "-json")
	cmdVal.Dir = modulePath
	outV, err := cmdVal.CombinedOutput()
	if err == nil {
		return nil, fmt.Errorf("expected terraform plan to fail due to missing owners, but it passed. Output: %s", string(outV))
	}

	return parseTerraformDiagnostics(string(outV))
}

// Helper function to parse terraform diagnostics from NDJSON output
func parseTerraformDiagnostics(output string) ([]struct {
	Severity string `json:"severity"`
	Summary  string `json:"summary"`
	Detail   string `json:"detail"`
}, error) {
	var diagnostics []struct {
		Severity string `json:"severity"`
		Summary  string `json:"summary"`
		Detail   string `json:"detail"`
	}

	lines := strings.Split(output, "\n")
	for _, line := range lines {
		line = strings.TrimSpace(line)
		if line == "" {
			continue
		}
		var entry PlanLogEntry
		if err := json.Unmarshal([]byte(line), &entry); err != nil {
			continue // Skip lines that aren't JSON
		}
		if entry.Type == "diagnostic" && entry.Diagnostic.Severity == "error" {
			diagnostics = append(diagnostics, struct {
				Severity string `json:"severity"`
				Summary  string `json:"summary"`
				Detail   string `json:"detail"`
			}{
				Severity: entry.Diagnostic.Severity,
				Summary:  entry.Diagnostic.Summary,
				Detail:   entry.Diagnostic.Detail,
			})
		}
	}
	return diagnostics, nil
}

// Helper function to check if diagnostics contain owners error
func hasOwnersError(diagnostics []struct {
	Severity string `json:"severity"`
	Summary  string `json:"summary"`
	Detail   string `json:"detail"`
}) bool {
	for _, diag := range diagnostics {
		if diag.Severity == "error" && (strings.Contains(diag.Summary, "owners") || strings.Contains(diag.Detail, "owners")) {
			return true
		}
	}
	return false
}

func TestMissingOwnersVariableError(t *testing.T) {
	_ = godotenv.Load()

	modulePath, err := filepath.Abs("..")
	if err != nil {
		t.Fatalf("failed to get absolute path: %s", err)
	}

	// Temporarily move tfvars files so 'owners' is truly missing
	movedFiles, err := backupTfvarsFiles(modulePath)
	if err != nil {
		t.Fatalf("failed to backup tfvars files: %s", err)
	}
	defer restoreTfvarsFiles(movedFiles)

	// Initialize terraform
	if err := runTerraformInit(modulePath); err != nil {
		t.Fatal(err)
	}

	// Get diagnostics from terraform plan
	diagnostics, err := getTerraformPlanDiagnostics(modulePath)
	if err != nil {
		t.Fatal(err)
	}

	// Check if owners error is present
	if !hasOwnersError(diagnostics) {
		t.Errorf("expected an error about missing required variable 'owners', got diagnostics: %+v", diagnostics)
	}
}
