# <-----------Variables for target groups------------>

variable "target_group_name" {
  description = "Name of target group"
  type        = string
}

variable "target_group_vpc_id" {
  description = "Vpc id for target group"
  type        = string
}

variable "target_group_type" {
  description = "Type of target group to be created ( options: instance, ip, alb, lambda , instance: default )"
  type        = string
}

variable "health_check" {
  description = "Health check configuration"
  type = object({
    enabled             = bool
    protocol            = string
    path                = string
    port                = string
    healthy_threshold   = number
    unhealthy_threshold = number
  })
  default = {
    enabled             = true
    protocol            = "http"
    path                = "/"
    port                = "traffic-port"
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}

# Listener rule specific configurations

variable "listener_rule_name" {
  description = "Name of listener rule"
  type        = string
  default     = ""
}

variable "listener_rule_priority_number" {
  type        = number
  description = "Priority number of listener rule"
}

variable "path_pattern" {
  type = object({
    values = list(string)
  })
  description = "Path pattern for listener rule"
  default = {
    values = []
  }
}

variable "host_header" {
  type = object({
    values = list(string)
  })
  description = "Host header for listener rule"
  default = {
    values = []
  }
}


# variable "target_group_arn" {
#   description = "Arn of target group"
#   type = string
# }

variable "https_listener_arn" {
  type = string
}
