# Aprovisionamiento de Infraestructura con Terraform

El servicio de ordenes requiere una infraestructura robusta y versionada en AWS. Utilizarás Terraform para aprovisionar la infraestructura, separando los módulos por red, computo y base de datos. El estado remoto de Terraform se guardará en un backend S3 declarado en el código de infraestructura. No se permitirá el uso de Lombok en el código Java.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | Infraestructura como codigo para el servicio de ordenes |
| **Nivel** | senior-l2 |
| **Tipo** | practical |
| **Tiempo estimado** | 8 horas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Tener el proyecto base del reto funcionando en tu máquina: clonar el repositorio, instalar las herramientas y verificar que compila y arranca antes de empezar a practicar.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Instala las herramientas para ejecutar el proyecto: JDK 17+ y Maven 3.9+ · Terraform 1.5+.
- Clona el repositorio del reto (el enlace viene en la entrega del reto y en la sección "Repositorio del Proyecto" del PDF) y ábrelo en tu IDE.
- Instala las dependencias y compila ejecutando `(cd infra && terraform init -backend=false && terraform -chdir=modules init -backend=false && terraform -chdir=environments/dev init -backend=false && terraform -chdir=modules/compute init -backend=false && terraform -chdir=modules/database init -backend=false && terraform -chdir=modules/network init -backend=false && terraform validate && terraform -chdir=modules validate && terraform -chdir=environments/dev validate && terraform -chdir=modules/compute validate && terraform -chdir=modules/database validate && terraform -chdir=modules/network validate) && (cd api && mvn -q -B -DskipTests -Dspring-boot.repackage.skip=true package)` en la raíz del repositorio.
- Confirma que el comando termina sin errores: el proyecto arranca y sus pruebas corren.
- Ubica los archivos de práctica: son los que contienen `TODO(reto)` (búscalos en el repositorio). Lee el README.md y el AGENTS.md antes de empezar.

**Entregable:** El proyecto compila/arranca sin errores con `(cd infra && terraform init -backend=false && terraform -chdir=modules init -backend=false && terraform -chdir=environments/dev init -backend=false && terraform -chdir=modules/compute init -backend=false && terraform -chdir=modules/database init -backend=false && terraform -chdir=modules/network init -backend=false && terraform validate && terraform -chdir=modules validate && terraform -chdir=environments/dev validate && terraform -chdir=modules/compute validate && terraform -chdir=modules/database validate && terraform -chdir=modules/network validate) && (cd api && mvn -q -B -DskipTests -Dspring-boot.repackage.skip=true package)`.

<details>
<summary>Pistas de conocimiento</summary>

- Los archivos con `TODO(reto)` son el ejercicio: el resto del repositorio ya está resuelto y no hace falta tocarlo.
- Si el comando de verificación falla, revisa la versión de las herramientas instaladas antes de modificar código.
- AGENTS.md describe el reto, el comando de verificación y las reglas del repositorio.

</details>

### Fase 1: Configuración Inicial

**Objetivo:** Configurar el entorno de Terraform y separar los módulos por red, computo y base de datos.

**Tiempo estimado:** 2 horas

**Instrucciones:**

- Crear la estructura de directorios para los módulos de Terraform.
- Configurar el backend remoto de Terraform en S3.
- Asegurarse de que no se use Lombok en el código Java.

**Entregable:** Estructura de directorios de Terraform con módulos separados y backend remoto configurado.

<details>
<summary>Pistas de conocimiento</summary>

- Terraform permite la gestión de infraestructura como código.
- Los módulos de Terraform ayudan a organizar y reutilizar código.

</details>

### Fase 2: Aprovisionamiento de Red

**Objetivo:** Aprovisionar la red necesaria para el servicio de ordenes utilizando Terraform.

**Tiempo estimado:** 2 horas

**Instrucciones:**

- Implementar la pieza `p3` en el componente `infra` con el símbolo `module.network`
- Asegurar que la pieza declare exclusivamente los recursos de red (VPC, subnets, security groups)
- Probar los casos de aceptación de `p3` para validar la creación y configuración de la red

**Entregable:** Módulo de red de Terraform completamente configurado y versionado

<details>
<summary>Pistas de conocimiento</summary>

- La red es la base de cualquier infraestructura en la nube.
- Las configuraciones de VPC y subredes son críticas para la seguridad y el rendimiento.

</details>

### Fase 3: Aprovisionamiento de Computo

**Objetivo:** Aprovisionar los recursos de computo necesarios para el servicio de ordenes utilizando Terraform.

**Tiempo estimado:** 2 horas

**Instrucciones:**

