# DB engine specific variables

variable "db_identifier" {
  description = "Database identifier"
}

variable "db_engine_type" {
  type = string

  description = "The type of database engine to be used for AWS RDS. Supported options are: 'aurora-mysql', 'aurora-postgresql', 'mysql', 'mariadb', 'postgres', 'oracle', 'sqlserver', 'db2'."

  validation {
    condition = contains(
      [
        "aurora-mysql",
        "aurora-postgresql",
        "mysql",
        "mariadb",
        "postgres",
        "oracle",
        "sqlserver",
      ],
      var.db_engine_type
    )
    error_message = "Invalid database engine type. Supported types are: 'aurora-mysql', 'aurora-postgresql', 'mysql', 'mariadb', 'postgres', 'oracle', 'sqlserver'"
  }

  default = "postgres" # Optionally, set a default value if desired
}

variable "db_engine_version" {
  type = string
}

variable "db_parameter_group_name" {
  type = string
}

variable "db_instance_class" {
  type        = string
  description = "Type of engine class for the database"
}

variable "db_username" {
  type        = string
  sensitive   = true
  description = "username of database"
}

variable "db_password" {
  type        = string
  sensitive   = true
  description = "password of database"
}


#<--------- Storage variables------------->
variable "storage_type" {
  default     = "gp3"
  description = "Type of storage gp2 or gp3"
}

variable "min_allocated_storage_in_gb" {
  type = number
}

variable "max_allocated_storage_in_gb" {
  type = number
}



# <--------------Networking variales------------------------>

variable "rds_security_groups_ids" {
  type        = list(string)
  description = "List of security group ids for the database"
}

variable "is_db_instance_publicly_accessible" {
  type    = bool
  default = false
}

variable "db_subnet_group_name" {
  type    = string
  default = "default"
}

# MutliAZ Support

variable "multi_az" {
  type    = bool
  default = false
}

# DB Backup Storage variables

variable "backup_retention_period" {
  type    = number
  default = 7
}

variable "backup_window" {
  type        = string
  description = "value"
}

# Storage encryption

variable "is_db_storage_encrypted" {
  type    = bool
  default = true
}

variable "kms_key_id" {
  type        = string
  description = "kms_key_id to encrypt db storage"
}
