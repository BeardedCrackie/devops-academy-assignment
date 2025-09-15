
module "vpc_alpha" {
  source   = "./modules/aws_vpc"
  vpc_cidr = "10.0.0.0/16"
  azs = ["eu-central-1a","eu-central-1c"]
}

module "vpc_beta" {
  source   = "./modules/aws_vpc"
  vpc_cidr = "10.1.0.0/16"
  azs = ["eu-central-1b"]
}
