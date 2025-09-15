provider "aws" {
    region = "us-east-1"
}
resource "aws_s3_bucket" "example" {
    bucket = "devops-academy-example"
}
terraform {
    backend "s3" {
        bucket = "terraform-state-storage"
        key = "devopsacademy/infra.tfstate"
        region = "eu-west-1"
        #dynamodb_table = "terraform-lock-table" #https://developer.hashicorp.com/terraform/language/backend/s3#state-locking
        use_lockfile = true
    }
}