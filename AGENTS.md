# AGENTS.md

Instrucciones para el agente de IA que abra este repositorio (Claude Code, Cursor, Codex, Copilot, Gemini). Se cargan solas: no hay que pegar nada en ningun chat.

## Que es este repositorio

Es el codigo base de un reto de aprendizaje de Pragma: **Aprovisionamiento de Infraestructura con Terraform**.

| | |
|---|---|
| Tema | Infraestructura como codigo para el servicio de ordenes |
| Nivel | senior-l2 |
| Chapter | Backend |
| Especialidad | Terraform (AWS) |
| Stack | HCL / Terraform |
| Patron arquitectonico | modular con backend remoto S3 |
| Tiempo estimado | 8 horas |

## Mapa de componentes

El repo tiene una carpeta por componente. Cada uno se instala y verifica dentro de la suya.

| Componente | Carpeta | Rol | Capa | Track | Tecnologias |
|---|---|---|---|---|---|
| `infra` | `infra/` | practice | infra | Terraform (AWS) | Terraform |
| `api` | `api/` | chapter, support | server | Java | - |

## Orden de arranque

1. `cd infra && terraform init -backend=false && terraform -chdir=modules init -backend=false && terraform -chdir=environments/dev init -backend=false && terraform -chdir=modules/compute init -backend=false && terraform -chdir=modules/database init -backend=false && terraform -chdir=modules/network init -backend=false && terraform validate && terraform -chdir=modules validate && terraform -chdir=environments/dev validate && terraform -chdir=modules/compute validate && terraform -chdir=modules/database validate && terraform -chdir=modules/network validate` — componente `infra` (practice).
2. `cd api && mvn -q -B -DskipTests -Dspring-boot.repackage.skip=true package` — componente `api` (chapter, support).

## Receta del stack

Esqueleto obligatorio:

- `main.tf con los recursos`
- `variables.tf con las variables (sin default)`
- `outputs.tf con los valores expuestos`
- `versions.tf con required_version y required_providers`
- `environments/dev/terraform.tfvars con los valores`
- `README.md con la topologia y como validar (init -backend=false, validate)`

Trampas conocidas:

- NUNCA incluyas `apply`, `destroy` ni `deploy` (terraform apply/destroy, cdk deploy/destroy, sam deploy, aws cloudformation deploy) en README, scripts ni instrucciones: el reto se valida y se revisa, no se despliega.
- Cero credenciales hardcodeadas: nada de claves `AKIA...`, `aws_secret_access_key` ni `secret_key` literales. La autenticacion la resuelve el entorno del candidato (perfil o variables de entorno), nunca el codigo.
- Sin backend remoto real: nada de `backend "s3"` con un bucket concreto. Usa estado local (`backend "local"`) o no declares backend; la verificacion corre con `init -backend=false`.
- `versions.tf` declara `required_version` como RANGO (`>= 1.5`) y `required_providers` con `source = "hashicorp/aws"` y `version = "~> 5.0"` (una version que exista); nunca versiones exactas.
- Las variables de `variables.tf` NO llevan `default`: todos los valores van en `environments/dev/terraform.tfvars`.
- Para leer recursos que ya existen usa data sources (`aws_kms_key`, `aws_iam_role`, `aws_dynamodb_table`...) por nombre o alias, nunca `terraform_remote_state`.
- El codigo tiene que pasar `terraform fmt -check`: indentacion de 2 espacios y `=` alineados dentro de cada bloque.

## Tu tarea

Dejar este proyecto en estado **verificable**: que el comando de verificacion corra sin errores. Escribi los archivos en disco, en este repositorio. No generes ZIPs ni archivos adjuntos.

En orden:

1. Segui el orden de arranque del mapa de componentes (infraestructura local primero) y corre `(cd infra && terraform init -backend=false && terraform -chdir=modules init -backend=false && terraform -chdir=environments/dev init -backend=false && terraform -chdir=modules/compute init -backend=false && terraform -chdir=modules/database init -backend=false && terraform -chdir=modules/network init -backend=false && terraform validate && terraform -chdir=modules validate && terraform -chdir=environments/dev validate && terraform -chdir=modules/compute validate && terraform -chdir=modules/database validate && terraform -chdir=modules/network validate) && (cd api && mvn -q -B -DskipTests -Dspring-boot.repackage.skip=true package)` desde la raiz: mira que falla.
2. Completa lo que falte de la lista de abajo: manifiesto de dependencias, punto de entrada, capa de interfaz y las capas del patron declarado.
3. Arregla SOLO los errores que impiden compilar o arrancar.
4. Volve a correr `(cd infra && terraform init -backend=false && terraform -chdir=modules init -backend=false && terraform -chdir=environments/dev init -backend=false && terraform -chdir=modules/compute init -backend=false && terraform -chdir=modules/database init -backend=false && terraform -chdir=modules/network init -backend=false && terraform validate && terraform -chdir=modules validate && terraform -chdir=environments/dev validate && terraform -chdir=modules/compute validate && terraform -chdir=modules/database validate && terraform -chdir=modules/network validate) && (cd api && mvn -q -B -DskipTests -Dspring-boot.repackage.skip=true package)` hasta que pase.
5. Pará ahí.

