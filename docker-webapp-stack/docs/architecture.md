# Arquitectura del Proyecto

Este proyecto implementa una aplicación web contenerizada utilizando Docker y gestionada mediante Docker Compose.  
La arquitectura se basa en dos servicios principales:

- **Nginx** como servidor web
- **MariaDB** como base de datos relacional

Ambos servicios se ejecutan en contenedores aislados y se comunican a través de una red interna creada por Docker Compose.

---

## 🧱 Componentes principales

### 1. Servicio Web (Nginx)
- Construido desde un Dockerfile personalizado ubicado en `app/`.
- Sirve contenido HTML estático.
- Expone el puerto **8080** en el host → **80** en el contenedor.
- Utiliza un volumen persistente para almacenar el contenido web.

### 2. Servicio de Base de Datos (MariaDB)
- Basado en la imagen oficial `mariadb:10.6`.
- Configurado mediante variables de entorno definidas en `.env`.
- Utiliza un volumen persistente para almacenar datos de forma duradera.

---

## 🔗 Comunicación entre servicios

Docker Compose crea automáticamente una red interna donde los contenedores pueden comunicarse por nombre:

- El contenedor web accede a la base de datos usando el hostname:  
