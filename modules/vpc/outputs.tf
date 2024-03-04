output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets" {
  value = aws_subnet.public[*]
}

output "private_subnets" {
  value = aws_subnet.private[*]
}

output "public_route_table_id" {
  value = aws_route_table.public_rtb.id
}

output "private_route_table_id" {
  value = aws_default_route_table.private_rtb.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.internet_gateway.id
}