import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../auth/view/login_page.dart';
import '../../faturas/view/faturas_page.dart';
import '../../contratos/view/contratos_page.dart';
import '../../consumo/view/consumo_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      appBar: AppBar(
        title: Image.asset(
      'assets/Horizontal Padrão Branco.png',
        height: 60, // ajuste o tamanho conforme necessário
        ),
        backgroundColor: const Color(0xFF042454),
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        toolbarHeight: 80,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text.rich(
              TextSpan(
                text: 'Olá, ',
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: FirebaseAuth.instance.currentUser?.displayName ?? 'Usuário',
                    style: const TextStyle(color: Color(0xFF042454)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Acompanhe seus resultados de consumo e economia.',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 24),
            _buildSummaryCards(),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildChartCard('Consumo Mensal (kWh)', const Color.fromARGB(255, 237, 247, 246))),
                const SizedBox(width: 16),
                Expanded(child: _buildChartCard('Economia Mensal (R\$', const Color.fromARGB(255, 237, 247, 246))),
              ],
            ),
            const SizedBox(height: 24),
            _buildFaturaCards(),
            const SizedBox(height: 24),
            _buildFaturasList(),
          ],
        ),
      ),
      backgroundColor: const Color(0xFFF7FAF9),
    );
  }
}

Widget _buildDrawer(BuildContext context) {
  return Drawer(
    child: Container(
      color: const Color(0xFF042454),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFF042454)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/Horizontal Padrão Branco.png',
                  height: 128, // ajuste o tamanho conforme necessário
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard, color: Colors.white),
            title: const Text('Dashboard', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
            onTap: () {
              Navigator.pop(context); // Fecha o Drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.receipt_long, color: Colors.white),
            title: const Text('Faturas', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
            onTap: () {
              Navigator.pop(context); // Fecha o Drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FaturasPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.assignment, color: Colors.white),
            title: const Text('Contratos', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
            onTap: () {
              Navigator.pop(context); // Fecha o Drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContratosPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart, color: Colors.white),
            title: const Text('Consumo', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
            onTap: () {
              Navigator.pop(context); // Fecha o Drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ConsumoPage()),
              );
            },
          ),
          const Divider(color: Colors.white24),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.white70),
            title: const Text('Sair', style: TextStyle(color: Colors.white70)),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    ),
  );
}

Widget _buildSummaryCards() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      _buildSummaryCard('Consumo Total', '39.600 kWh', Icons.flash_on, const Color(0xFF042454)),
      _buildSummaryCard('Economia Total', 'R\$ 5.120,00', Icons.trending_down, const Color(0xFF042454)),
    ],
  );
}

Widget _buildSummaryCard(String title, String value, IconData icon, Color color) {
  return Expanded(
    child: Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color.fromARGB(255, 255, 255, 255), size: 28),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 14, color: Color.fromARGB(255, 255, 255, 255))),
            const SizedBox(height: 4),
            Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 255, 255, 255))),
          ],
        ),
      ),
    ),
  );
}

Widget _buildChartCard(String title, Color color) {
  return Card(
    color: color,
    child: SizedBox(
      height: 220,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: Center(
                child: Text('Gráfico aqui', style: TextStyle(color: Colors.black38)),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
      
Widget _buildFaturaCards() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      _buildFaturaCard('Faturas Pendentes', '2', Icons.receipt_long, const Color(0xFF042454)),
      _buildFaturaCard('Contratos Ativos', '2', Icons.assignment, const Color(0xFF042454)),
    ],
  );
}

Widget _buildFaturaCard(String title, String value, IconData icon, Color color) {
  return Expanded(
    child: Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color.fromARGB(255, 255, 255, 255), size: 28),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 14, color: Color.fromARGB(255, 255, 255, 255))),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255))),
          ],
        ),
      ),
    ),
  );
}

Widget _buildFaturasList() {
  return Card(
    color: const Color.fromARGB(255, 237, 247, 246),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Últimas Faturas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              TextButton(onPressed: () {}, child: const Text('Ver todas →')),
            ],
          ),
          const SizedBox(height: 8),
          _buildFaturaItem('2026-02', '09/03/2026', 'Paga', 'R\$ 2.590,00', Colors.green),
          _buildFaturaItem('2026-04', '09/05/2026', 'Pendente', 'R\$ 2.450,00', Colors.orange),
          _buildFaturaItem('2026-01', '09/02/2026', 'Paga', 'R\$ 3.010,00', Colors.green),
        ],
      ),
    ),
  );
}

Widget _buildFaturaItem(String mes, String venc, String status, String valor, Color statusColor) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    title: Text(mes, style: const TextStyle(fontWeight: FontWeight.bold)),
    subtitle: Text('Venc.: $venc'),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(status, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12)),
        ),
        const SizedBox(width: 12),
        Text(valor, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    ),
  );
}
