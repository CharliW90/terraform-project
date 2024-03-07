data "aws_instance" "app-server" {
  count = length(var.instances)
  instance_id = var.instances[count.index].id
}

data "aws_lb_target_group" "tg" {
  count = length(var.instances)
  tags = {
    "app" = "${var.instances[count.index].app}"
  }
}

resource "aws_autoscaling_group" "autoscaler" {
  depends_on = [ aws_launch_template.instance_apps ]
  count = length(data.aws_instance.app-server[*])
  name = "${data.aws_instance.app-server[count.index].tags.Name}-autoscaler"

  min_size = var.min_size
  max_size = var.max_size
  desired_capacity = var.desired_size

  health_check_grace_period = 300
  health_check_type = "ELB"

  launch_template {
    id = aws_launch_template.instance_apps[count.index].id
    version = "$Latest"
  }

  vpc_zone_identifier = data.aws_instance.app-server[count.index].associate_public_ip_address ? var.public_subnets : var.private_subnets

  target_group_arns = [data.aws_lb_target_group.tg[count.index].arn]
}

resource "aws_launch_template" "instance_apps" {
  depends_on = [ data.aws_instance.app-server ]
  count = length(data.aws_instance.app-server[*])
  name = "${data.aws_instance.app-server[count.index].tags.Name}-asg-t"
  instance_type = data.aws_instance.app-server[count.index].instance_type
  image_id = data.aws_instance.app-server[count.index].ami
  key_name = data.aws_instance.app-server[count.index].key_name
  network_interfaces {
    associate_public_ip_address = data.aws_instance.app-server[count.index].associate_public_ip_address
    security_groups = data.aws_instance.app-server[count.index].associate_public_ip_address ? var.public_security_groups : var.private_security_groups
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${data.aws_instance.app-server[count.index].tags.Name}-asg"
    }
  }
}