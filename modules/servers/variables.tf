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

variable "lighting_ami" {
  type = string
  default = "ubuntu"
}

variable "heating_ami" {
  type = string
  default = "ubuntu"
}

variable "status_ami" {
  type = string
  default = "ubuntu"
}

variable "auth_ami" {
  type = string
  default = "ubuntu"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}