# Security groups to allow HTTP/HTTPS Ingress and Egress
resource "aws_security_group" "allow_ingress" {
  name   = "allow-ingress"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "allow_http_in" {
  type = "ingress"

  from_port = 80
  to_port   = 80
  protocol  = "tcp"

  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]

  security_group_id = aws_security_group.allow_ingress.id
}

resource "aws_security_group_rule" "allow_https_in" {
  type = "ingress"

  from_port = 443
  to_port   = 443
  protocol  = "tcp"

  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]

  security_group_id = aws_security_group.allow_ingress.id
}

resource "aws_security_group_rule" "allow_port_3000" {
  type = "ingress"

  from_port = 3000
  to_port = 3000
  protocol = "tcp"

  cidr_blocks = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]

  security_group_id = aws_security_group.allow_ingress.id
}

resource "aws_security_group" "allow_egress" {
  name   = "allow-egress"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "allow_all_out" {
  type = "egress"

  from_port        = 0
  to_port          = 0
  protocol         = -1

  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = ["::/0"]

  security_group_id = aws_security_group.allow_egress.id
}

# Security groups to allow SSH from only your IP address
resource "aws_security_group" "allow_ssh" {
  name   = "allow_ssh"
  vpc_id = var.vpc_id
}

data "http" "my_ip_address" {
  url = "http://ipv4.icanhazip.com"
}

resource "aws_security_group_rule" "allow_ssh" {
  type = "ingress"

  from_port = 22
  to_port   = 22
  protocol  = "tcp"

  cidr_blocks = ["${chomp(data.http.my_ip_address.response_body)}/32"]

  security_group_id = aws_security_group.allow_ssh.id
}

resource "aws_security_group_rule" "allow_bastion_ssh" {
  type = "ingress"

  from_port = 22
  to_port   = 22
  protocol  = "tcp"
  

  self = true

  security_group_id = aws_security_group.allow_ssh.id
}

resource "aws_security_group" "allow_internal_ingress" {
  name   = "allow-internal-ingress"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "allow_internal_port_3000" {
  type = "ingress"

  from_port = 3000
  to_port   = 3000
  protocol  = "tcp"
  

  self = true

  security_group_id = aws_security_group.allow_internal_ingress.id
}

resource "aws_security_group_rule" "allow_internal_port_80" {
  type = "ingress"

  from_port = 80
  to_port   = 80
  protocol  = "tcp"
  

  self = true

  security_group_id = aws_security_group.allow_internal_ingress.id
}