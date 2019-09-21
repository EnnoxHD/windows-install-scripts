eclipse installation
download eclipse ide for java devs
  from https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/2019-09/R/eclipse-java-2019-09-R-win32-x86_64.zip&mirror_id=1
extract archive to C:\Program Files\eclipse\
delete archive
install java 13 support from https://download.eclipse.org/eclipse/updates/4.13-P-builds
  with ids: org.eclipse.jdt.java13patch.feature.group,org.eclipse.jdt.java13patch.source.feature.group
  C:\Program Files\eclipse\eclipse.exe -clean -purgeHistory -application org.eclipse.equinox.p2.director -noSplash -repository https://download.eclipse.org/eclipse/updates/4.13-P-builds -installIUs org.eclipse.jdt.java13patch.feature.group,org.eclipse.jdt.java13patch.source.feature.group
set home variable HOME=%USERPROFILE%
make shortcut Eclipse IDE
