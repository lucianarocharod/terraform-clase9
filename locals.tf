locals {
  resource_prefix = "${var.prefix}-${var.location}"
  common_tags = {
    Environment = "clase9"
    ManagedBy   = "Terraform"
    Owner       = var.prefix
  }
}
