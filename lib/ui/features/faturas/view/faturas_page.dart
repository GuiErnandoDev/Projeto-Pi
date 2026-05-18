import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:piprojeto/ui/features/home/view/home_page.dart';
import '../../auth/view/login_page.dart';
import '../../contratos/view/contratos_page.dart';
// importação de consumo removida
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:piprojeto/services/firestore_service.dart';

class FaturasPage extends StatefulWidget {
  const FaturasPage({super.key});

  @override
  State<FaturasPage> createState() => _FaturasPageState();
}

class _FaturasPageState extends State<FaturasPage> {
  final FirestoreService _firestoreService = FirestoreService();
  String _status = 'Todos';
  final String? _uid = FirebaseAuth.instance.currentUser?.uid;


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
              'Visualize suas faturas mensais',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Container(), // Campo de busca pode ser implementado depois
                ),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: _status,
                  items: const [
                    DropdownMenuItem(value: 'Todos', child: Text('Todos')),
                    DropdownMenuItem(value: 'Pagas', child: Text('Pagas')),
                    DropdownMenuItem(value: 'Pendente', child: Text('Pendentes')),
                  ],
                  onChanged: (v) {
                    if (v != null) setState(() => _status = v);
                  },
                  borderRadius: BorderRadius.circular(12),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: _uid == null
                  ? const Center(child: Text('Usuário não autenticado.'))
                  : StreamBuilder<QuerySnapshot>(
                      stream: _firestoreService.getUserSubcollectionStream(_uid!, 'faturas'),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Center(child: Text('Nenhuma fatura encontrada.'));
                        }
                        final docs = snapshot.data!.docs;
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text('Referência')),
                              DataColumn(label: Text('Vencimento')),
                              DataColumn(label: Text('Valor')),
                              DataColumn(label: Text('Consumo')),
                              DataColumn(label: Text('Economia')),
                              DataColumn(label: Text('Status')),
                            ],
                            rows: docs.map((doc) {
                              final data = doc.data() as Map<String, dynamic>;
                              return DataRow(cells: [
                                DataCell(Text(data['referencia'] ?? '')),
                                DataCell(Text(data['vencimento'] ?? '')),
                                DataCell(Text(data['valor']?.toString() ?? '')),
                                DataCell(Text(data['consumo']?.toString() ?? '')),
                                DataCell(Text(data['economia']?.toString() ?? '')),
                                DataCell(Text(data['status'] ?? '')),
                              ]);
                            }).toList(),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Nenhuma função de adição/exclusão para clientes

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
            // ListTile de Consumo removido
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
}

