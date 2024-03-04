output "lighting_id" {
  value = aws_instance.lighting.id
}

output "heating_id" {
  value = aws_instance.heating
}

output "status_id" {
  value = aws_instance.status.id
}

output "auth_id" {
  value = aws_instance.auth.id
}

output "ssh_login_details" {
  value = [
    "lighting app: ssh -i ~/.ssh/${aws_instance.lighting.key_name}.pem ubuntu@${aws_instance.lighting.public_dns}",
    "heating app: ssh -i ~/.ssh/${aws_instance.heating.key_name}.pem ubuntu@${aws_instance.heating.public_dns}",
    "status app: ssh -i ~/.ssh/${aws_instance.status.key_name}.pem ubuntu@${aws_instance.status.public_dns}",
    "auth app: ssh -i ~/.ssh/${aws_instance.auth.key_name}.pem ubuntu@${aws_instance.auth.private_dns}"
  ]
}