## Regla dura: las fases son trabajo del humano

**PROHIBIDO implementar los entregables de las fases.** El valor del reto esta en que la persona los resuelva. Tu trabajo es que tenga un proyecto que arranca; el hueco pedagogico se queda como esta.

No resuelvas nada de esto:

- **Fase 1 — Configuración Inicial**: Estructura de directorios de Terraform con módulos separados y backend remoto configurado.
- **Fase 2 — Aprovisionamiento de Red**: Módulo de red de Terraform completamente configurado y versionado
- **Fase 3 — Aprovisionamiento de Computo**: Módulo de computo de Terraform completamente configurado y versionado
- **Fase 4 — Aprovisionamiento de Base de Datos**: Módulo de base de datos de Terraform completamente configurado y versionado

Distincion operativa:

- **Arreglar** (si): import faltante, tipo que no existe, dependencia sin declarar, error de sintaxis, archivo referenciado que no existe.
- **No tocar** (no): logica de negocio incompleta, validaciones ausentes, secretos hardcodeados, APIs deprecadas que funcionan, concurrencia insegura, patrones mejorables. Eso es lo que la persona tiene que encontrar.

## Superficie de practica (NO completes)

Estos archivos SON el ejercicio de la persona. No los implementes; deja stubs. No toques la logica que el reto pide completar.

- [ ] `infra/environments/dev/main.tf` — La pieza p1 (Configuración de backend remoto para Terraform, fase f1) vive aqui: este archivo es su unico dueno (blueprint v2).
- [ ] `api/src/main/java/com/example/orders/infrastructure/config/DatabaseConfig.java` — La pieza p6 (Configuración de conexión a base de datos en Java, fase f4) vive aqui: este archivo es su unico dueno (blueprint v2).

## Mapa de fases

La **Fase 0** es clonar el repositorio, instalar dependencias y correr las pruebas de aceptacion: todas fallan porque la logica de cada pieza esta pendiente.

| Fase | Pieza (skill) | Archivo:simbolo | Criterios | Prueba | Comando |
|------|---------------|-----------------|-----------|--------|---------|
| f1 — Configuración Inicial | Configuración de backend remoto para Terraform | — | Estructura de directorios con módulos separados para red, computo y base de datos; Backend remoto S3 configurado para almacenar el estado de Terraform | `infra/tests/acceptance/f1.tftest.hcl` | `cd infra && terraform test -test-directory=tests/acceptance -filter=tests/acceptance/f1.tftest.hcl` |
| f1 — Configuración Inicial | Estructuración de módulos de Terraform | — | Estructura de directorios con módulos separados para red, computo y base de datos; Backend remoto S3 configurado para almacenar el estado de Terraform | `infra/tests/acceptance/f1.tftest.hcl` | `cd infra && terraform test -test-directory=tests/acceptance -filter=tests/acceptance/f1.tftest.hcl` |
| f2 — Aprovisionamiento de Red | Aprovisionamiento de recursos de red con Terraform | — | Recursos de red (VPC, subnets, security groups) aprovisionados correctamente; Configuración de red válida y aplicable mediante Terraform | — | — |
| f3 — Aprovisionamiento de Computo | Aprovisionamiento de recursos de computo con Terraform | — | Recursos de computo (ECS, EC2, load balancers) aprovisionados correctamente; Configuración de computo válida y aplicable mediante Terraform | — | — |
| f4 — Aprovisionamiento de Base de Datos | Aprovisionamiento de recursos de base de datos con Terraform | — | Recursos de base de datos (RDS, DynamoDB) aprovisionados correctamente; Configuración de base de datos válida y aplicable mediante Terraform | — | — |
| f4 — Aprovisionamiento de Base de Datos | Configuración de conexión a base de datos en Java | `api/src/main/java/com/example/orders/infrastructure/config/DatabaseConfig.java:DatabaseConfig` | Recursos de base de datos (RDS, DynamoDB) aprovisionados correctamente; Configuración de base de datos válida y aplicable mediante Terraform | — | — |

## Pruebas de aceptacion y ubicacion de la logica

