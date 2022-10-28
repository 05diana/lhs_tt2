# AWS Provider
terraform {
  required_providers {
    aws = { source = "hashicorp/aws" }
  }
}

# Backend State
terraform {
  backend "s3" {}
}

# Credentials as AWS
provider "aws" {
  region = var.aws_region
}
