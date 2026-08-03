@echo off
cd /d "%~dp0"

if not exist "caddy_windows_amd64.exe" (
    echo caddy_windows_amd64.exe not found.
    echo Put caddy_windows_amd64.exe in this folder:
    echo %~dp0
    pause
    exit /b 1
)

if not exist "Caddyfile" (
    echo Caddyfile not found.
    echo Put Caddyfile in this folder:
    echo %~dp0
    pause
    exit /b 1
)

echo Starting Caddy from:
echo %cd%
echo.
echo Test URL:
echo http://localhost/distribution.json
echo.

"%~dp0caddy_windows_amd64.exe" run --config "%~dp0Caddyfile"
pause
