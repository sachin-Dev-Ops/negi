terraform {
  required_version = ">= 1.2.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.37.0"
    }
  }
}

provider "aws" {
  default_tags {
    tags = {
      Environment = "workload-production-ap-southeast-2"
      Owner       = var.customer_prefix
      Project     = "Infrastructure"
      ManagedBy   = "Terraform"
    }
  }
}
