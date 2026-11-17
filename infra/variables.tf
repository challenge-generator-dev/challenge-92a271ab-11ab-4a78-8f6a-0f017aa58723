# ==============================================================================
# Variables para el aprovisionamiento de infraestructura del servicio de órdenes
# ==============================================================================

# ------------------------------------------------------------------------------
# Variables comunes utilizadas por todos los módulos
# ------------------------------------------------------------------------------

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
  default     = "dev"
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "El entorno debe ser: dev, staging o prod."
  }
}

variable "project_name" {
  description = "Nombre del proyecto para identificar recursos"
  type        = string
  default     = "orders"
}

variable "aws_region" {
  description = "Región de AWS donde se aprovisionarán los recursos"
  type        = string
  default     = "us-east-1"
}

# ------------------------------------------------------------------------------
# Variables del módulo de red (network)
# ------------------------------------------------------------------------------

variable "vpc_cidr" {
  description = "Bloque CIDR para la VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Zonas de disponibilidad para las subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnet_cidrs" {
  description = "Bloques CIDR para las subnets públicas"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "Bloques CIDR para las subnets privadas"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.20.0/24"]
}

variable "enable_nat_gateway" {
  description = "Habilitar NAT Gateway para acceso a internet desde subnets privadas"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Usar un solo NAT Gateway para todas las subnets privadas"
  type        = bool
  default     = false
}

# ------------------------------------------------------------------------------
# Variables del módulo de compute (computo)
# ------------------------------------------------------------------------------

variable "instance_type" {
  description = "Tipo de instancia EC2 para los servidores de aplicaciones"
  type        = string
  default     = "t3.medium"
}

variable "ami_id" {
  description = "ID de la AMI personalizada para las instancias"
  type        = string
  default     = ""
}

variable "min_size" {
  description = "Número mínimo de instancias en el Auto Scaling Group"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Número máximo de instancias en el Auto Scaling Group"
  type        = number
  default     = 4
}

variable "desired_capacity" {
  description = "Número deseado de instancias en el Auto Scaling Group"
  type        = number
  default     = 2
}

variable "target_group_port" {
  description = "Puerto del target group para el Application Load Balancer"
  type        = number
  default     = 8080
}

variable "target_group_protocol" {
  description = "Protocolo del target group (HTTP o HTTPS)"
  type        = string
  default     = "HTTP"
}

variable "health_check_path" {
  description = "Ruta para el health check del Application Load Balancer"
  type        = string
  default     = "/actuator/health"
}

variable "health_check_interval" {
  description = "Intervalo de tiempo entre health checks en segundos"
  type        = number
  default     = 30
}

variable "alb_name" {
  description = "Nombre del Application Load Balancer"
  type        = string
  default     = "orders-alb"
}

variable "alb_internal" {
  description = "Indica si el ALB es interno (true) o público (false)"
  type        = bool
  default     = false
}

variable "alb_http_port" {
  description = "Puerto HTTP del ALB"
  type        = number
  default     = 80
}

variable "alb_https_port" {
  description = "Puerto HTTPS del ALB"
  type        = number
  default     = 443
}

variable "key_name" {
  description = "Nombre del par de claves SSH para acceso a instancias"
  type        = string
  default     = ""
}

variable "user_data" {
  description = "Script de inicialización de las instancias (user data)"
  type        = string
  default     = ""
  sensitive   = true
}

# ------------------------------------------------------------------------------
# Variables del módulo de base de datos (database)
# ------------------------------------------------------------------------------

variable "db_instance_class" {
  description = "Clase de instancia de base de datos"
  type        = string
  default     = "db.t3.medium"
}

variable "db_engine" {
  description = "Motor de base de datos (postgres, mysql, oracle-ee)"
  type        = string
  default     = "postgres"
}

variable "db_engine_version" {
  description = "Versión del motor de base de datos"
  type        = string
  default     = "15.4"
}

variable "db_name" {
  description = "Nombre de la base de datos"
  type        = string
  default     = "ordersdb"
}

variable "db_username" {
  description = "Usuario maestro de la base de datos"
  type        = string
  default     = "dbadmin"
}

variable "db_password" {
  description = "Contraseña del usuario maestro de la base de datos"
  type        = string
  sensitive   = true
}

variable "db_allocated_storage" {
  description = "Almacenamiento asignado a la base de datos en GB"
  type        = number
  default     = 20
}

variable "db_max_allocated_storage" {
  description = "Almacenamiento máximo asignado a la base de datos en GB"
  type        = number
  default     = 100
}

variable "db_storage_type" {
  description = "Tipo de almacenamiento (standard, gp2, gp3, io1)"
  type        = string
  default     = "gp3"
}

variable "db_storage_iops" {
  description = "IOPS provisionados para almacenamiento io1 o gp3"
  type        = number
  default     = 3000
}

variable "db_multi_az" {
  description = "Habilitar despliegue Multi-AZ"
  type        = bool
  default     = false
}

variable "db_backup_retention_days" {
  description = "Días de retención de backups"
  type        = number
  default     = 7
}

variable "db_backup_window" {
  description = "Ventana de tiempo para backups (UTC)"
  type        = string
  default     = "03:00-04:00"
}

variable "db_maintenance_window" {
  description = "Ventana de tiempo para mantenimiento (UTC)"
  type        = string
  default     = "mon:04:00-mon:05:00"
}

variable "db_skip_final_snapshot" {
  description = "Omitir snapshot final al destruir la base de datos"
  type        = bool
  default     = false
}

variable "db_deletion_protection" {
  description = "Habilitar protección contra eliminación"
  type        = bool
  default     = true
}

variable "db_port" {
  description = "Puerto de la base de datos"
  type        = number
  default     = 5432
}

variable "db_ca_cert_identifier" {
  description = "Identificador del certificado CA para RDS"
  type        = string
  default     = "rds-ca-rsa2048-g1"
}

# ------------------------------------------------------------------------------
# Variables de etiquetas (tags) para todos los recursos
# ------------------------------------------------------------------------------

variable "tags" {
  description = "Mapa de etiquetas adicionales para todos los recursos"
  type        = map(string)
  default     = {}
}