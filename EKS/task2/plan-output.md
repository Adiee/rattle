```
advait.thakkar@ITIN000759-MAC task2 % plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_eks_cluster.rattle_eks_cluster will be created
  + resource "aws_eks_cluster" "rattle_eks_cluster" {
      + arn                   = (known after apply)
      + certificate_authority = (known after apply)
      + cluster_id            = (known after apply)
      + created_at            = (known after apply)
      + endpoint              = (known after apply)
      + id                    = (known after apply)
      + identity              = (known after apply)
      + name                  = "rattle-eks01-cluster"
      + platform_version      = (known after apply)
      + role_arn              = (known after apply)
      + status                = (known after apply)
      + tags                  = {
          + "Name"            = "rattle-eks01_nodeGroup"
          + "tag_cost_center" = "rattle-eks01-test-vaule"
          + "tag_env"         = "rattle-eks01-test-vaule"
          + "tag_jira"        = "rattle-eks01-test-vaule"
          + "tag_tf"          = "rattle-eks01-test-vaule"
        }
      + tags_all              = {
          + "Name"            = "rattle-eks01_nodeGroup"
          + "tag_cost_center" = "rattle-eks01-test-vaule"
          + "tag_env"         = "rattle-eks01-test-vaule"
          + "tag_jira"        = "rattle-eks01-test-vaule"
          + "tag_tf"          = "rattle-eks01-test-vaule"
        }
      + version               = (known after apply)

      + kubernetes_network_config {
          + ip_family         = (known after apply)
          + service_ipv4_cidr = (known after apply)
          + service_ipv6_cidr = (known after apply)
        }

      + vpc_config {
          + cluster_security_group_id = (known after apply)
          + endpoint_private_access   = false
          + endpoint_public_access    = true
          + public_access_cidrs       = (known after apply)
          + security_group_ids        = (known after apply)
          + subnet_ids                = (known after apply)
          + vpc_id                    = (known after apply)
        }
    }

  # aws_eks_node_group.rattle-eks01_node_group will be created
  + resource "aws_eks_node_group" "rattle-eks01_node_group" {
      + ami_type               = (known after apply)
      + arn                    = (known after apply)
      + capacity_type          = (known after apply)
      + cluster_name           = "rattle-eks01-cluster"
      + disk_size              = (known after apply)
      + id                     = (known after apply)
      + instance_types         = (known after apply)
      + node_group_name        = "rattle-eks01-node-group"
      + node_group_name_prefix = (known after apply)
      + node_role_arn          = (known after apply)
      + release_version        = (known after apply)
      + resources              = (known after apply)
      + status                 = (known after apply)
      + subnet_ids             = (known after apply)
      + tags                   = {
          + "Name"            = "rattle-eks01_nodeGroup"
          + "tag_cost_center" = "rattle-eks01-test-vaule"
          + "tag_env"         = "rattle-eks01-test-vaule"
          + "tag_jira"        = "rattle-eks01-test-vaule"
          + "tag_tf"          = "rattle-eks01-test-vaule"
        }
      + tags_all               = {
          + "Name"            = "rattle-eks01_nodeGroup"
          + "tag_cost_center" = "rattle-eks01-test-vaule"
          + "tag_env"         = "rattle-eks01-test-vaule"
          + "tag_jira"        = "rattle-eks01-test-vaule"
          + "tag_tf"          = "rattle-eks01-test-vaule"
        }
      + version                = (known after apply)

      + remote_access {
          + ec2_ssh_key = "rattle-key-pair"
        }

      + scaling_config {
          + desired_size = 1
          + max_size     = 2
          + min_size     = 1
        }

      + update_config {
          + max_unavailable            = (known after apply)
          + max_unavailable_percentage = (known after apply)
        }
    }

  # aws_iam_policy.eks_node_group_policy will be created
  + resource "aws_iam_policy" "eks_node_group_policy" {
      + arn         = (known after apply)
      + description = "IAM policy for rattle-eks01 node group"
      + id          = (known after apply)
      + name        = "rattle-eks01-node-group-policy"
      + name_prefix = (known after apply)
      + path        = "/"
      + policy      = jsonencode(
            {
              + Statement = [
                  + {
                      + Action   = "eks:DescribeCluster"
                      + Effect   = "Allow"
                      + Resource = "*"
                    },
                  + {
                      + Action   = "eks:ListNodegroups"
                      + Effect   = "Allow"
                      + Resource = "*"
                    },
                  + {
                      + Action   = "eks:DescribeNodegroup"
                      + Effect   = "Allow"
                      + Resource = "*"
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + policy_id   = (known after apply)
      + tags_all    = (known after apply)
    }

  # aws_iam_role.eks_cluster_role will be created
  + resource "aws_iam_role" "eks_cluster_role" {
      + arn                   = (known after apply)
      + assume_role_policy    = jsonencode(
            {
              + Statement = [
                  + {
                      + Action    = "sts:AssumeRole"
                      + Effect    = "Allow"
                      + Principal = {
                          + Service = "eks.amazonaws.com"
                        }
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + create_date           = (known after apply)
      + force_detach_policies = false
      + id                    = (known after apply)
      + managed_policy_arns   = (known after apply)
      + max_session_duration  = 3600
      + name                  = "rattle-eks01-role"
      + name_prefix           = (known after apply)
      + path                  = "/"
      + tags_all              = (known after apply)
      + unique_id             = (known after apply)

      + inline_policy {
          + name   = (known after apply)
          + policy = (known after apply)
        }
    }

  # aws_iam_role.eks_node_group_role will be created
  + resource "aws_iam_role" "eks_node_group_role" {
      + arn                   = (known after apply)
      + assume_role_policy    = jsonencode(
            {
              + Statement = [
                  + {
                      + Action    = "sts:AssumeRole"
                      + Effect    = "Allow"
                      + Principal = {
                          + Service = "ec2.amazonaws.com"
                        }
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + create_date           = (known after apply)
      + force_detach_policies = false
      + id                    = (known after apply)
      + managed_policy_arns   = (known after apply)
      + max_session_duration  = 3600
      + name                  = "rattle-eks01-node-group-role"
      + name_prefix           = (known after apply)
      + path                  = "/"
      + tags_all              = (known after apply)
      + unique_id             = (known after apply)

      + inline_policy {
          + name   = (known after apply)
          + policy = (known after apply)
        }
    }

  # aws_internet_gateway.rattle_igw will be created
  + resource "aws_internet_gateway" "rattle_igw" {
      + arn      = (known after apply)
      + id       = (known after apply)
      + owner_id = (known after apply)
      + tags_all = (known after apply)
      + vpc_id   = (known after apply)
    }

  # aws_key_pair.my_key_pair will be created
  + resource "aws_key_pair" "my_key_pair" {
      + arn             = (known after apply)
      + fingerprint     = (known after apply)
      + id              = (known after apply)
      + key_name        = "rattle-key-pair"
      + key_name_prefix = (known after apply)
      + key_pair_id     = (known after apply)
      + key_type        = (known after apply)
      + public_key      = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDMXRCxbqO9rdX6zNm7XgpaElhHRnNCtDprjoP7to1B+XEsdBuyJjdnIA7WiSWzUh/zWM2yJFrK8lXWlCvl8Fbu+zbryYxPKKPxlew0mQLUdK3qnwtJbgfXTtU/gVbgf/VC5ZET3VaGOr/Gf+1SDX+SoEmnsMnqrfKMh5iMhO4QL2U2SivFxZA0xWUt+u+0NVwWfTEF93IeJ7bbVc8IAgVlPZChu96teHuXGhRIzwPDRMa/Aer412TwNrG7d2+Wp/qkgouT/AINHKHE9uU+PQs3KwSCwheU4YJBDn+/GFHjpzL88uWeXgWnxDFvoa0JJFlCXdkOZAe02QNH5KOuWz/eCUZ6m2ch57DOuBUAG6wOWtCC6yXyK0ghsPZh23AWY5Jw7zAxE2LO4hbcps/fHM1KcvjnbbS2tQRzmVQzgdE3Uoqr9tbFkCBRFPbxshyJxLbk3xMnM7oyxItIYOgDxX20jI24uSr2DuG0u8k2kn8yaAI/76DjhRjrsk0yobhjrsc= advait.thakkar@ITIN000759-MAC"
      + tags_all        = (known after apply)
    }

  # aws_route_table.public_route_table[0] will be created
  + resource "aws_route_table" "public_route_table" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = [
          + {
              + carrier_gateway_id         = ""
              + cidr_block                 = "0.0.0.0/0"
              + core_network_arn           = ""
              + destination_prefix_list_id = ""
              + egress_only_gateway_id     = ""
              + gateway_id                 = (known after apply)
              + ipv6_cidr_block            = ""
              + local_gateway_id           = ""
              + nat_gateway_id             = ""
              + network_interface_id       = ""
              + transit_gateway_id         = ""
              + vpc_endpoint_id            = ""
              + vpc_peering_connection_id  = ""
            },
        ]
      + tags             = (known after apply)
      + tags_all         = (known after apply)
      + vpc_id           = (known after apply)
    }

  # aws_route_table.public_route_table[1] will be created
  + resource "aws_route_table" "public_route_table" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = [
          + {
              + carrier_gateway_id         = ""
              + cidr_block                 = "0.0.0.0/0"
              + core_network_arn           = ""
              + destination_prefix_list_id = ""
              + egress_only_gateway_id     = ""
              + gateway_id                 = (known after apply)
              + ipv6_cidr_block            = ""
              + local_gateway_id           = ""
              + nat_gateway_id             = ""
              + network_interface_id       = ""
              + transit_gateway_id         = ""
              + vpc_endpoint_id            = ""
              + vpc_peering_connection_id  = ""
            },
        ]
      + tags             = (known after apply)
      + tags_all         = (known after apply)
      + vpc_id           = (known after apply)
    }

  # aws_route_table.public_route_table[2] will be created
  + resource "aws_route_table" "public_route_table" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = [
          + {
              + carrier_gateway_id         = ""
              + cidr_block                 = "0.0.0.0/0"
              + core_network_arn           = ""
              + destination_prefix_list_id = ""
              + egress_only_gateway_id     = ""
              + gateway_id                 = (known after apply)
              + ipv6_cidr_block            = ""
              + local_gateway_id           = ""
              + nat_gateway_id             = ""
              + network_interface_id       = ""
              + transit_gateway_id         = ""
              + vpc_endpoint_id            = ""
              + vpc_peering_connection_id  = ""
            },
        ]
      + tags             = (known after apply)
      + tags_all         = (known after apply)
      + vpc_id           = (known after apply)
    }

  # aws_route_table_association.public_subnet_association[0] will be created
  + resource "aws_route_table_association" "public_subnet_association" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_route_table_association.public_subnet_association[1] will be created
  + resource "aws_route_table_association" "public_subnet_association" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_route_table_association.public_subnet_association[2] will be created
  + resource "aws_route_table_association" "public_subnet_association" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_security_group.eks_cluster_sg will be created
  + resource "aws_security_group" "eks_cluster_sg" {
      + arn                    = (known after apply)
      + description            = "Security group for EKS cluster"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "10.10.0.0/24",
                ]
              + description      = ""
              + from_port        = 443
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 443
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "10.10.0.0/24",
                ]
              + description      = ""
              + from_port        = 443
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 443
            },
        ]
      + name                   = "rattle-eks01-sg"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags_all               = (known after apply)
      + vpc_id                 = (known after apply)
    }

  # aws_subnet.private_subnets[0] will be created
  + resource "aws_subnet" "private_subnets" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "us-west-2a"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.0.10.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Name" = "private-subnet-us-west-2a"
        }
      + tags_all                                       = {
          + "Name" = "private-subnet-us-west-2a"
        }
      + vpc_id                                         = (known after apply)
    }

  # aws_subnet.private_subnets[1] will be created
  + resource "aws_subnet" "private_subnets" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "us-west-2b"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.0.11.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Name" = "private-subnet-us-west-2b"
        }
      + tags_all                                       = {
          + "Name" = "private-subnet-us-west-2b"
        }
      + vpc_id                                         = (known after apply)
    }

  # aws_subnet.private_subnets[2] will be created
  + resource "aws_subnet" "private_subnets" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "us-west-2c"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.0.12.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Name" = "private-subnet-us-west-2c"
        }
      + tags_all                                       = {
          + "Name" = "private-subnet-us-west-2c"
        }
      + vpc_id                                         = (known after apply)
    }

  # aws_subnet.public_subnets[0] will be created
  + resource "aws_subnet" "public_subnets" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "us-west-2a"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.0.0.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = true
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Name" = "public-subnet-us-west-2a"
        }
      + tags_all                                       = {
          + "Name" = "public-subnet-us-west-2a"
        }
      + vpc_id                                         = (known after apply)
    }

  # aws_subnet.public_subnets[1] will be created
  + resource "aws_subnet" "public_subnets" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "us-west-2b"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.0.1.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = true
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Name" = "public-subnet-us-west-2b"
        }
      + tags_all                                       = {
          + "Name" = "public-subnet-us-west-2b"
        }
      + vpc_id                                         = (known after apply)
    }

  # aws_subnet.public_subnets[2] will be created
  + resource "aws_subnet" "public_subnets" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "us-west-2c"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.0.2.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = true
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Name" = "public-subnet-us-west-2c"
        }
      + tags_all                                       = {
          + "Name" = "public-subnet-us-west-2c"
        }
      + vpc_id                                         = (known after apply)
    }

  # aws_vpc.rattle_vpc will be created
  + resource "aws_vpc" "rattle_vpc" {
      + arn                                  = (known after apply)
      + cidr_block                           = "10.0.0.0/16"
      + default_network_acl_id               = (known after apply)
      + default_route_table_id               = (known after apply)
      + default_security_group_id            = (known after apply)
      + dhcp_options_id                      = (known after apply)
      + enable_dns_hostnames                 = true
      + enable_dns_support                   = true
      + enable_network_address_usage_metrics = (known after apply)
      + id                                   = (known after apply)
      + instance_tenancy                     = "default"
      + ipv6_association_id                  = (known after apply)
      + ipv6_cidr_block                      = (known after apply)
      + ipv6_cidr_block_network_border_group = (known after apply)
      + main_route_table_id                  = (known after apply)
      + owner_id                             = (known after apply)
      + tags                                 = {
          + "Name" = "rattle-vpc"
        }
      + tags_all                             = {
          + "Name" = "rattle-vpc"
        }
    }

Plan: 21 to add, 0 to change, 0 to destroy.````
