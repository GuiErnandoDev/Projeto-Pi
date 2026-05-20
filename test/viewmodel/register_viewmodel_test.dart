import 'package:flutter_test/flutter_test.dart';
import 'package:piprojeto/ui/features/auth/viewmodel/register_viewmodel.dart';

void main() {
  late RegisterViewModel viewModel;

  setUp(() {
    viewModel = RegisterViewModel();
  });

  group('RegisterViewModel - Testes de Unidade', () {
    test('TC01 — Cadastro válido', () async {
      await viewModel.register(name: 'Gabriel', email: 'gabriel@email.com', password: '123456');
      expect(viewModel.isRegistered, true);
      expect(viewModel.message, 'Cadastro realizado com sucesso');
    });

    test('TC02 — Cadastro com campos vazios', () async {
      await viewModel.register(name: '', email: '', password: '');
      expect(viewModel.isRegistered, false);
      expect(viewModel.message, 'Preencha todos os campos.');
    });

    test('TC03 — Cadastro com email inválido', () async {
      await viewModel.register(name: 'Gabriel', email: 'gabriel', password: '123456');
      expect(viewModel.isRegistered, false);
      expect(viewModel.message, 'Informe um email válido');
    });

    test('TC04 — Cadastro duplicado', () async {
      await viewModel.register(name: 'Gabriel', email: 'gabriel@email.com', password: '123456');
      viewModel.clearMessage();
      await viewModel.register(name: 'Outro', email: 'gabriel@email.com', password: '654321');
      expect(viewModel.isRegistered, false);
      expect(viewModel.message, 'E-mail já cadastrado');
    });
  });
}
