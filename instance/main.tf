resource "aws_instance" "ansibleserver" {
  ami               = var.ans_ami
  instance_type     = var.ans_type
  availability_zone = var.avil_zone
  security_groups   = [var.sg_id]

  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install epel -y",
      "sudo amazon-linux-extras enable ansible2",
      "sudo yum install ansible -y"
    ]
  }
}
resource "aws_instance" "node" {
  count         = var.node_num
  ami           = var.node_ami
  instance_type = var.node_type
  tags = {
    Name = "node-${count.index}"
  }
}
