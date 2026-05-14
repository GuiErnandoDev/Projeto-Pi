import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../auth/view/login_page.dart';
import '../../faturas/view/faturas_page.dart';
import '../../contratos/view/contratos_page.dart';
import '../../home/view/home_page.dart';

class ConsumoPage extends StatelessWidget {
	const ConsumoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      appBar: AppBar(
        title: const Text('Consumo'),
        backgroundColor: const Color(0xFF042454),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF7FAF9),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Consumo',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF222222),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Histórico e análise de consumo energético',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Gráfico 1
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Consumo Mensal (kWh)', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFEAF8F3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(child: Text('Gráfico de Linha (placeholder)', style: TextStyle(color: Colors.black38))),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Gráfico 2
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Economia Mensal (R\$)', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFF9E5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(child: Text('Gráfico de Barras (placeholder)', style: TextStyle(color: Colors.black38))),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Mês')),
                        DataColumn(label: Text('Consumo (kWh)')),
                        DataColumn(label: Text('Custo (R\$)')),
                        DataColumn(label: Text('Economia (R\$)')),
                        DataColumn(label: Text('Ponta')),
                        DataColumn(label: Text('Fora Ponta')),
                        DataColumn(label: Text('Ações')),
                      ],
                      rows: [
                        _DataRowConsumo('2026-04', '3.500 kWh', 'R\$ 2.450,00', 'R\$ 650,00', '1.000 kWh', '2.500 kWh'),
                        _DataRowConsumo('2026-03', '4.000 kWh', 'R\$ 2.800,00', 'R\$ 600,00', '1.150 kWh', '2.850 kWh'),
                        _DataRowConsumo('2026-02', '3.700 kWh', 'R\$ 2.590,00', 'R\$ 540,00', '1.080 kWh', '2.620 kWh'),
                        _DataRowConsumo('2026-01', '4.300 kWh', 'R\$ 3.010,00', 'R\$ 470,00', '1.250 kWh', '3.050 kWh'),
                        _DataRowConsumo('2025-12', '3.900 kWh', 'R\$ 2.730,00', 'R\$ 620,00', '1.120 kWh', '2.780 kWh'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

DataRow _DataRowConsumo(String mes, String consumo, String custo, String economia, String ponta, String foraPonta) {
  return DataRow(
    cells: [
      DataCell(Text(mes)),
      DataCell(Text(consumo)),
      DataCell(Text(custo)),
      DataCell(Text(
        economia,
        style: TextStyle(color: const Color.fromARGB(255, 235, 246, 245), fontWeight: FontWeight.bold),
      )),
      DataCell(Text(ponta)),
      DataCell(Text(foraPonta)),
      DataCell(IconButton(
        icon: Icon(Icons.delete_outline, color: const Color.fromARGB(255, 237, 247, 246)),
        onPressed: () {},
        tooltip: 'Excluir registro',
      )),
    ],
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
                  height: 128,
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
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

