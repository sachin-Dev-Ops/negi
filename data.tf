data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

# For VPC Peering
data "terraform_remote_state" "shared_ap_southeast_2_account" {
  backend = "s3"

  config = {
    bucket         = "${var.customer_prefix}-tfstate-ap-southeast-2"
    key            = "shared-ap-southeast-2.tfstate"
    region         = "ap-southeast-2"
    dynamodb_table = "${var.customer_prefix}-tfstate-ap-southeast-2"
    role_arn       = "arn:aws:iam::471112901938:role/terraform-cross-account-remote-state"
  }
}

# For VPC Flow Logs
data "terraform_remote_state" "audit_account" {
  backend = "s3"

  config = {
    bucket         = "${var.customer_prefix}-tfstate-ap-southeast-2"
    key            = "audit.tfstate"
    region         = "ap-southeast-2"
    dynamodb_table = "${var.customer_prefix}-tfstate-ap-southeast-2"
    role_arn       = "arn:aws:iam::471112901938:role/terraform-cross-account-remote-state"
  }
}

# For ec2 Lambda Scheduler
data "terraform_remote_state" "main_account" {
  backend = "s3"

  config = {
    bucket         = "${var.customer_prefix}-tfstate-ap-southeast-2"
    key            = "main.tf"
    region         = "ap-southeast-2"
    dynamodb_table = "${var.customer_prefix}-tfstate-ap-southeast-2"
    role_arn       = "arn:aws:iam::471112901938:role/terraform-cross-account-remote-state"
  }
}

