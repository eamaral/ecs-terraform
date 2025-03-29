provider "aws" {
  region = "us-east-1"
}

variable "vpc_id" {}
variable "private_subnets" {
  type = list(string)
}
variable "alb_target_group_arn" {}
variable "alb_sg_id" {}
variable "ecr_image_url" {
  description = "Imagem do backend no ECR"
}

resource "aws_ecs_cluster" "fastfood_cluster" {
  name = "fastfood-ecs-cluster"
}

resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = "/ecs/fastfood-backend"
  retention_in_days = 7
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "ecs_task_cognito_access" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonCognitoPowerUser"
}

resource "aws_ecs_task_definition" "fastfood_task" {
  family                   = "fastfood-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "fastfood-backend",
      image     = var.ecr_image_url,
      essential = true,
      portMappings = [
        {
          containerPort = 3000,
          hostPort      = 3000,
          protocol      = "tcp"
        }
      ],
      environment = [
        { name = "AWS_REGION", value = "us-east-1" },
        { name = "AWS_SDK_LOAD_CONFIG", value = "1" },
        { name = "COGNITO_CLIENT_ID", value = "4opmve1ragnaft1lrv431q4t3s" },
        { name = "COGNITO_USER_POOL_ID", value = "us-east-1_iiITt7551" },
        { name = "DB_HOST", value = "fastfood-db.c2veeay0m6ri.us-east-1.rds.amazonaws.com" },
        { name = "DB_PORT", value = "3306" },
        { name = "DB_NAME", value = "fastfood" },
        { name = "DB_USER", value = "admin" },
        { name = "DB_PASS", value = "Senha123" },
        { name = "LOCAL_PORT", value = "3000" },
        { name = "NODE_ENV", value = "production" },
        { name = "MERCADOPAGO_ACCESS_TOKEN", value = "TEST-7513763222088119-102723-066d60f2c69bc1f0a4f4d4163d2b448a-163051303" },
        { name = "MERCADOPAGO_PUBLIC_KEY", value = "TEST-5ae40bfd-d399-475d-914f-79a45924cf87" },
        { name = "EMAIL_USER", value = "erik.fernandes87@gmail.com" },
        { name = "EMAIL_PASS", value = "nanf erny zkzm vepg" },
        { name = "CPF_API_URL", value = "https://qvt7gb3vnb.execute-api.us-east-1.amazonaws.com/prod/auth/cpf" }
      ],
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs_logs.name,
          awslogs-region        = "us-east-1",
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

resource "aws_security_group" "ecs_service_sg" {
  name   = "fastfood-ecs-service-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [var.alb_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ecs_service" "fastfood_service" {
  name            = "fastfood-service"
  cluster         = aws_ecs_cluster.fastfood_cluster.id
  task_definition = aws_ecs_task_definition.fastfood_task.arn
  launch_type     = "FARGATE"
  desired_count   = 2
  platform_version = "1.4.0"

  network_configuration {
    subnets          = var.private_subnets
    security_groups  = [aws_security_group.ecs_service_sg.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = var.alb_target_group_arn
    container_name   = "fastfood-backend"
    container_port   = 3000
  }

  depends_on = [
    aws_iam_role_policy_attachment.ecs_task_execution_role_policy,
    aws_iam_role_policy_attachment.ecs_task_cognito_access
  ]
}