# Pillbox

Pillbox é um aplicativo de gerenciamento de medicamentos desenvolvido em Flutter, que se conecta a uma caixa de remédios inteligente por meio de um Arduino. O aplicativo ajuda os usuários a manterem o controle de seus medicamentos, horários de administração e doses, facilitando o gerenciamento da saúde de maneira eficiente e intuitiva.

## Funcionalidades

- **Criação de Perfil:** Os usuários podem criar um perfil para armazenar informações pessoais e preferências relacionadas ao gerenciamento de medicamentos.
- **Cadastro de Medicamentos:** Adicione medicamentos ao seu perfil, incluindo detalhes como nome, dosagem, frequência e horários de administração.
- **Conexão com Caixa de Remédios Inteligente:** O aplicativo se comunica com uma caixa de remédios inteligente via Arduino, para automatizar o controle e fornecimento dos medicamentos.
- **Alertas de Medicação:** Receba notificações e lembretes para tomar seus medicamentos nos horários programados.
- **Histórico de Administração:** Visualize o histórico de administração de medicamentos, incluindo datas e horários em que os medicamentos foram tomados.
- **Gerenciamento de Doses:** Ajuste a dosagem e a frequência de administração dos medicamentos conforme necessário.

## Instalação

Para instalar o Pillbox, siga estas etapas:

1. Abra o navegador da Web e acesse o site do GitHub.
2. Clique no botão "Code" e selecione "Download ZIP".
3. Extraia o arquivo ZIP para uma pasta de sua preferência.
4. Abra o terminal e navegue até a pasta onde o arquivo ZIP foi extraído.
5. Execute os seguintes comandos para instalar e executar o aplicativo:

```bash
flutter clean
flutter pub get
flutter run
```

## Configuração do Hardware

Para conectar o Pillbox à caixa de remédios inteligente, siga estas etapas:

1. Configure o Arduino de acordo com as especificações fornecidas no repositório do projeto.
2. Conecte o Arduino à caixa de remédios inteligente e ao seu computador.
3. Certifique-se de que o firmware do Arduino está atualizado e configurado para se comunicar com o aplicativo Pillbox.
4. Ajuste as configurações de comunicação no aplicativo para conectar-se ao Arduino.

## Contribuições

Contribuições são bem-vindas! Se você tiver sugestões ou correções, sinta-se à vontade para abrir um issue ou enviar um pull request.

## Autor

Henrique França, Leonardo Yukio, Luiza Loures

## Licença

Pillbox é um projeto de código aberto licenciado sob a licença MIT.

## Exemplo de Uso

Aqui está um exemplo de como usar o Pillbox:

1. Crie um perfil e adicione seus medicamentos.
2. Configure os horários de administração e as doses para cada medicamento.
3. Conecte o aplicativo à caixa de remédios inteligente usando o Arduino.
4. Receba alertas e notificações quando for hora de tomar seu medicamento.
5. Verifique o histórico para acompanhar a administração dos seus medicamentos.

