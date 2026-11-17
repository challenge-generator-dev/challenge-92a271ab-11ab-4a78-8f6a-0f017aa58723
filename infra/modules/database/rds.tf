# Módulo de base de datos para el servicio de órdenes
# Define instancia RDS, parámetros de configuración y security groups

resource "aws_db_instance" "orders_db" {
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "15.4"
  instance_class         = var.db_instance_class
  db_name                = "ordersdb"
  username               = var.db_username
  password               = var.db_password
  parameter_group_name   = "default.postgres15"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.orders_db_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.orders_db_subnet_group.name
  multi_az               = true

  tags = {
    Name = "orders-db"
  }
}

resource "aws_db_subnet_group" "orders_db_subnet_group" {
  name       = "orders-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "orders-db-subnet-group"
  }
}

resource "aws_security_group" "orders_db_sg" {
  name        = "orders-db-sg"
  description = "Security group para la base de datos del servicio de órdenes"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.orders_ec2_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "orders-db-sg"
  }
}

# TODO(reto): Configurar read replicas para la base de datos RDS
# Implementar réplicas de lectura para mejorar el rendimiento de consultas