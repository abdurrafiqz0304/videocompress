@echo off
title TITANIUM // UNINSTALLER
color 0E
cls

echo.
echo  ================================================
echo   SYSTEM PURGE PROTOCOL
echo  ================================================
echo.

:: 1. CLEAN PYTHON CACHE
if exist "__pycache__" (
    rmdir /s /q "__pycache__"
    echo  [REMOVED] Python Cache Artifacts.
)

:: 2. REMOVE SHORTCUT
if exist "%USERPROFILE%\Desktop\Video Compressor.lnk" (
    del "%USERPROFILE%\Desktop\Video Compressor.lnk"
    echo  [REMOVED] Desktop Shortcut.
)

echo.
echo  ------------------------------------------------
echo   WARNING: DATA DESTRUCTION IMMINENT
echo  ------------------------------------------------
echo  Do you want to delete the video folders?
echo   - videos_raw
echo   - videos_compressed
echo.
echo  (All videos inside will be lost forever)
echo.

set /p choice=" >> CONFIRM DELETION? (Y/N): "

if /i "%choice%"=="Y" (
    if exist "videos_raw" rmdir /s /q "videos_raw"
    if exist "videos_compressed" rmdir /s /q "videos_compressed"
    echo.
    echo  [REMOVED] Video Data Sectors Purged.
) else (
    echo.
    echo  [SAVED] Video Data Sectors Retained.
)

echo.
echo  ================================================
echo   PURGE COMPLETE.
echo  ================================================
pause