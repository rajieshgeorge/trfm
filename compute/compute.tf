module "network" {
  source = "../network"
}


resource "aws_instance" "web" {
  ami = "${var.ami-id[var.region]}"
  instance_type = "${var.web_instabce_type}"
  subnet_id = module.network.web_subnet_id
  #subnet_id = "subnet-0ca0b0616c4a9dd34"

  tags = {
    Name = "webserver001"
    project = var.project
    Environment = var.env
    Managed_via = "terraform"
  }
}


