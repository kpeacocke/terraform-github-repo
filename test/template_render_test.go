package test

import (
	"fmt"
	"os"
	"path/filepath"
	"strings"
	"testing"
	"text/template"

	"github.com/Masterminds/sprig/v3"
)

func mockFuncMap() template.FuncMap {
	return template.FuncMap{
		"matrix": func(args ...interface{}) map[string]interface{} {
			return map[string]interface{}{"language": []string{"go", "python"}}
		},
		"secrets": func(args ...interface{}) map[string]interface{} {
			return map[string]interface{}{"GITHUB_TOKEN": "dummy-token"}
		},
		"github": func(args ...interface{}) map[string]interface{} {
			return map[string]interface{}{
				"event": map[string]interface{}{
					"pull_request": map[string]interface{}{
						"base": map[string]interface{}{"sha": "dummysha"},
					},
					"sha": "dummysha",
				},
			}
		},
	}
}

func renderTemplate(t *testing.T, tmplPath string, data interface{}) string {
	tmplName := filepath.Base(tmplPath)
	tmplContent, err := os.ReadFile(tmplPath)
	if err != nil {
		t.Fatalf("Failed to read template %s: %v", tmplPath, err)
	}
	tmpl, err := template.New(tmplName).
		Funcs(sprig.TxtFuncMap()).
		Funcs(mockFuncMap()).
		Parse(string(tmplContent))
	if err != nil {
		t.Fatalf("Failed to parse template %s: %v", tmplPath, err)
	}
	var sb strings.Builder
	err = tmpl.Execute(&sb, data)
	if err != nil {
		t.Fatalf("Failed to render template %s: %v", tmplPath, err)
	}
	return sb.String()
}

func TestPrintWorkingDirectory(t *testing.T) {
	dir, err := os.Getwd()
	if err != nil {
		t.Fatalf("Failed to get working directory: %v", err)
	}
	fmt.Println("Current working directory:", dir)
}

func TestRenderDependabotTemplate(t *testing.T) {
	path := filepath.Join("..", "templates", ".github", "workflows", "dependabot.yml.tmpl")
	output := renderTemplate(t, path, map[string]interface{}{})
	if !strings.Contains(output, "updates:") {
		t.Error("Rendered dependabot.yml missing 'updates:' block")
	}
	if !strings.Contains(output, "package-ecosystem: \"github-actions\"") {
		t.Error("Rendered dependabot.yml missing 'package-ecosystem: \"github-actions\"'")
	}
}

func TestRenderCodeQLTemplate(t *testing.T) {
	path := filepath.Join("..", "templates", ".github", "workflows", "codeql.yml.tmpl")
	output := renderTemplate(t, path, map[string]interface{}{"languages": []string{"go", "python"}})
	if !strings.Contains(output, "jobs:") {
		t.Error("Rendered codeql.yml missing 'jobs:' block")
	}
	if !strings.Contains(output, "CodeQL Analysis") {
		t.Error("Rendered codeql.yml missing 'CodeQL Analysis' job name")
	}
}

func TestRenderCIEnforcementTemplate(t *testing.T) {
	path := filepath.Join("..", "templates", ".github", "workflows", "ci-enforcement.yml.tmpl")
	output := renderTemplate(t, path, map[string]interface{}{})
	if !strings.Contains(output, "jobs:") {
		t.Error("Rendered ci-enforcement.yml missing 'jobs:' block")
	}
	if !strings.Contains(output, "ci-enforcement:") {
		t.Error("Rendered ci-enforcement.yml missing 'ci-enforcement:' job")
	}
}
