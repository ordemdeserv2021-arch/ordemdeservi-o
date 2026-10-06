@echo off
title Criando Atalho para o Sistema de OS...
color 0A

:: Define o caminho da pasta atual e do arquivo index.html
set "CURRENT_DIR=%~dp0"
set "HTML_FILE=%CURRENT_DIR%index.html"

:: Script VBScript temporario para criar o atalho com icone
set "VBS_SCRIPT=%TEMP%\create_os_shortcut.vbs"

echo Set oWS = WScript.CreateObject("WScript.Shell") > "%VBS_SCRIPT%"
echo sLinkFile = oWS.SpecialFolders("Desktop") ^& "\Sistema de Ordens de Servico.lnk" >> "%VBS_SCRIPT%"
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> "%VBS_SCRIPT%"
echo oLink.TargetPath = "%HTML_FILE%" >> "%VBS_SCRIPT%"
echo oLink.WorkingDirectory = "%CURRENT_DIR%" >> "%VBS_SCRIPT%"
echo oLink.Description = "Sistema de Ordens de Servico - Carlos Alberto" >> "%VBS_SCRIPT%"
echo oLink.IconLocation = "shell32.dll, 22" >> "%VBS_SCRIPT%"
echo oLink.Save >> "%VBS_SCRIPT%"

:: Executa o VBScript e remove o temporario
cscript //nologo "%VBS_SCRIPT%"
del "%VBS_SCRIPT%"

echo.
echo ============================================================
echo   ATALHO CRIADO COM SUCESSO NA SUA AREA DE TRABALHO!
echo ============================================================
echo.
echo Procure pelo icone "Sistema de Ordens de Servico" na sua Area de Trabalho.
echo.
pause