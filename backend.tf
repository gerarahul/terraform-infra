terraform {
  backend "s3" {
    bucket         = var.bucket_name
    key            = var.tf_state_s3_path
    region         = var.region
    dynamodb_table = var.dynamodb_table_name
    encrypt        = true
  }
}