- Implementar la pieza `p4` en el componente `infra` con el símbolo `module.compute`
- Asegurar que la pieza declare exclusivamente los recursos de computo (ECS, EC2, load balancers)
- Probar los casos de aceptación de `p4` para validar la creación y configuración del computo

**Entregable:** Módulo de computo de Terraform completamente configurado y versionado

<details>
<summary>Pistas de conocimiento</summary>

- Los recursos de computo son esenciales para ejecutar el servicio.
- Las instancias EC2 deben estar bien configuradas para cumplir con los requisitos del servicio.

</details>

### Fase 4: Aprovisionamiento de Base de Datos

**Objetivo:** Aprovisionar la base de datos necesaria para el servicio de ordenes utilizando Terraform.

**Tiempo estimado:** 2 horas

**Instrucciones:**

- Implementar la pieza `p5` en el componente `infra` con el símbolo `module.database`
- Asegurar que la pieza declare exclusivamente los recursos de base de datos (RDS, DynamoDB)
- Probar los casos de aceptación de `p5` para validar la creación y configuración de la base de datos

**Entregable:** Módulo de base de datos de Terraform completamente configurado y versionado

<details>
<summary>Pistas de conocimiento</summary>

- La base de datos es crítica para el almacenamiento y recuperación de datos.
- Las configuraciones de RDS o Aurora deben estar optimizadas para el rendimiento y la escalabilidad.

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué es Terraform y cómo se utiliza para aprovisionar infraestructura?
- **paraQueSirve**: ¿Para qué sirve separar los módulos de Terraform por red, computo y base de datos?
- **comoSeUsa**: ¿Cómo se configura el backend remoto de Terraform en S3?
- **queDecisionesImplica**: ¿Qué decisiones implica el aprovisionamiento de la red y cómo afectan al servicio de ordenes?

## Criterios de Evaluacion

- Configuración correcta de la estructura de directorios de Terraform con módulos separados.
- Configuración correcta del backend remoto de Terraform en S3.
- Aprovisionamiento correcto de la red utilizando Terraform.
- Aprovisionamiento correcto de los recursos de computo utilizando Terraform.
- Aprovisionamiento correcto de la base de datos utilizando Terraform.

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

## Pruebas de aceptacion

Las pruebas de aceptacion (columna "Prueba" de la tabla) son de **solo lectura**: definen que significa "listo". No las edites, no las borres y no les agregues `skip`; lo que se resuelve es el codigo de cada pieza.

## Restricciones del pedido

| Restriccion | Donde se cumple | Estado |
|-------------|-----------------|--------|
| Usar modulos de Terraform separados por red, computo y base de datos (un directorio por modulo) | chequeo estatico (code): exige `module "network"`, `module "compute"`, `module "database"` | Verificada |
| No usar Lombok en el codigo Java | chequeo estatico (code): prohibe `@Data`, `@Getter`, `@Setter`, `@Builder`, `lombok` | Verificada |
| Guardar el estado remoto de Terraform en un backend S3 declarado en el codigo de infraestructura | chequeo estatico (code): exige `backend "s3"` | Verificada |

## Mapa de componentes

El repo tiene una carpeta por componente. Cada uno se instala y verifica dentro de la suya.

| Componente | Carpeta | Rol | Capa | Track | Tecnologias |
|---|---|---|---|---|---|
| `infra` | `infra/` | practice | infra | Terraform (AWS) | Terraform |
| `api` | `api/` | chapter, support | server | Java | - |

## Orden de arranque

1. `cd infra && terraform init -backend=false && terraform -chdir=modules init -backend=false && terraform -chdir=environments/dev init -backend=false && terraform -chdir=modules/compute init -backend=false && terraform -chdir=modules/database init -backend=false && terraform -chdir=modules/network init -backend=false && terraform validate && terraform -chdir=modules validate && terraform -chdir=environments/dev validate && terraform -chdir=modules/compute validate && terraform -chdir=modules/database validate && terraform -chdir=modules/network validate` — componente `infra` (practice).
2. `cd api && mvn -q -B -DskipTests -Dspring-boot.repackage.skip=true package` — componente `api` (chapter, support).

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
(cd infra && terraform init -backend=false && terraform -chdir=modules init -backend=false && terraform -chdir=environments/dev init -backend=false && terraform -chdir=modules/compute init -backend=false && terraform -chdir=modules/database init -backend=false && terraform -chdir=modules/network init -backend=false && terraform validate && terraform -chdir=modules validate && terraform -chdir=environments/dev validate && terraform -chdir=modules/compute validate && terraform -chdir=modules/database validate && terraform -chdir=modules/network validate) && (cd api && mvn -q -B -DskipTests -Dspring-boot.repackage.skip=true package)
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
