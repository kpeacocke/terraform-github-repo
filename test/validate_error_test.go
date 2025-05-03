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
	// Plan instead of validate to trigger variable validation
	cmdVal := exec.Command("terraform", "plan", "-json")
	cmdVal.Dir = modulePath
	outV, err := cmdVal.CombinedOutput()
	if err == nil {
		t.Fatalf("expected terraform plan to fail due to missing owners, but it passed. Output: %s", string(outV))
	}
	var vo ValidateOutput
	// Parse NDJSON (line-delimited JSON) from terraform plan
	lines := strings.Split(string(outV), "\n")
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
			vo.Diagnostics = append(vo.Diagnostics, struct {
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
	found := false
	for _, diag := range vo.Diagnostics {
		if diag.Severity == "error" && (strings.Contains(diag.Summary, "owners") || strings.Contains(diag.Detail, "owners")) {
			found = true
			break
		}
	}
	if !found {
		t.Errorf("expected an error about missing required variable 'owners', got diagnostics: %+v", vo.Diagnostics)
	}
}