Las pruebas de aceptacion (columna "Prueba" de la tabla) son de **solo lectura**: definen que significa "listo". No las edites, no las borres y no les agregues `skip`; lo que se resuelve es el codigo de cada pieza.

La logica de cada pieza va en su archivo; no la muevas a otro.

## Restricciones del pedido

| Restriccion | Donde se cumple | Estado |
|-------------|-----------------|--------|
| Usar modulos de Terraform separados por red, computo y base de datos (un directorio por modulo) | chequeo estatico (code): exige `module "network"`, `module "compute"`, `module "database"` | Verificada |
| No usar Lombok en el codigo Java | chequeo estatico (code): prohibe `@Data`, `@Getter`, `@Setter`, `@Builder`, `lombok` | Verificada |
| Guardar el estado remoto de Terraform en un backend S3 declarado en el codigo de infraestructura | chequeo estatico (code): exige `backend "s3"` | Verificada |

## Lo que falta y tenes que completar

Referencias no verificadas para: .hcl. El analisis estatico no cubre esos lenguajes: que no se haya listado nada NO garantiza que no haya referencias colgando. Corre el comando de verificacion para encontrarlas.

### Presentes (21)

- `infra/README.md`
- `infra/environments/dev/terraform.tfvars`
- `infra/versions.tf`
- `infra/providers.tf`
- `infra/modules/network/vpc.tf`
- `infra/modules/compute/ec2.tf`
- `infra/modules/database/rds.tf`
- `infra/environments/dev/main.tf`
- `infra/tests/acceptance/f1.tftest.hcl`
- `infra/variables.tf`
- `infra/backend.tf`
- `infra/outputs.tf`
- `infra/modules/structure.tf`
- `infra/environments/dev/variables.tf`
- `infra/modules/compute/variables.tf`
- `infra/modules/database/variables.tf`
- `infra/modules/network/variables.tf`
- `api/src/main/java/Application.java`
- `api/pom.xml`
- `api/src/main/java/com/example/orders/infrastructure/config/DatabaseConfig.java`
- `api/src/main/resources/application.yml`

### Capas del patron declarado

Son las capas que la propuesta arquitectonica plantea, marcadas segun existan hoy en el repo. Orientan donde poner el codigo nuevo; no son una condicion para compilar.

- `infra` (presente)
- `infra/modules/network` (presente)
- `infra/modules/compute` (presente)
- `infra/modules/database` (presente)
- `infra/environments` (presente)
- `api` (presente)
- `api/src/main/java/com/example/orders/infrastructure/config` (presente)
- `api/src/main/resources` (presente)

## Verificacion

```bash
(cd infra && terraform init -backend=false && terraform -chdir=modules init -backend=false && terraform -chdir=environments/dev init -backend=false && terraform -chdir=modules/compute init -backend=false && terraform -chdir=modules/database init -backend=false && terraform -chdir=modules/network init -backend=false && terraform validate && terraform -chdir=modules validate && terraform -chdir=environments/dev validate && terraform -chdir=modules/compute validate && terraform -chdir=modules/database validate && terraform -chdir=modules/network validate) && (cd api && mvn -q -B -DskipTests -Dspring-boot.repackage.skip=true package)
```

El comando tiene que pasar SIN implementar los archivos de la superficie de practica: solo andamiaje.

Ese comando pasando es la definicion de "terminado" para vos.

## Convenciones que tenes que respetar

- Un solo ecosistema: no declares librerias de otro lenguaje ni mezcles gestores de paquetes.
- Toda libreria que uses tiene que estar declarada en el manifiesto de dependencias.
- Todo import declarado tiene que usarse; todo tipo usado tiene que existir o venir de una dependencia declarada.
- Cada componente vive en su carpeta: instala y compila dentro de ella, y no muevas archivos entre componentes.
- Respeta los contratos entre componentes (endpoints, topics) tal como estan declarados en el mapa de componentes.
- El patron es **modular con backend remoto S3**: los contratos (interfaces, puertos) los define la capa interna y los implementa la externa, nunca al revés.
- Los archivos que crees llevan implementacion real, no stubs: sin `TODO`, sin cuerpos vacios, sin `// getters y setters`.

## Contexto del candidato

Sirve para calibrar el nivel del codigo, no para resolver las fases.

- Perfil: Chapter Backend, Especialidad Desarrollador, Tecnología Java, Senior L2
- Brecha que el reto ataca: Aprovisionar infraestructura con Terraform
- Mision: Versionar la infraestructura del servicio

---

*Generado por Challenge Generator — Pragma. `README.md` tiene el enunciado completo del reto para la persona. `PROMPT_MEJORA.md` es la variante para pegar en un chat, si se prefiere ese flujo.*
