variable "vpc_cidr" {
  description = "The CIDR block of the vpc"
}

variable "public_subnets_cidr" {
  type        = list(any)
  description = "The CIDR block for the public subnet"
}

variable "private_subnets_cidr" {
  type        = list(any)
  description = "The CIDR block for the private subnet"
}

variable "region" {
  description = "Region in which vpc & other resources will be created"
}

variable "availability_zones_public" {
  type        = list(any)
  description = "The az that the resources will be launched"
}

variable "availability_zones_private" {
  type        = list(any)
  description = "The az that the resources will be launched"
}

variable "project" {
  description = "Enter your project name"
}

variable "tags" { # Do not add Name tag in this, as added directly in multiple resources
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = {
    "Environment" = "QA"
  }
}

variable "create_eip_for_natgw" {
  description = "Whether to create a elastic ip for nat gateway and the associated resources"
  default     = false
  type        = bool
}
