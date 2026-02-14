@echo off
echo ================================================
echo   Creando estructura del proyecto Docker...
echo ================================================

REM Crear carpetas principales
mkdir docker-webapp-stack
mkdir docker-webapp-stack\docs
mkdir docker-webapp-stack\app

REM Crear archivos vacíos
type nul > docker-webapp-stack\README.md
type nul > docker-webapp-stack\docker-compose.yml
type nul > docker-webapp-stack\.env

type nul > docker-webapp-stack\docs\architecture.md
type nul > docker-webapp-stack\docs\deployment_guide.md
type nul > docker-webapp-stack\docs\troubleshooting.md
type nul > docker-webapp-stack\docs\volumes.md

type nul > docker-webapp-stack\app\Dockerfile
type nul > docker-webapp-stack\app\index.html

echo.
echo ================================================
echo   Estructura creada correctamente.
echo   Ahora puedes pegar el contenido en cada archivo.
echo ================================================
pause
