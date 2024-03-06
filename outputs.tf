output "logins" {
  value = module.instances.ssh_login_details
}

output "public_load_balancer_url" {
  value = module.external_load_balancer.lb_dns
}

output "private_load_balancer_url" {
  value = module.internal_load_balancer.lb_dns
}