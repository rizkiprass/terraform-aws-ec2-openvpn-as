#Tagging Common
variable "environment" {
  default = "prod"
}

variable "environment_dev" {
  default = "dev"
}
variable "customer" {
  default = "sandbox"
}

locals {
  common_tags = {
    Project     = var.project
    Environment = var.environment
    Terraform   = "Yes"
  }

  common_tags_dev = {
    Project     = var.project
    Environment = var.environment_dev
    Terraform   = "Yes"
  }
}