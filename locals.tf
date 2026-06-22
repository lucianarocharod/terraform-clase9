# locals.tf — Valores calculados internamente por Terraform
locals {
  # Prefijo único que combina las variables — se usa en todos los nombres
  resource_prefix = "clase9-${var.prefix}-${var.location}"

  # Tags que se aplican a todos los recursos del proyecto
  common_tags = {
    Environment = "clase9"
    ManagedBy   = "Terraform"
    Owner       = var.prefix
  }
}
