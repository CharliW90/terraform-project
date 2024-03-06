resource "aws_lb_target_group" "target" {
  count = length(var.instances)
  name = "${var.project_name}-${var.instances[count.index].public ? "public" : "private"}-tg${count.index}"
  protocol = var.target_protocol
  protocol_version = var.target_protocol_version
  port = var.target_port
  vpc_id = var.vpc_id
  health_check {
    path = "/api/${var.instances[count.index].api_path}${var.instances[count.index].public ? "/health" : ""}"
    protocol = "HTTP"
  }
  tags = {
    "app" = "${var.instances[count.index].api_path}"
  }
}

resource "aws_lb_listener_rule" "app_rule" {
  count = length(var.instances)
  listener_arn = aws_lb_listener.listener.arn
  condition {
    path_pattern {
      values = ["/api/${var.instances[count.index].api_path}*"]
    }
  }
  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.target[count.index].arn
  }
}

resource "aws_lb_target_group_attachment" "tg_attachment" {
  count = length(var.instances)
  target_id = var.instances[count.index].id
  target_group_arn = aws_lb_target_group.target[count.index].arn
}

resource "aws_lb" "load_balancer" {
  name = "${var.project_name}-${var.public ? "public" : "private"}-lb"
  internal = !var.public
  load_balancer_type = "application"
  security_groups = var.security_groups
  subnets = var.subnets
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port = var.listen_port
  protocol = var.listen_protocol

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      status_code = 404
      message_body = "Endpoint not found."
    }
  }
}