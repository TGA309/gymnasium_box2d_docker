@echo off

:: Note: Do not run using batch-runner or any other VSCode extensions as then it cannot retrieve the ipv4 address of the machine.

:: Change to the directory where the script is located
cd /d %~dp0

:: Check if running on Windows
ver | findstr /I "Windows" >nul
if errorlevel 1 (
    echo This script is designed for Windows systems. Use start.sh on Linux.
    PAUSE
    exit /b 1
)

:: Check if running as administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This script requires administrative privileges to set up the DISPLAY environment variable for VcXsrv.
    echo Kindly rerun the script as an Administrator.
    PAUSE
    exit /b 1
)

:: Check if VcXsrv is in the PATH
echo Checking if VcXsrv is in the PATH...
where vcxsrv >nul 2>&1
if %errorlevel%==0 (
    echo VcXsrv is in the PATH. Proceeding to start VcXsrv.
    goto StartVcXsrv
) else (
    echo VcXsrv is not in the PATH. Checking if it is installed locally...
)

:: Define the installation path for VcXsrv
set VCXSERV_DOWNLOAD_PATH="C:\Program Files\VcXsrv\vcxsrv.exe"
set TEMP_DIR=%CD%\vcxsrv_temp
set TEMP_PATH=%TEMP_DIR%\vcxsrv-setup.exe
set VCXSERV_URL="https://sourceforge.net/projects/vcxsrv/files/latest/download"

:: Check if VcXsrv is installed locally
if not exist %VCXSERV_DOWNLOAD_PATH% (
    echo VcXsrv is not installed. Downloading and installing VcXsrv...

    :: Create the temporary directory in the current folder
    if not exist "%TEMP_DIR%" (
        md "%TEMP_DIR%"
    )

    :: Download the installer using Start-Process instead of Invoke-WebRequest
    powershell -Command "Invoke-WebRequest -UserAgent Wget -Uri '%VCXSERV_URL%' -OutFile '%TEMP_PATH%'"

    :: Check if the installer was downloaded
    if not exist "%TEMP_PATH%" (
        echo Failed to download VcXsrv installer. Exiting...
        PAUSE
        exit /b 1
    )

    :: Run the installer silently
    echo Installing VcXsrv...
    "%TEMP_PATH%" /S

    :: Check if installation was successful
    if not exist %VCXSERV_DOWNLOAD_PATH% (
        echo Failed to install VcXsrv. Exiting...
        PAUSE
        exit /b 1
    )
    echo VcXsrv installed successfully.

    :: Clean up: delete the installer and temp directory
    echo Cleaning up temporary files...
    del /f /q "%TEMP_PATH%"
    rmdir /s /q "%TEMP_DIR%"
)

:: VcXsrv is installed but not in the system PATH, adding to the system's PATH
echo VcXsrv is installed locally!
echo.
echo Adding VcXsrv to the system PATH...
set VCXSERV_SYSTEM_PATH="C:\Program Files\VcXsrv"
powershell -Command "[Environment]::SetEnvironmentVariable('Path', [Environment]::GetEnvironmentVariable('Path', 'Machine') + ';%VCXSERV_SYSTEM_PATH%', 'Machine')"

:: Ask the user to restart the script after PATH update
echo The system PATH has been updated. Please restart this script to apply changes.
PAUSE
exit /b 0

:StartVcXsrv
:: Check if VcXsrv is running
tasklist /FI "IMAGENAME eq vcxsrv.exe" | find /I "vcxsrv.exe" >nul

:: If VcXsrv is running, kill the process
if not errorlevel 1 (
    echo VcXsrv is already running. Stopping it now...
    taskkill /F /IM vcxsrv.exe >nul
    echo VcXsrv stopped.
)

:: Write the DISPLAY environment variable to the .env file
echo Writing DISPLAY variable to .env file...
echo DISPLAY=:0 > .env

:: Start VcXsrv
echo Starting VcXsrv...
start vcxsrv :0 -multiwindow -clipboard -wgl -ac

:: Wait a moment to ensure VcXsrv starts
timeout /t 5 >nul

:: Check if VcXsrv is running
tasklist /FI "IMAGENAME eq vcxsrv.exe" | find /I "vcxsrv.exe" >nul

if errorlevel 1 (
    echo Failed to start VcXsrv. Please check your configuration.
) else (
    echo VcXsrv started successfully.
)

PAUSE
exit /b 0