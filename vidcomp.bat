@echo off
title TITANIUM // ACTIVE SESSION
color 0C
cls

:: --- AUTO-LOCATE LOGIC ---
:: Simpan lokasi asal user (kalau perlu balik)
pushd "%~dp0"

echo.
echo  ================================================
echo   TITANIUM COMPRESSOR // SYSTEM BOOT
echo  ================================================
echo.

:: 1. CHECK PYTHON
python --version >nul 2>&1
if %errorlevel% neq 0 (
    color 4F
    echo  [CRITICAL] PYTHON NOT INSTALLED.
    pause
    popd
    exit /b
)

:: 2. CHECK SCRIPT
if not exist "videocompress.py" (
    color 4F
    echo  [CRITICAL] CORE MISSING: videocompress.py
    echo  Looking in: %CD%
    pause
    popd
    exit /b
)

:: 3. EXECUTE
python videocompress.py

:: 4. CLEANUP
echo.
echo  ================================================
echo   SESSION TERMINATED.
echo  ================================================
:: Kembali ke folder asal user (optional)
popd
pause >nul