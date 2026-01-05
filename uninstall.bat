@echo off
title TITANIUM // SYSTEM PURGE
color 0E
cls

echo.
echo  ================================================
echo   SYSTEM PURGE PROTOCOL
echo  ================================================
echo.

:: CLEAN CACHE
if exist "__pycache__" (
    rmdir /s /q "__pycache__"
    echo  [REMOVED] Python Cache Artifacts.
)

:: REMOVE SHORTCUT
if exist "%USERPROFILE%\Desktop\Video Compressor.lnk" (
    del "%USERPROFILE%\Desktop\Video Compressor.lnk"
    echo  [REMOVED] Desktop Entry.
)

echo.
echo  Do you wish to delete 'videos_raw' and 'videos_compressed'?
echo  [WARNING] THIS ACTION CANNOT BE UNDONE.
echo.
set /p choice=" CONFIRM DELETION (Y/N): "

if /i "%choice%"=="Y" (
    if exist "videos_raw" rmdir /s /q "videos_raw"
    if exist "videos_compressed" rmdir /s /q "videos_compressed"
    echo  [REMOVED] Data Sectors Purged.
) else (
    echo  [SAVED] Data Sectors Retained.
)

echo.
echo  ================================================
echo   PURGE COMPLETE.
echo  ================================================
pause