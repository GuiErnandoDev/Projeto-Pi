# Casos de uso do sistema

## UC01 — Realizar login no sistema

**Ator:** Cliente  
**Objetivo:** permitir o acesso seguro ao portal.  
**Pré-condição:** o cliente já possui conta cadastrada no sistema.  
**Pós-condição:** o cliente entra na área principal do portal.

**Diagrama de Atividade**
<img width="470" height="747" alt="image" src="https://github.com/user-attachments/assets/18992287-dae1-480a-bc93-c51a09a1b285" />

**Diagrama de Sequência**
<img width="684" height="842" alt="image" src="https://github.com/user-attachments/assets/1836423a-7ea3-4d2e-9080-7ddb81acdd0e" />

---

## UC02 — Alterar senha

**Ator:** Cliente  
**Objetivo:** permitir que o cliente atualize sua senha de acesso.  
**Pré-condição:** o cliente precisa estar autenticado ou em processo de primeiro acesso.  
**Pós-condição:** a nova senha passa a valer para os próximos acessos.

**Diagrama de Atividade**
<img width="410" height="666" alt="image" src="https://github.com/user-attachments/assets/97449243-7d0e-4b23-8139-1df3a61de963" />

**Diagrama de Sequência**
<img width="669" height="536" alt="image" src="https://github.com/user-attachments/assets/affdc60a-cac9-4bb6-8368-705a03670c4b" />

---

## UC03 — Recuperar senha

**Ator:** Cliente  
**Objetivo:** recuperar o acesso ao portal em caso de esquecimento da senha.  
**Pré-condição:** o cliente já possui cadastro no sistema.  
**Pós-condição:** o cliente redefine a senha e pode voltar a acessar a conta.

**Diagrama de Atividade**
<img width="432" height="742" alt="image" src="https://github.com/user-attachments/assets/02418181-a8db-4fdb-a277-f3477f48c96b" />

**Diagrama de Sequência**
<img width="760" height="748" alt="image" src="https://github.com/user-attachments/assets/ddef0431-f8e9-4c0f-85c3-ec548d967f38" />

---

## UC04 — Editar informações do perfil

**Ator:** Cliente  
**Objetivo:** atualizar dados básicos do próprio perfil.  
**Pré-condição:** o cliente já está logado no sistema.  
**Pós-condição:** as informações alteradas ficam registradas no perfil do cliente.

**Diagrama de Atividade**
<img width="692" height="592" alt="image" src="https://github.com/user-attachments/assets/f28c618e-a888-4fb4-9ad8-8bddf0ca1529" />

**Diagrama de Sequência**
<img width="620" height="718" alt="image" src="https://github.com/user-attachments/assets/69c361f2-4c04-439c-b20e-5344db91f971" />

---

## UC05 — Visualizar informações do cliente

**Ator:** Cliente  
**Objetivo:** consultar seus dados dentro do portal.  
**Pré-condição:** o cliente precisa estar autenticado.  
**Pós-condição:** as informações do cliente são exibidas para consulta.

**Diagrama de Atividade**
<img width="594" height="415" alt="image" src="https://github.com/user-attachments/assets/9d6acc73-1b9c-41f1-9614-dd314aee3864" />

**Diagrama de Sequência**
<img width="700" height="506" alt="image" src="https://github.com/user-attachments/assets/ae7798ef-5018-4d1e-ade6-756c8fd15534" />

---

## UC06 — Consultar e baixar faturas em PDF

**Ator:** Cliente  
**Objetivo:** consultar as faturas disponíveis e baixar o documento em PDF.  
**Pré-condição:** o cliente precisa estar logado e ter faturas vinculadas ao seu cadastro.  
**Pós-condição:** a lista de faturas é exibida e o PDF escolhido pode ser baixado.

**Diagrama de Atividade**
<img width="646" height="620" alt="image" src="https://github.com/user-attachments/assets/169d53ef-6411-49fa-bce7-c5671520be6b" />

**Diagrama de Sequência**
<img width="613" height="766" alt="image" src="https://github.com/user-attachments/assets/33d8df83-8ff4-4605-901f-fd860eac20bf" />

---

## UC07 — Visualizar dashboard de consumo de energia

**Ator:** Cliente  
**Objetivo:** acompanhar o histórico de consumo de energia.  
**Pré-condição:** o cliente está logado e possui dados de consumo vinculados à conta.  
**Pós-condição:** o dashboard de consumo é exibido ao cliente.

**Diagrama de Atividade**
<img width="446" height="574" alt="image" src="https://github.com/user-attachments/assets/4b3d0a7b-ad77-4220-a25b-f87345294545" />

**Diagrama de Sequência**
<img width="776" height="581" alt="image" src="https://github.com/user-attachments/assets/cd718642-856f-4f04-ab55-91c0efa6673d" />

---

## UC08 — Visualizar dashboard de economia financeira

**Ator:** Cliente  
**Objetivo:** acompanhar a economia financeira gerada ao cliente.  
**Pré-condição:** o cliente está autenticado e possui dados financeiros vinculados à conta.  
**Pós-condição:** o dashboard de economia é apresentado com os indicadores disponíveis.

**Diagrama de Atividade**
<img width="478" height="559" alt="image" src="https://github.com/user-attachments/assets/1252cc0a-3150-4d12-aec9-bd9f6c7108ad" />

**Diagrama de Sequência**
<img width="817" height="581" alt="image" src="https://github.com/user-attachments/assets/45f6691a-faac-4f34-8baf-92981fc091ef" />

---

## UC09 — Filtrar dashboards por mês e ano

**Ator:** Cliente  
**Objetivo:** refinar a visualização dos dashboards por período.  
**Pré-condição:** o cliente está logado e acessando algum dashboard do sistema.  
**Pós-condição:** os dashboards passam a exibir os dados do mês e ano selecionados.

**Diagrama de Atividade**
<img width="525" height="544" alt="image" src="https://github.com/user-attachments/assets/0632e61b-82e0-4377-9ba1-782f43a23c0e" />

**Diagrama de Sequência**
<img width="734" height="690" alt="image" src="https://github.com/user-attachments/assets/2856ae05-88d2-44ec-94e7-325f231213fa" />

---

## UC10 — Visualizar contratos vinculados

**Ator:** Cliente  
**Objetivo:** consultar os contratos associados ao seu CPF ou CNPJ.  
**Pré-condição:** o cliente está autenticado no sistema e possui vínculo contratual com a empresa.  
**Pós-condição:** o cliente consegue visualizar contratos ativos e, quando houver, o histórico de contratos inativos.

**Diagrama de Atividade**
<img width="606" height="688" alt="image" src="https://github.com/user-attachments/assets/a116071a-b406-4d44-aae1-80c08d56ab4f" />

**Diagrama de Sequência**
<img width="745" height="708" alt="image" src="https://github.com/user-attachments/assets/9d062c4e-9f25-4b13-9a66-bf8b86c1f434" />


