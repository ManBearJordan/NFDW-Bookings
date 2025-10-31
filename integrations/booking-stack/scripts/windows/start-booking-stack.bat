@echo off
setlocal
cd /d %~dp0\..\..
docker compose pull
docker compose up -d
echo.
echo Booking stack is starting:
echo - Easy!Appointments: http://localhost:8080
echo - Node-RED:          http://localhost:1880
endlocal
