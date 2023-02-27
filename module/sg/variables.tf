variable "vpc-id" {
  
}
variable "default_route" {
  type        = string
  description = "Default Route from and to internet"
  default     = "0.0.0.0/0"
}
variable "public-subnets-cidr" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}
variable "private-subnets-cidr" {
  type    = list(string)
  default = ["10.0.3.0/24", "10.0.3.0/24"]
}
