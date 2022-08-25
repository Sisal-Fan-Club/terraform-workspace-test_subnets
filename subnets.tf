locals {
  test_compartment = local.tfe_workspace_outputs.test_compartment.test_compartment
  
  vcn = local.tfe_workspace_outputs.vcn.vcn
  dmz_route_table = local.tfe_workspace_outputs.vcn.dmz_route_table
  app_route_table = local.tfe_workspace_outputs.vcn.app_route_table
  
  app_subnet = oci_core_subnet.app_subnet
  dmz_subnet = oci_core_subnet.dmz_subnet
}

resource "oci_core_subnet" "app_subnet" {
  compartment_id = local.test_compartment.id
  vcn_id = local.vcn.id
  
  display_name = "Application Network - Test Environment"
  cidr_block = "10.0.10.0/24"
  prohibit_internet_ingress = true
  route_table_id = local.app_route_table.id
  
  freeform_tags = merge({
    security-profile = "app"
    
  }, local.vcn.freeform_tags, local.test_compartment.freeform_tags )
}

resource "oci_core_subnet" "dmz_subnet" {
  compartment_id = local.test_compartment.id
  vcn_id = local.vcn.id
  
  display_name = "DMZ - Test Environment"
  cidr_block = "10.0.100.0/24"
  prohibit_internet_ingress = false
  route_table_id = local.dmz_route_table.id
  
  freeform_tags = merge({
    security-profile = "dmz"
    
  }, local.vcn.freeform_tags, local.test_compartment.freeform_tags )
}
