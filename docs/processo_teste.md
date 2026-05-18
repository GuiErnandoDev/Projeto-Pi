# Documento B — Processo de Teste

**Projeto:** Auth 29119 App  
**Tecnologia:** Flutter  
**Arquitetura:** MVVM  
**Norma aplicada:** ISO/IEC/IEEE 29119-2

## 1. Estratégia de Teste
- Testes de unidade
- Testes de integração
- Uso de FakeAuthService

## 2. Ambiente de Teste
- Flutter SDK
- Dart SDK
- flutter_test
- integration_test

## 3. Critérios de Entrada
- Projeto funcional
- ViewModels implementados
- Documento A concluído

## 4. Critérios de Saída
- Todos os testes executados
- Resultados registrados
- Relatório produzido

## 5. Ordem de Execução
1. Testar SignUpViewModel
2. Testar LoginViewModel
3. Testar integração Cadastro → Login
4. Testar integração Login → Home

## 6. Implementação
test/
  viewmodel/
    login_viewmodel_test.dart
    signup_viewmodel_test.dart
integration_test/
  auth_flow_test.dart

## 7. Controle
- Planejados
- Executados
- Aprovados
- Reprovados

## 8. Execução
- flutter test
- flutter test integration_test

## 9. Conclusão
Encerrar após execução completa e análise dos resultados.
