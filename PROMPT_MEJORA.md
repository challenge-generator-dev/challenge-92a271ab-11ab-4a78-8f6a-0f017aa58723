# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener el proyecto completo y arrancable. Guarda los archivos que te devuelva en la
carpeta del repo, respetando exactamente las rutas.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Superficie de practica — NO resuelvas

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs.

- `infra/environments/dev/main.tf` — La pieza p1 (Configuración de backend remoto para Terraform, fase f1) vive aqui: este archivo es su unico dueno (blueprint v2).
- `api/src/main/java/com/example/orders/infrastructure/config/DatabaseConfig.java` — La pieza p6 (Configuración de conexión a base de datos en Java, fase f4) vive aqui: este archivo es su unico dueno (blueprint v2).

## Mapa de componentes

El repo tiene una carpeta por componente. Cada uno se instala y verifica dentro de la suya.

| Componente | Carpeta | Rol | Capa | Track | Tecnologias |
|---|---|---|---|---|---|
| `infra` | `infra/` | practice | infra | Terraform (AWS) | Terraform |
| `api` | `api/` | chapter, support | server | Java | - |

## Orden de arranque

1. `cd infra && terraform init -backend=false && terraform -chdir=modules init -backend=false && terraform -chdir=environments/dev init -backend=false && terraform -chdir=modules/compute init -backend=false && terraform -chdir=modules/database init -backend=false && terraform -chdir=modules/network init -backend=false && terraform validate && terraform -chdir=modules validate && terraform -chdir=environments/dev validate && terraform -chdir=modules/compute validate && terraform -chdir=modules/database validate && terraform -chdir=modules/network validate` — componente `infra` (practice).
2. `cd api && mvn -q -B -DskipTests -Dspring-boot.repackage.skip=true package` — componente `api` (chapter, support).

## Referencias no verificadas

Referencias no verificadas para: .hcl. El analisis estatico no cubre esos lenguajes: que no se haya listado nada NO garantiza que no haya referencias colgando.

## Como saber que terminaste

