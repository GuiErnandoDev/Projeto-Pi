import 'package:flutter_test/flutter_test.dart';
import 'package:piprojeto/ui/features/contratos/viewmodel/contratos_viewmodel.dart';

void main() {
  late ContratosViewModel viewModel;

  setUp(() {
    viewModel = ContratosViewModel();
  });

  group('ContratosViewModel', () {
    test('TC01 — Adiciona contrato e conta ativos/inativos', () {
      viewModel.adicionarContrato(Contrato(nome: 'Contrato 1', status: 'Ativo'));
      viewModel.adicionarContrato(Contrato(nome: 'Contrato 2', status: 'Inativo'));
      viewModel.adicionarContrato(Contrato(nome: 'Contrato 3', status: 'Ativo'));
      expect(viewModel.contratos.length, 3);
      expect(viewModel.ativos, 2);
      expect(viewModel.inativos, 1);
    });
  });
}
