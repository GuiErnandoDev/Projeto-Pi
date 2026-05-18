import 'package:flutter_test/flutter_test.dart';
import 'package:piprojeto/ui/features/faturas/viewmodel/faturas_viewmodel.dart';

void main() {
  late FaturasViewModel viewModel;

  setUp(() {
    viewModel = FaturasViewModel();
  });

  group('FaturasViewModel', () {
    test('Adiciona fatura e calcula total', () {
      viewModel.adicionarFatura(Fatura(referencia: '2024-01', valor: 100.0, status: 'Paga'));
      viewModel.adicionarFatura(Fatura(referencia: '2024-02', valor: 200.0, status: 'Pendente'));
      expect(viewModel.faturas.length, 2);
      expect(viewModel.total, 300.0);
    });

    test('Conta faturas pagas e pendentes', () {
      viewModel.adicionarFatura(Fatura(referencia: '2024-01', valor: 100.0, status: 'Paga'));
      viewModel.adicionarFatura(Fatura(referencia: '2024-02', valor: 200.0, status: 'Pendente'));
      viewModel.adicionarFatura(Fatura(referencia: '2024-03', valor: 50.0, status: 'Pendente'));
      expect(viewModel.pagas, 1);
      expect(viewModel.pendentes, 2);
    });
  });
}
