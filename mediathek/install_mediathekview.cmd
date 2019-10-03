@echo off
chcp 1252 >nul 2>&1
title MediathekView Installation
net session >nul 2>&1
if not %errorlevel% == 0 (
  echo Diese Installation muss als Administrator ausgef�hrt werden!
  echo Bitte wie folgt ausf�hren: Rechtsklick, "Als Administrator ausf�hren", "Ja"
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
echo $url = "https://download.mediathekview.de/stabil/MediathekView-13.5.0-win.exe">> %~dp0\%PSDATEI%
echo $output = "$root\MediathekView-13.5.0-win.exe">> %~dp0\%PSDATEI%
echo Write-Host "[3/9] MediathekView wird heruntergeladen">> %~dp0\%PSDATEI%
echo Invoke-WebRequest -Uri $url -OutFile $output>> %~dp0\%PSDATEI%
echo Write-Host "[3/9] MediathekView wurde heruntergeladen">> %~dp0\%PSDATEI%
echo Write-Host "[4/9] Altes MediathekView entfernen">> %~dp0\%PSDATEI%
echo Remove-Item -Path "C:\Program Files\MediathekView-13.3.0" -Force -Recurse -ErrorAction Ignore>> %~dp0\%PSDATEI%
echo Remove-Item -Path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\MediathekView.lnk" -Force -Recurse -ErrorAction Ignore>> %~dp0\%PSDATEI%
echo Write-Host "[4/9] Altes MediathekView wurde entfernt">> %~dp0\%PSDATEI%
echo Write-Host "[5/9] MediathekView installieren">> %~dp0\%PSDATEI%
echo Start-Process -Wait -FilePath "$output" -ArgumentList "-q">> %~dp0\%PSDATEI%
echo Write-Host "[5/9] MediathekView wurde installiert">> %~dp0\%PSDATEI%
echo Write-Host "[6/9] MediathekView Installer entfernen">> %~dp0\%PSDATEI%
echo Remove-Item -Path "$output" -Force -Recurse -ErrorAction Ignore>> %~dp0\%PSDATEI%
echo Write-Host "[6/9] MediathekView Installer wurde entfernt">> %~dp0\%PSDATEI%
rem ======--- Installationsskript ---======
rem =======================================
echo [1/9] Installationsskript fertig
echo [2/9] Ausf�hrungsregel f�r das Skript anpassen
powershell.exe Set-ExecutionPolicy Unrestricted -Scope CurrentUser
echo [2/9] Ausf�hrungsregel wurde angepasst
powershell.exe %~dp0\%PSDATEI%
echo [8/9] Installationsskript entfernen
del /f /s /q %~dp0\%PSDATEI% >nul 2>&1
echo [8/9] Installationsskript wurde entfernt
echo [9/9] Ausf�hrungsregel zur�cksetzen
powershell.exe Set-ExecutionPolicy Undefined -Scope CurrentUser
echo [9/9] Ausf�hrungsregel wurde zur�ckgesetzt
echo ----------------------------
echo MediathekView ist fertig installiert!
echo.
echo Hinweis: Manuelle Anpassung des Taskleitensymbols notwendig!
echo.
echo Bitte manuell das MediathekView-Symbol in der Taskleiste entfernen
echo (Rechtsklick, "Von Taskleiste l�sen") und
echo aus dem Startmen� das "MediathekView"-Symbol (nicht "MediathekView IPv4"!)
echo aus dem Ordner "MediathekView" auf die Taskleiste ziehen.
echo.
pause
:END
