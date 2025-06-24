package terraform.extra_guardrails

import rego.v1

# 1. Enforce minimum Terraform version
deny contains msg if {
	not input.terraform_version
	msg := "Terraform version must be specified in the configuration."
}

deny contains msg if {
	input.terraform_version < "1.3.0"
	msg := sprintf("Terraform version must be >= 1.3.0, found %v", [input.terraform_version])
}

# 2. Require provider version pinning
deny contains msg if {
	some name
	provider := input.provider_versions[name]
	not provider.version
	msg := sprintf("Provider \"%s\" must have a version constraint.", [name])
}

deny contains msg if {
	some name
	input.provider_versions[name] == "*"
	msg := sprintf("Provider \"%s\" must not use a wildcard version (*).", [name])
}

# 3. Disallow hardcoded secrets
deny contains msg if {
	rc := input.resource_changes[_]
	some k
	val := rc.change.after[k]
	is_string(val)
	contains(lower(k), "password")
	msg := sprintf("Hardcoded secret detected in resource %v via 'password'", [rc.type])
}

# 4. Enforce resource naming conventions
deny contains msg if {
	rc := input.resource_changes[_]
	name := rc.change.after.name
	not contains(name, "prod")
	not contains(name, "dev")
	not contains(name, "staging")
	msg := sprintf("Resource %v name must include environment (prod/dev/staging)", [rc.type])
}

# 5. Require variable descriptions
deny contains msg if {
	v := input.variables[_]
	not v.description
	msg := sprintf("Variable %v must have a description", [v.name])
}

# 6. Restrict use of deprecated or dangerous resources

deny contains msg if {
	rc := input.resource_changes[_]
	rc.type == "aws_instance"
	msg := "Use of aws_instance is discouraged; use modules or managed services."
}

# 7. Require logging and monitoring

deny contains msg if {
	rc := input.resource_changes[_]
	rc.type == "aws_s3_bucket"
	not rc.change.after.logging
	type := rc.type
	msg := sprintf("S3 bucket of type %v must have logging enabled.", [type])
}

deny contains msg if {
	rc := input.resource_changes[_]
	rc.type == "aws_db_instance"
	not rc.change.after.monitoring_interval
	msg := "RDS instance must have monitoring enabled."
}

# 8. Enforce cost estimation

deny contains msg if {
	input.infracost_total > 1000
	msg := sprintf("Infracost estimate exceeds $1000: $%v", [input.infracost_total])
}

# 9. Restrict public IP assignment

deny contains msg if {
	rc := input.resource_changes[_]
	rc.type == "aws_instance"
	rc.change.after.associate_public_ip_address
	msg := "EC2 instance must not have a public IP."
}

# 10. Require MFA for IAM users/groups

deny contains msg if {
	rc := input.resource_changes[_]
	rc.type == "aws_iam_user"
	not rc.change.after.mfa_enabled
	type := rc.type
	msg := sprintf("IAM user of type %v must have MFA enabled.", [type])
}

# 11. Enforce least privilege for IAM policies

deny contains msg if {
	rc := input.resource_changes[_]
	rc.type == "aws_iam_policy"
	contains(rc.change.after.policy, "\"Action\": \"*\"")
	type := rc.type
	msg := sprintf("IAM policy of type %v must not allow Action: *", [type])
}

deny contains msg if {
	rc := input.resource_changes[_]
	rc.type == "aws_iam_policy"
	contains(rc.change.after.policy, "\"Resource\": \"*\"")
	type := rc.type
	msg := sprintf("IAM policy of type %v must not allow Resource: *", [type])
}

# 12. Require backup/retention policies

deny contains msg if {
	rc := input.resource_changes[_]
	rc.type == "aws_db_instance"
	not rc.change.after.backup_retention_period
	type := rc.type
	msg := sprintf("RDS instance of type %v must have backup retention enabled.", [type])
}

# 13. Restrict region usage (configurable)

allow_regions := {"us-east-1", "us-west-2", "eu-west-1"}

deny contains msg if {
	rc := input.resource_changes[_]
	region := rc.change.after.region
	not allow_regions[region]
	msg := sprintf("Region %v is not allowed", [region])
}

# 14. Require HTTPS for endpoints

deny contains msg if {
	rc := input.resource_changes[_]
	rc.type == "aws_lb_listener"
	rc.change.after.protocol != "HTTPS"
	type := rc.type
	msg := sprintf("Load balancer listener of type %v must use HTTPS.", [type])
}

deny contains msg if {
	rc := input.resource_changes[_]
	rc.type == "aws_api_gateway_stage"
	not rc.change.after.variables.endpoint_type == "EDGE"
	type := rc.type
	msg := sprintf("API Gateway of type %v must use EDGE endpoint (HTTPS).", [type])
}

# 15. Disallow inline IAM policies

deny contains msg if {
	rc := input.resource_changes[_]
	rc.type == "aws_iam_user_policy"
	msg := "Inline IAM user policies are not allowed."
}

deny contains msg if {
	rc := input.resource_changes[_]
	rc.type == "aws_iam_role_policy"
	msg := "Inline IAM role policies are not allowed."
}
