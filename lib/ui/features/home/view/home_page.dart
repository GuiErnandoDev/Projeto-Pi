import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:piprojeto/data/services/firestore_service.dart';
import '../../auth/view/login_page.dart';
import '../../faturas/view/faturas_page.dart';
import '../../contratos/view/contratos_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final String? uid = FirebaseAuth.instance.currentUser?.uid;
    final FirestoreService _firestoreService = FirestoreService();
    return Scaffold(
      drawer: _buildDrawer(context),
      appBar: AppBar(
        title: Image.asset(
          'assets/Horizontal Padrão Branco.png',
          height: 60,
        ),
        backgroundColor: const Color(0xFF042454),
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        toolbarHeight: 80,
        // ...existing code...
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            if (uid == null)
              Text.rich(
                TextSpan(
                  text: 'Olá, ',
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: 'Usuário',
                      style: const TextStyle(color: Color(0xFF042454)),
                    ),
                  ],
                ),
              )
            else
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance.collection('clientes').doc(uid).snapshots(),
                builder: (context, snapshot) {
                  String nome = 'Usuário';
                  if (snapshot.hasData && snapshot.data!.data() != null) {
                    final data = snapshot.data!.data() as Map<String, dynamic>;
                    nome = data['nome'] ?? 'Usuário';
                  }
                  return Text.rich(
                    TextSpan(
                      text: 'Olá, ',
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: nome,
                          style: const TextStyle(color: Color(0xFF042454)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            const SizedBox(height: 4),
            const Text(
              'Acompanhe seus resultados de consumo e economia.',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 24),
            _buildSummaryCards(),
            const SizedBox(height: 24),
            ConsumoEconomiaChart(tipo: 'consumo'),
            const SizedBox(height: 16),
            ConsumoEconomiaChart(tipo: 'economia'),
            const SizedBox(height: 24),
            if (uid == null)
              _buildFaturaCards(0, 0)
            else
              StreamBuilder<QuerySnapshot>(
                stream: _firestoreService.getUserSubcollectionStream(uid, 'faturas'),
                builder: (context, faturaSnapshot) {
                  int pendentes = 0;
                  if (faturaSnapshot.hasData) {
                    pendentes = faturaSnapshot.data!.docs.where((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      return (data['status'] ?? '').toString().toLowerCase() == 'pendente';
                    }).length;
                  }
                  return StreamBuilder<QuerySnapshot>(
                    stream: _firestoreService.getUserSubcollectionStream(uid, 'contratos'),
                    builder: (context, contratoSnapshot) {
                      int ativos = 0;
                      if (contratoSnapshot.hasData) {
                        ativos = contratoSnapshot.data!.docs.where((doc) {
                          final data = doc.data() as Map<String, dynamic>;
                          return (data['status'] ?? '').toString().toLowerCase() == 'ativo';
                        }).length;
                      }
                      return _buildFaturaCards(pendentes, ativos);
                    },
                  );
                },
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


class ConsumoEconomiaChart extends StatelessWidget {
  final String tipo; // 'consumo' ou 'economia'
  const ConsumoEconomiaChart({super.key, required this.tipo});

  @override
  Widget build(BuildContext context) {
    final String? uid = FirebaseAuth.instance.currentUser?.uid;
    final FirestoreService _firestoreService = FirestoreService();
    final String titulo = tipo == 'consumo' ? 'Consumo Mensal (kWh)' : 'Economia Mensal (R\$)';
    final Color cor = tipo == 'consumo'
        ? const Color.fromARGB(255, 237, 247, 246)
        : const Color.fromARGB(255, 237, 247, 246);

    return Card(
      color: cor,
      child: SizedBox(
        height: 240,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Expanded(
                child: uid == null
                    ? const Center(child: Text('Usuário não autenticado.'))
                    : StreamBuilder<QuerySnapshot>(
                        stream: _firestoreService.getUserSubcollectionStream(uid, 'faturas'),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                            return const Center(child: Text('Sem dados para o gráfico.'));
                          }
                          final docs = snapshot.data!.docs.toList();
                          // Ordena por referência (mês/ano)
                          docs.sort((a, b) => (a['referencia'] ?? '').compareTo(b['referencia'] ?? ''));
                          final labels = docs.map((doc) => doc['referencia']?.toString() ?? '').toList();
                          final valores = docs.map((doc) {
                            final v = doc[tipo];
                            if (v is num) return v.toDouble();
                            if (v is String) {
                              // Remove tudo que não for número, vírgula ou ponto
                              String clean = v.replaceAll(RegExp(r'[^0-9,\.]'), '');
                              clean = clean.replaceAll(',', '.');
                              // Remove pontos extras à esquerda (ex: '...110.75' -> '110.75')
                              clean = clean.replaceFirst(RegExp(r'^\.+'), '');
                              // Se ficar vazio, retorna 0
                              if (clean.isEmpty) return 0.0;
                              // Garante que só haja um ponto decimal
                              final parts = clean.split('.');
                              if (parts.length > 2) {
                                clean = parts.sublist(0, parts.length - 1).join('') + '.' + parts.last;
                              }
                              return double.tryParse(clean) ?? 0.0;
                            }
                            return 0.0;
                          }).toList();
                          if (valores.every((v) => v == 0)) {
                            return const Center(child: Text('Sem valores para exibir.'));
                          }
                          return LineChart(
                            LineChartData(
                              gridData: FlGridData(show: true),
                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 40,
                                    getTitlesWidget: (value, meta) {
                                      // Mostra o valor exato, sem K
                                      return Text(value % 1 == 0 ? value.toInt().toString() : value.toStringAsFixed(1), style: const TextStyle(fontSize: 10));
                                    },
                                  ),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      int idx = value.toInt();
                                      if (idx < 0 || idx >= labels.length) return const SizedBox.shrink();
                                      return Text(labels[idx], style: const TextStyle(fontSize: 10));
                                    },
                                    interval: 1,
                                    reservedSize: 32,
                                  ),
                                ),
                                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                              ),
                              borderData: FlBorderData(show: true),
                              minX: 0,
                              maxX: (valores.length - 1).toDouble(),
                              minY: 0,
                              lineBarsData: [
                                LineChartBarData(
                                  spots: [
                                    for (int i = 0; i < valores.length; i++)
                                      FlSpot(i.toDouble(), valores[i]),
                                  ],
                                  isCurved: true,
                                  color: tipo == 'consumo' ? Colors.blue : Colors.green,
                                  barWidth: 3,
                                  dotData: FlDotData(show: true),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
      

Widget _buildFaturaCards(int pendentes, int ativos) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      _buildFaturaCard('Faturas Pendentes', pendentes.toString(), Icons.receipt_long, const Color(0xFF042454)),
      _buildFaturaCard('Contratos Ativos', ativos.toString(), Icons.assignment, const Color(0xFF042454)),
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
  final String? uid = FirebaseAuth.instance.currentUser?.uid;
  final FirestoreService _firestoreService = FirestoreService();
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
              TextButton(onPressed: () {}, child: const Text('Ver todas →', style: TextStyle(color: Color(0xFF042454)))),
            ],
          ),
          const SizedBox(height: 8),
          if (uid == null)
            const Text('Usuário não autenticado.')
          else
            StreamBuilder<QuerySnapshot>(
              stream: _firestoreService.getUserSubcollectionStream(uid, 'faturas'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Text('Nenhuma fatura encontrada.');
                }
                // Ordena por vencimento decrescente (se possível)
                final docs = snapshot.data!.docs.toList();
                docs.sort((a, b) {
                  final aData = a.data() as Map<String, dynamic>;
                  final bData = b.data() as Map<String, dynamic>;
                  return (bData['vencimento'] ?? '').compareTo(aData['vencimento'] ?? '');
                });
                // Mostra as 3 mais recentes
                final ultimas = docs.take(3).toList();
                return Column(
                  children: ultimas.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    final status = (data['status'] ?? '').toString();
                    Color statusColor = status.toLowerCase() == 'paga'
                        ? Colors.green
                        : status.toLowerCase() == 'pendente'
                            ? Colors.orange
                            : Colors.grey;
                    return _buildFaturaItem(
                      data['referencia']?.toString() ?? '',
                      data['vencimento']?.toString() ?? '',
                      status,
                      data['valor']?.toString() ?? '',
                      statusColor,
                    );
                  }).toList(),
                );
              },
            ),
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
