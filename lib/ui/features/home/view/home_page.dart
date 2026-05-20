import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:piprojeto/data/services/firestore_service.dart';
import '../../auth/view/login_page.dart';
import '../../faturas/view/faturas_page.dart';
import '../../contratos/view/contratos_page.dart';
import '../../perfil/view/page.perfil.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final String? uid = FirebaseAuth.instance.currentUser?.uid;
    final FirestoreService firestoreService = FirestoreService();

    return Scaffold(
      drawer: _buildDrawer(context),
      appBar: AppBar(
        title: Image.asset(
          'assets/Horizontal Padrão Branco.png',
          height: 60,
        ),
        backgroundColor: const Color(0xFF042454),
        foregroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 80,
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
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
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
                stream: FirebaseFirestore.instance
                    .collection('clientes')
                    .doc(uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  String nome = 'Usuário';

                  if (snapshot.hasData && snapshot.data!.data() != null) {
                    final data = snapshot.data!.data() as Map<String, dynamic>;
                    nome = data['nome']?.toString() ?? 'Usuário';
                  }

                  return Text.rich(
                    TextSpan(
                      text: 'Olá, ',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
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
            const ConsumoEconomiaChart(tipo: 'consumo'),
            const SizedBox(height: 16),
            const ConsumoEconomiaChart(tipo: 'economia'),
            const SizedBox(height: 24),
            if (uid == null)
              _buildFaturaCards(0, 0)
            else
              StreamBuilder<QuerySnapshot>(
                stream: firestoreService.getUserSubcollectionStream(
                  uid,
                  'faturas',
                ),
                builder: (context, faturaSnapshot) {
                  int pendentes = 0;

                  if (faturaSnapshot.hasData) {
                    pendentes = faturaSnapshot.data!.docs.where((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      return (data['status'] ?? '')
                              .toString()
                              .toLowerCase() ==
                          'pendente';
                    }).length;
                  }

                  return StreamBuilder<QuerySnapshot>(
                    stream: firestoreService.getUserSubcollectionStream(
                      uid,
                      'contratos',
                    ),
                    builder: (context, contratoSnapshot) {
                      int ativos = 0;

                      if (contratoSnapshot.hasData) {
                        ativos = contratoSnapshot.data!.docs.where((doc) {
                          final data = doc.data() as Map<String, dynamic>;
                          return (data['status'] ?? '')
                                  .toString()
                                  .toLowerCase() ==
                              'ativo';
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
                  height: 128,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard, color: Colors.white),
            title: const Text(
              'Dashboard',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.receipt_long, color: Colors.white),
            title: const Text(
              'Faturas',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FaturasPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.assignment, color: Colors.white),
            title: const Text(
              'Contratos',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContratosPage()),
              );
            },
          ),  
          ListTile(
  leading: const Icon(Icons.person, color: Colors.white),
  title: const Text(
    'Perfil',
    style: TextStyle(color: Colors.white),
  ),
  onTap: () {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PerfilPage()),
    );
  },
),
          const Divider(color: Colors.white24),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.white70),
            title: const Text(
              'Sair',
              style: TextStyle(color: Colors.white70),
            ),
            onTap: () async {
              await FirebaseAuth.instance.signOut();

              if (!context.mounted) return;

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
      _buildSummaryCard(
        'Consumo Total',
        '39.600 kWh',
        Icons.flash_on,
        const Color(0xFF042454),
      ),
      _buildSummaryCard(
        'Economia Total',
        'R\$ 5.120,00',
        Icons.trending_down,
        const Color(0xFF042454),
      ),
    ],
  );
}

Widget _buildSummaryCard(
  String title,
  String value,
  IconData icon,
  Color color,
) {
  return Expanded(
    child: Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white, size: 28),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class ConsumoEconomiaChart extends StatelessWidget {
  final String tipo;

  const ConsumoEconomiaChart({super.key, required this.tipo});

  @override
  Widget build(BuildContext context) {
    final String? uid = FirebaseAuth.instance.currentUser?.uid;
    final FirestoreService firestoreService = FirestoreService();

    final String titulo = tipo == 'consumo'
        ? 'Consumo Mensal (kWh)'
        : 'Economia Mensal (R\$)';

    const Color cor = Color.fromARGB(255, 237, 247, 246);

    return Card(
      color: cor,
      child: SizedBox(
        height: 240,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: uid == null
                    ? const Center(child: Text('Usuário não autenticado.'))
                    : StreamBuilder<QuerySnapshot>(
                        stream: firestoreService.getUserSubcollectionStream(
                          uid,
                          'faturas',
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return const Center(
                              child: Text('Sem dados para o gráfico.'),
                            );
                          }

                          final docs = snapshot.data!.docs.toList();

                          docs.sort((a, b) {
                            final aData = a.data() as Map<String, dynamic>;
                            final bData = b.data() as Map<String, dynamic>;

                            return (aData['referencia'] ?? '')
                                .toString()
                                .compareTo(
                                  (bData['referencia'] ?? '').toString(),
                                );
                          });

                          final labels = docs.map((doc) {
                            final data = doc.data() as Map<String, dynamic>;
                            return data['referencia']?.toString() ?? '';
                          }).toList();

                          final valores = docs.map((doc) {
                            final data = doc.data() as Map<String, dynamic>;
                            final v = data[tipo];

                            if (v is num) return v.toDouble();

                            if (v is String) {
                              String clean =
                                  v.replaceAll(RegExp(r'[^0-9,\.]'), '');

                              clean = clean.replaceAll(',', '.');
                              clean = clean.replaceFirst(RegExp(r'^\.+'), '');

                              if (clean.isEmpty) return 0.0;

                              final parts = clean.split('.');

                              if (parts.length > 2) {
                                clean =
                                    '${parts.sublist(0, parts.length - 1).join('')}.${parts.last}';
                              }

                              return double.tryParse(clean) ?? 0.0;
                            }

                            return 0.0;
                          }).toList();

                          if (valores.every((v) => v == 0)) {
                            return const Center(
                              child: Text('Sem valores para exibir.'),
                            );
                          }

                          return LineChart(
                            LineChartData(
                              gridData: const FlGridData(show: true),
                              titlesData: FlTitlesData(
                                leftTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 40,
                                    getTitlesWidget: (value, meta) {
                                      final texto = value % 1 == 0
                                          ? value.toInt().toString()
                                          : value.toStringAsFixed(1);

                                      return Text(
                                        texto,
                                        style: const TextStyle(fontSize: 10),
                                      );
                                    },
                                  ),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      final int idx = value.toInt();

                                      if (idx < 0 || idx >= labels.length) {
                                        return const SizedBox.shrink();
                                      }

                                      return Text(
                                        labels[idx],
                                        style: const TextStyle(fontSize: 10),
                                      );
                                    },
                                    interval: 1,
                                    reservedSize: 32,
                                  ),
                                ),
                                rightTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                topTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
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
                                  color: tipo == 'consumo'
                                      ? Colors.blue
                                      : Colors.green,
                                  barWidth: 3,
                                  dotData: const FlDotData(show: true),
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
      _buildFaturaCard(
        'Faturas Pendentes',
        pendentes.toString(),
        Icons.receipt_long,
        const Color(0xFF042454),
      ),
      _buildFaturaCard(
        'Contratos Ativos',
        ativos.toString(),
        Icons.assignment,
        const Color(0xFF042454),
      ),
    ],
  );
}

Widget _buildFaturaCard(
  String title,
  String value,
  IconData icon,
  Color color,
) {
  return Expanded(
    child: Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white, size: 28),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildFaturasList() {
  final String? uid = FirebaseAuth.instance.currentUser?.uid;
  final FirestoreService firestoreService = FirestoreService();

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
              const Text(
                'Últimas Faturas',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Ver todas →',
                  style: TextStyle(color: Color(0xFF042454)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (uid == null)
            const Text('Usuário não autenticado.')
          else
            StreamBuilder<QuerySnapshot>(
              stream: firestoreService.getUserSubcollectionStream(
                uid,
                'faturas',
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Text('Nenhuma fatura encontrada.');
                }

                final docs = snapshot.data!.docs.toList();

                docs.sort((a, b) {
                  final aData = a.data() as Map<String, dynamic>;
                  final bData = b.data() as Map<String, dynamic>;

                  return (bData['vencimento'] ?? '')
                      .toString()
                      .compareTo((aData['vencimento'] ?? '').toString());
                });

                final ultimas = docs.take(3).toList();

                return Column(
                  children: ultimas.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    final status = (data['status'] ?? '').toString();

                    final Color statusColor =
                        status.toLowerCase() == 'paga'
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

Widget _buildFaturaItem(
  String mes,
  String venc,
  String status,
  String valor,
  Color statusColor,
) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    title: Text(
      mes,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
    subtitle: Text('Venc.: $venc'),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          valor,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}