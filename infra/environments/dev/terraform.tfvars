# Terraform tfvars for dev environment
# AWS Networking
vpc_cidr_block             = "10.0.0.0/16"
public_subnet_cidr_blocks  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidr_blocks = ["10.0.3.0/24", "10.0.4.0/24"]
availability_zones         = ["us-east-1a", "us-east-1b"]

# EC2 Compute
instance_type      = "t3.micro"
ami_id             = "ami-0c55b159cbfafe1f0" # Amazon Linux 2
key_name           = "dev-keypair"
desired_capacity   = 2
min_size           = 2
max_size           = 4

# RDS Database
db_instance_class  = "db.t3.micro"
db_engine          = "postgres"
db_engine_version  = "15.4"
db_name            = "devdb"
db_username        = "admin"
db_password        = "change-me-in-production" # In real environments, use secrets manager
allocated_storage  = 20
multi_az           = false

# Tags
environment        = "dev"
owner              = "backend-team"
project            = "infrastructure"