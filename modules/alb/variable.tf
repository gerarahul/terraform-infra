variable "alb_security_groups" {
  type        = list(string)
  description = "Security groups to be attached with alb"
}

variable "public_subnets_ids" {
  description = "List of public subnets for alb"
}

# <--------------listener specific configurations------------->

variable "https_listener_certificate_arn" {
  description = "ARN of https listener from acm"
  type        = string
}

variable "https_listener_default_target_group" {
  type = string
}

