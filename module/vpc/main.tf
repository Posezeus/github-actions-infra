##VPC
resource "aws_vpc" "demo-vpc" {
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = merge(local.common_tags, {

    Name = "${var.project-name}-vpc"
  })
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

}

data "aws_availability_zones" "azs" {}
##Public Subnets 
resource "aws_subnet" "public-subnets" {
  count                   = var.pub-count 
  vpc_id                  = aws_vpc.demo-vpc.id
  cidr_block              = "${var.subnet_cidr_prefix}.${count.index * 2 + 1}.0/24"
  availability_zone = data.aws_availability_zones.azs.names[count.index]
  map_public_ip_on_launch = true
  tags = merge(local.common_tags,  {
    Name = "public-subnet-${count.index + 1}"
  })
}

##Private Subnets 
resource "aws_subnet" "private-subnets" {
  count             = var.priv-count
  vpc_id            = aws_vpc.demo-vpc.id
  cidr_block        = "${var.subnet_cidr_prefix}.${count.index * 2}.0/24"
  availability_zone = data.aws_availability_zones.azs.names[count.index]
  tags = merge(local.common_tags,  {

  Name = "private-subnet-${count.index + 1}" })

}

##Internet Gateway
resource "aws_internet_gateway" "demo-igw" {
  vpc_id = aws_vpc.demo-vpc.id
  tags = merge(local.common_tags,  {

    Name = "${var.project-name}-igw"
  })

}


##Public Route Table
resource "aws_route_table" "public-demo-rt" {
  vpc_id = aws_vpc.demo-vpc.id
  tags = merge(local.common_tags, {
    Name = "${var.project-name}-pub-rt"
  })

}
resource "aws_route" "public-subnet-route" {
  route_table_id         = aws_route_table.public-demo-rt.id
  destination_cidr_block = var.default_route
  gateway_id             = aws_internet_gateway.demo-igw.id
}


##Route table Association with public subnets 
resource "aws_route_table_association" "public-demo-rta" {
  count          = var.pub-count
  subnet_id      = element(aws_subnet.public-subnets[*].id, count.index)
  route_table_id = aws_route_table.public-demo-rt.id

}
##Private Route Table
resource "aws_route_table" "private-demo-rt" {
  vpc_id = aws_vpc.demo-vpc.id
  tags = merge(local.common_tags,  {
    Name = "${var.project-name}-priv-rt"
  })

}


##Route table Association with private subnets 
resource "aws_route_table_association" "private-demo-rta" {
  count          = var.priv-count
  subnet_id      = element(aws_subnet.private-subnets[*].id, count.index)
  route_table_id = aws_route_table.private-demo-rt.id

}
