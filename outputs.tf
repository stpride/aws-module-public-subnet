output "subnet_ids" {
  description = "List of subnet ids"
  value = aws_subnet.subnet.*.id
}

output "public_route_table_ids" {
  description = "List of route table ids"
  value = aws_route_table.rtb.*.id
}
