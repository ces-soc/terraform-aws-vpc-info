
// VPC outputs
output "vpc" {
  value = data.aws_vpc.vpc
}
output "private_subnet_ids" {
  value = [data.aws_subnet.private_a.id, data.aws_subnet.private_b.id]
}
output "public_subnet_ids" {
  value = [data.aws_subnet.public_a.id, data.aws_subnet.public_b.id]
}
output "data_subnet_ids" {
  value = [data.aws_subnet.data_a.id, data.aws_subnet.data_b.id]
}
output "private_subnets" {
  value = [data.aws_subnet.private_a, data.aws_subnet.private_b]
}
output "public_subnets" {
  value = [data.aws_subnet.public_a, data.aws_subnet.public_b]
}
output "data_subnets" {
  value = [data.aws_subnet.data_a, data.aws_subnet.data_b]
}

output "on_prem_deploy" {
  value = local.on_prem_deploy
}