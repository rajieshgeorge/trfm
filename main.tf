#Terraform remote state location
terraform {
  backend "s3" {
    bucket = "learntfrm"
   key = "terraform/learntf.tfstate"
   region = "eu-west-2"
  }
}

# Mention the provider
provider "aws" {
  region     = "eu-west-2"
} # end provider

# Declare the data source
data "aws_availability_zones" "availability_zones" {
  state = "available"
}

module "network" {
  source = "./network"
# servers = 5
}