```bash
(cd infra && terraform init -backend=false && terraform -chdir=modules init -backend=false && terraform -chdir=environments/dev init -backend=false && terraform -chdir=modules/compute init -backend=false && terraform -chdir=modules/database init -backend=false && terraform -chdir=modules/network init -backend=false && terraform validate && terraform -chdir=modules validate && terraform -chdir=environments/dev validate && terraform -chdir=modules/compute validate && terraform -chdir=modules/database validate && terraform -chdir=modules/network validate) && (cd api && mvn -q -B -DskipTests -Dspring-boot.repackage.skip=true package)
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Backend, Especialidad Desarrollador, Tecnología Java, Senior L2

### Brecha de conocimiento
Aprovisionar infraestructura con Terraform

### Misión / candidato
Versionar la infraestructura del servicio

### Reto
- Tema: Infraestructura como codigo para el servicio de ordenes
- Seniority: senior-l2
- Tipo: practical
- Título: Aprovisionamiento de Infraestructura con Terraform
- Tiempo estimado: 8 horas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Configuración Inicial — objetivo: Configurar el entorno de Terraform y separar los módulos por red, computo y base de datos. — entregable (NO resolver): Estructura de directorios de Terraform con módulos separados y backend remoto configurado.
- Fase 2: Aprovisionamiento de Red — objetivo: Aprovisionar la red necesaria para el servicio de ordenes utilizando Terraform. — entregable (NO resolver): Módulo de red de Terraform completamente configurado y versionado
- Fase 3: Aprovisionamiento de Computo — objetivo: Aprovisionar los recursos de computo necesarios para el servicio de ordenes utilizando Terraform. — entregable (NO resolver): Módulo de computo de Terraform completamente configurado y versionado
- Fase 4: Aprovisionamiento de Base de Datos — objetivo: Aprovisionar la base de datos necesaria para el servicio de ordenes utilizando Terraform. — entregable (NO resolver): Módulo de base de datos de Terraform completamente configurado y versionado

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (entrega de archivos).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Entrega de archivos
Entregá cada archivo con su ruta completa, respetando exactamente la estructura de rutas
indicada por los marcadores: un bloque por archivo, precedido por su ruta. No generes ZIPs
ni archivos adjuntos.
La entrega debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: Entregá los archivos completos al finalizar. No preguntes si el usuario
quiere recibirlos. Simplemente entregalos; No debes desplegar en el chat el resumen de lo que arreglaste, solo entregá los archivos.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del último archivo entregado
No preguntes si el usuario quiere los archivos: simplemente entregalos siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: infra/README.md ===
# Terraform Infrastructure Module

## Overview
This module provisions AWS infrastructure using Terraform. It includes:
- VPC with public/private subnets
- EC2 instances
- RDS database
- Network security groups and routing

## Prerequisites
- Terraform 1.9.0
- AWS CLI configured with credentials
- AWS account with permissions for VPC, EC2, and RDS

## Directory Structure
```
.
├── environments/          # Environment-specific configurations
│   └── dev/               # Development environment
│       ├── main.tf        # Root module for dev
│       └── terraform.tfvars
├── modules/               # Reusable infrastructure modules
│   ├── compute/           # EC2 instances
│   ├── database/          # RDS instances
│   └── network/           # VPC/networking
├── tests/                 # Acceptance tests
│   └── acceptance/
│       └── f1.tftest.hcl
├── backend.tf             # Remote state configuration
├── outputs.tf             # Output values
├── providers.tf           # Provider configurations
├── variables.tf           # Input variables
└── versions.tf            # Terraform version constraints
```

## Setup
1. Initialize Terraform:
   ```bash
   terraform init
   ```

2. Plan infrastructure changes:
   ```bash
   terraform plan -var-file=environments/dev/terraform.tfvars
   ```

3. Apply infrastructure changes:
   ```bash
   terraform apply -var-file=environments/dev/terraform.tfvars
   ```

## Testing
Run acceptance tests:
```bash
terraform test
```

## Outputs
After applying, Terraform will output:
- VPC ID
- EC2 instance public IPs
- RDS endpoint
- Security group IDs

## Notes
- All resources are tagged with environment (dev/prod)
- The VPC uses 10.0.0.0/16 CIDR block
- EC2 instances use Amazon Linux 2 AMI

// === ARCHIVO: infra/environments/dev/terraform.tfvars ===
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

// === ARCHIVO: infra/versions.tf ===
terraform {
  required_version = ">= 1.9.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.100.0"
    }
  }
}

// === ARCHIVO: infra/providers.tf ===
provider "aws" {
  region = "us-east-1"
}

// === ARCHIVO: infra/modules/network/vpc.tf ===
# Módulo de red para el servicio de órdenes
# Define VPC, subnets públicas y privadas, security groups y routing

resource "aws_vpc" "orders_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "orders-vpc"
  }
}

resource "aws_internet_gateway" "orders_igw" {
  vpc_id = aws_vpc.orders_vpc.id

  tags = {
    Name = "orders-igw"
  }
}

resource "aws_subnet" "public_subnet" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.orders_vpc.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]
  map_public_ip_on_launch = true

  tags = {
    Name = "orders-public-subnet-${count.index}"
  }
}

resource "aws_subnet" "private_subnet" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.orders_vpc.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]

  tags = {
    Name = "orders-private-subnet-${count.index}"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.orders_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.orders_igw.id
  }

  tags = {
    Name = "orders-public-rt"
  }
}

resource "aws_route_table_association" "public_rta" {
  count          = length(aws_subnet.public_subnet)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_security_group" "orders_sg" {
  name        = "orders-security-group"
  description = "Security group para el servicio de órdenes"
  vpc_id      = aws_vpc.orders_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "orders-sg"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

# TODO(reto): Configurar NAT Gateway para permitir salida a internet desde subnets privadas
# Implementar la creación de NAT Gateway y actualizar las route tables privadas

// === ARCHIVO: infra/modules/compute/ec2.tf ===
# Módulo de computo para el servicio de órdenes
# Define instancias EC2, load balancers y auto scaling groups

resource "aws_launch_template" "orders_lt" {
  name_prefix   = "orders-lt"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.orders_ec2_sg.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "orders-instance"
    }
  }
}

resource "aws_autoscaling_group" "orders_asg" {
  desired_capacity    = 2
  max_size            = 4
  min_size            = 1
  vpc_zone_identifier = var.public_subnet_ids

  launch_template {
    id      = aws_launch_template.orders_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "orders-asg"
    propagate_at_launch = true
  }
}

resource "aws_lb" "orders_alb" {
  name               = "orders-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.orders_alb_sg.id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = "orders-alb"
  }
}

resource "aws_lb_target_group" "orders_tg" {
  name     = "orders-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/health"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

resource "aws_lb_listener" "orders_listener" {
  load_balancer_arn = aws_lb.orders_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.orders_tg.arn
  }
}

resource "aws_security_group" "orders_ec2_sg" {
  name        = "orders-ec2-sg"
  description = "Security group para instancias EC2 del servicio de órdenes"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.orders_alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "orders-ec2-sg"
  }
}

resource "aws_security_group" "orders_alb_sg" {
  name        = "orders-alb-sg"
  description = "Security group para el ALB del servicio de órdenes"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "orders-alb-sg"
  }
}

# TODO(reto): Configurar auto scaling policies basadas en métricas de CPU
# Implementar políticas de escalado automático para el ASG

// === ARCHIVO: infra/modules/database/rds.tf ===
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

// === ARCHIVO: infra/environments/dev/main.tf ===
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

// === ARCHIVO: infra/tests/acceptance/f1.tftest.hcl ===
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

// === ARCHIVO: infra/variables.tf ===
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

// === ARCHIVO: infra/backend.tf ===
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

// === ARCHIVO: infra/outputs.tf ===
# Definición de outputs para los módulos de Terraform

output "vpc_id" {
  description = "ID de la VPC creada"
  value       = module.network.vpc_id
}

output "public_subnet_ids" {
  description = "IDs de las subnets públicas"
  value       = module.network.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs de las subnets privadas"
  value       = module.network.private_subnet_ids
}

output "alb_dns_name" {
  description = "DNS name del Application Load Balancer"
  value       = module.compute.alb_dns_name
}

output "alb_security_group_id" {
  description = "ID del security group del ALB"
  value       = module.compute.alb_security_group_id
}

output "asg_name" {
  description = "Nombre del Auto Scaling Group"
  value       = module.compute.asg_name
}

output "db_instance_endpoint" {
  description = "Endpoint de la instancia RDS"
  value       = module.database.db_instance_endpoint
}

output "db_instance_id" {
  description = "ID de la instancia RDS"
  value       = module.database.db_instance_id
}

output "db_security_group_id" {
  description = "ID del security group de la base de datos"
  value       = module.database.db_security_group_id
}

// === ARCHIVO: infra/modules/structure.tf ===
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

// === ARCHIVO: infra/environments/dev/variables.tf ===
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

// === ARCHIVO: infra/modules/compute/variables.tf ===
variable "ami_id" {
  type        = string
  description = "AMI ID for the EC2 instances"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "key_name" {
  type        = string
  description = "SSH key pair name for EC2 instances"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs for the ALB"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where resources will be deployed"
}

// === ARCHIVO: infra/modules/database/variables.tf ===
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

// === ARCHIVO: infra/modules/network/variables.tf ===
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

// === ARCHIVO: api/src/main/java/Application.java ===
package com.example;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan(basePackages = {"com.example"})
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}

// === ARCHIVO: api/pom.xml ===
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>3.4.13</version>
        <relativePath/>
    </parent>

    <groupId>com.example</groupId>
    <artifactId>reto</artifactId>
    <version>1.0.0</version>
    <name>reto</name>

    <properties>
        <java.version>21</java.version>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.postgresql</groupId>
            <artifactId>postgresql</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-actuator</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-validation</artifactId>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>

// === ARCHIVO: api/src/main/java/com/example/orders/infrastructure/config/DatabaseConfig.java ===
// TODO(reto): archivo stubbeado; implementa los cuerpos.
package com.example.orders.infrastructure.config;

import jakarta.validation.constraints.NotBlank;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.validation.annotation.Validated;

@Validated
@ConfigurationProperties(prefix = "database")
public class DatabaseConfig {

    @NotBlank(message = "El endpoint de la base de datos no puede estar vacío")
    private String endpoint;

    @NotBlank(message = "El password de la base de datos no puede estar vacío")
    private String password;

    public DatabaseConfig() {
    }

    public DatabaseConfig(String endpoint, String password) {
        this.endpoint = endpoint;
        this.password = password;
    }

    public String getEndpoint() {
        return endpoint;
    }

    public void setEndpoint(String endpoint) {
        this.endpoint = endpoint;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void validate() {
      throw new UnsupportedOperationException("TODO(reto): validate");
    }
}

// === ARCHIVO: api/src/main/resources/application.yml ===
spring:
  application:
    name: orders-service
  datasource:
    url: jdbc:postgresql://${DATABASE_ENDPOINT:localhost}:${DATABASE_PORT:5432}/${DATABASE_NAME:orders}
    username: ${DATABASE_USERNAME:postgres}
    password: ${DATABASE_PASSWORD:}
    driver-class-name: org.postgresql.Driver
    hikari:
      maximum-pool-size: 10
      minimum-idle: 5
      connection-timeout: 30000
      idle-timeout: 600000
      max-lifetime: 1800000
  jpa:
    hibernate:
      ddl-auto: update
    show-sql: false
    properties:
      hibernate:
        dialect: org.hibernate.dialect.PostgreSQLDialect
        format_sql: true
    open-in-view: false
  jackson:
    serialization:
      write-dates-as-timestamps: false
    deserialization:
      fail-on-unknown-properties: false

server:
  port: ${SERVER_PORT:8080}
  servlet:
    context-path: /
  compression:
    enabled: true

management:
  endpoints:
    web:
      exposure:
        include: health,info,metrics,prometheus
      base-path: /actuator
  endpoint:
    health:
      show-details: when_authorized
      probes:
        enabled: true
  health:
    livenessState:
      enabled: true
    readinessState:
      enabled: true
  metrics:
    export:
      prometheus:
        enabled: true

logging:
  level:
    root: INFO
    com.example.orders: DEBUG
    org.springframework.web: INFO
    org.hibernate.SQL: DEBUG
    org.hibernate.type.descriptor.sql.BasicBinder: TRACE
  pattern:
    console: "%d{yyyy-MM-dd HH:mm:ss} - %msg%n"
    file: "%d{yyyy-MM-dd HH:mm:ss} [%thread] %-5level %logger{36} - %msg%n"
```
