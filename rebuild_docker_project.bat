@echo off
echo ================================================
echo     Reconstruyendo Docker Web App Stack...
echo ================================================

REM Comprobar si Docker está instalado
echo Comprobando instalacion de Docker...
docker --version >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo ERROR: Docker no esta instalado.
    echo Instala Docker Desktop antes de continuar.
    pause
    exit /b
)
echo Docker encontrado.
echo.

REM Comprobar si existe la carpeta del proyecto
IF NOT EXIST docker-webapp-stack (
    echo ERROR: No se encuentra la carpeta docker-webapp-stack
    echo Asegurate de ejecutar este script en el directorio correcto.
    pause
    exit /b
)

cd docker-webapp-stack

echo ================================================
echo     1. Deteniendo y limpiando contenedores
echo ================================================
docker-compose down

echo Eliminando contenedores detenidos...
docker container prune -f

echo Eliminando volumenes persistentes del proyecto...
docker volume rm docker-webapp-stack_web_content >nul 2>&1
docker volume rm docker-webapp-stack_db_data >nul 2>&1

echo Eliminando volumenes huerfanos...
docker volume prune -f

echo Eliminando imagenes no utilizadas...
docker image prune -f

echo Eliminando redes no utilizadas...
docker network prune -f

echo.
echo ================================================
echo     2. Reconstruyendo imagenes
echo ================================================
docker-compose build

echo.
echo ================================================
echo     3. Levantando contenedores
echo ================================================
docker-compose up -d

echo.
echo ================================================
echo     4. Estado final de los contenedores
echo ================================================
docker ps

echo.
echo ================================================
echo   Reconstruccion completada con exito.
echo   Accede a la aplicacion en: http://localhost:8080
echo ================================================
pause
