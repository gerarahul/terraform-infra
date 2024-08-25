module "prod_db" {
  source = "./modules/db"

  # DB engine specific parameters
  db_identifier           = var.db_identifier
  db_engine_type          = "postgres"
  db_engine_version       = "16.2"
  db_instance_class       = "db.t3.small"
  db_username             = var.db_username
  db_password             = var.db_password
  db_parameter_group_name = "default.postgres16"

  # storage parameters
  storage_type                = "gp3"
  min_allocated_storage_in_gb = 30
  max_allocated_storage_in_gb = 100

  # Networking for db
  rds_security_groups_ids            = [module.prod_rds_sg.security_group_id]
  is_db_instance_publicly_accessible = false
  db_subnet_group_name               = "default-${module.prod_vpc.aws_vpc_id}"

  # Backup
  backup_retention_period = 7
  backup_window           = "18:00-18:30"

  # Encryption
  is_db_storage_encrypted = true
  kms_key_id              = data.aws_kms_key.by_alias.arn
}

data "aws_kms_key" "by_alias" {
  key_id = "alias/aws/rds"
}
