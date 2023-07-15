variable "access_key" {}

variable "secret_key" {}

provider "aws" {
  region     = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

terraform {
  cloud {
    organization = "pras"

    workspaces {
      name = "test-mymodule"
    }
  }
}