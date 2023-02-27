 ##Private SG
resource "aws_security_group" "private-sg" {
  name       = "private-sg"
  vpc_id     = var.vpc-id
  /* count      = length(var.public-subnets-cidr)
  cidr_block = element(var.public-subnets-cidr, count.index)*/ 


  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.alb-sg.id]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.private-subnets-cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.default_route]
  }

  tags = {
    Name = "private-sg"
  }
}

##SG for ALB
resource "aws_security_group" "alb-sg" {
  name   = "alb-sg"
  vpc_id = var.vpc-id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "alb-security-group"
  }
} 
