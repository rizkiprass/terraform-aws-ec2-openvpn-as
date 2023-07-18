#Tagging Common
variable "environment" {
  default = "dev"
}

variable "project" {
  default = "sandbox"
}

locals {
  common_tags = {
    Project     = var.project
    Environment = var.environment
    Terraform   = "Yes"
  }
}

variable "cidr" {
  default = "10.0.0.0/16"
}

variable "Public_Subnet_AZ_A" {
  default = "10.0.0.0/24"
}
variable "Public_Subnet_AZ_B" {
  default = "10.0.1.0/24"
}