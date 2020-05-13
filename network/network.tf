resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.dnsSupport
  enable_dns_hostnames = var.dnsHostNames
  tags = {
    Name ="test-vpc"
    Project = var.project
    Environment = var.env
    Managed_via = "terraform"
  }
}
