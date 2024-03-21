output "network_vpc" {
  value = aws_vpc.vpc
}
output "vpc_cidr_block" {
  value = aws_vpc.vpc.cidr_block
}
output "bastion-sg" {
  value = aws_security_group.bastion-sg
}
