output "ecs_cluster_name" {
  value = aws_ecs_cluster.fastfood_cluster.name
}

output "ecs_service_name" {
  value = aws_ecs_service.fastfood_service.name
}

output "ecs_service_sg_id" {
  description = "ID do Security Group do ECS que acessa o banco"
  value       = aws_security_group.ecs_service_sg.id
}
