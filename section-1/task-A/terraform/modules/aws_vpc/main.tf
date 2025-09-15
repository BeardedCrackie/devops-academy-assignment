resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.this.id
}

# Calculate subnet CIDRs using cidrsubnet function
# For each AZ, create public subnet (starting from index 0) and private subnet (starting from index for length of azs)
locals {
  public_subnet_cidrs = {
    for idx, az in var.azs : idx => cidrsubnet(var.vpc_cidr, 8, idx)
  }
  private_subnet_cidrs = {
    for idx, az in var.azs : idx => cidrsubnet(var.vpc_cidr, 8, idx + length(var.azs))
  }
}

module "az_networks" {
  source   = "../aws_az_pub_priv_network"
  for_each = { for idx, az in var.azs : idx => az }

  az                  = each.value
  vpc_id              = aws_vpc.this.id
  public_subnet_cidr  = local.public_subnet_cidrs[each.key]
  private_subnet_cidr = local.private_subnet_cidrs[each.key]
  igw_id              = aws_internet_gateway.gw.id
}
