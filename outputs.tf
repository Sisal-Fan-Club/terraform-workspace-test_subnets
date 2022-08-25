output "app_subnet" {
  value = local.app_subnet
  
  sensitive = true
}

output "dmz_subnet" {
  value = local.dmz_subnet
  
  sensitive = true
}
