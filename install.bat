@echo off
title TITANIUM // SETUP & PATH INTEGRATION
color 0B
cls

echo.
echo  ================================================
echo   TITANIUM COMPRESSOR // SYSTEM INSTALLATION
echo  ================================================
echo.

:: 1. CREATE DIRECTORIES
if not exist "videos_raw" mkdir "videos_raw"
if not exist "videos_compressed" mkdir "videos_compressed"
echo  [OK] Data Sectors Initialized.

:: 2. CHECK FFMPEG
if exist "ffmpeg.exe" (
    echo  [OK] FFmpeg Binaries Detected.
) else (
    color 0E
    echo  [WARNING] 'ffmpeg.exe' MISSING!
    echo   Make sure to put ffmpeg.exe here, or the tool won't work.
)

:: 3. ADD TO WINDOWS PATH (Bahagian Penting!)
echo.
echo  [..] CONFIGURING SYSTEM PATH ENVIRONMENT...
echo       (This allows you to type 'vidcomp' from anywhere)

:: Guna PowerShell untuk tambah Path dengan selamat
set "PROJECT_PATH=%~dp0"
:: Buang backslash terakhir kalau ada
if "%PROJECT_PATH:~-1%"=="\" set "PROJECT_PATH=%PROJECT_PATH:~0,-1%"

powershell -Command "[Environment]::SetEnvironmentVariable('Path', [Environment]::GetEnvironmentVariable('Path', 'User') + ';%PROJECT_PATH%', 'User')"

echo  [OK] System Path Updated.
echo       (You may need to restart CMD for changes to take effect)

:: 4. SHORTCUT (Backup kalau user suka klik icon)
echo.
echo  [..] Creating Desktop Shortcut (Optional access)...
set SCRIPT="%TEMP%\MakeShortcut.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") > %SCRIPT%
echo sLinkFile = oWS.ExpandEnvironmentStrings("%%USERPROFILE%%\Desktop\Video Compressor.lnk") >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "%~dp0vidcomp.bat" >> %SCRIPT%
echo oLink.WorkingDirectory = "%~dp0" >> %SCRIPT%
echo oLink.Description = "Launch Titanium Compressor" >> %SCRIPT%
echo oLink.IconLocation = "%SystemRoot%\System32\shell32.dll, 238" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del %SCRIPT%

echo.
echo  ================================================
echo   INSTALLATION COMPLETE.
echo  ================================================
echo.
echo  RESTART your Command Prompt / Terminal now.
echo  Then, just type: vidcomp
echo.
pause