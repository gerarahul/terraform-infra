# Prod bastion sg
module "prod_bastion_sg" {
  source = "./modules/security-group"

  name        = "bastion-sg"
  description = "security group for bastion"
  vpc_id      = module.prod_vpc.aws_vpc_id
  # CIDR ingress rules
  cidr_ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "ssh access globally"
    }
  ]

  tags = {
    Name = "prod-bastion-sg"
  }
}

# SG for alb in prod
module "prod_alb_sg" {
  source = "./modules/security-group"

  name        = "prod-alb-sg"
  description = "Security group for alb in prod env"
  vpc_id      = module.prod_vpc.aws_vpc_id
  # CIDR ingress rules
  cidr_ingress_rules = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"] # HTTP access from anywhere
      description = "http access for alb"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"] # HTTPS access from anywhere
      description = "https access for alb"
    }
  ]

  tags = {
    Name = "prod-alb-sg"
  }
}

# SG for api in prod
module "prod_api_sg" {
  source = "./modules/security-group"

  name        = "prod-api-sg"
  description = "security group for prod api "
  vpc_id      = module.prod_vpc.aws_vpc_id

  # Reference the db_sg module's security group ID for application traffic
  sg_ingress_rules = [
    {
      from_port       = 80
      to_port         = 80
      protocol        = "tcp"
      security_groups = [module.prod_alb_sg.security_group_id]
      description     = "allow http traffic from alb"
    },
    {
      from_port       = 22
      to_port         = 22
      protocol        = "tcp"
      security_groups = [module.prod_bastion_sg.security_group_id]
      description     = "allow ssh from the bastion"
    },
  ]

  tags = {
    Name = "prod-api-sg"
  }
}

# SG for web and admin panel ec2 in prod
module "prod_web_sg" {
  source = "./modules/security-group"

  name        = "web-app-prod-sg"
  description = "prod-sg-for web app"
  vpc_id      = module.prod_vpc.aws_vpc_id

  # Reference the db_sg module's security group ID for application traffic
  sg_ingress_rules = [
    {
      from_port       = 22
      to_port         = 22
      protocol        = "tcp"
      security_groups = [module.prod_bastion_sg.security_group_id]
      description     = "Allow ssh traffic from bastion"
    },
    {
      from_port       = 3000
      to_port         = 3000
      protocol        = "tcp"
      security_groups = [module.prod_alb_sg.security_group_id]
      description     = "Allow traffic on port 3000 from alb"
    },
    {
      from_port       = 4000
      to_port         = 4000
      protocol        = "tcp"
      security_groups = [module.prod_alb_sg.security_group_id]
      description     = "Allow traffic on port 4000 from alb"
    }
  ]

  tags = {
    Name = "prod-web-sg"
  }
}

# SG for rds in prod
module "prod_rds_sg" {
  source = "./modules/security-group"

  name        = "prod-rds-sg"
  description = "rds sg for prod"
  vpc_id      = module.prod_vpc.aws_vpc_id

  # Reference the db_sg module's security group ID for application traffic
  sg_ingress_rules = [
    {
      from_port       = 5432
      to_port         = 5432
      protocol        = "tcp"
      security_groups = [module.prod_api_sg.security_group_id]
      description     = "Allow traffic from prod api sg"
    }
  ]

  tags = {
    Name = "prod-db-sg"
  }
}
