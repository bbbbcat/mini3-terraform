terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.39.1"
    }
  }
}
provider "aws" {
  region = "us-west-2"
}

module "network" {
  source                 = "./network"
  vpc_cidr               = "10.0.0.0/16"
  subnet_cidr_pub        = "10.0.1.0/24"
  subnet_cidr_pri_dev_01 = "10.0.10.0/24"
  subnet_cidr_pri_dev_02 = "10.0.20.0/24"
  subnet_cidr_pri_db     = "10.0.30.0/24"
  teamcidr               = "10.0.1.0/24"
}

module "sg_1" {
  source            = "./sg"
  from_port         = [80]
  to_port           = [80]
  protocal          = ["http"]
  name              = "g1-f1-sg-01"
  vpc_id            = module.network.network_vpc.id
  vpc_cidr_block_id = module.network.bastion-sg.id
}
module "sg_2" {
  source            = "./sg"
  from_port         = [80]
  to_port           = [80]
  protocal          = ["http"]
  name              = "g1-b1-sg-01"
  vpc_id            = module.network.network_vpc.id
  vpc_cidr_block_id = module.network.bastion-sg.id
}
module "sg_3" {
  source            = "./sg"
  from_port         = [80]
  to_port           = [80]
  protocal          = ["http"]
  name              = "g1-f2-sg-01"
  vpc_id            = module.network.network_vpc.id
  vpc_cidr_block_id = module.network.bastion-sg.id
}
module "sg_4" {
  source            = "./sg"
  from_port         = [80]
  to_port           = [80]
  protocal          = ["http"]
  name              = "g1-b2-sg-01"
  vpc_id            = module.network.network_vpc.id
  vpc_cidr_block_id = module.network.bastion-sg.id
}
module "sg_5" {
  source            = "./sg"
  from_port         = [80]
  to_port           = [80]
  protocal          = ["http"]
  name              = "g1-f3-sg-01"
  vpc_id            = module.network.network_vpc.id
  vpc_cidr_block_id = module.network.bastion-sg.id
}
module "sg_6" {
  source            = "./sg"
  from_port         = [80]
  to_port           = [80]
  protocal          = ["http"]
  name              = "g1-b3-sg-01"
  vpc_id            = module.network.network_vpc.id
  vpc_cidr_block_id = module.network.bastion-sg.id
}
module "instance" {
  source    = "./instance"
  ans_ami   = "ami-0c7843ce70e666e51"
  ans_type  = "t2.micro"
  avil_zone = "us-west-2a"
  sg_id     = module.sg_1.sg_id.id

  node_ami  = "ami-0c7843ce70e666e51"
  node_num  = 3
  node_type = "t2.micro"
}
