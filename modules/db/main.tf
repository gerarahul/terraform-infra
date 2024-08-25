resource "aws_db_instance" "default" {

  # DB engine specific parameters
  identifier           = var.db_identifier
  engine               = var.db_engine_type
  engine_version       = var.db_engine_version
  instance_class       = var.db_instance_class
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = var.db_parameter_group_name
  skip_final_snapshot  = false # Don't skip final snapshot


  # storage settings
  storage_type          = var.storage_type
  allocated_storage     = var.min_allocated_storage_in_gb
  max_allocated_storage = var.max_allocated_storage_in_gb
  copy_tags_to_snapshot = true

  # Networking for db
  vpc_security_group_ids = var.rds_security_groups_ids
  publicly_accessible    = var.is_db_instance_publicly_accessible
  db_subnet_group_name   = var.db_subnet_group_name

  # AZ Support
  multi_az = false

  # Deletion Protection
  deletion_protection      = true
  delete_automated_backups = false

  # Backup
  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window

  # Encryption
  storage_encrypted = var.is_db_storage_encrypted
  kms_key_id        = var.kms_key_id

  lifecycle {
    ignore_changes = [
      engine_version,
      parameter_group_name,
      availability_zone,
      db_subnet_group_name
    ]
  }
}
