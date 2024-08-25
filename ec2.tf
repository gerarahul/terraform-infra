# prod api ec2
module "prod_api_ec2_instance" {
  source = "./modules/ec2"

  override_ami_id           = "ami-003c463c8207b4dfa"
  subnet_id                 = element(module.prod_vpc.private_subnet_id, 0)
  instance_type             = "t3.medium"
  vpc_security_group_ids    = [module.prod_api_sg.security_group_id]
  key_pair_name             = var.key_pair_name
  root_ebs_volume_size      = "8"
  additional_ebs_volume     = "0"
  include_additional_volume = false
  user_data                 = "${path.module}/user-data-scripts/prod_api_ec2_instance.sh"
  tags = {
    Name   = "prod-api"
    env    = "prod"
    server = "api"
  }

  root_block_device_tags = {
    Name   = "prod-api"
    env    = "prod"
    server = "api"
  }

  ec2_stop_protection        = true
  ec2_termination_protection = true

}

# web ec2
module "prod_web_ec2_instance" {
  source = "./modules/ec2"

  override_ami_id           = "ami-003c463c8207b4dfa"
  subnet_id                 = element(module.prod_vpc.private_subnet_id, 0)
  instance_type             = "t3.medium"
  vpc_security_group_ids    = [module.prod_web_sg.security_group_id]
  key_pair_name             = var.key_pair_name
  root_ebs_volume_size      = "35"
  additional_ebs_volume     = "0"
  include_additional_volume = false
  user_data                 = "${path.module}/user-data-scripts/prod_web_ec2_instance.sh"
  tags = {
    Name   = "prod-web-app-&-admin-panel"
    env    = "prod"
    server = "web-&-admin"
  }

  root_block_device_tags = {
    Name   = "prod-web-app-&-admin-panel"
    env    = "prod"
    server = "web-&-admin"
  }

  ec2_stop_protection        = true
  ec2_termination_protection = true

}

# Bastion ec2 for prod
module "prod_bastion_ec2_instance" {
  source = "./modules/ec2"

  override_ami_id           = "ami-003c463c8207b4dfa"
  subnet_id                 = element(module.prod_vpc.public_subnet_id, 1)
  instance_type             = "t3.micro"
  vpc_security_group_ids    = [module.prod_bastion_sg.security_group_id]
  key_pair_name             = "bastion-key"
  root_ebs_volume_size      = "8"
  additional_ebs_volume     = "0"
  include_additional_volume = false
  user_data                 = ""
  tags = {
    Name = "prod-bastion-machine"
    env  = "prod"
  }

  root_block_device_tags = {
    Name = "prod-bastion-machine"
    env  = "prod"
  }

  ec2_stop_protection        = true
  ec2_termination_protection = true

}
