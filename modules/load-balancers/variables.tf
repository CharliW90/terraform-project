variable "public" {
  type = bool
}

variable "target_protocol" {
  type = string
  default = "HTTP"
}

variable "target_protocol_version" {
  type = string
  default = "HTTP1"
}

variable "target_port" {
  type = number
  default = 3000
}

variable "vpc_id" {
  type = string
}

variable "instances" {
  type = list(object({
    id = string
    public = bool
    api_path = string
  }))
}

variable "project_name" {
  type = string
}

variable "security_groups" {
  type = list(string)
}

variable "subnets" {
  type = list(string)
}

variable "listen_protocol" {
  type = string
}

variable "listen_port" {
  type = number
}