output "security_group_ingress_id" {
  value = aws_security_group.allow_ingress.id
}

output "security_group_egress_id" {
  value = aws_security_group.allow_egress.id
}

output "security_group_ssh_in_id" {
  value = aws_security_group.allow_ssh.id
}