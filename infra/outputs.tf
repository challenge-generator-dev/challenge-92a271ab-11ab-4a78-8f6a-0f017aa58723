# Definición de outputs para los módulos de Terraform

output "vpc_id" {
  description = "ID de la VPC creada"
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "IDs de las subnets públicas"
  value       = module.network.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs de las subnets privadas"
  value       = module.network.private_subnet_ids
}

output "alb_dns_name" {
  description = "DNS name del Application Load Balancer"
  value       = module.compute.alb_dns_name
}

output "alb_security_group_id" {
  description = "ID del security group del ALB"
  value       = module.compute.alb_security_group_id
}

output "asg_name" {
  description = "Nombre del Auto Scaling Group"
  value       = module.compute.asg_name
}

output "db_instance_endpoint" {
  description = "Endpoint de la instancia RDS"
  value       = module.database.db_instance_endpoint
}

output "db_instance_id" {
  description = "ID de la instancia RDS"
  value       = module.database.db_instance_id
}

output "db_security_group_id" {
  description = "ID del security group de la base de datos"
  value       = module.database.db_security_group_id
}