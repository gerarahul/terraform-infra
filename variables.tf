# S3 backend specific variables

variable "profile" {
  description = "Name of aws profile"
  type        = string
}

variable "region" {
  description = "AWS region in which resources will be created by terraform"
  type        = string
}

variable "bucket_name" {
  description = "Bucket name for storing s3 state files"
  type        = string
}

variable "tf_state_s3_path" {
  description = "path of state file in s3 bucket"
  type        = string
}

variable "dynamodb_table_name" {
  description = "Name of dynamodb table for state locking"
  type        = string
}

# alb specific variables

variable "https_listener_certificate_arn" {
  type = string
}

variable "https_listener_default_target_group" {
  type = string
}



variable "db_identifier" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}

# ec2 variables
variable "key_pair_name" {
  type = string
}
