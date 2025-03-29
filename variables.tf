variable "region" {
  description = "Região da AWS"
  type        = string
}

variable "vpc_id" {
  description = "ID da VPC"
  type        = string
}

variable "private_subnets" {
  description = "Subnets privadas"
  type        = list(string)
}

variable "alb_target_group_arn" {
  description = "ARN do Target Group do ALB"
  type        = string
}

variable "alb_sg_id" {
  description = "ID do Security Group do ALB"
  type        = string
}

variable "container_definition" {
  description = "Definição do container ECS"
  type        = any
}