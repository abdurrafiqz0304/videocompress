@echo off
title TITANIUM // RUNTIME
color 0C
cls

echo.
echo  ================================================
echo   SYSTEM BOOT SEQUENCE INITIATED...
echo  ================================================
echo.

:: CHECK PYTHON
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo  [ERROR] PYTHON ENVIRONMENT NOT FOUND.
    pause
    exit
)

:: CHECK SCRIPT
if not exist "videocompress.py" (
    echo  [ERROR] MISSING CORE FILE: videocompress.py
    pause
    exit
)

:: EXECUTE
python videocompress.py

echo.
echo  ================================================
echo   PROCESS TERMINATED.
echo  ================================================
pause >nul