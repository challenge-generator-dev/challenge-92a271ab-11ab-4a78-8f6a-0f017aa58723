# Estructuración de módulos de Terraform en directorios separados
# Este archivo orquesta los módulos de infraestructura para el servicio de órdenes

module "network" {
  source = "../modules/network"

  environment            = var.environment
  project_name           = var.project_name
  vpc_cidr               = var.vpc_cidr
  availability_zones     = var.availability_zones
  public_subnet_cidrs    = var.public_subnet_cidrs
  private_subnet_cidrs   = var.private_subnet_cidrs
  enable_nat_gateway     = var.enable_nat_gateway
  single_nat_gateway     = var.single_nat_gateway
  tags                   = var.tags
}

module "compute" {
  source = "../modules/compute"

  ami_id            = var.ami_id
  instance_type     = var.instance_type
  key_name          = var.key_name
  vpc_id            = module.network.vpc_id
  public_subnet_ids = module.network.public_subnet_ids
}

module "database" {
  source = "../modules/database"

  environment              = var.environment
  project_name             = var.project_name
  vpc_id                   = module.network.vpc_id
  private_subnet_ids       = module.network.private_subnet_ids
  db_instance_class        = var.db_instance_class
  db_engine                = var.db_engine
  db_engine_version        = var.db_engine_version
  db_name                  = var.db_name
  db_username              = var.db_username
  db_password              = var.db_password
  db_allocated_storage     = var.db_allocated_storage
  db_max_allocated_storage = var.db_max_allocated_storage
  db_storage_type          = var.db_storage_type
  db_storage_iops          = var.db_storage_iops
  db_multi_az              = var.db_multi_az
  db_backup_retention_days = var.db_backup_retention_days
  db_backup_window         = var.db_backup_window
  db_maintenance_window    = var.db_maintenance_window
  db_skip_final_snapshot   = var.db_skip_final_snapshot
  db_deletion_protection   = var.db_deletion_protection
  db_port                  = var.db_port
  db_ca_cert_identifier    = var.db_ca_cert_identifier
  tags                     = var.tags
}