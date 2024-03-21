resource "aws_security_group" "security" {
  vpc_id = var.vpc_id
  name   = var.name
  tags = {
    name = var.name
  }
}

resource "aws_security_group_rule" "allow_inbound_from_other_sg-1" {
  type                     = "ingress"
  count                    = length(var.protocal)
  from_port                = var.from_port[count.index]
  to_port                  = var.to_port[count.index]
  protocol                 = var.protocal[count.index]
  source_security_group_id = var.vpc_cidr_block_id
  security_group_id        = aws_security_group.security.id
}
resource "aws_security_group_rule" "allow_inbound_from_other_sg-2" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "ssh"
  source_security_group_id = var.vpc_cidr_block_id
  security_group_id        = aws_security_group.security.id
}


resource "aws_vpc_security_group_egress_rule" "security_ipv4" {
  security_group_id = aws_security_group.security.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
