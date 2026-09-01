output "network_id" {
  description = "The ID of the created network."
  value       = stackit_network.this.network_id
}

output "network_name" {
  description = "The name of the created network."
  value       = stackit_network.this.name
}

output "ipv4_prefix" {
  description = "The IPv4 CIDR prefix assigned to the network."
  value       = stackit_network.this.ipv4_prefix
}

output "ipv6_prefix" {
  description = "The IPv6 CIDR prefix assigned to the network."
  value       = stackit_network.this.ipv6_prefix
}

output "security_group_id" {
  description = "The ID of the security group, if created."
  value       = var.create_security_group ? stackit_security_group.this[0].security_group_id : null
}

output "security_group_name" {
  description = "The name of the security group, if created."
  value       = var.create_security_group ? stackit_security_group.this[0].name : null
}
