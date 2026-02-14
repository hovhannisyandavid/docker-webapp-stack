@echo off
echo ================================================
echo   Creando proyecto Docker Web App Stack...
echo ================================================

REM Crear carpetas
mkdir docker-webapp-stack
mkdir docker-webapp-stack\docs
mkdir docker-webapp-stack\app

REM Crear README.md
echo # Docker Web Application Stack> docker-webapp-stack\README.md
echo.>> docker-webapp-stack\README.md
echo Este proyecto implementa una aplicacion web contenerizada utilizando Docker y Docker Compose.>> docker-webapp-stack\README.md
echo Incluye:>> docker-webapp-stack\README.md
echo - Servidor web Nginx>> docker-webapp-stack\README.md
echo - Base de datos MariaDB>> docker-webapp-stack\README.md
echo - Volumenes persistentes>> docker-webapp-stack\README.md
echo - Documentacion profesional>> docker-webapp-stack\README.md
echo.>> docker-webapp-stack\README.md
echo ## Como iniciar el entorno>> docker-webapp-stack\README.md
echo docker-compose up -d>> docker-webapp-stack\README.md
echo.>> docker-webapp-stack\README.md
echo Accede a la aplicacion en: http://localhost:8080>> docker-webapp-stack\README.md

REM Crear docker-compose.yml
echo version: "3.9"> docker-webapp-stack\docker-compose.yml
echo.>> docker-webapp-stack\docker-compose.yml
echo services:>> docker-webapp-stack\docker-compose.yml
echo   web:>> docker-webapp-stack\docker-compose.yml
echo     build: ./app>> docker-webapp-stack\docker-compose.yml
echo     container_name: webapp>> docker-webapp-stack\docker-compose.yml
echo     ports:>> docker-webapp-stack\docker-compose.yml
echo       - "8080:80">> docker-webapp-stack\docker-compose.yml
echo     volumes:>> docker-webapp-stack\docker-compose.yml
echo       - web_content:/usr/share/nginx/html>> docker-webapp-stack\docker-compose.yml
echo     depends_on:>> docker-webapp-stack\docker-compose.yml
echo       - db>> docker-webapp-stack\docker-compose.yml
echo.>> docker-webapp-stack\docker-compose.yml
echo   db:>> docker-webapp-stack\docker-compose.yml
echo     image: mariadb:10.6>> docker-webapp-stack\docker-compose.yml
echo     container_name: mariadb>> docker-webapp-stack\docker-compose.yml
echo     restart: always>> docker-webapp-stack\docker-compose.yml
echo     environment:>> docker-webapp-stack\docker-compose.yml
echo       MYSQL_ROOT_PASSWORD: ${DB_ROOT_PASSWORD}>> docker-webapp-stack\docker-compose.yml
echo       MYSQL_DATABASE: ${DB_NAME}>> docker-webapp-stack\docker-compose.yml
echo       MYSQL_USER: ${DB_USER}>> docker-webapp-stack\docker-compose.yml
echo       MYSQL_PASSWORD: ${DB_PASSWORD}>> docker-webapp-stack\docker-compose.yml
echo     volumes:>> docker-webapp-stack\docker-compose.yml
echo       - db_data:/var/lib/mysql>> docker-webapp-stack\docker-compose.yml
echo.>> docker-webapp-stack\docker-compose.yml
echo volumes:>> docker-webapp-stack\docker-compose.yml
echo   web_content:>> docker-webapp-stack\docker-compose.yml
echo   db_data:>> docker-webapp-stack\docker-compose.yml

REM Crear .env
echo DB_ROOT_PASSWORD=rootpass123> docker-webapp-stack\.env
echo DB_NAME=projectdb>> docker-webapp-stack\.env
echo DB_USER=projectuser>> docker-webapp-stack\.env
echo DB_PASSWORD=password123>> docker-webapp-stack\.env

REM Crear Dockerfile
echo FROM nginx:latest> docker-webapp-stack\app\Dockerfile
echo COPY index.html /usr/share/nginx/html/index.html>> docker-webapp-stack\app\Dockerfile

REM Crear index.html
echo ^<!DOCTYPE html^> > docker-webapp-stack\app\index.html
echo ^<html^> >> docker-webapp-stack\app\index.html
echo ^<head^> >> docker-webapp-stack\app\index.html
echo     ^<title^>Docker Web App^</title^> >> docker-webapp-stack\app\index.html
