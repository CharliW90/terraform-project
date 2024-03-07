variable "project_name" {
  type = string
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "availability_zones" {
  type = list(string)
}

variable "vpc_cidr_block" {
  type = string
}

variable "public_cidr_blocks" {
  type = list(string)
}

variable "private_cidr_blocks" {
  type = list(string)
}

variable "key_name" {
  type = string
}

variable "lighting_ami" {
  type = string
}

variable "heating_ami" {
  type = string
}

variable "status_ami" {
  type = string
}

variable "auth_ami" {
  type = string
}

variable "load_balancer_target_port" {
  type = number
}

variable "load_balancer_listen_port" {
  type = number
}