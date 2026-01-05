@echo off
title TITANIUM // SETUP WIZARD
color 0B
cls

echo.
echo  ================================================
echo   INITIALIZING WORKSPACE ENVIRONMENTS
echo  ================================================
echo.

:: 1. CREATE DIRECTORIES
if not exist "videos_raw" (
    mkdir "videos_raw"
    echo  [OK] Input Sector Created (videos_raw).
) else (
    echo  [OK] Input Sector Exists.
)

if not exist "videos_compressed" (
    mkdir "videos_compressed"
    echo  [OK] Output Sector Created (videos_compressed).
) else (
    echo  [OK] Output Sector Exists.
)

echo.

:: 2. CHECK FFMPEG BINARIES
if exist "ffmpeg.exe" (
    echo  [OK] FFmpeg Core Detected.
) else (
    color 0E
    echo  [WARNING] 'ffmpeg.exe' NOT FOUND IN ROOT FOLDER.
    echo  ---------------------------------------------------
    echo   Please download 'ffmpeg.exe' and paste it here
    echo   before running the compressor.
    echo  ---------------------------------------------------
)

echo.

:: 3. GENERATE DESKTOP SHORTCUT
echo  [..] Generating Desktop Shortcut...

set SCRIPT="%TEMP%\MakeShortcut.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") > %SCRIPT%
echo sLinkFile = oWS.ExpandEnvironmentStrings("%%USERPROFILE%%\Desktop\Video Compressor.lnk") >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "%~dp0vidcomp.bat" >> %SCRIPT%
echo oLink.WorkingDirectory = "%~dp0" >> %SCRIPT%
echo oLink.Description = "Launch Titanium Compressor" >> %SCRIPT%
:: Guna icon folder standard windows
echo oLink.IconLocation = "%SystemRoot%\System32\shell32.dll, 238" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%

cscript /nologo %SCRIPT%
del %SCRIPT%

echo  [OK] Shortcut deployed to Desktop.

echo.
echo  ================================================
echo   SETUP COMPLETE.
echo  ================================================
echo.
echo  You can now launch the tool via the Desktop Shortcut.
pause