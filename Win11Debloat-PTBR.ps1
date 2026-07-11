# Win11Debloat Brasil
# Interface em português do Brasil para o motor Win11Debloat.
# Projeto original: Copyright (c) 2020 Raphire — licença MIT.
# Adaptação brasileira mantida por Michel Anglus.

[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'

function Testar-Administrador {
    $identidade = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($identidade)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Mostrar-Mensagem {
    param(
        [Parameter(Mandatory)] [string]$Mensagem,
        [string]$Titulo = 'Win11Debloat Brasil',
        [System.Windows.MessageBoxImage]$Icone = [System.Windows.MessageBoxImage]::Information,
        [System.Windows.MessageBoxButton]$Botoes = [System.Windows.MessageBoxButton]::OK
    )

    return [System.Windows.MessageBox]::Show($Mensagem, $Titulo, $Botoes, $Icone)
}

if (-not (Testar-Administrador)) {
    try {
        $argumentosElevados = "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
        Start-Process -FilePath 'powershell.exe' -ArgumentList $argumentosElevados -Verb RunAs | Out-Null
    }
    catch {
        Add-Type -AssemblyName PresentationFramework
        [System.Windows.MessageBox]::Show(
            'Não foi possível obter permissão de administrador. Execute novamente e aceite a solicitação do Windows.',
            'Permissão necessária',
            [System.Windows.MessageBoxButton]::OK,
            [System.Windows.MessageBoxImage]::Error
        ) | Out-Null
    }
    exit
}

Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase

$motorPath = Join-Path $PSScriptRoot 'Win11Debloat.ps1'
$arquivoRecursos = Join-Path $PSScriptRoot 'Config\Recursos-PTBR.json'
$logsPath = Join-Path $PSScriptRoot 'Logs'

if (-not (Test-Path -LiteralPath $motorPath)) {
    Mostrar-Mensagem -Titulo 'Arquivos incompletos' -Icone Error -Mensagem "O motor principal não foi encontrado em:`n$motorPath`n`nCopie esta edição brasileira para a pasta raiz do Win11Debloat." | Out-Null
    exit 1
}

if (-not (Test-Path -LiteralPath $arquivoRecursos)) {
    Mostrar-Mensagem -Titulo 'Arquivos incompletos' -Icone Error -Mensagem "A tradução dos recursos não foi encontrada em:`n$arquivoRecursos" | Out-Null
    exit 1
}

if (-not (Test-Path -LiteralPath $logsPath)) {
    New-Item -ItemType Directory -Path $logsPath -Force | Out-Null
}

try {
    $recursos = (Get-Content -LiteralPath $arquivoRecursos -Raw -Encoding UTF8 | ConvertFrom-Json).Recursos
}
catch {
    Mostrar-Mensagem -Titulo 'Erro de configuração' -Icone Error -Mensagem "Não foi possível carregar os recursos em português:`n`n$($_.Exception.Message)" | Out-Null
    exit 1
}

$xaml = @'
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Win11Debloat Brasil" Width="1080" Height="780"
        MinWidth="900" MinHeight="620" WindowStartupLocation="CenterScreen"
        Background="#08111F" Foreground="#F8FAFC" FontFamily="Segoe UI">
    <Window.Resources>
        <Style TargetType="Button">
            <Setter Property="Foreground" Value="#F8FAFC"/>
            <Setter Property="Background" Value="#17233A"/>
            <Setter Property="BorderBrush" Value="#2D3D59"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="Padding" Value="16,9"/>
            <Setter Property="Margin" Value="4"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
        </Style>
        <Style TargetType="CheckBox">
            <Setter Property="Foreground" Value="#E5E7EB"/>
            <Setter Property="FontSize" Value="13"/>
            <Setter Property="Margin" Value="0,6,0,6"/>
            <Setter Property="Cursor" Value="Hand"/>
        </Style>
        <Style TargetType="GroupBox">
            <Setter Property="Foreground" Value="#FFFFFF"/>
            <Setter Property="Background" Value="#101B2E"/>
            <Setter Property="BorderBrush" Value="#263754"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="Padding" Value="16"/>
            <Setter Property="Margin" Value="8"/>
            <Setter Property="Width" Value="490"/>
        </Style>
    </Window.Resources>

    <Grid Margin="22">
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>

        <Grid Grid.Row="0" Margin="4,0,4,14">
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition Width="Auto"/>
            </Grid.ColumnDefinitions>
            <StackPanel>
                <TextBlock Text="Win11Debloat Brasil" FontSize="32" FontWeight="Bold"/>
                <TextBlock Text="Deixe o Windows 11 mais limpo, privado e rápido — totalmente em português."
                           Foreground="#9FB1CC" FontSize="15" Margin="0,5,0,0"/>
            </StackPanel>
            <Border Grid.Column="1" Background="#123C73" CornerRadius="16" Padding="14,7" VerticalAlignment="Center">
                <TextBlock Text="EDIÇÃO BRASILEIRA" Foreground="#DCEEFF" FontWeight="Bold" FontSize="12"/>
            </Border>
        </Grid>

        <Border Grid.Row="1" Background="#0D192A" BorderBrush="#223451" BorderThickness="1"
                CornerRadius="8" Padding="10" Margin="4,0,4,12">
            <StackPanel Orientation="Horizontal">
                <Button x:Name="BotaoRecomendado" Content="Modo recomendado" Background="#155EBA" BorderBrush="#2E7BD8"/>
                <Button x:Name="BotaoLeve" Content="Modo leve"/>
                <Button x:Name="BotaoTudo" Content="Selecionar tudo"/>
                <Button x:Name="BotaoLimpar" Content="Limpar seleção"/>
                <CheckBox x:Name="CriarRestauracao"
                          Content="Criar ponto de restauração antes de aplicar"
                          IsChecked="True" Margin="22,0,0,0" VerticalAlignment="Center"/>
            </StackPanel>
        </Border>

        <ScrollViewer Grid.Row="2" VerticalScrollBarVisibility="Auto" HorizontalScrollBarVisibility="Disabled">
            <WrapPanel x:Name="PainelRecursos" Orientation="Horizontal"/>
        </ScrollViewer>

        <Border Grid.Row="3" Background="#0D192A" BorderBrush="#223451" BorderThickness="1"
                CornerRadius="8" Padding="12" Margin="4,12,4,0">
            <Grid>
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="*"/>
                    <ColumnDefinition Width="Auto"/>
                </Grid.ColumnDefinitions>
                <StackPanel VerticalAlignment="Center">
                    <TextBlock x:Name="TextoStatus" Text="Selecione as alterações que deseja aplicar." FontWeight="SemiBold"/>
                    <TextBlock Text="Passe o mouse sobre cada opção para ver uma explicação."
                               Foreground="#8FA2BF" FontSize="12" Margin="0,3,0,0"/>
                </StackPanel>
                <StackPanel Grid.Column="1" Orientation="Horizontal">
                    <Button x:Name="BotaoLogs" Content="Abrir logs"/>
                    <Button x:Name="BotaoAplicar" Content="Aplicar alterações"
                            Background="#15803D" BorderBrush="#22A451" Padding="22,10"/>
                </StackPanel>
            </Grid>
        </Border>
    </Grid>
</Window>
'@

$leitorXml = New-Object System.Xml.XmlNodeReader ([xml]$xaml)
$janela = [Windows.Markup.XamlReader]::Load($leitorXml)

$painelRecursos = $janela.FindName('PainelRecursos')
$botaoRecomendado = $janela.FindName('BotaoRecomendado')
$botaoLeve = $janela.FindName('BotaoLeve')
$botaoTudo = $janela.FindName('BotaoTudo')
$botaoLimpar = $janela.FindName('BotaoLimpar')
$botaoAplicar = $janela.FindName('BotaoAplicar')
$botaoLogs = $janela.FindName('BotaoLogs')
$criarRestauracao = $janela.FindName('CriarRestauracao')
$textoStatus = $janela.FindName('TextoStatus')

$conversorPincel = New-Object System.Windows.Media.BrushConverter
$controles = New-Object System.Collections.Generic.List[object]

foreach ($nomeGrupo in ($recursos.Grupo | Select-Object -Unique)) {
    $grupoVisual = New-Object System.Windows.Controls.GroupBox
    $grupoVisual.Header = $nomeGrupo
    $grupoVisual.FontWeight = 'SemiBold'

    $pilha = New-Object System.Windows.Controls.StackPanel

    foreach ($recurso in ($recursos | Where-Object { $_.Grupo -eq $nomeGrupo })) {
        $caixa = New-Object System.Windows.Controls.CheckBox
        $caixa.Content = $recurso.Titulo
        $caixa.ToolTip = $recurso.Descricao
        $caixa.Tag = $recurso
        $caixa.IsChecked = [bool]$recurso.Padrao
        $caixa.FontWeight = 'Normal'

        if ($recurso.Risco) {
            $caixa.Foreground = $conversorPincel.ConvertFromString('#FBBF24')
            $caixa.Content = "⚠  $($recurso.Titulo)"
        }

        $pilha.Children.Add($caixa) | Out-Null
        $controles.Add($caixa)
    }

    $grupoVisual.Content = $pilha
    $painelRecursos.Children.Add($grupoVisual) | Out-Null
}

function Aplicar-Predefinicao {
    param([ValidateSet('Padrao', 'Leve', 'Tudo', 'Limpar')] [string]$Tipo)

    foreach ($controle in $controles) {
        $recurso = $controle.Tag
        switch ($Tipo) {
            'Padrao' { $controle.IsChecked = [bool]$recurso.Padrao }
            'Leve'   { $controle.IsChecked = [bool]$recurso.Leve }
            'Tudo'   { $controle.IsChecked = $true }
            'Limpar' { $controle.IsChecked = $false }
        }
    }

    $mensagens = @{
        Padrao = 'Modo recomendado selecionado.'
        Leve   = 'Modo leve selecionado.'
        Tudo   = 'Todas as opções foram selecionadas. Revise os itens marcados com aviso.'
        Limpar = 'Seleção limpa.'
    }
    $textoStatus.Text = $mensagens[$Tipo]
}

$botaoRecomendado.Add_Click({ Aplicar-Predefinicao -Tipo Padrao })
$botaoLeve.Add_Click({ Aplicar-Predefinicao -Tipo Leve })
$botaoTudo.Add_Click({ Aplicar-Predefinicao -Tipo Tudo })
$botaoLimpar.Add_Click({ Aplicar-Predefinicao -Tipo Limpar })

$botaoLogs.Add_Click({
    if (-not (Test-Path -LiteralPath $logsPath)) {
        New-Item -ItemType Directory -Path $logsPath -Force | Out-Null
    }
    Start-Process explorer.exe -ArgumentList ('"{0}"' -f $logsPath) | Out-Null
})

$botaoAplicar.Add_Click({
    $selecionados = @($controles | Where-Object { $_.IsChecked -eq $true })

    if ($selecionados.Count -eq 0) {
        Mostrar-Mensagem -Titulo 'Nenhuma alteração selecionada' -Icone Warning -Mensagem 'Selecione pelo menos uma alteração antes de continuar.' | Out-Null
        return
    }

    $itensRisco = @($selecionados | Where-Object { $_.Tag.Risco })
    $resumo = ($selecionados | ForEach-Object { "• $($_.Tag.Titulo)" }) -join "`n"

    $mensagemConfirmacao = "Serão aplicadas $($selecionados.Count) alterações:`n`n$resumo`n`nDeseja continuar?"
    if ($itensRisco.Count -gt 0) {
        $mensagemConfirmacao += "`n`nATENÇÃO: a seleção contém $($itensRisco.Count) opção(ões) avançada(s) marcada(s) em amarelo."
    }

    $confirmacao = Mostrar-Mensagem -Titulo 'Confirmar alterações' -Icone Question -Botoes YesNo -Mensagem $mensagemConfirmacao
    if ($confirmacao -ne [System.Windows.MessageBoxResult]::Yes) {
        $textoStatus.Text = 'Operação cancelada. Nenhuma alteração foi aplicada.'
        return
    }

    $botaoAplicar.IsEnabled = $false
    $textoStatus.Text = 'Aplicando alterações. Não desligue o computador...'
    $janela.Dispatcher.Invoke([action]{}, [System.Windows.Threading.DispatcherPriority]::Background)

    $dataExecucao = Get-Date -Format 'yyyyMMdd-HHmmss'
    $arquivoSaida = Join-Path $logsPath "Win11Debloat-PTBR-$dataExecucao.log"
    $arquivoErro = Join-Path $logsPath "Win11Debloat-PTBR-$dataExecucao-erros.log"

    try {
        $argumentos = @(
            '-NoProfile',
            '-ExecutionPolicy', 'Bypass',
            '-File', ('"{0}"' -f $motorPath),
            '-Silent'
        )

        if ($criarRestauracao.IsChecked -eq $true) {
            $argumentos += '-CreateRestorePoint'
        }

        foreach ($controle in $selecionados) {
            foreach ($token in $controle.Tag.Tokens) {
                $argumentos += [string]$token
            }
        }

        $executavelPowerShell = Join-Path $env:SystemRoot 'System32\WindowsPowerShell\v1.0\powershell.exe'
        $processo = Start-Process -FilePath $executavelPowerShell `
            -ArgumentList $argumentos `
            -Wait `
            -PassThru `
            -WindowStyle Hidden `
            -RedirectStandardOutput $arquivoSaida `
            -RedirectStandardError $arquivoErro

        $temErros = (Test-Path -LiteralPath $arquivoErro) -and ((Get-Item -LiteralPath $arquivoErro).Length -gt 0)

        if ($processo.ExitCode -eq 0 -and -not $temErros) {
            $textoStatus.Text = 'Alterações concluídas com sucesso.'
            Mostrar-Mensagem -Titulo 'Concluído' -Icone Information -Mensagem "As alterações foram aplicadas com sucesso.`n`nAlgumas opções podem exigir que você saia da conta ou reinicie o computador." | Out-Null
        }
        else {
            $textoStatus.Text = 'A execução terminou com avisos. Consulte os logs.'
            Mostrar-Mensagem -Titulo 'Concluído com avisos' -Icone Warning -Mensagem "A execução foi finalizada, mas o motor registrou avisos ou erros.`n`nAbra a pasta de logs para consultar os detalhes.`n`nCódigo de saída: $($processo.ExitCode)" | Out-Null
        }
    }
    catch {
        $textoStatus.Text = 'Não foi possível concluir a operação.'
        $_ | Out-File -FilePath $arquivoErro -Append -Encoding UTF8
        Mostrar-Mensagem -Titulo 'Erro ao aplicar alterações' -Icone Error -Mensagem "Ocorreu um erro durante a execução:`n`n$($_.Exception.Message)`n`nOs detalhes foram salvos na pasta de logs." | Out-Null
    }
    finally {
        $botaoAplicar.IsEnabled = $true
    }
})

$janela.Add_Closed({
    [System.GC]::Collect()
    [System.GC]::WaitForPendingFinalizers()
})

$janela.ShowDialog() | Out-Null
