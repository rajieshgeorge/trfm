module "network" {
  source = "./network"
# servers = 5
}

module "compute" {
  source = "./compute"
# servers = 5
}

output "instance_web_id" {
  value = module.compute.instance_id
}

//output of network components

output "vpc_id" {
  value = module.network.vpc_id
}

output "public_subnet_id" {
  value = module.network.public_subnet_id
}

output "web_subnet_id"{
value = module.network.web_subnet_id
}

output "data_subnet_id" {
  value = module.network.data_subnet_id
}

output "internet_gw_id" {
  value = module.network.igw_id
}

output "nat_gw_id" {
  value = module.network.natgw_id
}

output "nat_gw_ip" {
  value = module.network.nat_eip
}

output "public_rt_id" {
  value = module.network.public_route_table
}
