import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:piprojeto/data/services/firestore_service.dart';
import '../../auth/view/login_page.dart';
import '../../home/view/home_page.dart';
import '../../faturas/view/faturas_page.dart';
import '../../perfil/view/perfil_page.dart';

/// Tela de contratos do usuário.
/// Exibe lista de contratos ativos e encerrados.
class ContratosPage extends StatelessWidget {
  const ContratosPage({super.key});

  @override
  /// Monta a interface da tela de contratos, mostrando lista de contratos do usuário.
  Widget build(BuildContext context) {
    final String? uid = FirebaseAuth.instance.currentUser?.uid;
    final FirestoreService firestoreService = FirestoreService();

    return Scaffold(
      drawer: _buildDrawer(context),
      appBar: AppBar(
        title: const Text('Contratos'),
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
            const Text(
              'Contratos',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF222222),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Gerencie seus contratos de serviço',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 44),
            Expanded(
              child: uid == null
                  ? const Center(child: Text('Usuário não autenticado.'))
                  : StreamBuilder<QuerySnapshot>(
                      stream: firestoreService.getUserSubcollectionStream(
                        uid,
                        'contratos',
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Center(
                            child: Text('Nenhum contrato encontrado.'),
                          );
                        }

                        final docs = snapshot.data!.docs;

                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: docs.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 16),
                          itemBuilder: (context, index) {
                            final data =
                                docs[index].data() as Map<String, dynamic>;

                            return _ContratoCard(
                              titulo: data['titulo']?.toString() ?? '',
                              descricao: data['descricao']?.toString() ?? '',
                              inicio: data['inicio']?.toString() ?? '',
                              termino: data['termino']?.toString() ?? '',
                              valor: data['valor']?.toString() ?? '',
                              status: data['status']?.toString() ?? '',
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

/// Card visual para exibir informações de um contrato.
class _ContratoCard extends StatelessWidget {
  final String titulo;
  final String descricao;
  final String inicio;
  final String termino;
  final String valor;
  final String status;

  const _ContratoCard({
    required this.titulo,
    required this.descricao,
    required this.inicio,
    required this.termino,
    required this.valor,
    required this.status,
  });

  @override
  /// Monta o card visual do contrato.
  Widget build(BuildContext context) {
    final bool contratoAtivo = status == 'Ativo';

    return Container(
      width: 320,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  titulo,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF222222),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: contratoAtivo
                      ? const Color(0xFF3FE18F).withValues(alpha: 0.15)
                      : Colors.red.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: contratoAtivo
                        ? const Color(0xFF3FE18F)
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            descricao,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Início', style: TextStyle(color: Colors.black54)),
              const SizedBox(width: 8),
              Text(inicio, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          Row(
            children: [
              const Text('Término', style: TextStyle(color: Colors.black54)),
              const SizedBox(width: 8),
              Text(
                termino,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                'Valor Mensal',
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(width: 8),
              Text(
                valor,
                style: const TextStyle(
                  color: Color(0xFF3FE18F),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

/// Drawer lateral de navegação entre as páginas principais do app.
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