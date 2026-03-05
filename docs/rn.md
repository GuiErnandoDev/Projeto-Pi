# Regras de Negócio (RN)

### RN01 — Acesso Restrito ao Titular
Um cliente só pode visualizar contratos, faturas e dashboards que estejam estritamente vinculados ao seu próprio CPF ou CNPJ. 

### RN02 — Segurança no Primeiro Acesso
Quando a Ativvo criar a conta do cliente e fornecer uma senha padrão, o sistema deve obrigar o cliente a alterar essa senha no seu primeiro login, antes de acessar qualquer dashboard.

### RN03 — Status das Faturas 
O sistema deve classificar e exibir as faturas com base em seus status reais (ex: "Paga", "Pendente" ou "Em Atraso"), refletindo a situação financeira do cliente com a Ativvo.

### RN04 — Exibição de Contratos 
O cliente pode visualizar o histórico de contratos antigos (inativos), mas os dashboards de consumo e economia do mês atual devem refletir apenas os dados de contratos que estão atualmente ativos.

### RN05 — Maioridade 
Para criar uma conta, o usuário deve ter mais de 18 anos.

### RN06 — Limite de tentativas de login
Após 5 tentativas inválidas, a conta deve ser temporariamente bloqueada.
