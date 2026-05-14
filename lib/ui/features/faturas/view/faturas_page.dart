import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:piprojeto/ui/features/home/view/home_page.dart';
import '../../auth/view/login_page.dart';
import '../../contratos/view/contratos_page.dart';
import '../../consumo/view/consumo_page.dart';

class FaturasPage extends StatelessWidget {
  const FaturasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      appBar: AppBar(
        title: const Text('Faturas'),
        backgroundColor: const Color(0xFF042454),
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF7FAF9),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Faturas',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Gerencie suas faturas mensais',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar por mês de referência...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: 'Todos',
                  items: const [
                    DropdownMenuItem(value: 'Todos', child: Text('Todos')),
                    DropdownMenuItem(value: 'Pagas', child: Text('Pagas')),
                    DropdownMenuItem(value: 'Pendentes', child: Text('Pendentes')),
                  ],
                  onChanged: (v) {},
                  borderRadius: BorderRadius.circular(12),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Referência')),
                    DataColumn(label: Text('Vencimento')),
                    DataColumn(label: Text('Valor')),
                    DataColumn(label: Text('Consumo')),
                    DataColumn(label: Text('Economia')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Ações')),
                  ],
                  rows: [
                    _faturaRow('2026-02', '09/03/2026', 'R\$ 2.590,00', '3.700 kWh', 'R\$ 540,00', 'Paga'),
                    _faturaRow('2026-04', '09/05/2026', 'R\$ 2.450,00', '3.500 kWh', 'R\$ 650,00', 'Pendente'),
                    _faturaRow('2026-01', '09/02/2026', 'R\$ 3.010,00', '4.300 kWh', 'R\$ 470,00', 'Paga'),
                    _faturaRow('2026-05', '09/06/2026', 'R\$ 2.700,00', '3.900 kWh', '--', 'Pendente'),
                    _faturaRow('2026-03', '09/04/2026', 'R\$ 2.800,00', '4.000 kWh', 'R\$ 600,00', 'Paga'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

DataRow _faturaRow(String ref, String venc, String valor, String consumo, String economia, String status) {
  Color statusColor = status == 'Paga'
      ? Colors.green
      : status == 'Pendente'
          ? Colors.amber[700]!
          : Colors.grey;
  return DataRow(cells: [
    DataCell(Text(ref)),
    DataCell(Text(venc)),
    DataCell(Text(valor, style: const TextStyle(fontWeight: FontWeight.bold))),
    DataCell(Text(consumo)),
    DataCell(Text(economia, style: TextStyle(color: economia == '--' ? Colors.black38 : Colors.green, fontWeight: FontWeight.bold))),
    DataCell(Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(status, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold)),
    )),
    DataCell(IconButton(
      icon: const Icon(Icons.delete, color: Colors.red),
      onPressed: () {},
      tooltip: 'Excluir',
    )),
  ]);
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

