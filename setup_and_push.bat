@echo off
REM Sets up this folder as a fresh git repo and pushes it to a new GitHub repo.
REM Run this AFTER you've created an empty public repo on GitHub (instructions below).

setlocal enabledelayedexpansion
cd /d "%~dp0"

echo.
echo ============================================================
echo  BALTOSim Dashboards - publish to GitHub
echo ============================================================
echo.
echo Before running this:
echo   1. Go to https://github.com/new
echo   2. Name the repo (suggestion: baltosim-dashboards)
echo   3. Choose Public
echo   4. DO NOT add a README, .gitignore, or license
echo   5. Click Create repository
echo   6. Copy the HTTPS URL it shows you, e.g.
echo        https://github.com/Davidavid45/baltosim-dashboards.git
echo.
set /p REPO_URL=Paste the new repo's HTTPS URL and press Enter:

if "%REPO_URL%"=="" (
  echo No URL provided. Exiting.
  pause
  exit /b 1
)

echo.
echo === Resetting local git state ===
if exist ".git" (
  rmdir /s /q ".git"
  echo Removed old .git folder.
)

echo.
echo === Initializing fresh repo ===
git init -b main
if errorlevel 1 goto :fail

git add .
if errorlevel 1 goto :fail

git commit -m "Add BALTOSim dashboards hub and CityLink frequency review draft"
if errorlevel 1 goto :fail

echo.
echo === Adding remote ===
git remote add origin %REPO_URL%
if errorlevel 1 goto :fail

echo.
echo === Pushing to GitHub ===
git push -u origin main
if errorlevel 1 goto :fail

echo.
echo ============================================================
echo  Done. Files are on GitHub.
echo ============================================================
echo.
echo Next - enable GitHub Pages on the new repo:
echo   1. In your browser, open the repo on GitHub
echo   2. Click Settings (top tabs)
echo   3. Click Pages (left sidebar, under Code and automation)
echo   4. Source: Deploy from a branch
echo   5. Branch: main, Folder: / (root)
echo   6. Click Save
echo   7. Wait ~60 seconds, then refresh - the live URL appears in a green box
echo.
pause
exit /b 0

:fail
echo.
echo Something went wrong. Scroll up to see the error.
pause
exit /b 1
