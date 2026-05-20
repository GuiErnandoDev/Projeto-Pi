import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:piprojeto/ui/features/home/view/home_page.dart';
import '../../auth/view/login_page.dart';
import '../../contratos/view/contratos_page.dart';
// Removido import duplicado e incorreto
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:piprojeto/data/services/firestore_service.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../perfil/view/perfil_page.dart';

/// Tela de faturas do usuário.
/// Permite visualizar, baixar e compartilhar faturas em PDF.
class FaturasPage extends StatefulWidget {
  const FaturasPage({super.key});

  @override
  State<FaturasPage> createState() => _FaturasPageState();
}

/// Estado da tela de faturas, gerencia listagem e geração de PDF.
class _FaturasPageState extends State<FaturasPage> {
  final FirestoreService firestoreService = FirestoreService();
  final String? uid = FirebaseAuth.instance.currentUser?.uid;

  /// Gera e compartilha o PDF da fatura selecionada.
  Future<void> _gerarPdf(Map<String, dynamic> data) async {
    try {
      final pdf = pw.Document();
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Container(
            padding: const pw.EdgeInsets.all(24),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Fatura', style: pw.TextStyle(fontSize: 32, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 16),
                pw.Text('Referência: ${data['referencia'] ?? ''}'),
                pw.Text('Vencimento: ${data['vencimento'] ?? ''}'),
                pw.Text('Valor: R\$ ${data['valor'] ?? ''}'),
                pw.Text('Consumo: ${data['consumo'] ?? ''} kWh'),
                pw.Text('Economia: R\$ ${data['economia'] ?? ''}'),
                pw.Text('Status: ${data['status'] ?? ''}'),
                pw.SizedBox(height: 32),
                pw.Text('Gerado em: ${DateTime.now().toString().substring(0, 16)}'),
              ],
            ),
          ),
        ),
      );
      await Printing.layoutPdf(onLayout: (format) async => pdf.save());
      if (!mounted) return;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('PDF gerado/compartilhado com sucesso!')),
          );
        }
      });
    } catch (e) {
      if (!mounted) return;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao gerar PDF: $e')),
          );
        }
      });
    }
  }

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
            const SizedBox(height: 24),
            Expanded(
              child: uid == null
                  ? const Center(child: Text('Usuário não autenticado.'))
                  : StreamBuilder<QuerySnapshot>(
                      stream: firestoreService.getUserSubcollectionStream(
                        uid!,
                        'faturas',
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Center(child: Text('Nenhuma fatura encontrada.'));
                        }
                        final docs = snapshot.data!.docs;
                        // Ordena as faturas pela referência (ordem decrescente, mais recente primeiro)
                        docs.sort((a, b) {
                          final refA = (a.data() as Map<String, dynamic>)['referencia']?.toString() ?? '';
                          final refB = (b.data() as Map<String, dynamic>)['referencia']?.toString() ?? '';
                          return refB.compareTo(refA);
                        });
                        return ListView.separated(
                          itemCount: docs.length,
                          separatorBuilder: (_, _) => const SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            final data = docs[index].data() as Map<String, dynamic>;
                            final status = (data['status'] ?? '').toString().toLowerCase();
                            Color statusColor;
                            switch (status) {
                              case 'paga':
                                statusColor = Colors.green;
                                break;
                              case 'pendente':
                                statusColor = Colors.orange;
                                break;
                              default:
                                statusColor = Colors.grey;
                            }
                            return Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Referência: ${data['referencia'] ?? ''}',
                                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                          decoration: BoxDecoration(
                                            color: statusColor.withValues(alpha: 0.15),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            data['status']?.toString() ?? '',
                                            style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text('Vencimento: ${data['vencimento'] ?? ''}'),
                                    Text('Valor: R\$ ${data['valor'] ?? ''}'),
                                    Text('Consumo: ${data['consumo'] ?? ''} kWh'),
                                    Text('Economia: R\$ ${data['economia'] ?? ''}'),
                                    const SizedBox(height: 12),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFF042454),
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                        ),
                                        onPressed: () => _gerarPdf(data),
                                        icon: const Icon(Icons.picture_as_pdf),
                                        label: const Text('Baixar PDF'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
            // Removido ListTile duplicado de Perfil
            ListTile(
              leading: const Icon(Icons.receipt_long, color: Colors.white),
              title: const Text(
                'Faturas',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
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
                  MaterialPageRoute(
                    builder: (context) => const ContratosPage(),
                  ),
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
