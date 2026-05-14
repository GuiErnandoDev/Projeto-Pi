import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      appBar: AppBar(
        title: const Text('ATIVVO'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
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
                    text: 'Nogueira',
                    style: TextStyle(color: Colors.teal),
                  ),
                  TextSpan(text: ' 👋'),
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
                Expanded(child: _buildChartCard('Consumo Mensal (kWh)', Colors.teal.shade100)),
                const SizedBox(width: 16),
                Expanded(child: _buildChartCard('Economia Mensal (R\$', Colors.yellow.shade200)),
              ],
            ),
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
      color: const Color(0xFF16202A),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFF16202A)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('ATIVVO', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('CONSULTORIA ENERGÉTICA', style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
          _buildDrawerItem(Icons.dashboard, 'Dashboard'),
          _buildDrawerItem(Icons.receipt_long, 'Faturas'),
          _buildDrawerItem(Icons.assignment, 'Contratos'),
          _buildDrawerItem(Icons.bar_chart, 'Consumo'),
          const Divider(color: Colors.white24),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.white70),
            title: const Text('Sair', style: TextStyle(color: Colors.white70)),
            onTap: () {},
          ),
        ],
      ),
    ),
  );
}

Widget _buildDrawerItem(IconData icon, String title) {
  return ListTile(
    leading: Icon(icon, color: Colors.white),
    title: Text(title, style: const TextStyle(color: Colors.white)),
    onTap: () {},
  );
}

Widget _buildSummaryCards() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      _buildSummaryCard('Consumo Total', '39.600 kWh', Icons.flash_on, Colors.teal.shade50),
      _buildSummaryCard('Economia Total', 'R\$ 5.120,00', Icons.trending_down, Colors.green.shade50),
      _buildSummaryCard('Faturas Pendentes', '2', Icons.receipt_long, Colors.orange.shade50),
      _buildSummaryCard('Contratos Ativos', '2', Icons.assignment, Colors.blue.shade50),
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
            Icon(icon, color: Colors.teal, size: 28),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 14, color: Colors.black54)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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

Widget _buildFaturasList() {
  return Card(
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
