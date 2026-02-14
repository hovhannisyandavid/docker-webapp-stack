@echo off
echo ================================================
echo   Mostrando logs de WEB y DB simultaneamente
echo ================================================

start cmd /k "docker logs -f webapp"
start cmd /k "docker logs -f mariadb"

echo Se han abierto dos ventanas con los logs en tiempo real.
pause
