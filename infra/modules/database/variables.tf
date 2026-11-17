# Variables del módulo de base de datos
# Estas variables son consumidas por los recursos RDS del módulo

variable "environment" {
  description = "Entorno de despliegue (dev, staging, prod)"
  type        = string
}

variable "project_name" {
  description = "Nombre del proyecto para etiquetado"
  type        = string
}

variable "vpc_id" {
  description = "ID de la VPC donde se aprovisionará la base de datos"
  type        = string
}

variable "private_subnet_ids" {
  description = "IDs de las subnets privadas donde se creará el grupo de subnets de RDS"
  type        = list(string)
}

variable "db_instance_class" {
  description = "Clase de instancia de base de datos"
  type        = string
}

variable "db_engine" {
  description = "Motor de base de datos"
  type        = string
  default     = "postgres"
}

variable "db_engine_version" {
  description = "Versión del motor de base de datos"
  type        = string
}

variable "db_name" {
  description = "Nombre de la base de datos"
  type        = string
}

variable "db_username" {
  description = "Usuario maestro de la base de datos"
  type        = string
}

variable "db_password" {
  description = "Contraseña del usuario maestro"
  type        = string
  sensitive   = true
}

variable "db_allocated_storage" {
  description = "Almacenamiento asignado en GB"
  type        = number
}

variable "db_max_allocated_storage" {
  description = "Almacenamiento máximo en GB para auto-escalado"
  type        = number
}

variable "db_storage_type" {
  description = "Tipo de almacenamiento (gp2, gp3, io1, etc.)"
  type        = string
}

variable "db_storage_iops" {
  description = "IOPS para almacenamiento gp3 o io1"
  type        = number
}

variable "db_multi_az" {
  description = "Habilitar despliegue multi-AZ"
  type        = bool
}

variable "db_backup_retention_days" {
  description = "Días de retención de backups"
  type        = number
}

variable "db_backup_window" {
  description = "Ventana de backup en formato HH:MM-HH:MM"
  type        = string
}

variable "db_maintenance_window" {
  description = "Ventana de mantenimiento en formato dia:HH:MM-dia:HH:MM"
  type        = string
}

variable "db_skip_final_snapshot" {
  description = "Omitir snapshot final al destruir la instancia"
  type        = bool
}

variable "db_deletion_protection" {
  description = "Habilitar protección contra eliminación"
  type        = bool
}

variable "db_port" {
  description = "Puerto de la base de datos"
  type        = number
}

variable "db_ca_cert_identifier" {
  description = "Identificador del certificado CA de RDS"
  type        = string
}

variable "tags" {
  description = "Etiquetas adicionales para los recursos"
  type        = map(string)
  default     = {}
}