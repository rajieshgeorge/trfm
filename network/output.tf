
output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "public_subnet_id" {
  value = "${aws_subnet.public.id}"
}

output "web_subnet_id" {
  value = "${aws_subnet.web.id}"
}

output "data_subnet_id" {
  value = "${aws_subnet.data.id}"
}

output "igw_id" {
  value = "${aws_internet_gateway.igw.id}"
}

output "natgw_id" {
  value = "${aws_nat_gateway.natgw.id}"
}

output "nat_eip" {
  value = "${aws_eip.nat-eip.public_ip}"
}

output "public_route_table" {
  value = "${aws_route_table.rt-public.id}"
}
