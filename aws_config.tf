module "aws_config" {
  source = "git@github.com:squizify/squizify-foundation-modules.git//src/modules/aws_config?ref=v1.2.0"

  config_bucket_name = "${var.customer_prefix}-aws-config-delivery-bucket"
  enabled            = true
  primary_region     = var.primary_region
}
