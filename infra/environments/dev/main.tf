terraform {
  backend "s3" {
    bucket         = "orders-terraform-state"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}

variable "project_name" {
  type        = string
  default     = "orders"
}

variable "availability_zones" {
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnet_cidrs" {
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.20.0/24"]
}

variable "enable_nat_gateway" {
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  type        = bool
  default     = false
}

variable "ami_id" {
  type        = string
  default     = ""
}

variable "instance_type" {
  type        = string
  default     = "t3.medium"
}

variable "key_name" {
  type        = string
  default     = ""
}

variable "public_subnet_ids" {
  type        = list(string)
  default     = []
}

module "network" {
  source = "../../modules/network"

  environment          = "dev"
  project_name         = var.project_name
  vpc_cidr             = var.vpc_cidr
  availability_zones   = var.availability_zones
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  enable_nat_gateway   = var.enable_nat_gateway
  single_nat_gateway   = var.single_nat_gateway
}

module "compute" {
  source = "../../modules/compute"

  ami_id            = var.ami_id
  instance_type     = var.instance_type
  key_name          = var.key_name
  vpc_id            = module.network.vpc_id
  public_subnet_ids = [module.network.public_subnet_ids[0], module.network.public_subnet_ids[1]]
}

module "database" {
  source = "../../modules/database"

  environment            = "dev"
  project_name           = var.project_name
  vpc_id                 = module.network.vpc_id
  private_subnet_ids     = module.network.private_subnet_ids
  db_instance_class      = var.db_instance_class
  db_engine              = var.db_engine
  db_engine_version      = var.db_engine_version
  db_name                = var.db_name
  db_username            = var.db_username
  db_password            = var.db_password
  db_allocated_storage   = var.db_allocated_storage
  db_max_allocated_storage = var.db_max_allocated_storage
  db_storage_type        = var.db_storage_type
  db_storage_iops        = var.db_storage_iops
  db_multi_az            = var.db_multi_az
  db_backup_retention_days = var.db_backup_retention_days
  db_backup_window       = var.db_backup_window
  db_maintenance_window  = var.db_maintenance_window
  db_skip_final_snapshot = var.db_skip_final_snapshot
  db_deletion_protection = var.db_deletion_protection
  db_port                = var.db_port
  db_ca_cert_identifier  = var.db_ca_cert_identifier
}

variable "db_instance_class" {
  type        = string
  default     = "db.t3.medium"
}

variable "db_engine" {
  type        = string
  default     = "postgres"
}

variable "db_engine_version" {
  type        = string
  default     = "15.4"
}

variable "db_allocated_storage" {
  type        = number
  default     = 20
}

variable "db_max_allocated_storage" {
  type        = number
  default     = 100
}

variable "db_storage_type" {
  type        = string
  default     = "gp3"
}

variable "db_storage_iops" {
  type        = number
  default     = 3000
}

variable "db_multi_az" {
  type        = bool
  default     = false
}

variable "db_backup_retention_days" {
  type        = number
  default     = 7
}

variable "db_backup_window" {
  type        = string
  default     = "03:00-04:00"
}

variable "db_maintenance_window" {
  type        = string
  default     = "mon:04:00-mon:05:00"
}

variable "db_skip_final_snapshot" {
  type        = bool
  default     = false
}

variable "db_deletion_protection" {
  type        = bool
  default     = true
}

variable "db_port" {
  type        = number
  default     = 5432
}

variable "db_ca_cert_identifier" {
  type        = string
  default     = "rds-ca-rsa2048-g1"
}