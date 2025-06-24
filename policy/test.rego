package terraform.test

import data.terraform.guardrails
import data.terraform.extra_guardrails

# Test for S3 ACL policy
mock_input := {
    "resource_changes": [
        {
            "address": "aws_s3_bucket.test",
            "type": "aws_s3_bucket",
            "change": {
                "after": {
                    "acl": "public-read",
                    "server_side_encryption_configuration": {
                        "rule": {
                            "apply_server_side_encryption_by_default": {
                                "sse_algorithm": "AES256"
                            }
                        }
                    },
                    "versioning": {
                        "enabled": true
                    },
                    "force_destroy": false,
                    "tags": {
                        "Environment": "dev",
                        "Owner": "DevOps"
                    }
                }
            }
        }
    ]
}

test_s3_acl_violation if {
    # This test specifically checks if our policy correctly flags S3 buckets with public-read ACL
    deny_set := guardrails.deny with input as mock_input
    violations := [msg | msg = deny_set[_]; contains(msg, "public-read")]
    count(violations) > 0
}

test_fixed_s3_acl if {
    # This test checks if fixing the ACL resolves that specific violation
    safe_input := json.patch(mock_input, [{
        "op": "replace", 
        "path": "/resource_changes/0/change/after/acl", 
        "value": "private"
    }])
    
    deny_set := guardrails.deny with input as safe_input
    violations := [msg | msg = deny_set[_]; contains(msg, "public-read")]
    count(violations) == 0
}
