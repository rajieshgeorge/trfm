resource "aws_network_acl" "nacl-pub" {
  vpc_id = "${aws_vpc.vpc.id}"
  subnet_ids = [aws_subnet.public.id]

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = "-1"
    to_port    = "-1"
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  tags = {
    Name = "nacl"
    project = var.project
    Environment = var.env
    Managed_via = "terraform"
  }
}

resource "aws_network_acl" "nacl-private" {
  vpc_id = "${aws_vpc.vpc.id}"
  subnet_ids = [aws_subnet.data.id,aws_subnet.web.id]

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = "-1"
    to_port    = "-1"
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  tags = {
    Name = "nacl"
    project = var.project
    Environment = var.env
    Managed_via = "terraform"
  }
}
