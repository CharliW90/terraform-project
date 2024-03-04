variable "project_name" {
  type = string
}

variable "availability_zones" {
  type = list(string)
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