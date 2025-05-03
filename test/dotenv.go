package test

import (
	"bufio"
	"log"
	"os"
	"strings"
)

// LoadDotEnv loads environment variables from a .env file in the project root.
func LoadDotEnv() {
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
		os.Setenv(key, value)
	}
	if err := scanner.Err(); err != nil {
		log.Printf("[WARN] Error reading .env file: %v", err)
	}
}
