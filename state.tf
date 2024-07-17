terraform {
  backend "s3" {
    bucket         = "squizify-tfstate-ap-southeast-2"
    key            = "workload-staging-ap-southeast-2.tfstate"
    region         = "ap-southeast-2"
    dynamodb_table = "squizify-tfstate-ap-southeast-2"
    role_arn       = "arn:aws:iam::471112901938:role/terraform-cross-account-remote-state"
  }
}
