variable "name" {
  description = "The name of the security group"
  type        = string
}

variable "description" {
  description = "The description of the security group"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the security group will be created"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "cidr_ingress_rules" {
  description = "List of ingress rules with CIDR blocks"
  type = list(object({
    from_port   = number       # The starting port of the ingress rule
    to_port     = number       # The ending port of the ingress rule
    protocol    = string       # The protocol (tcp, udp, etc.)
    cidr_blocks = list(string) # The list of CIDR blocks allowed in this rule
    description = string       # The description of rule
  }))
  default = []
}

variable "sg_ingress_rules" {
  description = "List of ingress rules with Security Group IDs"
  type = list(object({
    from_port       = number       # The starting port of the ingress rule
    to_port         = number       # The ending port of the ingress rule
    protocol        = string       # The protocol (tcp, udp, etc.)
    security_groups = list(string) # The list of Security Group IDs allowed in this rule
    description     = string       # The description of rule
  }))
  default = []
}
