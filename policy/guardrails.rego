package terraform.guardrails

deny[msg] if {
	rc := input.resource_changes[_]
	rc.type == "aws_s3_bucket"
	not rc.change.after.server_side_encryption_configuration
	msg := "S3 bucket must have server-side encryption enabled"
}

deny[msg] if {
	rc := input.resource_changes[_]
	rc.type == "aws_s3_bucket"
	rc.change.after.acl == "public-read"
	msg := "S3 bucket must not be public-read"
}

deny[msg] if {
	rc := input.resource_changes[_]
	rc.type == "aws_security_group_rule"
	rc.change.after.cidr_blocks[_] == "0.0.0.0/0"
	msg := "Security group rule must not allow 0.0.0.0/0"
}

deny[msg] if {
	rc := input.resource_changes[_]
	rc.type == "aws_iam_user"
	msg := "IAM users are not allowed"
}

deny[msg] if {
	rc := input.resource_changes[_]
	rc.type == "aws_db_instance"
	not rc.change.after.storage_encrypted
	msg := "RDS instance must have storage_encrypted=true"
}

deny[msg] if {
	rc := input.resource_changes[_]
	rc.type == "aws_s3_bucket"
	not rc.change.after.tags.Environment
	msg := "S3 bucket must have an 'Environment' tag"
}

deny[msg] if {
	rc := input.resource_changes[_]
	rc.type == "aws_s3_bucket"
	not rc.change.after.tags.Owner
	msg := "S3 bucket must have an 'Owner' tag"
}

deny[msg] if {
	rc := input.resource_changes[_]
	rc.type == "aws_s3_bucket"
	not rc.change.after.tags
	msg := "S3 bucket must have tags"
}

deny[msg] if {
	rc := input.resource_changes[_]
	rc.type == "aws_db_instance"
	not rc.change.after.tags
	msg := "RDS instance must have tags"
}

deny[msg] if {
	rc := input.resource_changes[_]
	rc.type == "aws_db_instance"
	not rc.change.after.tags.Owner
	msg := "RDS instance must have an 'Owner' tag"
}

deny[msg] if {
	rc := input.resource_changes[_]
	rc.type == "aws_db_instance"
	not rc.change.after.tags.Environment
	msg := "RDS instance must have an 'Environment' tag"
}

deny[msg] if {
	rc := input.resource_changes[_]
	rc.type == "aws_s3_bucket"
	not rc.change.after.versioning.enabled
	msg := "S3 bucket must have versioning enabled"
}

deny[msg] if {
	rc := input.resource_changes[_]
	rc.type == "aws_s3_bucket"
	rc.change.after.force_destroy
	msg := "S3 bucket must not have force_destroy=true"
}
