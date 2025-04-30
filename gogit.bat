@echo off
REM Check if inside a Git repository
git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (
    echo Not a Git repository.
    exit /b 1
)

REM Get the remote URL
for /f "delims=" %%i in ('git remote get-url origin 2^>nul') do set REMOTE_URL=%%i

if not defined REMOTE_URL (
    echo No remote URL found for 'origin'.
    exit /b 1
)

REM Convert SSH to HTTPS if needed
set "URL=%REMOTE_URL%"
echo %URL% | findstr /r "^git@.*:.*\.git$" >nul
if not errorlevel 1 (
    REM Convert git@github.com:user/repo.git to https://github.com/user/repo
    set "URL=%URL:git@=https://%"
    set "URL=%URL::=/%"
)

REM Remove trailing .git if present
setlocal enabledelayedexpansion
set "URL=!URL:.git=!"
endlocal & set "URL=%URL%"

REM Open in browser
start "" "%URL%"