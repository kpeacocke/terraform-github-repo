package terraform.extra_guardrails

# 1. Enforce minimum Terraform version

deny[msg] if {
	not input.terraform_version
	msg := "Terraform version must be specified in the configuration."
}

deny[msg] if {
	input.terraform_version < "1.3.0"
	msg := sprintf("Terraform version must be >= 1.3.0, found %v", [input.terraform_version])
}

# 2. Require provider version pinning
# Deny if any provider has no version constraint
deny[msg] if {
	provider := input.provider_versions[_]
	not provider.version
	msg := sprintf("Provider \"%s\" must have a version constraint.", [provider.name])
}

# Deny if any provider uses a wildcard version
deny[msg] if {
	some provider
	input.provider_versions[provider] == "*"
	msg := sprintf("Provider \"%s\" must not use a wildcard version (*).", [provider])
}

# 3. Disallow hardcoded secrets
# Disallow hardcoded passwords

deny[msg] if {
	rc := input.resource_changes[_]
	some k
	val := rc.change.after[k]
	is_string(val)
	contains(val, "password")
	msg := sprintf("Hardcoded secret detected in resource %v via 'password'", [rc.type])
}

# Disallow hardcoded tokens

deny[msg] if {
	rc := input.resource_changes[_]
	some k
	val := rc.change.after[k]
	is_string(val)
	contains(val, "token")
	msg := sprintf("Hardcoded secret detected in resource %v via 'token'", [rc.type])
}

# Disallow hardcoded generic secrets

deny[msg] if {
	rc := input.resource_changes[_]
	some k
	val := rc.change.after[k]
	is_string(val)
	contains(val, "secret")
	msg := sprintf("Hardcoded secret detected in resource %v via 'secret'", [rc.type])
}

# 4. Enforce resource naming conventions

deny[msg] if {
	rc := input.resource_changes[_]
	name := rc.change.after.name
	not contains(name, "prod")
	not contains(name, "dev")
	not contains(name, "staging")
	msg := sprintf("Resource %v name must include environment (prod/dev/staging)", [rc.type])
}

# 5. Require variable descriptions

deny[msg] if {
	v := input.variables[_]
	not v.description
	msg := sprintf("Variable %v must have a description", [v.name])
}

# 6. Restrict use of deprecated or dangerous resources

deny[msg] if {
	rc := input.resource_changes[_]
	rc.type == "aws_instance"
	msg := "Use of aws_instance is discouraged; use modules or managed services."
}

# 7. Require logging and monitoring

deny[msg] if {
	rc := input.resource_changes[_]
	rc.type == "aws_s3_bucket"
	not rc.change.after.logging
	msg := "S3 bucket must have logging enabled."
}

deny[msg] if {
	rc := input.resource_changes[_]
	rc.type == "aws_db_instance"
	not rc.change.after.monitoring_interval
	msg := "RDS instance must have monitoring enabled."
}

# 8. Enforce cost estimation

deny[msg] if {
	msg := sprintf("Infracost estimate exceeds $1000: $%v", [input.infracost_total])
}

# 9. Restrict public IP assignment

deny[msg] if {
	rc := input.resource_changes[_]
	rc.type == "aws_instance"
	rc.change.after.associate_public_ip_address
	msg := "EC2 instance must not have a public IP."
}

# 10. Require MFA for IAM users/groups

deny[msg] if {
	rc := input.resource_changes[_]
	rc.type == "aws_iam_user"
	not rc.change.after.mfa_enabled
	msg := "IAM user must have MFA enabled."
}

# 11. Enforce least privilege for IAM policies

deny[msg] if {
	rc := input.resource_changes[_]
	rc.type == "aws_iam_policy"
	contains(rc.change.after.policy, "\"Action\": \"*\"")
	msg := "IAM policy must not allow Action: *"
}

deny[msg] if {
	rc := input.resource_changes[_]
	rc.type == "aws_iam_policy"
	contains(rc.change.after.policy, "\"Resource\": \"*\"")
	msg := "IAM policy must not allow Resource: *"
}

# 12. Require backup/retention policies

deny[msg] if {
	rc := input.resource_changes[_]
	rc.type == "aws_db_instance"
	not rc.change.after.backup_retention_period
	msg := "RDS instance must have backup retention enabled."
}

# 13. Restrict region usage (configurable)
allow_regions := {"us-east-1", "us-west-2", "eu-west-1"}

deny[msg] if {
	rc := input.resource_changes[_]
	region := rc.change.after.region
	not allow_regions[region]
	msg := sprintf("Region %v is not allowed", [region])
}

# 14. Require HTTPS for endpoints

deny[msg] if {
	rc := input.resource_changes[_]
	rc.type == "aws_lb_listener"
	rc.change.after.protocol != "HTTPS"
	msg := "Load balancer listener must use HTTPS."
}

deny[msg] if {
	rc := input.resource_changes[_]
	rc.type == "aws_api_gateway_stage"
	not rc.change.after.variables.endpoint_type == "EDGE"
	msg := "API Gateway must use EDGE endpoint (HTTPS)."
}

# 15. Disallow inline IAM policies

deny[msg] if {
	rc := input.resource_changes[_]
	rc.type == "aws_iam_user_policy"
	msg := "Inline IAM user policies are not allowed."
}

deny[msg] if {
	rc := input.resource_changes[_]
	rc.type == "aws_iam_role_policy"
	msg := "Inline IAM role policies are not allowed."
}
