variable "environment" {}
variable "aws_region" {}

# vpc
variable "az_count" {
  default = 2
}
variable "availability_zones" {
  default = ["eu-central-1a", "eu-central-1b"]
}
variable "cidr_block" {}