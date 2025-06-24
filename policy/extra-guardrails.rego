package terraform.extra_guardrails

# 1. Enforce minimum Terraform version
deny["Terraform version must be specified in the configuration."] if {
	not input.terraform_version
}

deny[sprintf("Terraform version must be >= 1.3.0, found %v", [input.terraform_version])] if {
	input.terraform_version < "1.3.0"
}

# 2. Require provider version pinning
deny[sprintf("Provider \"%s\" must have a version constraint.", [name])] if {
	some name
	provider := input.provider_versions[name]
	not provider.version
}

deny[sprintf("Provider \"%s\" must not use a wildcard version (*).", [name])] if {
	some name
	input.provider_versions[name] == "*"
}

# 3. Disallow hardcoded secrets
deny[sprintf("Hardcoded secret detected in resource %v via 'password'", [rc.type])] if {
	rc := input.resource_changes[_]
	some k
	val := rc.change.after[k]
	is_string(val)
	contains(lower(k), "password")
}

# 4. Enforce resource naming conventions
deny[sprintf("Resource %v name must include environment (prod/dev/staging)", [rc.type])] if {
	rc := input.resource_changes[_]
	name := rc.change.after.name
	not contains(name, "prod")
	not contains(name, "dev")
	not contains(name, "staging")
}

# 5. Require variable descriptions
deny[sprintf("Variable %v must have a description", [v.name])] if {
	v := input.variables[_]
	not v.description
}

# 6. Restrict use of deprecated or dangerous resources

deny["Use of aws_instance is discouraged; use modules or managed services."] if {
	rc := input.resource_changes[_]
	rc.type == "aws_instance"
}

# 7. Require logging and monitoring

deny[sprintf("S3 bucket of type %v must have logging enabled.", [type])] if {
	rc := input.resource_changes[_]
	rc.type == "aws_s3_bucket"
	not rc.change.after.logging
	type := rc.type
}

deny["RDS instance must have monitoring enabled."] if {
	rc := input.resource_changes[_]
	rc.type == "aws_db_instance"
	not rc.change.after.monitoring_interval
}

# 8. Enforce cost estimation

deny[sprintf("Infracost estimate exceeds $1000: $%v", [input.infracost_total])] if {
	input.infracost_total > 1000
}

# 9. Restrict public IP assignment

deny["EC2 instance must not have a public IP."] if {
	rc := input.resource_changes[_]
	rc.type == "aws_instance"
	rc.change.after.associate_public_ip_address
}

# 10. Require MFA for IAM users/groups

deny[sprintf("IAM user of type %v must have MFA enabled.", [type])] if {
	rc := input.resource_changes[_]
	rc.type == "aws_iam_user"
	not rc.change.after.mfa_enabled
	type := rc.type
}

# 11. Enforce least privilege for IAM policies

deny[sprintf("IAM policy of type %v must not allow Action: *", [type])] if {
	rc := input.resource_changes[_]
	rc.type == "aws_iam_policy"
	contains(rc.change.after.policy, "\"Action\": \"*\"")
	type := rc.type
}

deny[sprintf("IAM policy of type %v must not allow Resource: *", [type])] if {
	rc := input.resource_changes[_]
	rc.type == "aws_iam_policy"
	contains(rc.change.after.policy, "\"Resource\": \"*\"")
	type := rc.type
}

# 12. Require backup/retention policies

deny[sprintf("RDS instance of type %v must have backup retention enabled.", [type])] if {
	rc := input.resource_changes[_]
	rc.type == "aws_db_instance"
	not rc.change.after.backup_retention_period
	type := rc.type
}

# 13. Restrict region usage (configurable)

allow_regions := {"us-east-1", "us-west-2", "eu-west-1"}

deny[sprintf("Region %v is not allowed", [region])] if {
	rc := input.resource_changes[_]
	region := rc.change.after.region
	not allow_regions[region]
}

# 14. Require HTTPS for endpoints

deny[sprintf("Load balancer listener of type %v must use HTTPS.", [type])] if {
	rc := input.resource_changes[_]
	rc.type == "aws_lb_listener"
	rc.change.after.protocol != "HTTPS"
	type := rc.type
}

deny[sprintf("API Gateway of type %v must use EDGE endpoint (HTTPS).", [type])] if {
	rc := input.resource_changes[_]
	rc.type == "aws_api_gateway_stage"
	not rc.change.after.variables.endpoint_type == "EDGE"
	type := rc.type
}

# 15. Disallow inline IAM policies

deny["Inline IAM user policies are not allowed."] if {
	rc := input.resource_changes[_]
	rc.type == "aws_iam_user_policy"
}

deny["Inline IAM role policies are not allowed."] if {
	rc := input.resource_changes[_]
	rc.type == "aws_iam_role_policy"
}