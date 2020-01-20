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
echo [1/7] Generieren des Installationsskripts
set PSDATEI=install_mediathekview.ps1
rem =======================================
rem ======--- Installationsskript ---======
echo $root = $PSScriptRoot> %~dp0\%PSDATEI%
echo $global:ProgressPreference = "SilentlyContinue">> %~dp0\%PSDATEI%
echo $url = "https://download.mediathekview.de/stabil/MediathekView-latest-win.exe">> %~dp0\%PSDATEI%
echo $output = "$root\MediathekView-latest-win.exe">> %~dp0\%PSDATEI%
echo Write-Host "[3/7] MediathekView wird heruntergeladen">> %~dp0\%PSDATEI%
echo Invoke-WebRequest -Uri $url -OutFile $output>> %~dp0\%PSDATEI%
echo Write-Host "[3/7] MediathekView wurde heruntergeladen">> %~dp0\%PSDATEI%
echo Write-Host "[4/7] MediathekView installieren">> %~dp0\%PSDATEI%
echo Start-Process -Wait -FilePath "$output" -ArgumentList "-q">> %~dp0\%PSDATEI%
echo Write-Host "[4/7] MediathekView wurde installiert">> %~dp0\%PSDATEI%
echo Write-Host "[5/7] MediathekView Installer entfernen">> %~dp0\%PSDATEI%
echo Remove-Item -Path "$output" -Force -Recurse -ErrorAction Ignore>> %~dp0\%PSDATEI%
echo Write-Host "[5/7] MediathekView Installer wurde entfernt">> %~dp0\%PSDATEI%
rem ======--- Installationsskript ---======
rem =======================================
echo [1/7] Installationsskript fertig
echo [2/7] Ausführungsregel für das Skript anpassen
powershell.exe Set-ExecutionPolicy Unrestricted -Scope CurrentUser
echo [2/7] Ausführungsregel wurde angepasst
powershell.exe %~dp0\%PSDATEI%
echo [6/7] Installationsskript entfernen
del /f /s /q %~dp0\%PSDATEI% >nul 2>&1
echo [6/7] Installationsskript wurde entfernt
echo [7/7] Ausführungsregel zurücksetzen
powershell.exe Set-ExecutionPolicy Undefined -Scope CurrentUser
echo [7/7] Ausführungsregel wurde zurückgesetzt
echo ----------------------------
echo MediathekView ist fertig installiert!
echo.
pause
:END
