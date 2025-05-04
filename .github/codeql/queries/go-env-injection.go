package main

import (
	"os"
	"os/exec"
)

func main() {
	testEnvInjection()
}

// Test case for env injection detection
func testEnvInjection() {
	userInput := os.Getenv("USER_INPUT")
	cmd := exec.Command("sh", "-c", "echo "+userInput)
	_ = cmd.Run()
}
