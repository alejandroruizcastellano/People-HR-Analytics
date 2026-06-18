# 🗄️ SQL — Extracción de datos

Esta carpeta contiene la consulta utilizada para construir la tabla de empleados
enriquecida que alimenta el dashboard de Power BI.

## Fuente de datos

Base de datos pública de ejemplo de MySQL: **Employee Sample Database**
🔗 https://dev.mysql.com/doc/employee/en/

Simula el entorno de RR. HH. de una organización (empleados, salarios, títulos,
departamentos, fechas de contratación, ubicaciones).

> El volcado completo de la base de datos (`RRHH_employees_database.sql`, ~173 MB)
> **no se incluye en el repo** por superar el límite de GitHub. Descárgalo desde el
> enlace anterior y cárgalo en una instancia local de MySQL.

## Carga y conexión

1. Crear la base de datos y cargar el volcado en MySQL.
2. Ejecutar `01_query_empleados.sql` para obtener la vista de empleados.
3. Conectar Power BI directamente a MySQL usando esa consulta como origen.

## `01_query_empleados.sql`

Integra mediante `LEFT JOIN` las tablas `employees`, `titles`, `dept_emp`,
`departments`, `cities` y `country` para producir una única tabla con:

| Campo | Descripción |
|---|---|
| `emp_no` | Identificador del empleado |
| `empleado` | Nombre completo (`first_name` + `last_name`) |
| `fecha_contrato` | Fecha de contratación |
| `genero` | Masculino / Femenino / Otro |
| `fecha_nacimiento` | Fecha de nacimiento |
| `grado_academico` | Nivel de estudios |
| `cargo` | Título / puesto |
| `departamento` | Departamento |
| `cargo_desde` / `cargo_hasta` | Vigencia del cargo |
| `ubicacion` / `pais` | Localización |

> **Nota:** en las tablas `titles` y `salaries`, el valor `9999-01-01` en `to_date`
> indica el registro vigente (cargo/salario actual). Ese tratamiento se resuelve en
> Power Query (ver [`../powerbi/modelo_datos.md`](../powerbi/modelo_datos.md)).
