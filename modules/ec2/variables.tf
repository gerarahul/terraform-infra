variable "override_ami_id" {
  description = "Value of ami to be placed if want to override default ubuntu ami"
  type        = string
}

variable "subnet_id" {
  description = "The CIDR block of the subnets in which ec2 will be created"
}

variable "instance_type" {
  description = "The CIDR block of the vpc"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "Security group/groups to be attached with ec2"
  type        = list(string)
}

variable "key_pair_name" {
  description = "Key name to be attached with ec2"
  type        = string
}

variable "root_ebs_volume_size" {
  description = "Root ebs volume for ec2"
  type        = string
  default     = "8"
}

variable "additional_ebs_volume" {
  description = "additional ebs volume for ec2 ( if required )"
  default     = "2"
}

variable "include_additional_volume" {
  description = "Provide input in true or false to create additional ebs volume"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = {
    "env" = "prod"
  }
}

variable "user_data" {
  description = "path of user data script for ec2 instance"
  type        = string
  default     = ""
}

variable "root_block_device_tags" {
  type    = map(string)
  default = {}
}


variable "ec2_stop_protection" {
  type        = bool
  description = "Whether to allow stop protection or not"
  default     = false
}

variable "ec2_termination_protection" {
  type        = bool
  description = "Whether to allow termination protection or not"
  default     = false
}
