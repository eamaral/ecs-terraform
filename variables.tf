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

variable "ecr_image_url" {
  description = "URL da imagem do container no ECR"
  type        = string
  default     = "124355673305.dkr.ecr.us-east-1.amazonaws.com/fastfood-backend:latest"
}

variable "db_host" {
  description = "Endpoint do banco RDS"
  type        = string
}

variable "db_username" {
  description = "Usuário do banco"
  type        = string
}

variable "db_password" {
  description = "Senha do banco"
  type        = string
}

variable "mercadopago_access_token" {
  description = "Token de acesso MercadoPago"
  type        = string
}

variable "mercadopago_public_key" {
  description = "Chave pública MercadoPago"
  type        = string
}

variable "email_user" {
  description = "E-mail do remetente"
  type        = string
}

variable "email_pass" {
  description = "Senha do e-mail (app password)"
  type        = string
}

variable "cognito_user_pool_id" {
  description = "ID do User Pool Cognito"
  type        = string
}

variable "cognito_client_id" {
  description = "Client ID do Cognito"
  type        = string
}
