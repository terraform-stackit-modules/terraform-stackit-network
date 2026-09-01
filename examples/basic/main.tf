#####################################################################################
# Terraform module examples are meant to show an _example_ on how to use a module
# per use-case. The code below should not be copied directly but referenced in order
# to build your own root module that invokes this module
#####################################################################################

# Minimal — network only
module "network" {
  source = "../.."

  project_id  = var.project_id
  name        = "my-network"
  ipv4_prefix = "192.168.0.0/24"
}

# With security group and rules
module "network_with_sg" {
  source = "../.."

  project_id  = var.project_id
  name        = "my-network-with-sg"
  ipv4_prefix = "10.0.1.0/24"

  create_security_group      = true
  security_group_description = "Allow HTTPS and all egress"

  security_group_rules = [
    {
      direction  = "ingress"
      ether_type = "IPv4"
      ip_range   = "0.0.0.0/0"
      protocol   = { name = "TCP" }
      port_range = { min = 443, max = 443 }
    },
    {
      direction  = "egress"
      ether_type = "IPv4"
      ip_range   = "0.0.0.0/0"
      protocol   = { name = "TCP" }
    },
  ]
}
