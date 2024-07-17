output "region" {
  value       = data.aws_region.current.name
  description = "Region name for this account"
}


output "account_id" {
  value       = data.aws_caller_identity.current.account_id
  description = "Account Id for this account"
}

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "AWS VPC ID for this account"
}

output "vpc_cidr" {
  value       = module.vpc.vpc_cidr
  description = "VPC CIDR for this account"
}

output "peering_connector_to_shared_ap_southeast_2_id" {
  value       = aws_vpc_peering_connection.peer_to_shared_ap_southeast_2_vpc.id
  description = "AWS VPC Peering connector to Shared ap-southeast-2 ID"
}
