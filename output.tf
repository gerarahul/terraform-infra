# Sg Outputs
output "prod_bastion_sg_id" {
  value = module.prod_bastion_sg.security_group_id
}

output "prod_alb_sg_id" {
  value = module.prod_alb_sg.security_group_id
}

output "prod_api_sg_id" {
  value = module.prod_api_sg.security_group_id
}

output "prod_web_sg_id" {
  value = module.prod_web_sg.security_group_id
}

output "prod_rds_sg_id" {
  value = module.prod_rds_sg.security_group_id
}

# Vpc component outputs
output "private_subnet_id_1" {
  value = element(module.prod_vpc.private_subnet_id, 0)
}

