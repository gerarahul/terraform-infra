# Target group creation
resource "aws_lb_target_group" "this" {
  name     = var.target_group_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.target_group_vpc_id

  target_type = var.target_group_type # ( options: instance, ip, alb, lambda , instance: default )

  health_check {
    enabled             = var.health_check.enabled
    protocol            = var.health_check.protocol
    path                = var.health_check.path
    port                = var.health_check.port
    healthy_threshold   = var.health_check.healthy_threshold
    unhealthy_threshold = var.health_check.unhealthy_threshold
  }

  tags = {
    Name = var.target_group_name
  }
}

# Listener rules 
resource "aws_lb_listener_rule" "static" {
  listener_arn = var.https_listener_arn
  priority     = var.listener_rule_priority_number

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }

  # Conditional block for path_pattern
  dynamic "condition" {
    for_each = length(var.path_pattern.values) > 0 ? [1] : []
    content {
      path_pattern {
        values = var.path_pattern.values
      }
    }
  }

  # Conditional block for host_header
  dynamic "condition" {
    for_each = length(var.host_header.values) > 0 ? [1] : []
    content {
      host_header {
        values = var.host_header.values
      }
    }
  }

  tags = {
    Name = var.listener_rule_name
  }
}
