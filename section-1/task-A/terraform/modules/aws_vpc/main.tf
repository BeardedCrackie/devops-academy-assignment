data "aws_availability_zones" "available" {}
data "aws_region" "current" {}

resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
}

# Create an IPAM pool for the VPC
resource "aws_vpc_ipam" "ipam" {
  operating_regions {
    region_name = data.aws_region.current.region
  }
}

resource "aws_vpc_ipam_pool" "ipam_pool" {
  address_family = "ipv4"
  ipam_scope_id  = aws_vpc_ipam.ipam.private_default_scope_id
}

# Allocate /24 CIDRs for each public and private subnet per AZ
resource "aws_vpc_ipam_pool_cidr" "public" {
  for_each = { for idx, az in var.azs : idx => az }
  ipam_pool_id = aws_vpc_ipam_pool.ipam_pool.id
  netmask_length  = 24
}

resource "aws_vpc_ipam_pool_cidr" "private" {
  for_each = { for idx, az in var.azs : idx => az }
  ipam_pool_id = aws_vpc_ipam_pool.ipam_pool.id
  netmask_length  = 24
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.this.id
}

module "az_networks" {
  source   = "../aws_az_pub_priv_network"
  for_each = { for idx, az in var.azs : idx => az }

  az                  = each.value
  vpc_id              = aws_vpc.this.id
  public_subnet_cidr  = aws_vpc_ipam_pool_cidr.public[each.key].cidr
  private_subnet_cidr = aws_vpc_ipam_pool_cidr.private[each.key].cidr
  igw_id              = aws_internet_gateway.gw.id
}
