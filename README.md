# Win11Debloat Brasil

Uma edição brasileira, com interface gráfica totalmente em **português do Brasil**, baseada no motor do projeto Win11Debloat.

> **Objetivo:** facilitar a remoção de aplicativos desnecessários, reduzir telemetria, desativar anúncios e sugestões, controlar recursos de inteligência artificial e personalizar o Windows 11 sem exigir conhecimentos avançados de PowerShell.

## Principais recursos

- Interface gráfica moderna e organizada por categorias.
- Modo recomendado e modo leve.
- Criação opcional de ponto de restauração antes das alterações.
- Remoção de aplicativos pré-instalados.
- Controles de privacidade, telemetria e localização.
- Desativação de Copilot, Recall, Clique para Fazer e outros recursos de IA.
- Ajustes do Menu Iniciar, barra de tarefas e Explorador de Arquivos.
- Opções de desempenho, aparência, atualizações e multitarefa.
- Registro detalhado das execuções na pasta `Logs`.
- Avisos visuais para opções mais sensíveis.

## Como instalar sobre o repositório atual

1. Baixe e extraia este pacote.
2. Clique com o botão direito em `INSTALAR-PTBR.ps1`.
3. Escolha **Executar com PowerShell**.
4. Informe a pasta do repositório Win11Debloat quando solicitado.
5. Após a instalação, execute `Run.bat` ou `Executar-PTBR.bat`.

O instalador cria uma pasta de backup antes de substituir `README.md`, `Run.bat` ou uma versão anterior da interface brasileira.

## Instalação manual

Copie estes arquivos para a raiz do repositório:

- `Win11Debloat-PTBR.ps1`
- `Run.bat`
- `Executar-PTBR.bat`
- `README.md`

Depois copie:

- `Config/Recursos-PTBR.json` para a pasta `Config`.

O arquivo original `Win11Debloat.ps1` precisa permanecer no mesmo diretório, pois ele é o motor responsável por executar as alterações.

## Como usar

1. Execute `Run.bat`.
2. Aceite a solicitação de administrador do Windows.
3. Escolha o modo recomendado, o modo leve ou marque as opções manualmente.
4. Passe o mouse sobre qualquer item para ler a explicação.
5. Clique em **Aplicar alterações**.
6. Revise o resumo e confirme.

As mensagens da interface são exibidas em português. A saída técnica do motor é direcionada para arquivos na pasta `Logs`.

## Segurança

Antes de aplicar alterações:

- mantenha a opção de criar ponto de restauração ativada;
- revise itens marcados em amarelo;
- não desligue o computador durante a execução;
- reinicie o Windows quando solicitado;
- use apenas em computadores nos quais você tenha autorização administrativa.

Algumas configurações podem afetar recursos específicos, políticas corporativas, criptografia, sincronização ou aplicativos instalados. O uso é de responsabilidade do usuário.

## Compatibilidade

Projetado para Windows 11 com Windows PowerShell 5.1 e os arquivos atuais do Win11Debloat. Alguns recursos dependem da edição, versão e compilação do Windows.

## Créditos e licença

Este projeto utiliza e preserva o motor do **Win11Debloat**, criado por **Raphire**, distribuído sob a licença MIT.

- Projeto original: Raphire/Win11Debloat
- Edição brasileira: Michel Anglus
- Licença: MIT

Os avisos de copyright e licença do projeto original devem permanecer no repositório e em qualquer redistribuição.
