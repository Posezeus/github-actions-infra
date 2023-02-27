variable "project-name" {}
variable "public-subnets-ids" {
  type = list(string)
}
variable "igw" {}
variable "private-route-table-id" {}

