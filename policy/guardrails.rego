package terraform.guardrails

deny["S3 bucket must have server-side encryption enabled"] if {
	rc := input.resource_changes[_]
	rc.type == "aws_s3_bucket"
	not rc.change.after.server_side_encryption_configuration
}

deny["S3 bucket must not be public-read"] if {
	rc := input.resource_changes[_]
	rc.type == "aws_s3_bucket"
	rc.change.after.acl == "public-read"
}

deny["Security group rule must not allow 0.0.0.0/0"] if {
	rc := input.resource_changes[_]
	rc.type == "aws_security_group_rule"
	rc.change.after.cidr_blocks[_] == "0.0.0.0/0"
}

deny["IAM users are not allowed"] if {
	rc := input.resource_changes[_]
	rc.type == "aws_iam_user"
}

deny["RDS instance must have storage_encrypted=true"] if {
	rc := input.resource_changes[_]
	rc.type == "aws_db_instance"
	not rc.change.after.storage_encrypted
}

deny["S3 bucket must have an 'Environment' tag"] if {
	rc := input.resource_changes[_]
	rc.type == "aws_s3_bucket"
	not rc.change.after.tags.Environment
}

deny["S3 bucket must have an 'Owner' tag"] if {
	rc := input.resource_changes[_]
	rc.type == "aws_s3_bucket"
	not rc.change.after.tags.Owner
}

deny["S3 bucket must have tags"] if {
	rc := input.resource_changes[_]
	rc.type == "aws_s3_bucket"
	not rc.change.after.tags
}

deny["RDS instance must have tags"] if {
	rc := input.resource_changes[_]
	rc.type == "aws_db_instance"
	not rc.change.after.tags
}

deny["RDS instance must have an 'Owner' tag"] if {
	rc := input.resource_changes[_]
	rc.type == "aws_db_instance"
	not rc.change.after.tags.Owner
}

deny["RDS instance must have an 'Environment' tag"] if {
	rc := input.resource_changes[_]
	rc.type == "aws_db_instance"
	not rc.change.after.tags.Environment
}

deny["S3 bucket must have versioning enabled"] if {
	rc := input.resource_changes[_]
	rc.type == "aws_s3_bucket"
	not rc.change.after.versioning.enabled
}

deny["S3 bucket must not have force_destroy=true"] if {
	rc := input.resource_changes[_]
	rc.type == "aws_s3_bucket"
	rc.change.after.force_destroy
}
