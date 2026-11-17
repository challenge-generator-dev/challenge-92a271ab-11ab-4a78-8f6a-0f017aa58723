provider "terraform" {
  alias = "mock"
}

mock_provider "terraform" {}

run "backend_s3_configured_correctly" {
  command = plan

  assert {
    condition     = terraform.backend.s3.bucket == "orders-terraform-state"
    error_message = "El bucket S3 debe ser 'orders-terraform-state'"
  }

  assert {
    condition     = terraform.backend.s3.key == "dev/terraform.tfstate"
    error_message = "La clave del estado debe ser 'dev/terraform.tfstate'"
  }

  assert {
    condition     = terraform.backend.s3.region == "us-east-1"
    error_message = "La región debe ser 'us-east-1'"
  }

  assert {
    condition     = terraform.backend.s3.encrypt == true
    error_message = "El cifrado debe estar habilitado"
  }

  assert {
    condition     = terraform.backend.s3.dynamodb_table == "terraform-locks"
    error_message = "La tabla de locks debe ser 'terraform-locks'"
  }
}

run "backend_s3_without_invalid_configuration" {
  command = plan

  assert {
    condition     = terraform.backend.s3.bucket != ""
    error_message = "El bucket no puede estar vacío"
  }

  assert {
    condition     = terraform.backend.s3.key != ""
    error_message = "La clave no puede estar vacía"
  }

  assert {
    condition     = can(regex("^[a-z0-9-]+$", terraform.backend.s3.bucket))
    error_message = "El bucket debe contener solo minúsculas, números y guiones"
  }
}