variable "from_port" {
  type = list(number)
}
variable "protocal" {
  type = list(string)
}
variable "to_port" {
  type = list(number)
}
variable "name" {
  type = string
}
variable "vpc_id" {
  type = string
}
variable "vpc_cidr_block_id" {
  type = string
}
