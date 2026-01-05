@echo off
title TITANIUM // AUTO-UPDATER
color 0D
cls

echo.
echo  ================================================
echo   SYSTEM UPDATE PROTOCOL INITIATED
echo  ================================================
echo.

:: 1. DOWNLOAD LATEST VERSION
echo  [..] CONNECTING TO GITHUB SERVER...
echo       (Downloading latest source code...)
curl -k -L -o titanium_update.zip https://github.com/abdurrafiqz0304/videocompress/archive/refs/heads/main.zip

if %errorlevel% neq 0 (
    color 0C
    echo.
    echo  [ERROR] DOWNLOAD FAILED. CHECK INTERNET CONNECTION.
    del titanium_update.zip >nul 2>&1
    pause
    exit
)

:: 2. EXTRACT UPDATE
echo  [..] EXTRACTING PACKAGES...
tar -xf titanium_update.zip

:: 3. INSTALL & REPLACE (OVERWRITE FILES)
echo  [..] OVERWRITING OLD FILES...
:: Pindahkan isi folder 'videocompress-main' ke folder semasa
xcopy "videocompress-main\*" "." /E /Y /C >nul

:: 4. CLEANUP
echo  [..] REMOVING TEMP FILES...
del titanium_update.zip
rmdir /s /q "videocompress-main"

:: 5. RE-RUN SETUP
echo.
echo  [SUCCESS] SYSTEM UPDATED TO LATEST VERSION.
echo  [..] Re-initializing dependencies...
echo.

:: Panggil install.bat untuk pastikan environment stable
call install.bat