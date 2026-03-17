# Casos de uso do sistema

## UC01 — Realizar login no sistema

**Ator:** Cliente  
**Objetivo:** permitir o acesso seguro ao portal.  
**Pré-condição:** o cliente já possui conta cadastrada no sistema.  
**Pós-condição:** o cliente entra na área principal do portal.

### Fluxo principal
1. O cliente acessa a tela de login.
2. Informa e-mail e senha.
3. O sistema valida as credenciais.
4. O acesso ao portal é liberado.

### Fluxos alternativos
- Se o e-mail ou a senha estiverem incorretos, o sistema informa a falha e permite nova tentativa.
- Se houver 5 tentativas inválidas, a conta é temporariamente bloqueada.
- Se for o primeiro acesso com senha provisória, o sistema exige a troca da senha antes de liberar o restante do portal.

### Relação com o MVP
Esse caso de uso corresponde ao **RF01** e é reforçado pelas regras **RN02** e **RN06**, sendo a porta de entrada para todas as outras funcionalidades do sistema.

---

## UC02 — Alterar senha

**Ator:** Cliente  
**Objetivo:** permitir que o cliente atualize sua senha de acesso.  
**Pré-condição:** o cliente precisa estar autenticado ou em processo de primeiro acesso.  
**Pós-condição:** a nova senha passa a valer para os próximos acessos.

### Fluxo principal
1. O cliente acessa a opção de alterar senha.
2. Informa a nova senha.
3. O sistema valida a alteração.
4. A nova senha é salva.

### Fluxos alternativos
- Se a nova senha não atender aos critérios definidos pelo sistema, a alteração não é concluída.
- Se for o primeiro acesso, o cliente não consegue seguir para o restante do portal sem trocar a senha.

### Relação com o MVP
Esse caso de uso implementa o **RF02** e está diretamente ligado à regra **RN02**, que obriga a troca da senha padrão no primeiro login.

---

## UC03 — Recuperar senha

**Ator:** Cliente  
**Objetivo:** recuperar o acesso ao portal em caso de esquecimento da senha.  
**Pré-condição:** o cliente já possui cadastro no sistema.  
**Pós-condição:** o cliente redefine a senha e pode voltar a acessar a conta.

### Fluxo principal
1. O cliente seleciona a opção **“Esqueci minha senha”**.
2. Informa os dados solicitados.
3. O sistema inicia o processo de recuperação.
4. O cliente redefine a senha.
5. O acesso é restabelecido.

### Fluxos alternativos
- Se os dados informados não forem reconhecidos, o sistema não conclui a recuperação.
- Se o processo for interrompido, a senha continua a mesma até a redefinição correta.

### Relação com o MVP
Esse caso de uso corresponde ao **RF03** e compõe o bloco mínimo de autenticação e segurança do portal.

---

## UC04 — Editar informações do perfil

**Ator:** Cliente  
**Objetivo:** atualizar dados básicos do próprio perfil.  
**Pré-condição:** o cliente já está logado no sistema.  
**Pós-condição:** as informações alteradas ficam registradas no perfil do cliente.

### Fluxo principal
1. O cliente acessa a área de perfil.
2. Visualiza seus dados.
3. Edita os campos permitidos.
4. Salva as alterações.
5. O sistema atualiza o cadastro.

### Fluxos alternativos
- Se algum campo não puder ser alterado, o sistema mantém esse dado apenas para consulta.
- Se houver erro no salvamento, os dados anteriores permanecem válidos.

### Relação com o MVP
Esse caso de uso implementa o **RF04** e atende à proposta de dar mais autonomia ao cliente dentro do portal.

---

## UC05 — Visualizar informações do cliente

**Ator:** Cliente  
**Objetivo:** consultar seus dados dentro do portal.  
**Pré-condição:** o cliente precisa estar autenticado.  
**Pós-condição:** as informações do cliente são exibidas para consulta.

### Fluxo principal
1. O cliente acessa a aba de informações.
2. O sistema busca os dados associados à conta.
3. As informações são exibidas na tela.

### Fluxos alternativos
- Se algum dado estiver incompleto, o sistema mostra somente as informações disponíveis.
- O cliente não pode visualizar dados que não estejam vinculados à própria conta.

### Relação com o MVP
Esse caso de uso corresponde ao **RF05** e também se relaciona à **RN01**, que restringe a visualização aos dados do próprio titular.

---

## UC06 — Consultar e baixar faturas em PDF

