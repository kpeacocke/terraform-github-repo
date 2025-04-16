# .tflint.hcl
# tflint configuration for this Terraform module
# Customize rules below as needed

# Disable unused declarations rule because module variables may not all be used in all cases
rule "terraform_unused_declarations" {
  enabled = false
}


