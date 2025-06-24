package terraform.test

import rego.v1

import data.terraform.extra_guardrails
import data.terraform.guardrails

# Sample test data
mock_input := {"resource_changes": [{
	"address": "aws_s3_bucket.test",
	"type": "aws_s3_bucket",
	"change": {"after": {
		"acl": "public-read",
		"server_side_encryption_configuration": {"rule": {"apply_server_side_encryption_by_default": {"sse_algorithm": "AES256"}}},
		"versioning": {"enabled": true},
		"force_destroy": false,
		"tags": {
			"Environment": "dev",
			"Owner": "DevOps",
		},
	}},
}]}
