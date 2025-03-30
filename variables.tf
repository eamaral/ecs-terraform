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
  description = "Lista de subnets privadas"
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
  description = "URL da imagem no ECR"
  type        = string
  default     = "124355673305.dkr.ecr.us-east-1.amazonaws.com/fastfood-backend:latest"
}

variable "db_host" {
  description = "Endpoint do banco de dados RDS (sem porta)"
  type        = string
  default     = ""
}

variable "db_port" {
  description = "Porta do banco de dados"
  type        = number
  default     = 3306
}

variable "db_name" {
  description = "Nome do banco de dados"
  type        = string
  default     = "fastfood"
}

variable "db_username" {
  description = "Usuário do banco de dados"
  type        = string
  default     = ""
}

variable "db_password" {
  description = "Senha do banco de dados"
  type        = string
  default     = ""
}

variable "cognito_user_pool_id" {
  description = "ID do User Pool do Cognito"
  type        = string
  default     = ""
}

variable "cognito_client_id" {
  description = "Client ID do Cognito"
  type        = string
  default     = ""
}

variable "mercadopago_access_token" {
  description = "Token de acesso ao Mercado Pago"
  type        = string
  default     = ""
}

variable "mercadopago_public_key" {
  description = "Chave pública do Mercado Pago"
  type        = string
  default     = ""
}

variable "email_user" {
  description = "Usuário do e-mail (remetente)"
  type        = string
  default     = ""
}

variable "email_pass" {
  description = "Senha do e-mail (app password)"
  type        = string
  default     = ""
}
