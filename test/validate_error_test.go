package test

import (
	"encoding/json"
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

func TestMissingOwnersVariableError(t *testing.T) {
	_ = godotenv.Load()
	// Temporarily move any tfvars files so 'owners' is truly missing
	modulePath, err := filepath.Abs("..")
	if err != nil {
		t.Fatalf("failed to get absolute path: %s", err)
	}

	tfvarsFiles := []string{
		filepath.Join(modulePath, "terraform.tfvars"),
		filepath.Join(modulePath, "test/fixtures/minimal_repo/github.auto.tfvars"),
	}
	var movedFiles []string
	for _, tfvarsPath := range tfvarsFiles {
		backup := tfvarsPath + ".bak"
		if _, err := exec.Command("test", "-f", tfvarsPath).Output(); err == nil {
			if err := exec.Command("mv", tfvarsPath, backup).Run(); err != nil {
				t.Fatalf("failed to move %s: %s", tfvarsPath, err)
			}
			movedFiles = append(movedFiles, tfvarsPath)
		}
	}
	defer func() {
		for _, tfvarsPath := range movedFiles {
			backup := tfvarsPath + ".bak"
			_ = exec.Command("mv", backup, tfvarsPath).Run()
		}
	}()
	// Initialize without backend
	cmdInit := exec.Command("terraform", "init", "-backend=false")
	cmdInit.Dir = modulePath
	out, err := cmdInit.CombinedOutput()
	if err != nil {
		t.Fatalf("terraform init failed: %s\nOutput: %s", err, string(out))
	}
	// Validate in JSON format
	cmdVal := exec.Command("terraform", "validate", "-json")
	cmdVal.Dir = modulePath
	outV, err := cmdVal.CombinedOutput()
	if err == nil {
		t.Fatalf("expected terraform validate to fail due to missing owners, but it passed. Output: %s", string(outV))
	}
	var vo ValidateOutput
	if err := json.Unmarshal(outV, &vo); err != nil {
		t.Fatalf("failed to parse terraform validate JSON output: %s\nOutput: %s", err, string(outV))
	}
	found := false
	for _, diag := range vo.Diagnostics {
		if diag.Severity == "error" && strings.Contains(diag.Summary, "owners") {
			found = true
			break
		}
	}
	if !found {
		t.Errorf("expected an error about missing required variable 'owners', got diagnostics: %+v", vo.Diagnostics)
	}
}
