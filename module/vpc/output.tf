output "project-name" {
  value = var.project-name
}
##VPC Components
output "vpc-id" {
  value = aws_vpc.demo-vpc
}
output "vpc_cidr_block" {
  value = aws_vpc.demo-vpc.cidr_block
}


##SUbnets
output "public-subnets-ids" {
  value = aws_subnet.public-subnets[*].id
}
output "private-subnets-ids" {
  ##count = length(var.private-subnets-cidr)
  ##value = element(aws_subnet.private-subnets[*].id, count.index)
  value = aws_subnet.private-subnets[*].id
}

##Internet Gateway
output "igw" {
  value = aws_internet_gateway.demo-igw
}

##Private Route Table ID
output "private-route-table-id" {
  value = aws_route_table.private-demo-rt.id
}
