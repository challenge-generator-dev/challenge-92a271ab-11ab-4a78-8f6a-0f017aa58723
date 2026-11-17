# Configuración del backend remoto S3 para almacenar el estado de Terraform
terraform {
  backend "s3" {
    bucket         = "orders-terraform-state-bucket"
    key            = "orders-service/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "orders-terraform-lock-table"
  }
}