**Ator:** Cliente  
**Objetivo:** consultar as faturas disponíveis e baixar o documento em PDF.  
**Pré-condição:** o cliente precisa estar logado e ter faturas vinculadas ao seu cadastro.  
**Pós-condição:** a lista de faturas é exibida e o PDF escolhido pode ser baixado.

### Fluxo principal
1. O cliente acessa a área de faturas.
2. O sistema lista as faturas disponíveis.
3. O cliente escolhe uma fatura.
4. O sistema libera o download em PDF.

### Fluxos alternativos
- Se não houver faturas disponíveis, o sistema informa isso ao cliente.
- Se o download falhar, a fatura continua listada para nova tentativa.
- As faturas devem aparecer com o status correto, como paga, pendente ou em atraso.

### Relação com o MVP
Esse caso de uso implementa o **RF06** e é complementado pela **RN03**, que define a exibição das faturas conforme seu status real.

---

## UC07 — Visualizar dashboard de consumo de energia

**Ator:** Cliente  
**Objetivo:** acompanhar o histórico de consumo de energia.  
**Pré-condição:** o cliente está logado e possui dados de consumo vinculados à conta.  
**Pós-condição:** o dashboard de consumo é exibido ao cliente.

### Fluxo principal
1. O cliente acessa o dashboard de consumo.
2. O sistema recupera os dados correspondentes.
3. Exibe gráficos e indicadores.
4. O cliente analisa o histórico apresentado.

### Fluxos alternativos
- Se não houver dados no período, o sistema exibe mensagem informando a ausência de registros.
- Se existirem contratos inativos, os dashboards do mês atual devem considerar apenas contratos ativos.

### Relação com o MVP
Esse caso de uso corresponde ao **RF07** e depende da **RN04**, que limita os dashboards atuais aos contratos ativos.

---

## UC08 — Visualizar dashboard de economia financeira

**Ator:** Cliente  
**Objetivo:** acompanhar a economia financeira gerada ao cliente.  
**Pré-condição:** o cliente está autenticado e possui dados financeiros vinculados à conta.  
**Pós-condição:** o dashboard de economia é apresentado com os indicadores disponíveis.

### Fluxo principal
1. O cliente abre o dashboard de economia.
2. O sistema busca os dados financeiros correspondentes.
3. Exibe gráficos e valores de economia.
4. O cliente consulta os resultados.

### Fluxos alternativos
- Se não existirem dados para o período escolhido, o sistema informa a indisponibilidade.
- Se houver contratos antigos, os dados do mês atual devem refletir somente os contratos ativos.

### Relação com o MVP
Esse caso de uso implementa o **RF08** e também é afetado pela **RN04**, que separa o histórico de contratos antigos dos dados atuais exibidos nos dashboards.

---

## UC09 — Filtrar dashboards por mês e ano

**Ator:** Cliente  
**Objetivo:** refinar a visualização dos dashboards por período.  
**Pré-condição:** o cliente está logado e acessando algum dashboard do sistema.  
**Pós-condição:** os dashboards passam a exibir os dados do mês e ano selecionados.

### Fluxo principal
1. O cliente acessa um dashboard.
2. Seleciona mês e ano.
3. O sistema aplica o filtro.
4. Os gráficos são atualizados conforme o período informado.

### Fluxos alternativos
- Se não houver dados no período selecionado, o sistema informa que não existem registros.
- Se o filtro for removido, a visualização padrão é restaurada.

### Relação com o MVP
Esse caso de uso corresponde ao **RF09** e funciona como apoio direto aos dashboards de consumo e economia.

---

## UC10 — Visualizar contratos vinculados

**Ator:** Cliente  
**Objetivo:** consultar os contratos associados ao seu CPF ou CNPJ.  
**Pré-condição:** o cliente está autenticado no sistema e possui vínculo contratual com a empresa.  
**Pós-condição:** o cliente consegue visualizar contratos ativos e, quando houver, o histórico de contratos inativos.

### Fluxo principal
1. O cliente acessa a área de contratos.
2. O sistema busca os contratos ligados ao titular autenticado.
3. Exibe os contratos ativos e o histórico disponível.

### Fluxos alternativos
- Se não houver contratos cadastrados, o sistema informa que não existem registros.
- O cliente não pode visualizar contratos vinculados a outro CPF ou CNPJ.
- Contratos inativos podem aparecer no histórico, mas não devem compor os dashboards atuais.

### Relação com o MVP
Esse caso de uso é complementar aos requisitos funcionais, porque a consulta de contratos aparece no objetivo do sistema e nas regras de negócio sobre acesso restrito ao titular e exibição de contratos.
