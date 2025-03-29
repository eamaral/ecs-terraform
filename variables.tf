variable "region" {
  description = "Região da AWS"
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "ID da VPC"
  type        = string
  default     = ""
}

variable "private_subnets" {
  description = "Subnets privadas"
  type        = list(string)
  default     = []
}

variable "alb_target_group_arn" {
  description = "ARN do Target Group do ALB"
  type        = string
  default     = ""
}

variable "alb_sg_id" {
  description = "ID do Security Group do ALB"
  type        = string
  default     = ""
}

variable "container_definition" {
  description = "Definição do container ECS"
  type        = any
  default     = null
}