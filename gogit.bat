@echo off
setlocal

REM Check for help command
if "%~1"=="--help" (
    echo.
    echo Usage: gogit [remote-name]
    echo        gogit show
    echo        gogit --help
    echo.
    echo Opens the remote Git URL in your browser.
    echo If no remote name is provided, defaults to 'origin'.
    echo.
    exit /b 0
)

REM Check for 'show' command
if "%~1"=="show" (
    git remote -v
    exit /b 0
)

REM Default to 'origin' if no remote is given
set "REMOTE_NAME=%~1"
if "%REMOTE_NAME%"=="" set "REMOTE_NAME=origin"

REM Check if inside a Git repository
git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (
    echo Not a Git repository.
    exit /b 1
)

REM Get the remote URL
for /f "delims=" %%i in ('git remote get-url %REMOTE_NAME% 2^>nul') do set "REMOTE_URL=%%i"

if not defined REMOTE_URL (
    echo Remote '%REMOTE_NAME%' not found or has no URL.
    echo.
    echo Available remotes:
    git remote
    exit /b 1
)

REM Convert SSH to HTTPS if needed
set "URL=%REMOTE_URL%"
echo %URL% | findstr /r "^git@.*:.*\.git$" >nul
if not errorlevel 1 (
    set "URL=%URL:git@=https://%"
    set "URL=%URL::=/%"
)

REM Remove .git suffix
setlocal enabledelayedexpansion
set "URL=!URL:.git=!"
endlocal & set "URL=%URL%"

echo Opening: %URL%
start "" "%URL%"