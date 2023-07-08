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