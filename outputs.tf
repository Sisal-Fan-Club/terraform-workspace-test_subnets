output "private_subnet" {
  value = local.private_subnet
  
  sensitive = true
}

output "dmz_subnet" {
  value = local.dmz_subnet
  
  sensitive = true
}
