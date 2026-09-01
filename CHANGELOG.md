# Changelog

All notable changes to this project will be documented in this file.

<a name="v0.0.1"></a>
## v0.0.1 - 2026-09-01

### Features

- Create a STACKIT network with full IPv4/IPv6 configuration support (prefix, gateway, nameservers, DHCP)
- Optional VPC association (`vpc_id`, `routing_table_id`, `routed`)
- Optional security group creation (`create_security_group`)
- Configurable security group name, description, and stateful mode
- Security group rules with unified `direction` field (`ingress`/`egress`)
- Rule matching by protocol name or protocol number
- Rule matching by remote IP range (`ip_range`) or remote security group (`remote_security_group_id`)
- Optional port range and ICMP parameters per rule
- `labels` propagated to all created resources
