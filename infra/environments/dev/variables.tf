variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "db_name" {
  type        = string
  description = "Name of the RDS database"
}

variable "db_username" {
  type        = string
  description = "Username for the RDS database"
}

variable "db_password" {
  type        = string
  description = "Password for the RDS database"
  sensitive   = true
}