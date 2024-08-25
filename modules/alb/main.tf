resource "aws_lb" "this" {
  name               = "api-prod-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.alb_security_groups
  subnets            = var.public_subnets_ids

  enable_deletion_protection = true

  tags = {
    Name = "prod_alb"
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.this.arn
  port              = "443"
  protocol          = "HTTPS"
  # ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn = var.https_listener_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = var.https_listener_default_target_group
  }

  tags = {
    Type = "https"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  tags = {
    Type = "http"
  }
}
