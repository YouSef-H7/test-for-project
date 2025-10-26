output "appgw_id" {
  description = "The ID of the Application Gateway"
  value       = azurerm_application_gateway.appgw.id
}

output "appgw_public_ip" {
  description = "The public IP address of the Application Gateway"
  value       = azurerm_public_ip.appgw_pip.ip_address
}
