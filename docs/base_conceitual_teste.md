# Documento A — Base Conceitual de Teste

**Projeto:** Auth 29119 App  
**Tecnologia:** Flutter  
**Arquitetura:** MVVM  
**Norma aplicada:** ISO/IEC/IEEE 29119-1

## 1. Sistema sob teste
Fluxo de autenticação do aplicativo Flutter.

## 2. Itens de teste
- SignUpViewModel
- LoginViewModel
- AuthRepositoryImpl
- FakeAuthService
- Fluxo Login → Home
- Fluxo Cadastro → Login

## 3. Escopo
- Cadastro
- Login
- Navegação
- Validação de campos
- Testes de unidade
- Testes de integração

## 4. Fora de escopo
- Firebase
- API real
- Segurança
- Performance

## 5. Requisitos
- RF01 — O usuário deve conseguir se cadastrar.
- RF02 — O sistema deve impedir cadastro com campos vazios.
- RF03 — O sistema deve impedir cadastro com e-mail inválido.
- RF04 — O sistema deve impedir cadastro duplicado.
- RF05 — O sistema deve retornar para login após cadastro.
- RF06 — O usuário deve conseguir fazer login.
- RF07 — O sistema deve impedir login com campos vazios.
- RF08 — O sistema deve impedir login inválido.
- RF09 — O sistema deve navegar para Home após login válido.

## 6. Condições de teste
- CT01 — Validar cadastro válido
- CT02 — Validar cadastro com campos vazios
- CT03 — Validar e-mail inválido
- CT04 — Validar cadastro duplicado
- CT05 — Validar retorno ao login
- CT06 — Validar login válido
- CT07 — Validar login com campos vazios
- CT08 — Validar login inválido
- CT09 — Validar navegação para Home

## 7. Tipos de teste
- Teste de Unidade
- Teste de Integração

## 8. Riscos
- R01 — Login inválido permitir acesso
- R02 — Navegação não funcionar
- R03 — Cadastro aceitar dados inválidos
- R04 — Mensagens não serem exibidas
- R05 — Estado do ViewModel inconsistente
