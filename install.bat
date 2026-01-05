@echo off
title TITANIUM // AUTO-INSTALLER & UPDATER
color 0B
cls

echo.
echo  ================================================
echo   TITANIUM COMPRESSOR // SYSTEM SETUP
echo  ================================================
echo.

:: 1. SETUP FOLDER
if not exist "videos_raw" mkdir "videos_raw"
if not exist "videos_compressed" mkdir "videos_compressed"
echo  [OK] Data Sectors Ready.

:: 2. CHECK & DOWNLOAD FFMPEG (Auto Logic)
if exist "ffmpeg.exe" (
    echo  [OK] FFmpeg Binaries Detected.
) else (
    echo.
    echo  [..] FFmpeg not found. INITIATING AUTO-DOWNLOAD...
    echo       (This is ~120MB. Please wait...)
    echo.
    
    :: Download guna curl (Built-in Windows 10/11)
    curl -L -o ffmpeg.zip https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-essentials.zip
    
    echo.
    echo  [..] Extracting FFmpeg...
    
    :: Extract guna tar
    tar -xf ffmpeg.zip
    
    :: Pindahkan ffmpeg.exe dan ffprobe.exe ke folder utama
    echo  [..] Installing Binaries...
    for /r %%i in (ffmpeg.exe) do move "%%i" . >nul
    for /r %%i in (ffprobe.exe) do move "%%i" . >nul
    
    :: Bersihkan fail sampah (Zip dan folder kosong)
    del ffmpeg.zip
    for /d %%d in (ffmpeg-*) do rmdir /s /q "%%d"
    
    echo  [OK] FFmpeg Successfully Installed!
)

:: 3. ADD TO WINDOWS PATH (Supaya boleh type 'vidcomp' kat mana-mana)
echo.
echo  [..] Configuring System Environment...
set "PROJECT_PATH=%~dp0"
if "%PROJECT_PATH:~-1%"=="\" set "PROJECT_PATH=%PROJECT_PATH:~0,-1%"
powershell -Command "[Environment]::SetEnvironmentVariable('Path', [Environment]::GetEnvironmentVariable('Path', 'User') + ';%PROJECT_PATH%', 'User')"
echo  [OK] System Path Updated.

:: 4. DESKTOP SHORTCUT
echo.
echo  [..] Creating Desktop Shortcut...
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
echo  Restart your CMD/Terminal to apply changes.
echo  Then just type: vidcomp
echo.
pause