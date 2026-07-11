# Win11Debloat Brasil

Uma edição brasileira do Win11Debloat com interface gráfica em **português do Brasil**.

O Win11Debloat Brasil permite remover aplicativos desnecessários, reduzir telemetria, desativar anúncios e sugestões, controlar recursos de inteligência artificial e personalizar o Windows 11 sem precisar alterar cada configuração manualmente.

<img width="1123" height="808" alt="tela1" src="https://github.com/user-attachments/assets/ab744e4c-1f39-41a9-9315-02852fe9f983" />

## Método rápido

Baixe e execute automaticamente a versão mais recente pelo PowerShell.

1. Abra o **PowerShell** ou o **Terminal**.
2. Copie e cole o comando abaixo:

```powershell
& ([scriptblock]::Create((irm "https://win11.anglus.com.br/Get-PTBR.ps1")))
```

3. Aguarde o download automático.
4. Aceite a solicitação de administrador do Windows.
5. Revise as opções e aplique somente as alterações desejadas.

> O comando sempre baixa a versão mais recente publicada na branch `master`.

## Método tradicional

<details>
<summary>Baixar e executar manualmente</summary>

1. Baixe o arquivo ZIP do repositório.
2. Extraia o conteúdo para uma pasta.
3. Execute `Run.bat` ou `Executar-PTBR.bat`.
4. Aceite a solicitação de administrador.
5. Siga as instruções exibidas na interface.

</details>

## Método avançado

<details>
<summary>Executar diretamente pelo PowerShell</summary>

1. Abra o PowerShell como administrador.
2. Acesse a pasta na qual os arquivos foram extraídos.
3. Execute:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
.\Win11Debloat-PTBR.ps1
```

</details>

## Recursos

### Remoção de aplicativos

- Remove aplicativos pré-instalados e promocionais.
- Remove aplicativos de jogos e componentes opcionais.
- Mantém opções sensíveis desmarcadas por padrão.

### Privacidade e conteúdo sugerido

- Desativa telemetria, dados de diagnóstico, histórico de atividades e anúncios personalizados.
- Remove dicas, sugestões e publicidade em diferentes áreas do Windows.
- Permite desativar localização e o recurso Localizar meu dispositivo.
- Reduz anúncios e conteúdo promocional no Microsoft Edge.

### Inteligência artificial

- Desativa o Microsoft Copilot.
- Desativa o Windows Recall.
- Desativa o recurso Clique para Fazer.
- Permite controlar recursos de IA do Paint, Bloco de Notas e Microsoft Edge.

### Sistema e atualizações

- Restaura o menu de contexto clássico.
- Desativa aceleração do mouse e atalhos das Teclas de Aderência.
- Controla Inicialização Rápida, Sensor de Armazenamento e BitLocker automático.
- Evita reinicializações automáticas durante o uso.
- Desativa o compartilhamento de atualizações com outros computadores.

### Aparência

- Ativa o modo escuro.
- Desativa transparência, animações e efeitos visuais.

### Menu Iniciar e pesquisa

- Remove resultados da Web e integração com o Bing.
- Oculta sugestões da Microsoft Store e destaques da pesquisa.
- Permite limpar ou simplificar o Menu Iniciar.

### Barra de tarefas

- Alinha os ícones à esquerda.
- Oculta pesquisa, Widgets, conversa e Visão de Tarefas.
- Adiciona a opção Finalizar tarefa.

### Explorador de Arquivos

- Mostra extensões de arquivos conhecidos.
- Mostra arquivos e pastas ocultos.
- Abre diretamente em Este Computador.
- Remove itens duplicados e atalhos desnecessários.

### Multitarefa

- Controla ajuste de janelas, Assistente de Ajuste e layouts.
- Define o comportamento do Alt + Tab.

### Recursos opcionais

- Ativa a Área Restrita do Windows.
- Ativa o Subsistema do Windows para Linux.

## Segurança

O modo recomendado foi criado para reduzir riscos, mas qualquer ferramenta que modifica configurações do Windows deve ser utilizada com atenção.

Antes de aplicar alterações:

- mantenha a criação do ponto de restauração ativada;
- revise as opções marcadas em amarelo;
- não desligue o computador durante a execução;
- reinicie o Windows quando necessário;
- use apenas em computadores nos quais você tenha autorização administrativa.

## Compatibilidade

Projetado para Windows 11 com Windows PowerShell 5.1 ou PowerShell mais recente.

Algumas opções dependem da edição, versão e compilação instalada do Windows.

## Créditos e licença

Este projeto utiliza e preserva o motor do **Win11Debloat**, criado por **Raphire**, distribuído sob a licença MIT.

- Projeto original: Raphire/Win11Debloat
- Edição brasileira: Michel Anglus
- Licença: MIT
