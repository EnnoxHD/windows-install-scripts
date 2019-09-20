@echo off
chcp 1252 >nul 2>&1
title MediathekView Installation
net session >nul 2>&1
if not %errorlevel% == 0 (
  echo Diese Installation muss als Administrator ausgeführt werden!
  echo Bitte wie folgt ausführen: Rechtsklick, "Als Administrator ausführen", "Ja"
  echo.
  echo Die Installation wird nun aufgrund fehlender Rechte beendet!
  pause
  goto END
)
echo MediathekView Installation
echo --------------------------
echo [1/9] Generieren des Installationsskripts
set PSDATEI=install_mediathekview.ps1
rem =======================================
rem ======--- Installationsskript ---======
echo $root = $PSScriptRoot> %~dp0\%PSDATEI%
echo $global:ProgressPreference = "SilentlyContinue">> %~dp0\%PSDATEI%
echo $url = "https://download.mediathekview.de/stabil/MediathekView-13.3.0-win.zip">> %~dp0\%PSDATEI%
echo $output = "$root\MediathekView-13.3.0-win.zip">> %~dp0\%PSDATEI%
echo Write-Host "[3/9] MediathekView wird heruntergeladen">> %~dp0\%PSDATEI%
echo Invoke-WebRequest -Uri $url -OutFile $output>> %~dp0\%PSDATEI%
echo Write-Host "[3/9] MediathekView wurde heruntergeladen">> %~dp0\%PSDATEI%
echo Write-Host "[4/9] Altes MediathekView entfernen">> %~dp0\%PSDATEI%
echo Remove-Item -Path "C:\Program Files\MediathekView-13.2.1" -Force -Recurse -ErrorAction Ignore>> %~dp0\%PSDATEI%
echo Remove-Item -Path "C:\Program Files\MediathekView-13.3.0" -Force -Recurse -ErrorAction Ignore>> %~dp0\%PSDATEI%
echo Write-Host "[4/9] Altes MediathekView wurde entfernt">> %~dp0\%PSDATEI%
echo Write-Host "[5/9] MediathekView entpacken">> %~dp0\%PSDATEI%
echo Expand-Archive -Path "$output" -DestinationPath "C:\Program Files\MediathekView-13.3.0\">> %~dp0\%PSDATEI%
echo Write-Host "[5/9] MediathekView wurde entpackt">> %~dp0\%PSDATEI%
echo Write-Host "[6/9] MediathekView Archiv entfernen">> %~dp0\%PSDATEI%
echo Remove-Item -Path "$output" -Force -Recurse -ErrorAction Ignore>> %~dp0\%PSDATEI%
echo Write-Host "[6/9] MediathekView Archiv wurde entfernt">> %~dp0\%PSDATEI%
echo Write-Host "[7/9] Verlinkung erstellen">> %~dp0\%PSDATEI%
setlocal DisableDelayedExpansion
set "AT=@"
setlocal EnableDelayedExpansion
echo $WshShell = New-Object -comObject WScript.Shell>> %~dp0\%PSDATEI%
echo $Shortcut = $WshShell.CreateShortcut("C:\ProgramData\Microsoft\Windows\Start Menu\Programs\MediathekView.lnk")>> %~dp0\%PSDATEI%
echo $Shortcut.TargetPath = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe">> %~dp0\%PSDATEI%
echo $Shortcut.Arguments = %AT%^">> %~dp0\%PSDATEI%
echo -WindowStyle Hidden ^"java.exe -jar ^'C:\Program Files\MediathekView-13.3.0\MediathekView.jar^'^">> %~dp0\%PSDATEI%
echo ^"%AT%>> %~dp0\%PSDATEI%
echo $Shortcut.IconLocation = "C:\Program Files\MediathekView-13.3.0\MediathekView.exe">> %~dp0\%PSDATEI%
echo $Shortcut.Save()>> %~dp0\%PSDATEI%
echo Write-Host "[7/9] Verlinkung wurde erstellt">> %~dp0\%PSDATEI%
rem ======--- Installationsskript ---======
rem =======================================
echo [1/9] Installationsskript fertig
echo [2/9] Ausführungsregel für das Skript anpassen
powershell.exe Set-ExecutionPolicy Unrestricted -Scope CurrentUser
echo [2/9] Ausführungsregel wurde angepasst
powershell.exe %~dp0\%PSDATEI%
echo [8/9] Installationsskript entfernen
del /f /s /q %~dp0\%PSDATEI% >nul 2>&1
echo [8/9] Installationsskript wurde entfernt
echo [9/9] Ausführungsregel zurücksetzen
powershell.exe Set-ExecutionPolicy Undefined -Scope CurrentUser
echo [9/9] Ausführungsregel wurde zurückgesetzt
echo ----------------------------
echo MediathekView ist fertig installiert!
echo.
pause
:END
