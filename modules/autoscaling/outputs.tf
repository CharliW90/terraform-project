output "console_log" {
  value = data.aws_instance.app-server[*].security_groups
}