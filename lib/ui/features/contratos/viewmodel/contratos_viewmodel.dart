import 'package:flutter/material.dart';

class Contrato {
  final String nome;
  final String status;
  Contrato({required this.nome, required this.status});
}

class ContratosViewModel extends ChangeNotifier {
  final List<Contrato> _contratos = [];
  List<Contrato> get contratos => List.unmodifiable(_contratos);

  void adicionarContrato(Contrato contrato) {
    _contratos.add(contrato);
    notifyListeners();
  }

  int get ativos => _contratos.where((c) => c.status.toLowerCase() == 'ativo').length;
  int get inativos => _contratos.where((c) => c.status.toLowerCase() == 'inativo').length;
}
