resource "aws_security_group" "this" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  lifecycle {
    create_before_destroy = true
  }

  # Ingress rules based on CIDR blocks
  dynamic "ingress" {
    for_each = var.cidr_ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      description = ingress.value.description
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  # Ingress rules based on Security Group IDs
  dynamic "ingress" {
    for_each = var.sg_ingress_rules
    content {
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = ingress.value.protocol
      description     = ingress.value.description
      security_groups = ingress.value.security_groups
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}
