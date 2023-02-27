variable "project-name" {
    default = "webapp"
    type = string
}

variable "availability_zones" {
    type = list(string)
    default = [ "us-west-1a", "us-west-1b" ]
}

variable "target_group_arn" {}
variable "security_group_ec2" {
    type = list(string)
}
variable "private_subnet" {
  
}