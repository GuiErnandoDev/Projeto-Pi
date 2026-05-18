import 'package:flutter_test/flutter_test.dart';
import 'package:piprojeto/ui/features/auth/viewmodel/login_viewmodel.dart';

void main() {
  late LoginViewModel viewModel;

  setUp(() {
    viewModel = LoginViewModel();
  });

  group('LoginViewModel - Testes de Unidade', () {
    test('Login válido', () async {
      await viewModel.login(email: 'teste@email.com', password: '123456');
      expect(viewModel.isLogged, true);
      expect(viewModel.message, isNull);
    });

    test('Login com campos vazios', () async {
      await viewModel.login(email: '', password: '');
      expect(viewModel.isLogged, false);
      expect(viewModel.message, 'Preencha email e senha.');
    });

    test('Login inválido', () async {
      await viewModel.login(email: 'teste@email.com', password: 'errado');
      expect(viewModel.isLogged, false);
      expect(viewModel.message, 'E-mail ou senha inválidos');
    });
  });
}
