@echo off
chcp 1252 >nul 2>&1
title MediathekView Patch
echo Diese Installation muss als Administrator ausgeführt werden!
echo. 
pause
echo.
echo MediathekView Patch
echo -------------------
echo [1/5] Generieren des Installationsskripts
set PSDATEI=patch_mediathekview.ps1
setlocal DisableDelayedExpansion
set "AT=@"
setlocal EnableDelayedExpansion
rem =======================================
rem ======--- Installationsskript ---======
echo Write-Host "[3/5] Verlinkung erstellen"> %~dp0\%PSDATEI%
echo $WshShell = New-Object -comObject WScript.Shell>> %~dp0\%PSDATEI%
echo $Shortcut = $WshShell.CreateShortcut("C:\ProgramData\Microsoft\Windows\Start Menu\Programs\MediathekView.lnk")>> %~dp0\%PSDATEI%
echo $Shortcut.TargetPath = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe">> %~dp0\%PSDATEI%
echo $Shortcut.Arguments = %AT%^">> %~dp0\%PSDATEI%
echo -WindowStyle Hidden ^"java.exe -jar ^'C:\Program Files\MediathekView-13.3.0\MediathekView.jar^'^">> %~dp0\%PSDATEI%
echo ^"%AT%>> %~dp0\%PSDATEI%
echo $Shortcut.IconLocation = "C:\Program Files\MediathekView-13.3.0\MediathekView.exe">> %~dp0\%PSDATEI%
echo $Shortcut.Save()>> %~dp0\%PSDATEI%
echo Write-Host "[3/5] Verlinkung wurde erstellt">> %~dp0\%PSDATEI%
rem ======--- Installationsskript ---======
rem =======================================
echo [1/5] Installationsskript fertig
echo [2/5] Ausführungsregel für das Skript anpassen
powershell.exe Set-ExecutionPolicy Unrestricted -Scope CurrentUser
echo [2/5] Ausführungsregel wurde angepasst
powershell.exe %~dp0\%PSDATEI%
echo [4/5] Installationsskript entfernen
del /f /s /q %~dp0\%PSDATEI% >nul 2>&1
echo [4/5] Installationsskript wurde entfernt
echo [5/5] Ausführungsregel zurücksetzen
powershell.exe Set-ExecutionPolicy Undefined -Scope CurrentUser
echo [5/5] Ausführungsregel wurde zurückgesetzt
echo -------------------------------------------
echo MediathekView Patch ist fertig installiert!
echo.
pause