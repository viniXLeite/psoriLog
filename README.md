# PsoriLog - MVP (Versão Beta 1.0)

O **PsoriLog** é uma aplicação móvel desenvolvida para auxiliar no monitoramento e tratamento de pacientes com Psoríase. O app permite o registro diário de sintomas pelos pacientes e o acompanhamento da evolução clínica por médicos através de dashboards visuais.

Este projeto foi desenvolvido em um **Sprint de 7 dias**, focando na arquitetura robusta e funcionalidades essenciais.

## 🚀 Tecnologias e Arquitetura

O projeto segue estritamente os princípios da **Clean Architecture** para garantir escalabilidade, testabilidade e desacoplamento.

* **Linguagem:** Dart (Flutter 3.x)
* **Gerenciamento de Estado:** Provider & ChangeNotifier
* **Injeção de Dependência:** GetIt
* **Requisições HTTP:** Dio
* **Armazenamento Seguro:** Flutter Secure Storage
* **Gráficos:** FL Chart
* **Backend:** Laravel (API REST)

### Estrutura de Pastas (Clean Architecture)
* `lib/features/`: Dividido por funcionalidades (Auth, DailyLog).
    * `presentation/`: UI (Pages, Widgets) e State (Providers).
    * `domain/`: Regras de Negócio (Entities, UseCases) e Contratos (Repositories).
    * `data/`: Implementação técnica (Models, DataSources, Repositories).
* `lib/core/`: Configurações globais (Network, Errors).

## 🛠️ Pré-requisitos

Para rodar o projeto localmente, você precisa de:
* Flutter SDK instalado.
* Emulador Android ou Dispositivo Físico.
* Backend Laravel rodando (ou configurar o App para modo Mock).

## 📦 Como Rodar

1.  **Clone o repositório:**
    ```bash
    git clone [https://github.com/seu-usuario/psorilog-mobile.git](https://github.com/seu-usuario/psorilog-mobile.git)
    cd psorilog-mobile
    ```

2.  **Instale as dependências:**
    ```bash
    flutter pub get
    ```

3.  **Configuração de Ambiente (Importante):**
    * O arquivo `lib/core/network/api_client.dart` define o IP do servidor.
    * **Emulador:** Usa `10.0.2.2`.
    * **Celular Físico:** Altere para o IP da sua máquina (ex: `192.168.0.X`).

4.  **Execute o App:**
    ```bash
    flutter run
    ```

## 🧪 Estratégia de Mock (Dados Fictícios)

Para garantir a estabilidade durante a apresentação, o aplicativo possui um sistema híbrido. Caso o backend esteja indisponível, os repositórios (`MockAuthRepository`, `MockDailyLogRepository`) podem ser injetados via `injection_container.dart` para simular o funcionamento completo da aplicação com dados locais.

## 👥 Autores

* **Rafael José Coelho Souza** - *Desenvolvimento Mobile & Arquitetura*
* **Vinicius Leite Xavier** - *UI Design & Frontend*
* **Breno Copeland Pitanga** - *Backend & Servidores*
* **Beatriz Eduarda Pires da Cruz** - *Banco de Dados*
