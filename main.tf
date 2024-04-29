terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = ">= 4.2"
  }
}


data "aws_ssm_parameter" "vpc_parameters" {
  name = "/${var.campus}/terraform/config"
}

locals {

  vpc_info = jsondecode(data.aws_ssm_parameter.vpc_parameters.value)

  vpc_name            = lookup(local.vpc_info, "${var.campus}-vpc-name")
  vpc_id              = lookup(local.vpc_info, "${var.campus}-vpc-id")
  private_a_subnet_id = lookup(local.vpc_info, "${var.campus}-private-a")
  private_b_subnet_id = lookup(local.vpc_info, "${var.campus}-private-b")
  data_a_subnet_id    = lookup(local.vpc_info, "${var.campus}-data-a")
  data_b_subnet_id    = lookup(local.vpc_info, "${var.campus}-data-b")
  public_a_subnet_id  = lookup(local.vpc_info, "${var.campus}-public-a")
  public_b_subnet_id  = lookup(local.vpc_info, "${var.campus}-public-b")
  on_prem_deploy      = lookup(local.vpc_info, "${var.campus}-on-prem-deploy")
}


// VPC info
data "aws_vpc" "vpc" {
  tags = {
    Name : local.vpc_name
  }
}

data "aws_subnet" "private_a" {
  id = local.private_a_subnet_id
}
data "aws_subnet" "private_b" {
  id = local.private_b_subnet_id
}
data "aws_subnet" "data_a" {
  id = local.data_a_subnet_id
}
data "aws_subnet" "data_b" {
  id = local.data_b_subnet_id
}
data "aws_subnet" "public_a" {
  id = local.public_a_subnet_id
}
data "aws_subnet" "public_b" {
  id = local.public_b_subnet_id
}

