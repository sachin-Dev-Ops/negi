module "vpc" {
  source         = "git@github.com:squizify/squizify-foundation-modules.git//src/modules/vpc?ref=v1.2.0"
  naming_prefix  = "${var.customer_prefix}-staging"
  network_prefix = "10.130"
  number_of_ngws = 1

  flow_log_bucket_arn = data.terraform_remote_state.audit_account.outputs.central_flow_log_bucket_arn

}

resource "aws_vpc_peering_connection" "peer_to_shared_ap_southeast_2_vpc" {
  peer_owner_id = data.terraform_remote_state.shared_ap_southeast_2_account.outputs.account_id
  peer_vpc_id   = data.terraform_remote_state.shared_ap_southeast_2_account.outputs.vpc_id
  vpc_id        = module.vpc.vpc_id
}

resource "aws_route" "private_vpc_peer_routes" {
  for_each                  = toset(module.vpc.private_rt_ids)
  route_table_id            = each.key
  destination_cidr_block    = data.terraform_remote_state.shared_ap_southeast_2_account.outputs.vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peer_to_shared_ap_southeast_2_vpc.id
}

