# main.tf — Recursos de infraestructura y configuración del proyecto
 
# ── Configuración de Terraform y providers ──────────────────────
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.0"
}
 
provider "azurerm" {
  features {}
}
 
# ── Resource Group ───────────────────────────────────────────────
resource "azurerm_resource_group" "main" {
  name     = "rg-${local.resource_prefix}"
  location = var.location
  tags     = local.common_tags
}
 
# ── Virtual Network ──────────────────────────────────────────────
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${local.resource_prefix}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = ["10.0.0.0/16"]
  tags                = local.common_tags
}
 
# ── Subnet ───────────────────────────────────────────────────────
resource "azurerm_subnet" "subnet" {
  name                 = "subnet-${local.resource_prefix}"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
 
# ── Network Security Group ────────────────────────────────────────
resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-${local.resource_prefix}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tags                = local.common_tags
 
  security_rule {
    name                       = "Allow-HTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
}
 
# ── Asociar NSG a la Subnet ──────────────────────────────────────
resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
