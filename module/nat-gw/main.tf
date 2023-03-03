##NAT Gateway 
##Subnet used by NAT Gateway is the first public subnet in each AZ
resource "aws_eip" "nat-eip" {
  vpc = true
  tags =  {
    Name = "${var.project-name}-eip"
  }
}
resource "aws_nat_gateway" "nat-gateway-demo" {
for_each = { for index, subnet_id in var.public-subnets-ids : index => subnet_id }

  subnet_id     = each.value
  allocation_id = aws_eip.nat-eip.id

  tags =  {
    Name = "${var.project-name}-nat-gw"
  }

  depends_on = [var.igw]
}
##aws_subnet.public-subnets[0].id
##[aws_internet_gateway.demo-igw]
## route to internet from private subnet AZ
resource "aws_route" "route_private_subnet_a" {
  route_table_id         = var.private-route-table-id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat-gateway-demo[0].id
} 