variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "region" {}
variable "project-name" {}
variable "default_route" {
  description = "Default Route from and to internet"
  default     = "0.0.0.0/0"
}