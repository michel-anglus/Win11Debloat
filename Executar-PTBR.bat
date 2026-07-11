@echo off
chcp 65001 >nul
title Win11Debloat Brasil
setlocal

set "SCRIPT=%~dp0Win11Debloat-PTBR.ps1"

if not exist "%SCRIPT%" (
    echo.
    echo ERRO: o arquivo Win11Debloat-PTBR.ps1 não foi encontrado.
    echo Extraia ou copie todos os arquivos do pacote para a pasta do Win11Debloat.
    echo.
    pause
    exit /b 1
)

echo.
echo Iniciando o Win11Debloat Brasil...
echo Aceite a solicitação de administrador do Windows.
echo.

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT%"

if errorlevel 1 (
    echo.
    echo A execução foi encerrada com erro.
    echo Consulte a pasta Logs para obter mais detalhes.
    echo.
    pause
)

endlocal
