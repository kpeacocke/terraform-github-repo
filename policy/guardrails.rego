package terraform.guardrails

# 1. S3 must have server-side encryption
deny[sprintf("S3 bucket %v must have server-side encryption enabled.", [rc.address])] if {
	rc := input.resource_changes[_]
	rc.type == "aws_s3_bucket"
	rc.change.after != null
	not rc.change.after.server_side_encryption_configuration
}

# 2. S3 must not be public-read
deny[sprintf("S3 bucket %v must not have ACL set to public-read.", [rc.address])] if {
	rc := input.resource_changes[_]
	rc.type == "aws_s3_bucket"
	rc.change.after != null
	rc.change.after.acl == "public-read"
}

# 3. Security group rule must not allow 0.0.0.0/0
deny[sprintf("Security group rule %v must not allow ingress from 0.0.0.0/0.", [rc.address])] if {
	rc := input.resource_changes[_]
	rc.type == "aws_security_group_rule"
	rc.change.after != null
	rc.change.after.cidr_blocks[_] == "0.0.0.0/0"
}

# 4. IAM users are not allowed
deny[sprintf("IAM user %v is not allowed.", [rc.address])] if {
	rc := input.resource_changes[_]
	rc.type == "aws_iam_user"
	rc.change.after != null
}

# 5. RDS must have storage encryption
deny[sprintf("RDS instance %v must have storage encryption enabled.", [rc.address])] if {
	rc := input.resource_changes[_]
	rc.type == "aws_db_instance"
	rc.change.after != null
	not rc.change.after.storage_encrypted
}

# 6. S3 must have required tags
deny[sprintf("S3 bucket %v must have tags.", [rc.address])] if {
	rc := input.resource_changes[_]
	rc.type == "aws_s3_bucket"
	rc.change.after != null
	not rc.change.after.tags
}

deny[sprintf("S3 bucket %v must have an 'Environment' tag.", [rc.address])] if {
	rc := input.resource_changes[_]
	rc.type == "aws_s3_bucket"
	rc.change.after != null
	not rc.change.after.tags.Environment
}

deny[sprintf("S3 bucket %v must have an 'Owner' tag.", [rc.address])] if {
	rc := input.resource_changes[_]
	rc.type == "aws_s3_bucket"
	rc.change.after != null
	not rc.change.after.tags.Owner
}

# 7. RDS must have required tags
deny[sprintf("RDS instance %v must have tags.", [rc.address])] if {
	rc := input.resource_changes[_]
	rc.type == "aws_db_instance"
	rc.change.after != null
	not rc.change.after.tags
}

deny[sprintf("RDS instance %v must have an 'Owner' tag.", [rc.address])] if {
	rc := input.resource_changes[_]
	rc.type == "aws_db_instance"
	rc.change.after != null
	not rc.change.after.tags.Owner
}

deny[sprintf("RDS instance %v must have an 'Environment' tag.", [rc.address])] if {
	rc := input.resource_changes[_]
	rc.type == "aws_db_instance"
	rc.change.after != null
	not rc.change.after.tags.Environment
}

# 8. S3 must have versioning enabled
deny[sprintf("S3 bucket %v must have versioning enabled.", [rc.address])] if {
	rc := input.resource_changes[_]
	rc.type == "aws_s3_bucket"
	rc.change.after != null
	not rc.change.after.versioning.enabled
}

# 9. S3 must not use force_destroy
deny[sprintf("S3 bucket %v must not have force_destroy set to true.", [rc.address])] if {
	rc := input.resource_changes[_]
	rc.type == "aws_s3_bucket"
	rc.change.after != null
	rc.change.after.force_destroy
}