@echo off
title Corundum Setup

NET SESSION >nul 2>&1
if %errorlevel% NEQ 0 (
    powershell.exe -Command "Start-Process '%~0' -Verb RunAs"
    exit /b
)

if exist "%USERPROFILE%\Corundum" (
    goto CorundumInstalled
) else (
    goto StartInstallation
)

:StartInstallation
echo Installation
echo.
echo Welcome to the Corundum installation wizard.
echo.
echo The Corundum version in this package is v1.1.1-stable.
echo.
echo Please choose the installation method:
echo 1. Install Corundum on the hard disk
echo 2. Choose a location for the portable installation
set /p choice="Enter your choice: "

if "%choice%"=="1" goto StartCorundumStartup
if "%choice%"=="2" goto PortableMode

cls
goto StartInstallation

:StartCorundumStartup
cls
echo Installation
echo.
echo Corundum can be started when your Windows session starts.
echo.
echo Would you like to launch Corundum when your Windows session starts?
echo 1. Enable this option
echo 2. Disable this option
echo 3. Exit
set /p startup="Enter your choice: "

if "%startup%"=="1" goto InstallHardDiskShortcut
if "%startup%"=="2" goto InstallHardDisk
if "%startup%"=="3" goto StartInstallation

cls
goto StartCorundumStartup

:InstallHardDiskShortcut
cls
echo Installation
echo.
echo You are about to install Corundum on your local hard disk (C:). You have selected automatic execution at login for user %USERNAME%.
echo.
echo Please choose the installation method:
echo 1. Install Corundum
echo 2. Go back
set /p install="Enter your choice: "

if "%install%"=="1" goto InstallNowShortcut
if "%install%"=="2" goto StartInstallation

cls
goto InstallHardDisk

:InstallNowShortcut
cls
echo Installation
echo.
echo Thank you for choosing Corundum! In a few moments, Corundum will be installed on your computer.
echo Stay on this window, the installation won't last long!
echo.
echo Status: Creating the Corundum folder...
mkdir "%USERPROFILE%\Corundum" > nul
echo Status: Copying files...
copy "%~dp0\main.bat" "%USERPROFILE%\Corundum" > nul
copy "%~dp0\install.bat" "%USERPROFILE%\Corundum" > nul
xcopy "%~dp0\utility" "%USERPROFILE%\Corundum\utility" /s /e /i > nul
copy "%~dp0\README.md" "%USERPROFILE%\Corundum" > nul
copy "%~dp0\LICENSE" "%USERPROFILE%\Corundum" > nul
cls

:: Création du raccourci dans le menu Démarrer (peu importe le choix de démarrage)
echo Installation
echo.
echo Thank you for choosing Corundum! In a few moments you'll be able to enjoy Corundum directly on your computer.
echo Stay on this window, the installation won't last long!
echo.
echo Status: Creating the shortcut...

set "target=%USERPROFILE%\Corundum\main.bat"
set "shortcut_folder=C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Enio Aiello"
set "shortcut_name=Corundum.lnk"

if not exist "%shortcut_folder%" (
    mkdir "%shortcut_folder%"
)

set "vbs_file=%temp%\create_shortcut.vbs"
echo Set WshShell = WScript.CreateObject("WScript.Shell") > "%vbs_file%"
echo Set oShellLink = WshShell.CreateShortcut("%shortcut_folder%\%shortcut_name%") >> "%vbs_file%"
echo oShellLink.TargetPath = "%target%" >> "%vbs_file%"
echo oShellLink.Save >> "%vbs_file%"

cscript //nologo "%vbs_file%" > nul
del "%vbs_file%" > nul
cls
echo Installation
echo.
echo Thank you for choosing Corundum! In a few moments, Corundum will be installed on your computer.
echo Stay on this window, the installation won't last long!
echo.
echo Status: Adding Corundum to startup...
set "shortcut_folder=%appdata%\Microsoft\Windows\Start Menu\Programs\Startup"
if not exist "%shortcut_folder%" (
    mkdir "%shortcut_folder%"
)

set "vbs_file=%temp%\create_startup_shortcut.vbs"
echo Set WshShell = WScript.CreateObject("WScript.Shell") > "%vbs_file%"
echo Set oShellLink = WshShell.CreateShortcut("%shortcut_folder%\%shortcut_name%") >> "%vbs_file%"
echo oShellLink.TargetPath = "%target%" >> "%vbs_file%"
echo oShellLink.Save >> "%vbs_file%"

cscript //nologo "%vbs_file%" > nul
del "%vbs_file%" > nul

cls
echo Installation
echo.
echo Thank you for choosing Corundum! In a few moments you'll be able to enjoy Corundum directly on your computer.
echo Stay on this window, the installation won't last long!
echo.
echo Status: Installation completed!
timeout /t 3 > nul
goto End

:InstallHardDisk
cls
echo Installation
echo.
echo You are about to install Corundum on your local hard disk (C:).
echo.
echo Please choose the installation method:
echo 1. Install Corundum
echo 2. Go back
set /p install="Enter your choice: "

if "%install%"=="1" goto InstallNowWithoutStartup
if "%install%"=="2" goto StartInstallation

cls
goto InstallHardDisk

