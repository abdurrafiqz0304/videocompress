@echo off
title TITANIUM // LAUNCHER
color 0C
cls

echo.
echo  ================================================
echo   TITANIUM COMPRESSOR // SYSTEM BOOT
echo  ================================================
echo.

:: 1. CHECK PYTHON
python --version >nul 2>&1
if %errorlevel% neq 0 (
    color 4F
    echo.
    echo  [CRITICAL ERROR] PYTHON NOT INSTALLED.
    echo  Please install Python from python.org
    echo.
    pause
    exit
)

:: 2. CHECK SCRIPT CORE
if not exist "videocompress.py" (
    color 4F
    echo.
    echo  [CRITICAL ERROR] CORE MISSING: videocompress.py
    echo  Make sure the python file is named correctly.
    echo.
    pause
    exit
)

:: 3. EXECUTE
:: Run script python
python videocompress.py

:: 4. EXIT SEQUENCE
echo.
echo  ================================================
echo   SESSION TERMINATED.
echo  ================================================
pause >nul