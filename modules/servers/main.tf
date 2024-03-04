resource "aws_instance" "lighting" {
  subnet_id = var.public_subnet_ids[0]
  instance_type = var.instance_type
  vpc_security_group_ids = var.public_security_groups
  associate_public_ip_address = true
  key_name = var.key_name
  ami = var.ami == "ubuntu" ? data.aws_ami.ubuntu.id : var.ami
  tags = {
    Name = "lighting-server"
  }
}

resource "aws_instance" "heating" {
  subnet_id = var.public_subnet_ids[1]
  instance_type = var.instance_type
  vpc_security_group_ids = var.public_security_groups
  associate_public_ip_address = true
  key_name = var.key_name
  ami = var.ami == "ubuntu" ? data.aws_ami.ubuntu.id : var.ami
  tags = {
    Name = "heating-server"
  }
}

resource "aws_instance" "status" {
  subnet_id = var.public_subnet_ids[2]
  instance_type = var.instance_type
  vpc_security_group_ids = var.public_security_groups
  associate_public_ip_address = true
  key_name = var.key_name
  ami = var.ami == "ubuntu" ? data.aws_ami.ubuntu.id : var.ami
  tags = {
    Name = "status-server"
  }
}

resource "aws_instance" "auth" {
  subnet_id = var.private_subnet_ids[0]
  instance_type = var.instance_type
  key_name = var.key_name
  ami = var.ami == "ubuntu" ? data.aws_ami.ubuntu.id : var.ami
  vpc_security_group_ids = var.private_security_groups
  tags = {
    Name = "auth-server"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}