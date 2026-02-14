@echo off
title Docker Health Monitor

REM Intervalo en segundos entre cada chequeo
set INTERVAL=10

:loop
cls
echo ================================================
echo        Monitor de Salud - Docker Web Stack
echo ================================================
echo Fecha y hora: %date% %time%
echo.

REM Comprobar si Docker está instalado
docker --version >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo ERROR: Docker no esta instalado.
    echo Instala Docker Desktop antes de continuar.
    timeout /t %INTERVAL%
    goto loop
)

REM Comprobar contenedores
echo --------------------------------
echo Contenedores en ejecucion:
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
echo.

REM Comprobar estado de la web
echo --------------------------------
echo Comprobando servidor web...
powershell -command "(Invoke-WebRequest -Uri http://localhost:8080 -UseBasicParsing).StatusCode" > web_status.tmp 2>nul

IF EXIST web_status.tmp (
    set /p WEBSTATUS=<web_status.tmp
    del web_status.tmp
    IF "%WEBSTATUS%"=="200" (
        echo Web OK - HTTP 200
    ) ELSE (
        echo ADVERTENCIA: La web responde con codigo %WEBSTATUS%
    )
) ELSE (
    echo ERROR: No se pudo contactar con el servidor web.
)
echo.

REM Comprobar MariaDB
echo --------------------------------
echo Comprobando MariaDB...
docker exec mariadb mysql -u root -prootpass123 -e "SELECT 1
