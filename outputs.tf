output "logins" {
  value = module.instances.ssh_login_details
}

output "public_load_balancer_url" {
  value = module.external_load_balancer.dns
}

output "private_load_balancer_url" {
  value = module.internal_load_balancer.dns
}

output "update_status_app_AMI" {
  value = [
    "scp -i ~/.ssh/${var.key_name}.pem ${local_file.status_app_env_local.filename} ubuntu@${module.instances.status_app_dns}:/home/ubuntu/ce-project-status",
    "aws ec2 create-image --instance-id ${module.instances.status_id} --name new_status_app"
  ]
}