:InstallNowWithoutStartup
cls
echo Installation
echo.
echo Thank you for choosing Corundum! In a few moments, Corundum will be installed on your computer.
echo Stay on this window, the installation won't last long!
echo.
echo Status: Creating the Corundum folder...
mkdir "%USERPROFILE%\Corundum" > nul
echo Status: Copying files...
copy "%~dp0\main.bat" "%USERPROFILE%\Corundum" > nul
copy "%~dp0\install.bat" "%USERPROFILE%\Corundum" > nul
xcopy "%~dp0\utility" "%USERPROFILE%\Corundum\utility" /s /e /i > nul
copy "%~dp0\README.md" "%USERPROFILE%\Corundum" > nul
copy "%~dp0\LICENSE" "%USERPROFILE%\Corundum" > nul
cls
echo Installation
echo.
echo Thank you for choosing Corundum! In a few moments you'll be able to enjoy Corundum directly on your computer.
echo Stay on this window, the installation won't last long!
echo.
echo Status: Creating the shortcut...

set "target=%USERPROFILE%\Corundum\main.bat"
set "shortcut_folder=C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Enio Aiello"
set "shortcut_name=Corundum.lnk"

if not exist "%shortcut_folder%" (
    mkdir "%shortcut_folder%"
)

set "vbs_file=%temp%\create_shortcut.vbs"
echo Set WshShell = WScript.CreateObject("WScript.Shell") > "%vbs_file%"
echo Set oShellLink = WshShell.CreateShortcut("%shortcut_folder%\%shortcut_name%") >> "%vbs_file%"
echo oShellLink.TargetPath = "%target%" >> "%vbs_file%"
echo oShellLink.Save >> "%vbs_file%"

cscript //nologo "%vbs_file%" > nul
del "%vbs_file%" > nul
cls
echo Installation
echo.
echo Thank you for choosing Corundum! In a few moments you'll be able to enjoy Corundum directly on your computer.
echo Stay on this window, the installation won't last long!
echo.
echo Status: Installation completed!
timeout /t 3 > nul
goto End

:PortableMode
cls
echo Installation
echo.
echo You are about to install Corundum in portable mode.
set /p portable_location="Enter the location: "

if not exist "%portable_location%" (
    cls
    echo The location does not exist. Please try again.
    timeout /t 3 > nul
    goto PortableMode
)

mkdir "%portable_location%\Corundum" > nul
copy "%~dp0\main.bat" "%portable_location%\Corundum" > nul
copy "%~dp0\install.bat" "%portable_location%\Corundum" > nul
xcopy "%~dp0\utility" "%portable_location%\Corundum\utility" /s /e /i > nul
copy "%~dp0\README.md" "%portable_location%\Corundum" > nul
copy "%~dp0\LICENSE" "%portable_location%\Corundum" > nul
echo Portable installation completed!
timeout /t 3 > nul
goto End

:CorundumInstalled
cls
echo Setup
echo.
echo Corundum is currently installed on your computer.
echo Please choose the action:
echo 1. Uninstall Corundum
echo 2. Update Corundum
echo 3. Modify startup option
set /p action="Enter your choice: "

if "%action%"=="1" goto UninstallCorundum
if "%action%"=="2" goto UpdateCorundum
if "%action%"=="3" goto ModifyStartup

cls
goto CorundumInstalled

:ModifyStartup
cls
echo Setup
echo.
echo Modify Startup Options
echo 1. Enable Corundum on startup
echo 2. Disable Corundum on startup
set /p startup_option="Enter your choice: "

if "%startup_option%"=="1" goto InstallNowShortcut
if "%startup_option%"=="2" goto DisableStartup

cls
goto ModifyStartup

:DisableStartup
cls
echo Setup
echo.
echo Status: Disabling startup...
del "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Corundum.lnk" > nul
cls
echo Setup
echo.
echo Status: Startup has been disabled.
timeout /t 3 > nul
goto CorundumInstalled

:UninstallCorundum
cls
echo Setup
echo.
echo Please wait while Corundum is uninstalling.
echo.
echo Status: Uninstalling...
rmdir /s /q "%USERPROFILE%\Corundum" > nul
del "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Corundum.lnk" > nul
del "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Enio Aiello\Corundum.lnk" > nul
cls
echo Setup
echo.
echo Please wait while Corundum is uninstalling.
echo.
echo Status: Uninstallation completed!
timeout /t 3 > nul
goto End

:UpdateCorundum
cls
echo Setup
echo.
echo Please wait while setup is updating Corundum.
echo.
echo Status: Updating Corundum...
rmdir /s /q "%USERPROFILE%\Corundum\utility" > nul
copy "%~dp0\main.bat" "%USERPROFILE%\Corundum" > nul
copy "%~dp0\install.bat" "%USERPROFILE%\Corundum" > nul
xcopy "%~dp0\utility" "%USERPROFILE%\Corundum\utility" /s /e /i > nul
cls
echo Setup
echo.
echo Please wait while setup is updating Corundum.
echo.
echo Status: Update completed!
timeout /t 3 > nul
goto End

:End
cls
echo Setup
echo.
echo The request has been completed successfully.
echo Press any key to exit the setup wizard.
pause > nul
exit
