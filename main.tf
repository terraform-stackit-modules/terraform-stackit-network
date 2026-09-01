resource "stackit_network" "this" {
  project_id                = var.project_id
  name                      = var.name
  dhcp                      = var.dhcp
  ipv4_gateway              = var.ipv4_gateway
  ipv4_nameservers          = var.ipv4_nameservers
  ipv4_prefix               = var.ipv4_prefix
  ipv4_prefix_length        = var.ipv4_prefix_length
  ipv4_vpc_network_range_id = var.ipv4_vpc_network_range_id
  ipv6_gateway              = var.ipv6_gateway
  ipv6_nameservers          = var.ipv6_nameservers
  ipv6_prefix               = var.ipv6_prefix
  ipv6_prefix_length        = var.ipv6_prefix_length
  ipv6_vpc_network_range_id = var.ipv6_vpc_network_range_id
  labels                    = var.labels
  no_ipv4_gateway           = var.no_ipv4_gateway
  no_ipv6_gateway           = var.no_ipv6_gateway
  region                    = var.region
  routed                    = var.routed
  routing_table_id          = var.routing_table_id
  vpc_id                    = var.vpc_id
}

resource "stackit_security_group" "this" {
  count = var.create_security_group ? 1 : 0

  project_id  = var.project_id
  region      = var.region
  name        = coalesce(var.security_group_name, "${var.name}-sg")
  description = var.security_group_description
  stateful    = var.security_group_stateful
  labels      = var.labels
}

resource "stackit_security_group_rule" "this" {
  for_each = var.create_security_group ? {
    for idx, rule in var.security_group_rules : "${rule.direction}-${idx}" => rule
  } : {}

  project_id               = var.project_id
  region                   = var.region
  security_group_id        = stackit_security_group.this[0].security_group_id
  direction                = each.value.direction
  ether_type               = each.value.ether_type
  ip_range                 = each.value.ip_range
  remote_security_group_id = each.value.remote_security_group_id

  protocol        = each.value.protocol
  port_range      = each.value.port_range
  icmp_parameters = each.value.icmp_parameters
}
