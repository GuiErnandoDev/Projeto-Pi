import 'package:flutter/material.dart';

class Fatura {
  final String referencia;
  final double valor;
  final String status;
  Fatura({required this.referencia, required this.valor, required this.status});
}

class FaturasViewModel extends ChangeNotifier {
  final List<Fatura> _faturas = [];
  List<Fatura> get faturas => List.unmodifiable(_faturas);

  void adicionarFatura(Fatura fatura) {
    _faturas.add(fatura);
    notifyListeners();
  }

  double get total => _faturas.fold(0.0, (total, f) => total + f.valor);

  int get pendentes => _faturas.where((f) => f.status.toLowerCase() == 'pendente').length;
  int get pagas => _faturas.where((f) => f.status.toLowerCase() == 'paga').length;
}
