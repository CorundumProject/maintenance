@echo off
set "target=%USERPROFILE%\Corundum maintenance\main.bat"
set "shortcut_folder=C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Enio Aiello"
set "shortcut_name=Corundum.lnk"
set "icon_url=https://github.com/CorundumProject/maintenance/blob/website/assets/img/favicon.png"
set "icon_path=%temp%\favicon.ico"

powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%icon_url%', '%icon_path%')"

if not exist "%shortcut_folder%" (
    mkdir "%shortcut_folder%"
)

set "vbs_file=%temp%\create_shortcut.vbs"
(
    echo Set WshShell = WScript.CreateObject("WScript.Shell")
    echo Set oShellLink = WshShell.CreateShortcut("%shortcut_folder%\%shortcut_name%")
    echo oShellLink.TargetPath = "%target%"
    echo oShellLink.IconLocation = "%icon_path%"
    echo oShellLink.Save
) > "%vbs_file%"

cscript //nologo "%vbs_file%" > nul
del "%vbs_file%" > nul

pause
