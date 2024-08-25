module "prod_alb" {
  source = "./modules/alb"

  alb_security_groups                 = [module.prod_alb_sg.security_group_id]
  public_subnets_ids                  = module.prod_vpc.public_subnet_id
  https_listener_certificate_arn      = var.https_listener_certificate_arn
  https_listener_default_target_group = var.https_listener_default_target_group
}
