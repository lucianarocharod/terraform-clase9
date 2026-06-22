# outputs.tf — Información que Terraform muestra al terminar apply
 
output "resource_group_name" {
  description = "Nombre del Resource Group creado"
  value       = azurerm_resource_group.main.name
}
 
output "vnet_name" {
  description = "Nombre de la Virtual Network"
  value       = azurerm_virtual_network.vnet.name
}
 
output "subnet_id" {
  description = "ID completo de la subnet en Azure"
  value       = azurerm_subnet.subnet.id
}
 
output "nsg_id" {
  description = "ID del Network Security Group"
  value       = azurerm_network_security_group.nsg.id
}
