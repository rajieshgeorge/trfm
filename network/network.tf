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

resource "aws_subnet" "public" {
  cidr_block = var.public-subnet-cidr
  vpc_id = "${aws_vpc.vpc.id}"
  tags = {
    Name = "publicsubnet"
    project = var.project
    Environment = var.env
    Managed_via = "terraform"
  }
}

resource "aws_subnet" "web" {
  cidr_block = var.web-subnet-cidr
  vpc_id = "${aws_vpc.vpc.id}"
  tags = {
    Name = "websubnet"
    project = var.project
    Environment = var.env
    Managed_via = "terraform"
  }
}

resource "aws_subnet" "data" {
  cidr_block = var.data-subnet-cidr
  vpc_id = "${aws_vpc.vpc.id}"
  tags = {
    Name = "datasubnet"
    project = var.project
    Environment = var.env
    Managed_via = "terraform"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags = {
    Name = "igw"
    project = var.project
    Environment = var.env
    Managed_via = "terraform"
  }
}
resource "aws_route_table" "rt-public" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
  tags = {
    Name = "rt-public"
    project = var.project
    Environment = var.env
    Managed_via = "terraform"
  }
}
resource "aws_eip" "nat-eip" {
vpc = true
   tags = {
     Name = "eip-ngw"
     project = var.project
     Environment = var.env
     Managed_via = "terraform"
   }
}
resource "aws_nat_gateway" "natgw" {
  allocation_id = "${aws_eip.nat-eip.id}"
  subnet_id = "${aws_subnet.public.id}"
}

