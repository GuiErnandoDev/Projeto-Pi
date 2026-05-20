# 1. Descrição do Produto

O sistema desenvolvido é um aplicativo móvel para gestão de clientes de energia, permitindo que usuários:
- Realizem cadastro e login
- Visualizem e editem seus dados cadastrais
- Consultem faturas e baixem em PDF
- Acompanhem dashboards de consumo e economia
- Visualizem contratos vinculados

**Objetivo:**
Facilitar o acesso dos clientes às informações de consumo, faturas e contratos, promovendo autonomia e transparência.

**Público-alvo:**
Clientes residenciais e empresariais.

**Problema que resolve:**
Dificuldade de acesso a informações de consumo, faturas e contratos, centralizando tudo em um app prático e seguro.

**Visão geral:**
O usuário realiza login/cadastro, acessa o dashboard com gráficos, consulta faturas, baixa PDFs, visualiza e edita dados do perfil e acompanha contratos ativos e inativos.

# 2. Atributos de Qualidade (ISO 25010)

**1. Usabilidade**
- Descrição: Facilidade de uso e aprendizado do app.
- Justificativa: Usuários de diferentes perfis devem conseguir utilizar o app sem dificuldades.

**2. Confiabilidade**
- Descrição: Capacidade do sistema de funcionar corretamente e proteger dados do usuário.
- Justificativa: Informações sensíveis (faturas, contratos) exigem confiança e integridade.

**3. Eficiência de desempenho**
- Descrição: Tempo de resposta rápido e uso otimizado de recursos do dispositivo.
- Justificativa: Usuários esperam respostas imediatas e navegação fluida.

**4. Segurança**
- Descrição: Proteção contra acessos não autorizados e vazamento de dados.
- Justificativa: O app lida com dados pessoais e financeiros.

**5. Manutenibilidade**
- Descrição: Facilidade de atualização, correção e evolução do sistema.
- Justificativa: O app deve ser facilmente adaptável a novas demandas e correções.

# 3. Requisitos de Qualidade

- O sistema deve permitir que o usuário acesse qualquer funcionalidade principal em no máximo três toques a partir do menu inicial.
- O app deve exibir feedback visual para todas as ações do usuário em até 1 segundo.
- O sistema deve garantir que apenas usuários autenticados acessem dados sensíveis.
- O app deve suportar atualização de dados cadastrais sem necessidade de reinstalação.
- O sistema deve manter disponibilidade mínima de 99% para acesso às funcionalidades principais.

# 4. Decisões de Engenharia

- Utilização da arquitetura MVVM para separar lógica de negócio da interface, facilitando manutenção e testes.
- Uso do Firebase Authentication e Firestore para autenticação segura e armazenamento confiável dos dados.
- Implementação de feedback visual (SnackBar, loaders) para todas as ações do usuário.
- Organização do código em módulos (auth, perfil, faturas, contratos, dashboard) para facilitar evolução e manutenção.
- Utilização de controllers e validação de campos para garantir integridade dos dados inseridos.
- Interface responsiva, com navegação clara e acessível em poucos toques.
