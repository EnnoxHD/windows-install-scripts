@echo off
chcp 1252 >nul 2>&1
title Eclipse IDE Installation
net session >nul 2>&1
if not %errorlevel% == 0 (
  echo Diese Installation muss als Administrator ausgeführt werden!
  echo Bitte wie folgt ausführen: Rechtsklick, "Als Administrator ausführen", "Ja"
  echo.
  echo Die Installation wird nun aufgrund fehlender Rechte beendet!
  pause
  goto END
)
echo Eclipse IDE Installation
echo ------------------------
echo [1/10] Generieren des Installationsskripts
set PSDATEI=install_eclipse.ps1
rem =======================================
rem ======--- Installationsskript ---======
echo $root = $PSScriptRoot> %~dp0\%PSDATEI%
echo $global:ProgressPreference = "SilentlyContinue">> %~dp0\%PSDATEI%
echo $url = "https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/2019-09/R/eclipse-java-2019-09-R-win32-x86_64.zip&mirror_id=1">> %~dp0\%PSDATEI%
echo $output = "$root\eclipse-java-2019-09-R-win32-x86_64.zip">> %~dp0\%PSDATEI%
echo Write-Host "[3/10] Eclipse IDE wird heruntergeladen">> %~dp0\%PSDATEI%
echo Write-Host "Bitte einige Minuten warten...">> %~dp0\%PSDATEI%
echo Invoke-WebRequest -Uri $url -OutFile $output>> %~dp0\%PSDATEI%
echo Write-Host "[3/10] Eclipse IDE wurde heruntergeladen">> %~dp0\%PSDATEI%
echo Write-Host "[4/10] Altes Eclipse IDE entfernen">> %~dp0\%PSDATEI%
echo Remove-Item -Path "C:\Program Files\eclipse" -Force -Recurse -ErrorAction Ignore>> %~dp0\%PSDATEI%
echo Write-Host "[4/10] Altes Eclipse IDE wurde entfernt">> %~dp0\%PSDATEI%
echo Write-Host "[5/10] Eclipse IDE entpacken">> %~dp0\%PSDATEI%
echo Expand-Archive -Path "$output" -DestinationPath "C:\Program Files\">> %~dp0\%PSDATEI%
echo Write-Host "[5/10] Eclipse IDE wurde entpackt">> %~dp0\%PSDATEI%
echo Write-Host "[6/10] Eclipse IDE Archiv entfernen">> %~dp0\%PSDATEI%
echo Remove-Item -Path "$output" -Force -Recurse -ErrorAction Ignore>> %~dp0\%PSDATEI%
echo Write-Host "[6/10] Eclipse IDE Archiv wurde entfernt">> %~dp0\%PSDATEI%
echo Write-Host "[7/10] Eclipse IDE Erweiterungen werden installiert">> %~dp0\%PSDATEI%
echo Write-Host "Bitte einige Minuten warten...">> %~dp0\%PSDATEI%
echo Start-Process -Wait -FilePath "C:\Program Files\eclipse\eclipse.exe" -ArgumentList "-clean", "-purgeHistory", "-application org.eclipse.equinox.p2.director", "-noSplash", "-repository https://download.eclipse.org/eclipse/updates/4.13-P-builds", "-installIUs org.eclipse.jdt.java13patch.feature.group,org.eclipse.jdt.java13patch.source.feature.group">> %~dp0\%PSDATEI%
echo Write-Host "[7/10] Eclipse IDE Erweiterungen wurden installiert">> %~dp0\%PSDATEI%
echo Write-Host "[8/10] Umgebungsvariablen setzen">> %~dp0\%PSDATEI%
echo [Environment]::SetEnvironmentVariable("HOME", "%%USERPROFILE%%", "User")>> %~dp0\%PSDATEI%
echo Write-Host "[8/10] Umgebungsvariablen wurden gesetzt">> %~dp0\%PSDATEI%
echo Write-Host "[9/10] Verlinkung erstellen">> %~dp0\%PSDATEI%
echo $WshShell = New-Object -comObject WScript.Shell>> %~dp0\%PSDATEI%
echo $Shortcut = $WshShell.CreateShortcut("C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Eclipse IDE.lnk")>> %~dp0\%PSDATEI%
echo $Shortcut.TargetPath = "C:\Program Files\eclipse\eclipse.exe">> %~dp0\%PSDATEI%
echo $Shortcut.IconLocation = "C:\Program Files\eclipse\eclipse.exe">> %~dp0\%PSDATEI%
echo $Shortcut.Save()>> %~dp0\%PSDATEI%
echo Write-Host "[9/10] Verlinkung wurde erstellt">> %~dp0\%PSDATEI%
rem ======--- Installationsskript ---======
rem =======================================
echo [1/10] Installationsskript fertig
echo [2/10] Ausführungsregel für das Skript anpassen
powershell.exe Set-ExecutionPolicy Unrestricted -Scope CurrentUser
echo [2/10] Ausführungsregel wurde angepasst
powershell.exe %~dp0\%PSDATEI%
echo [8/10] Installationsskript entfernen
del /f /s /q %~dp0\%PSDATEI% >nul 2>&1
echo [8/10] Installationsskript wurde entfernt
echo [10/10] Ausführungsregel zurücksetzen
powershell.exe Set-ExecutionPolicy Undefined -Scope CurrentUser
echo [10/10] Ausführungsregel wurde zurückgesetzt
echo ------------------------
echo Eclipse IDE ist fertig installiert!
echo.
pause
:END
