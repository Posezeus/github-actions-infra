variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "pub-count" {
  type        = number
  default     = 2
}
variable "priv-count" {
  type        = number
  default     = 2
}
variable "project-name" {}
variable "subnet_cidr_prefix" {
  default = "10.0"
}

variable "default_route" {
  description = "Default Route from and to internet"
  default     = "0.0.0.0/0"
}
variable "availability_zone" {
  default = ["us-west-1a", "us-west-1b"]
}