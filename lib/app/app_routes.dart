// Centralização de rotas do app
// Exemplo de estrutura, ajuste conforme suas rotas reais
import 'package:flutter/material.dart';
import '../ui/features/home/view/home_page.dart';
import '../ui/features/faturas/view/faturas_page.dart';
import '../ui/features/contratos/view/contratos_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String faturas = '/faturas';
  static const String contratos = '/contratos';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case faturas:
        return MaterialPageRoute(builder: (_) => const FaturasPage());
      case contratos:
        return MaterialPageRoute(builder: (_) => const ContratosPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Rota não encontrada: \'${settings.name}\'')),
          ),
        );
    }
  }
}
