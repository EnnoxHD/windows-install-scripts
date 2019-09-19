@echo off
chcp 1252 >nul 2>&1
title Java Installation
net session >nul 2>&1
if not %errorlevel% == 0 (
  echo Diese Installation muss als Administrator ausgeführt werden!
  echo Bitte wie folgt ausführen: Rechtsklick, "Als Administrator ausführen", "Ja"
  echo.
  echo Die Installation wird nun aufgrund fehlender Rechte beendet!
  pause
  goto END
)
echo Java Installation
echo -----------------
echo [1/9] Generieren des Installationsskripts
set PSDATEI=install_java.ps1
rem =======================================
rem ======--- Installationsskript ---======
echo $root = $PSScriptRoot> %~dp0\%PSDATEI%
echo $global:ProgressPreference = "SilentlyContinue">> %~dp0\%PSDATEI%
echo $url = "https://download.java.net/java/GA/jdk13/5b8a42f3905b406298b72d750b6919f6/33/GPL/openjdk-13_windows-x64_bin.zip">> %~dp0\%PSDATEI%
echo $output = "$root\openjdk-13_windows-x64_bin.zip">> %~dp0\%PSDATEI%
echo Write-Host "[3/9] Java wird heruntergeladen">> %~dp0\%PSDATEI%
echo Write-Host "Bitte einige Minuten warten...">> %~dp0\%PSDATEI%
echo Invoke-WebRequest -Uri $url -OutFile $output>> %~dp0\%PSDATEI%
echo Write-Host "[3/9] Java wurde heruntergeladen">> %~dp0\%PSDATEI%
echo Write-Host "[4/9] Altes Java entfernen">> %~dp0\%PSDATEI%
echo Remove-Item -Path "C:\Program Files\Java" -Force -Recurse -ErrorAction Ignore>> %~dp0\%PSDATEI%
echo Write-Host "[4/9] Altes Java wurde entfernt">> %~dp0\%PSDATEI%
echo Write-Host "[5/9] Java entpacken">> %~dp0\%PSDATEI%
echo Expand-Archive -Path "$output" -DestinationPath "C:\Program Files\Java\">> %~dp0\%PSDATEI%
echo Write-Host "[5/9] Java wurde entpackt">> %~dp0\%PSDATEI%
echo Write-Host "[6/9] Java Archiv entfernen">> %~dp0\%PSDATEI%
echo Remove-Item -Path "$output" -Force -Recurse -ErrorAction Ignore>> %~dp0\%PSDATEI%
echo Write-Host "[6/9] Java Archiv wurde entfernt">> %~dp0\%PSDATEI%
echo Write-Host "[7/9] Umgebungsvariablen setzen">> %~dp0\%PSDATEI%
echo [Environment]::SetEnvironmentVariable("JAVA_HOME", "C:\Program Files\Java\jdk-13\", "User")>> %~dp0\%PSDATEI%
echo $userpath = [Environment]::GetEnvironmentVariable("Path", "User").Split(";")>> %~dp0\%PSDATEI%
echo $clearpath = "">> %~dp0\%PSDATEI%
echo for($i=0; $i -lt $userpath.length; $i++){>> %~dp0\%PSDATEI%
echo if($userpath[$i] -notlike "*Java*" -and $userpath[$i] -notlike ""){>> %~dp0\%PSDATEI%
echo $clearpath = $clearpath + $userpath[$i] + ";">> %~dp0\%PSDATEI%
echo }>> %~dp0\%PSDATEI%
echo }>> %~dp0\%PSDATEI%
echo [Environment]::SetEnvironmentVariable("Path", $clearpath + "C:\Program Files\Java\jdk-13\bin\;", "User")>> %~dp0\%PSDATEI%
echo Write-Host "[7/9] Umgebungsvariablen wurden gesetzt">> %~dp0\%PSDATEI%
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
echo Java ist fertig installiert!
echo.
pause
:END
