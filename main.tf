##Create VPC
module "vpc" {
  source               = "./module/vpc"
  project-name         = var.project-name
  vpc_cidr             = var.vpc_cidr
}

##Create NAT GAteway
module "nat-gw" {
  source                 = "./module/nat-gw"
  project-name           = module.vpc.project-name
  private-route-table-id = module.vpc.private-route-table-id
  igw = module.vpc.igw
  public-subnets-ids     = [module.vpc.public-subnets-ids[0]]
}


 ##Create SGS
module "sg" {
  source = "./module/sg"
  vpc-id = module.vpc.vpc-id.id
} 

##Create ALB
module "alb" {
  source             = "./module/alb"
  project-name       = module.vpc.project-name
  public-subnets-ids = module.vpc.public-subnets-ids[*]
  vpc-id             = module.vpc.vpc-id.id
  alb-sg-id          = module.sg.alb-sg-id
}

module "asg" {
  source = "./module/asg"
  target_group_arn = module.alb.alb-tg-arn
  security_group_ec2  = module.sg.private-sg-id
  private_subnet = module.vpc.private-subnets-ids
}
