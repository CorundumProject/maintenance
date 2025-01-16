@echo off
title Corundum maintenance - Utilities manager
echo Utilities manager
echo.
echo Welcome to the Corundum maintenance utilities manager. Here, you can download, install, update or delete utilities for the Corundum maintenance system.
echo Please select an option from the list below:
echo.
echo 1. Download a utility
echo 2. Install a utility
echo 3. Update a utility
echo 4. Delete a utility
echo 5. Exit (return to Corundum maintenance)
echo.
set /p choice="Enter your choice: "

if %choice%==1 goto download
if %choice%==2 goto install
if %choice%==3 goto update
if %choice%==4 goto delete
if %choice%==5 goto back 

:download
cls
echo Download a utility
echo.
echo How do you want to download an utility?
echo 1. An URL
echo 2. A file
echo 3. A recommended utility
echo 4. Back
echo.
set /p choice="Enter your choice: "

if %choice%==1 goto download_url
if %choice%==2 goto download_file
if %choice%==3 goto download_recommended
if %choice%==4 goto back

:download_url
cls
echo Download a utility - URL
echo.
echo Please enter the URL of the utility you want to download:
echo.
echo Type cancel to cancel the download
set /p url="URL: "
if %url%==cancel goto download
cls
echo Downloading utility
echo.
echo Downloading from %url%...
echo.
powershell -Command "(New-Object Net.WebClient).DownloadFile(%url%, 'utility\temp\utility.zip')"
powershell Expand-Archive %url%
cls