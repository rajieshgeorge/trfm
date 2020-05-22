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


//create the public network
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


//create the Web network
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


//create the Data network
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



//create the internet Gateway
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

resource "aws_route_table" "rt-private" {
  vpc_id = "${aws_vpc.vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
  }
    tags = {
    Name = "rt-private"
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

resource "aws_route_table_association" "rt_association_public" {
  route_table_id = aws_route_table.rt-public.id
  subnet_id = aws_subnet.public.id

}

resource "aws_route_table_association" "rt_association_web" {
  route_table_id = aws_route_table.rt-private.id
  subnet_id = aws_subnet.web.id
}

resource "aws_route_table_association" "rt_association_data" {
  route_table_id = aws_route_table.rt-private.id
  subnet_id = aws_subnet.data.id
}

