package test

import (
	"bufio"
	"log"
	"os"
	"strings"
)

// LoadDotEnv loads environment variables from a .env file in the project root.
// This function will not override environment variables that are already set.
func LoadDotEnv() {
	// First check if file exists
	if _, err := os.Stat(".env"); os.IsNotExist(err) {
		log.Printf("[INFO] No .env file found. Using existing environment variables.")
		return
	}

	file, err := os.Open(".env")
	if err != nil {
		log.Printf("[WARN] Could not open .env file: %v", err)
		return
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		line := strings.TrimSpace(scanner.Text())
		if line == "" || strings.HasPrefix(line, "#") {
			continue
		}
		parts := strings.SplitN(line, "=", 2)
		if len(parts) != 2 {
			continue
		}
		key := strings.TrimSpace(parts[0])
		value := strings.Trim(strings.TrimSpace(parts[1]), `"`)
		
		// Only set if not already present in environment
		if os.Getenv(key) == "" {
			os.Setenv(key, value)
		}
	}
	if err := scanner.Err(); err != nil {
		log.Printf("[WARN] Error reading .env file: %v", err)
	}
}
