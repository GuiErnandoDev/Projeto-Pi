# Documento C — Técnicas e Casos de Teste

**Projeto:** Auth 29119 App  
**Tecnologia:** Flutter  
**Arquitetura:** MVVM  
**Norma aplicada:** ISO/IEC/IEEE 29119-4

## 1. Técnicas Utilizadas

| Técnica                       | Finalidade                           |
|-------------------------------|--------------------------------------|
| Particionamento de Equivalência | Separar entradas válidas e inválidas |
| Valor Limite                  | Validar campos vazios                |
| Transição de Estado           | Validar mudança de estado do sistema |
| Teste Baseado em Cenário      | Validar fluxo completo entre telas   |

## 2. Derivação das Condições de Teste

- CT01 — Validar cadastro válido (Particionamento de Equivalência)
- CT02 — Validar cadastro com campos vazios (Particionamento + Valor Limite)
- CT03 — Validar e-mail inválido (Particionamento)
- CT04 — Validar cadastro duplicado (Transição de Estado)
- CT05 — Validar retorno ao login (Cenário)
- CT06 — Validar login válido (Particionamento)
- CT07 — Validar login com campos vazios (Particionamento + Valor Limite)
- CT08 — Validar login inválido (Particionamento)
- CT09 — Validar navegação para Home (Cenário)

## 3. Tabela Consolidada de Casos de Teste

| ID   | Caso                                 |
|------|--------------------------------------|
| TC01 | Cadastro com dados válidos           |
| TC02 | Cadastro com campos vazios           |
| TC03 | Cadastro com e-mail inválido         |
| TC04 | Cadastro duplicado                   |
| TC05 | Retorno ao login após cadastro       |
| TC06 | Login válido                         |
| TC07 | Login com campos vazios              |
| TC08 | Login inválido                       |
| TC09 | Navegação para Home                  |

## 4. Conclusão da Etapa
As condições de teste identificadas anteriormente foram derivadas em casos de teste completos utilizando técnicas formais definidas pela ISO/IEC/IEEE 29119-4. Os casos de teste produzidos estão preparados para implementação automatizada no projeto Flutter, utilizando testes de unidade e testes de integração.
