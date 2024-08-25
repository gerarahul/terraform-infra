# Web Portal target group
module "prod_web_tg" {
  source              = "./modules/target-group"
  target_group_name   = "web-app-prod-tg"
  target_group_vpc_id = module.prod_vpc.aws_vpc_id
  target_group_type   = "instance"
  health_check = {
    enabled             = true
    protocol            = "http"
    path                = "/"
    port                = "traffic-port"
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  host_header = {
    values = ["example.net"] # Provide host header
  }

  listener_rule_name            = "redirect-to-web-portal"
  listener_rule_priority_number = 1
  https_listener_arn            = module.prod_alb.alb_https_listener_arn
}

module "prod_admin_tg" {
  source              = "./modules/target-group"
  target_group_name   = "admin-panel-prod-tg"
  target_group_vpc_id = module.prod_vpc.aws_vpc_id
  target_group_type   = "instance"
  health_check = {
    enabled             = true
    protocol            = "http"
    path                = "/"
    port                = "traffic-port"
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  host_header = {
    values = ["admin.example.net"] # Provide host header
  }

  listener_rule_name            = "redirect-to-admin-panel"
  listener_rule_priority_number = 2
  https_listener_arn            = module.prod_alb.alb_https_listener_arn
}


module "prod_api_tg" {
  source              = "./modules/target-group"
  target_group_name   = "api-prod-tg"
  target_group_vpc_id = module.prod_vpc.aws_vpc_id
  target_group_type   = "instance"
  health_check = {
    enabled             = true
    protocol            = "http"
    path                = "/api/v1/"
    port                = "traffic-port"
    healthy_threshold   = 3
    unhealthy_threshold = 2
  }

  host_header = {
    values = ["api.example.net"] # Provide host header
  }

  listener_rule_name            = "redirect-to-api"
  listener_rule_priority_number = 3
  https_listener_arn            = module.prod_alb.alb_https_listener_arn
}
