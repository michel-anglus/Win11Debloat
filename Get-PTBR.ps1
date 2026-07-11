# Win11Debloat Brasil - Instalador automático
# Projeto-base: Raphire/Win11Debloat (licença MIT)
# Edição brasileira: Michel Anglus
# Repositório: https://github.com/michel-anglus/Win11Debloat


$ErrorActionPreference = 'Stop'

function Escrever-Etapa {
    param([Parameter(Mandatory)][string]$Texto)
    Write-Host ""
    Write-Host "> $Texto" -ForegroundColor Cyan
}

function Encerrar-ComErro {
    param(
        [Parameter(Mandatory)][string]$Mensagem,
        [System.Management.Automation.ErrorRecord]$Erro
    )

    Write-Host ""
    Write-Host "ERRO: $Mensagem" -ForegroundColor Red

    if ($Erro) {
        Write-Host $Erro.Exception.Message -ForegroundColor DarkRed
    }

    Write-Host ""
    Write-Host "Pressione Enter para sair..." -ForegroundColor Yellow
    Read-Host | Out-Null
    exit 1
}

if ($ExecutionContext.SessionState.LanguageMode -ne 'FullLanguage') {
    Encerrar-ComErro -Mensagem 'A execução do PowerShell está limitada por uma política de segurança do Windows.'
}

try {
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
}
catch {
    # PowerShell moderno já negocia TLS automaticamente.
}

Clear-Host
Write-Host "--------------------------------------------------------------------------------" -ForegroundColor DarkCyan
Write-Host " Win11Debloat Brasil - Download e inicialização automática" -ForegroundColor White
Write-Host "--------------------------------------------------------------------------------" -ForegroundColor DarkCyan
Write-Host ""
Write-Host "Aguarde. A versão mais recente será baixada diretamente do GitHub." -ForegroundColor Gray

$tempBase = Join-Path $env:TEMP 'Win11Debloat-Brasil'
$pastaPrograma = Join-Path $tempBase 'Programa'
$pastaExtracao = Join-Path $tempBase 'Extracao'
$arquivoZip = Join-Path $tempBase 'Win11Debloat-Brasil.zip'

$urlArquivo = 'https://github.com/michel-anglus/Win11Debloat/archive/refs/heads/master.zip'

try {
    New-Item -ItemType Directory -Path $tempBase -Force | Out-Null
    New-Item -ItemType Directory -Path $pastaPrograma -Force | Out-Null

    Escrever-Etapa 'Preparando os arquivos temporários'

    # Mantém configurações, logs e backups de execuções anteriores.
    if (Test-Path -LiteralPath $pastaPrograma) {
        Get-ChildItem -LiteralPath $pastaPrograma -Force -ErrorAction SilentlyContinue |
            Where-Object { $_.Name -notin @('Config', 'Logs', 'Backups') } |
            Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
    }

    Remove-Item -LiteralPath $pastaExtracao -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -LiteralPath $arquivoZip -Force -ErrorAction SilentlyContinue

    Escrever-Etapa 'Baixando a versão mais recente do Win11Debloat Brasil'

    $parametrosDownload = @{
        Uri = $urlArquivo
        OutFile = $arquivoZip
        UseBasicParsing = $true
        Headers = @{
            'User-Agent' = 'Win11Debloat-Brasil-Installer'
            'Cache-Control' = 'no-cache'
        }
    }

    Invoke-WebRequest @parametrosDownload

    if (-not (Test-Path -LiteralPath $arquivoZip)) {
        throw 'O arquivo compactado não foi criado após o download.'
    }

    if ((Get-Item -LiteralPath $arquivoZip).Length -lt 1000) {
        throw 'O arquivo recebido parece estar incompleto.'
    }

    Escrever-Etapa 'Extraindo os arquivos'

    Expand-Archive -LiteralPath $arquivoZip -DestinationPath $pastaExtracao -Force

    $arquivoPrincipal = Get-ChildItem -LiteralPath $pastaExtracao -Recurse -File `
        -Filter 'Win11Debloat-PTBR.ps1' -ErrorAction SilentlyContinue |
        Select-Object -First 1

    if (-not $arquivoPrincipal) {
        throw 'A interface brasileira Win11Debloat-PTBR.ps1 não foi encontrada no pacote baixado.'
    }

    $pastaOrigem = $arquivoPrincipal.Directory.FullName

    Escrever-Etapa 'Instalando a edição brasileira'

    Get-ChildItem -LiteralPath $pastaOrigem -Force | ForEach-Object {
        Copy-Item -LiteralPath $_.FullName -Destination $pastaPrograma -Recurse -Force
    }

    $scriptPrincipal = Join-Path $pastaPrograma 'Win11Debloat-PTBR.ps1'

    if (-not (Test-Path -LiteralPath $scriptPrincipal)) {
        throw 'O script principal não foi encontrado depois da instalação.'
    }

    Escrever-Etapa 'Abrindo o Win11Debloat Brasil'

    $argumentos = "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPrincipal`""

    $processo = Start-Process `
        -FilePath 'powershell.exe' `
        -ArgumentList $argumentos `
        -Verb RunAs `
        -PassThru

    if ($processo) {
        $processo.WaitForExit()
    }
}
catch {
    Encerrar-ComErro -Mensagem 'Não foi possível baixar ou iniciar o Win11Debloat Brasil.' -Erro $_
}
finally {
    Remove-Item -LiteralPath $pastaExtracao -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item -LiteralPath $arquivoZip -Force -ErrorAction SilentlyContinue
}

Write-Host ""
Write-Host "Win11Debloat Brasil encerrado." -ForegroundColor Green
Write-Host ""

