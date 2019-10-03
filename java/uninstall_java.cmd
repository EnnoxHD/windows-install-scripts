@echo off
chcp 1252 >nul 2>&1
title Java Deinstallation
net session >nul 2>&1
if not %errorlevel% == 0 (
  echo Diese Deinstallation muss als Administrator ausgeführt werden!
  echo Bitte wie folgt ausführen: Rechtsklick, "Als Administrator ausführen", "Ja"
  echo.
  echo Die Deinstallation wird nun aufgrund fehlender Rechte beendet!
  pause
  goto END
)
echo Java Deinstallation
echo -------------------
echo [1/5] Generieren des Deinstallationsskripts
set PSDATEI=uninstall_java.ps1
rem =======================================
rem ======--- Installationsskript ---======
echo $root = $PSScriptRoot> %~dp0\%PSDATEI%
echo $global:ProgressPreference = "SilentlyContinue">> %~dp0\%PSDATEI%
echo Write-Host "[2/5] Java entfernen">> %~dp0\%PSDATEI%
echo Remove-Item -Path "C:\Program Files\Java" -Force -Recurse -ErrorAction Ignore>> %~dp0\%PSDATEI%
echo Write-Host "[2/5] Java wurde entfernt">> %~dp0\%PSDATEI%
echo Write-Host "[3/5] Umgebungsvariablen entfernen">> %~dp0\%PSDATEI%
echo [Environment]::SetEnvironmentVariable("JAVA_HOME", $null, "User")>> %~dp0\%PSDATEI%
echo $userpath = [Environment]::GetEnvironmentVariable("Path", "User").Split(";")>> %~dp0\%PSDATEI%
echo $clearpath = "">> %~dp0\%PSDATEI%
echo for($i=0; $i -lt $userpath.length; $i++){>> %~dp0\%PSDATEI%
echo if($userpath[$i] -notlike "*Java*" -and $userpath[$i] -notlike ""){>> %~dp0\%PSDATEI%
echo $clearpath = $clearpath + $userpath[$i] + ";">> %~dp0\%PSDATEI%
echo }>> %~dp0\%PSDATEI%
echo }>> %~dp0\%PSDATEI%
echo [Environment]::SetEnvironmentVariable("Path", $clearpath, "User")>> %~dp0\%PSDATEI%
echo Write-Host "[3/5] Umgebungsvariablen wurden entfernt">> %~dp0\%PSDATEI%
rem ======--- Installationsskript ---======
rem =======================================
echo [1/5] Deinstallationsskript fertig
echo [2/5] Ausführungsregel für das Skript anpassen
powershell.exe Set-ExecutionPolicy Unrestricted -Scope CurrentUser
echo [2/5] Ausführungsregel wurde angepasst
powershell.exe %~dp0\%PSDATEI%
echo [4/5] Deinstallationsskript entfernen
del /f /s /q %~dp0\%PSDATEI% >nul 2>&1
echo [4/5] Deinstallationsskript wurde entfernt
echo [5/5] Ausführungsregel zurücksetzen
powershell.exe Set-ExecutionPolicy Undefined -Scope CurrentUser
echo [5/5] Ausführungsregel wurde zurückgesetzt
echo ----------------------------
echo Java ist entfernt!
echo.
pause
:END
