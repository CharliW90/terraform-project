variable "db_name" {
  type = string
}

variable "hash_key" {
  type = string
}

variable "hash_key_type" {
  type = string
  validation {
    condition = contains(["S", "N", "B"], var.hash_key_type)
    error_message = "Must be one of 'S' (string), 'N' (number), 'B' (binary)."
  }
}