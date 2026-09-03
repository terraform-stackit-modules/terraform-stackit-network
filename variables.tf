# ─── Network ──────────────────────────────────────────────────────────────────

variable "project_id" {
  description = "STACKIT project ID in which the resources are created."
  type        = string
}

variable "name" {
  description = "The name of the network."
  type        = string
}

variable "region" {
  description = "The resource region. If not defined, the provider region is used."
  type        = string
  default     = null
}

variable "labels" {
  description = "Key-value pairs to attach to all resources created by this module."
  type        = map(string)
  default     = {}
}

variable "dhcp" {
  description = "Whether DHCP is enabled on the network."
  type        = bool
  default     = true
}

variable "routed" {
  description = "Whether the network is routed and accessible from other networks."
  type        = bool
  default     = null
}

variable "vpc_id" {
  description = "The ID of the VPC the network is associated with."
  type        = string
  default     = null
}

variable "routing_table_id" {
  description = "The ID of the routing table associated with the network."
  type        = string
  default     = null
}

variable "ipv4_prefix" {
  description = "The IPv4 prefix of the network (CIDR notation)."
  type        = string
  default     = null
}

variable "ipv4_prefix_length" {
  description = "The IPv4 prefix length of the network."
  type        = number
  default     = null
}

variable "ipv4_gateway" {
  description = "The IPv4 gateway of the network. Mutually exclusive with `no_ipv4_gateway`."
  type        = string
  default     = null
}

variable "no_ipv4_gateway" {
  description = "Set to true to create the network without an IPv4 gateway."
  type        = bool
  default     = null
}

variable "ipv4_nameservers" {
  description = "List of IPv4 nameservers for the network."
  type        = list(string)
  default     = null
}

variable "ipv4_vpc_network_range_id" {
  description = "The IPv4 VPC network range ID."
  type        = string
  default     = null
}

variable "ipv6_prefix" {
  description = "The IPv6 prefix of the network (CIDR notation)."
  type        = string
  default     = null
}

variable "ipv6_prefix_length" {
  description = "The IPv6 prefix length of the network."
  type        = number
  default     = null
}

variable "ipv6_gateway" {
  description = "The IPv6 gateway of the network. Mutually exclusive with `no_ipv6_gateway`."
  type        = string
  default     = null
}

variable "no_ipv6_gateway" {
  description = "Set to true to create the network without an IPv6 gateway."
  type        = bool
  default     = null
}

variable "ipv6_nameservers" {
  description = "List of IPv6 nameservers for the network."
  type        = list(string)
  default     = null
}

variable "ipv6_vpc_network_range_id" {
  description = "The IPv6 VPC network range ID."
  type        = string
  default     = null
}

# ─── Security Group ───────────────────────────────────────────────────────────

variable "create_security_group" {
  description = "Whether to create a security group and attach rules to this network."
  type        = bool
  default     = false
}

variable "security_group_name" {
  description = "Name of the security group. Defaults to `<name>-sg` when not set."
  type        = string
  default     = null
}

variable "security_group_description" {
  description = "Description of the security group."
  type        = string
  default     = null
}

variable "security_group_stateful" {
  description = "Whether the security group is stateful (connection tracking)."
  type        = bool
  default     = true
}

variable "security_group_rules" {
  description = <<-EOT
    List of security group rules. Each rule must specify a `direction` (`ingress` or `egress`).
    `protocol`, `port_range`, `icmp_parameters`, and `remote_security_group_id` are optional.
    For `protocol`, provide either `name` (string) or `number` (number).
  EOT
  type = list(object({
    direction                = string
    ether_type               = string
    ip_range                 = optional(string)
    remote_security_group_id = optional(string)
    protocol = optional(object({
      name   = optional(string)
      number = optional(number)
    }))
    port_range = optional(object({
      min = number
      max = number
    }))
    icmp_parameters = optional(object({
      code = number
      type = number
    }))
  }))
  default = []

  validation {
    condition     = alltrue([for r in var.security_group_rules : contains(["ingress", "egress"], r.direction)])
    error_message = "Each security_group_rule must have a direction of either \"ingress\" or \"egress\"."
  }

  validation {
    condition = alltrue([
      for r in var.security_group_rules :
      r.protocol == null || r.protocol.name == null ||
      contains(["ah", "dccp", "egp", "esp", "gre", "icmp", "igmp", "ipip", "ipv6-encap", "ipv6-frag", "ipv6-icmp", "ipv6-nonxt", "ipv6-opts", "ipv6-route", "ospf", "pgm", "rsvp", "sctp", "tcp", "udp", "udplite", "vrrp"], r.protocol.name)
    ])
    error_message = "protocol.name must be lowercase and one of: ah, dccp, egp, esp, gre, icmp, igmp, ipip, ipv6-encap, ipv6-frag, ipv6-icmp, ipv6-nonxt, ipv6-opts, ipv6-route, ospf, pgm, rsvp, sctp, tcp, udp, udplite, vrrp."
  }
}
