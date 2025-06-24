package terraform.guardrails

# 1. S3 must have server-side encryption
deny contains msg if {
    rc := input.resource_changes[_]
    rc.type == "aws_s3_bucket"
    after := rc.change.after
    after != null
    not after.server_side_encryption_configuration
    msg := sprintf("S3 bucket %v must have server-side encryption enabled.", [rc.address])
}

# 2. S3 must not be public-read
deny contains msg if {
    rc := input.resource_changes[_]
    rc.type == "aws_s3_bucket"
    after := rc.change.after
    after != null
    after.acl == "public-read"
    msg := sprintf("S3 bucket %v must not have ACL set to public-read.", [rc.address])
}

# 3. Security group rule must not allow 0.0.0.0/0
deny contains msg if {
    rc := input.resource_changes[_]
    rc.type == "aws_security_group_rule"
    after := rc.change.after
    after != null
    after.cidr_blocks[_] == "0.0.0.0/0"
    msg := sprintf("Security group rule %v must not allow ingress from 0.0.0.0/0.", [rc.address])
}

# 4. IAM users are not allowed
deny contains msg if {
    rc := input.resource_changes[_]
    rc.type == "aws_iam_user"
    after := rc.change.after
    after != null
    msg := sprintf("IAM user %v is not allowed.", [rc.address])
}

# 5. RDS must have storage encryption
deny contains msg if {
    rc := input.resource_changes[_]
    rc.type == "aws_db_instance"
    after := rc.change.after
    after != null
    not after.storage_encrypted
    msg := sprintf("RDS instance %v must have storage encryption enabled.", [rc.address])
}

# 6. S3 must have required tags
deny contains msg if {
    rc := input.resource_changes[_]
    rc.type == "aws_s3_bucket"
    after := rc.change.after
    after != null
    not after.tags
    msg := sprintf("S3 bucket %v must have tags.", [rc.address])
}

deny contains msg if {
    rc := input.resource_changes[_]
    rc.type == "aws_s3_bucket"
    after := rc.change.after
    after != null
    not after.tags.Environment
    msg := sprintf("S3 bucket %v must have an 'Environment' tag.", [rc.address])
}

deny contains msg if {
    rc := input.resource_changes[_]
    rc.type == "aws_s3_bucket"
    after := rc.change.after
    after != null
    not after.tags.Owner
    msg := sprintf("S3 bucket %v must have an 'Owner' tag.", [rc.address])
}

# 7. RDS must have required tags
deny contains msg if {
    rc := input.resource_changes[_]
    rc.type == "aws_db_instance"
    after := rc.change.after
    after != null
    not after.tags
    msg := sprintf("RDS instance %v must have tags.", [rc.address])
}

deny contains msg if {
    rc := input.resource_changes[_]
    rc.type == "aws_db_instance"
    after := rc.change.after
    after != null
    not after.tags.Owner
    msg := sprintf("RDS instance %v must have an 'Owner' tag.", [rc.address])
}

deny contains msg if {
    rc := input.resource_changes[_]
    rc.type == "aws_db_instance"
    after := rc.change.after
    after != null
    not after.tags.Environment
    msg := sprintf("RDS instance %v must have an 'Environment' tag.", [rc.address])
}

# 8. S3 must have versioning enabled
deny contains msg if {
    rc := input.resource_changes[_]
    rc.type == "aws_s3_bucket"
    after := rc.change.after
    after != null
    not after.versioning.enabled
    msg := sprintf("S3 bucket %v must have versioning enabled.", [rc.address])
}

# 9. S3 must not use force_destroy
deny contains msg if {
    rc := input.resource_changes[_]
    rc.type == "aws_s3_bucket"
    after := rc.change.after
    after != null
    after.force_destroy
    msg := sprintf("S3 bucket %v must not have force_destroy set to true.", [rc.address])
}
