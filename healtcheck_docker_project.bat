@echo off
echo ================================================
echo        Health Check - Docker Web App Stack
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
echo   1. Comprobando estado de contenedores
echo ================================================
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

echo.
echo ================================================
echo   2. Comprobando respuesta del servidor web
echo ================================================
powershell -command "(Invoke-WebRequest -Uri http://localhost:8080 -UseBasicParsing).StatusCode" > web_status.tmp 2>nul

IF EXIST web_status.tmp (
    set /p WEBSTATUS=<web_status.tmp
    del web_status.tmp
    IF "%WEBSTATUS%"=="200" (
        echo Web OK - Responde con HTTP 200
    ) ELSE (
        echo ADVERTENCIA: La web responde con codigo %WEBSTATUS%
    )
) ELSE (
    echo ERROR: No se pudo contactar con el servidor web.
)

echo.
echo ================================================
echo   3. Comprobando acceso a MariaDB
echo ================================================
docker exec mariadb mysql -u root -p%DB_ROOT_PASSWORD% -e "SELECT 1;" >nul 2>&1

IF %ERRORLEVEL% EQU 0 (
    echo MariaDB OK - Responde correctamente
) ELSE (
    echo ERROR: No se pudo conectar a MariaDB
)

echo.
echo ================================================
echo   4. Comprobando volumenes persistentes
echo ================================================
docker volume ls | findstr "docker-webapp-stack_web_content" >nul
IF %ERRORLEVEL% EQU 0 (
    echo Volumen web_content OK
) ELSE (
    echo ERROR: Volumen web_content no encontrado
)

docker volume ls | findstr "docker-webapp-stack_db_data" >nul
IF %ERRORLEVEL% EQU 0 (
    echo Volumen db_data OK
) ELSE (
    echo ERROR: Volumen db_data no encontrado
)

echo.
echo ================================================
echo   5. Resumen final
echo ================================================

echo Contenedores activos:
docker ps --format "table {{.Names}}\t{{.Status}}"

echo.
echo Health check completado.
echo ================================================
pause
