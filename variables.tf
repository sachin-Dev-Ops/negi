variable "customer_prefix" {
  type        = string
  description = "Prefix for all resources with the customer name. Should be lower case characters starting with an alpha character and be consistent across the environment. Only `-` as a special character."
}

variable "primary_region" {
  type        = string
  description = "Primary AWS Region to deploy resources into"
  default     = "ap-southeast-2"
}

variable "env" {
  type        = string
  description = "Workload environment"
}

variable "alb_sg_id" {
  type        = string
  description = "Squizify ALB security group id"
}

variable "web_ami_id" {
  type        = string
  description = "Web AMI ID"
}

variable "web_instance_type" {
  type        = string
  description = "Web instance type"
}

variable "cron_ami_id" {
  type        = string
  description = "Cron AMI ID"
}

variable "cron_01_instance_type" {
  type        = string
  description = "Cron 01 instance type"
}

variable "cron_02_instance_type" {
  type        = string
  description = "Cron 02 instance type"
}

variable "web_target_groups" {
  type        = set(string)
  description = "Set of target groups"
}
