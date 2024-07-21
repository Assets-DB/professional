# database

## Diagrama de Entidad-Relación (DER)
![alt text](./der/professional_der.png)

# Estructura de la Base de Datos

## Tabla "professional"

### Estructura
La tabla "professional" tiene la siguiente estructura:

| Columna            | Tipo              | Restricciones                              |
|--------------------|-------------------|--------------------------------------------|
| `professional_id`  | **PRIMARY KEY**   |                                            |
| `name`             | **VARCHAR(100)**  | NOT NULL                                   |
| `last_name`        | **VARCHAR(100)**  | NOT NULL                                   |
| `profile`          | **VARCHAR(100)**  | NOT NULL UNIQUE                            |
| `phone`            | **VARCHAR(30)**   |                                            |
| `email`            | **VARCHAR(255)**  |                                            |
| `password`         | **VARCHAR(255)**  | NOT NULL                                   |
| `gender`           | **gender_options**| NOT NULL                                   |
| `deleted_at`       | **TIMESTAMP**     |                                            |
| `created_at`       | **TIMESTAMP**     | NOT NULL DEFAULT CURRENT_TIMESTAMP         |
| `updated_at`       | **TIMESTAMP**     | NOT NULL DEFAULT CURRENT_TIMESTAMP         |

| Índice Único                                                            |
|-------------------------------------------------------------------------|
| `UNIQUE INDEX ((CASE WHEN email IS NOT NULL THEN email END))`           |
| `UNIQUE INDEX ((CASE WHEN phone IS NOT NULL THEN phone END))`           |

### Descripción
[COMPLETAR_DESCRIPCION]

***

## Tabla "professional_detail"

### Estructura
La tabla "professional" tiene la siguiente estructura:

| Columna           | Tipo                | Restricciones                               |
|-------------------|---------------------|---------------------------------------------|
| `detail_id`       | **PRIMARY KEY**     | REFERENCES "professional"(professional_id)  |
| `cuit`            | **VARCHAR(20)**     |                                             |
| `fiscal_status`   | **fiscal_status**   |                                             |
| `birthdate`       | **DATE**            |                                             |
| `bank`            | **VARCHAR(255)**    |                                             |
| `bank_account`    | **VARCHAR(50)**     |                                             |
| `cbu`             | **VARCHAR(23)**     |                                             |
| `alias`           | **VARCHAR(50)**     |                                             |
| `created_at`      | **TIMESTAMP**       | NOT NULL DEFAULT CURRENT_TIMESTAMP          |
| `updated_at`      | **TIMESTAMP**       | NOT NULL DEFAULT CURRENT_TIMESTAMP          |

### Descripción
[COMPLETAR_DESCRIPCION]