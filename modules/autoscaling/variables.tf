variable "instances" {
  type = list(object({
    id = string
    app = string
  }))
}

variable "min_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "desired_size" {
  type = number
}

variable "zone_identifiers" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "public_security_groups" {
  type = list(string)
}