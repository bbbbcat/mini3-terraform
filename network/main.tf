resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
}
resource "aws_subnet" "subnet_pub" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet_cidr_pub
  map_public_ip_on_launch = true
}
resource "aws_subnet" "subnet_pri_dev_01" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet_cidr_pri_dev_01
}
resource "aws_subnet" "subnet_pri_dev_02" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet_cidr_pri_dev_02
}
resource "aws_subnet" "subnet_cidr_pri_db" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet_cidr_pri_db
}

resource "aws_security_group" "bastion-sg" {
  name        = "bastion-sg"
  description = "Security group for bastion host"

  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.teamcidr]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "bastion" {
  ami           = var.ami
  instance_type = var.instancetype
}
resource "aws_eip" "eip" {
  instance = aws_instance.bastion.id
  domain   = "vpc"
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

}
resource "aws_route_table" "route_table_pub" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.subnet_cidr_pub
    gateway_id = aws_internet_gateway.igw.id
  }
}
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.subnet_pub.id

  depends_on = [aws_internet_gateway.igw]
}
resource "aws_route_table" "route_table_dev_1" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.vpc_cidr
    gateway_id = aws_nat_gateway.ngw.id
  }
}
resource "aws_route_table_association" "rt_add_dev_01" {
  subnet_id      = aws_subnet.subnet_pri_dev_01.id
  route_table_id = aws_route_table.route_table_dev_1.id
}
resource "aws_route_table" "route_table_dev_02" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.vpc_cidr
    gateway_id = aws_nat_gateway.ngw.id
  }
}
resource "aws_route_table_association" "rt_add_dev_02" {
  subnet_id      = aws_subnet.subnet_pri_dev_02.id
  route_table_id = aws_route_table.route_table_dev_02.id
}
