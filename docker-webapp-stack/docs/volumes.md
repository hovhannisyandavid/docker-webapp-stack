# Volúmenes Persistentes

Este proyecto utiliza volúmenes Docker para garantizar que los datos se mantengan incluso si los contenedores se eliminan o se reconstruyen.  
Los volúmenes permiten separar la lógica de la aplicación de los datos, asegurando persistencia y facilitando el mantenimiento.

---

## 📦 Volúmenes definidos en el proyecto

El archivo `docker-compose.yml` define dos volúmenes:

| Volumen        | Descripción                                  |
|----------------|-----------------------------------------------|
| `web_content`  | Contenido HTML servido por Nginx              |
| `db_data`      | Datos persistentes de MariaDB                 |

Estos volúmenes se crean automáticamente al ejecutar:

```bash
docker-compose up -d
