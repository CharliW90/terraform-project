variable "project_name" {
  type = string
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