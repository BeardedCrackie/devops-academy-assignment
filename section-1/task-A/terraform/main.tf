data "aws_availability_zones" "available" {}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

module "az_pub_priv_network_1"{
  source              = "./modules/aws_az_pub_priv_network"
  vpc_id              = aws_vpc.main.id
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  az                  = data.aws_availability_zones.available.names[0] # Use index here
  igw_id              = aws_internet_gateway.gw.id
}

module "az_pub_priv_network_2"{
  source              = "./modules/aws_az_pub_priv_network"
  vpc_id              = aws_vpc.main.id
  public_subnet_cidr  = "10.0.3.0/24"
  private_subnet_cidr = "10.0.4.0/24"
  az                  = data.aws_availability_zones.available.names[1] # Use index here
  igw_id              = aws_internet_gateway.gw.id
}