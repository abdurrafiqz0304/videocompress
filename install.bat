@echo off
title TITANIUM // INITIAL SETUP
color 0B
cls

echo.
echo  ================================================
echo   INITIALIZING WORKSPACE ENVIRONMENTS
echo  ================================================
echo.

:: CREATE FOLDERS
if not exist "videos_raw" mkdir "videos_raw"
if not exist "videos_compressed" mkdir "videos_compressed"
echo  [OK] Data Sectors Created.

:: CHECK FFMPEG
if exist "ffmpeg.exe" (
    echo  [OK] FFmpeg Binaries Detected.
) else (
    color 0E
    echo  [WARN] FFmpeg binaries missing from root.
    echo         Transfer ffmpeg.exe manually.
)

:: CREATE DESKTOP SHORTCUT
echo  [..] Generating Desktop Shortcut...
set SCRIPT="%TEMP%\MakeShortcut.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") > %SCRIPT%
echo sLinkFile = oWS.ExpandEnvironmentStrings("%%USERPROFILE%%\Desktop\Video Compressor.lnk") >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "%~dp0vidcomp.bat" >> %SCRIPT%
echo oLink.WorkingDirectory = "%~dp0" >> %SCRIPT%
echo oLink.Description = "Launch Video Compressor" >> %SCRIPT%
echo oLink.IconLocation = "%SystemRoot%\System32\imageres.dll, 15" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del %SCRIPT%

echo.
echo  [OK] CONFIGURATION COMPLETE.
echo  ================================================
pause