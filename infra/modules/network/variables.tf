# Variables del módulo de red
# Estas variables son consumidas por los recursos de VPC, subnets y gateways

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
}

variable "project_name" {
  description = "Nombre del proyecto para etiquetado"
  type        = string
}

variable "vpc_cidr" {
  description = "Bloque CIDR para la VPC"
  type        = string
}

variable "availability_zones" {
  description = "Zonas de disponibilidad a utilizar"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "Bloques CIDR para las subnets públicas"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Bloques CIDR para las subnets privadas"
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Habilitar NAT Gateway para salida a internet desde subnets privadas"
  type        = bool
}

variable "single_nat_gateway" {
  description = "Usar un solo NAT Gateway para todas las AZs (más económico)"
  type        = bool
}

variable "tags" {
  description = "Etiquetas adicionales para los recursos de red"
  type        = map(string)
  default     = {}
}