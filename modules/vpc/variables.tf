variable "vpc_cidr_block" {
  type = string
  default = "10.0.0.0/16"
}

variable "enable_dns" {
  type = bool
  default = true
}

variable "name" {
  type = string
  default = "my-vpc"
}

variable "availability_zones" {
  type = list(string)
}

variable "public_subnet_cidr_blocks" {
  type = list(string)
}

variable "private_subnet_cidr_blocks" {
  type = list(string)
}