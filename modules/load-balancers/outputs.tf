output "id" {
  value = aws_lb.load_balancer.id
}

output "dns" {
  value = aws_lb.load_balancer.dns_name
}