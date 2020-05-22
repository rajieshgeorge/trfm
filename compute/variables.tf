# Project Name
variable "project" {
  default = "MyfirstTFproject"
}

# environment (e.g. poc ,dev, sit, uat, preprod, prod)
variable "env" {
  default = "poc"
}

# AWS Region code
variable "region" {
  type = "string"
  default = "eu-west-2"
}

# Image IDs for AWS regions
variable "ami-id" {
  type = "map"
  default = {
    eu-west-2 = "ami-0fc841be1f929d7d1"
    eu-west-1 = "ami-0fc841be1f929d722"
  }
}

#Instance Types
variable "web_instabce_type" {
  default = "t2.micro"
}
# No. of Availability Zones to be used for HA.
#variable "az_count" {
#    default = 3
#    type = number
#}
