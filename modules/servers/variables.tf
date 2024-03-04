variable "public_subnet_ids" {
  type = list(string)
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "public_security_groups" {
  type = list(string)
}

variable "private_security_groups" {
  type = list(string)
}

variable "key_name" {
  type = string
}

variable "ami" {
  type = string
  default = "ubuntu"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}