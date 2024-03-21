variable "vpc_cidr" {
  type = string
}
variable "subnet_cidr_pub" {
  type = string
}
variable "subnet_cidr_pri_dev_01" {
  type = string
}
variable "subnet_cidr_pri_dev_02" {
  type = string
}
variable "subnet_cidr_pri_db" {
  type = string
}
variable "ami" {
  type    = string
  default = "ami-0c7843ce70e666e51"
}
variable "instancetype" {
  type    = string
  default = "t2.micro"
}
variable "teamcidr" {
}
