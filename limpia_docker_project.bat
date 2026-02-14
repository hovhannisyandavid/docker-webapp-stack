@echo off
echo ================================================
echo   Limpieza del proyecto Docker Web App Stack
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

echo Deteniendo contenedores...
docker-compose down

echo Eliminando contenedores detenidos...
docker container prune -f

echo Eliminando volumenes persistentes del proyecto...
docker volume rm docker-webapp-stack_web_content >nul 2>&1
docker volume rm docker-webapp-stack_db_data >nul 2>&1

echo Eliminando volumenes huérfanos...
docker volume prune -f

echo Eliminando imagenes no utilizadas...
docker image prune -f

echo Eliminando redes no utilizadas...
docker network prune -f

echo.
echo ================================================
echo   Limpieza completada.
echo   El proyecto esta completamente reseteado.
echo ================================================
pause
