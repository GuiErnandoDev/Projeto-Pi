import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../auth/view/login_page.dart';
import '../../home/view/home_page.dart';
import '../../faturas/view/faturas_page.dart';
import '../../contratos/view/contratos_page.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      drawer: _buildDrawer(context),
      appBar: AppBar(
        title: const Text('Perfil do Cliente'),
        backgroundColor: const Color(0xFF042454),
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF7FAF9),
      body: user == null
          ? const Center(
              child: Text('Usuário não autenticado.'),
            )
          : StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('clientes')
                  .doc(user.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return _buildPerfilSemDados(user.email);
                }

                final data = snapshot.data!.data() as Map<String, dynamic>;

                final nome = data['nome']?.toString() ?? 'Não informado';
                final email =
                    data['email']?.toString() ?? user.email ?? 'Não informado';
                final telefone =
                    data['telefone']?.toString() ?? 'Não informado';
                final cpfCnpj =
                    data['cpfCnpj']?.toString() ?? 'Não informado';
                final endereco =
                    data['endereco']?.toString() ?? 'Não informado';
                final unidadeConsumidora =
                    data['unidadeConsumidora']?.toString() ?? 'Não informado';

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Perfil do Cliente',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF222222),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Consulte suas informações cadastradas.',
                        style: TextStyle(color: Colors.black54),
                      ),
                      const SizedBox(height: 24),
                      _buildHeaderCard(nome, email),
                      const SizedBox(height: 24),
                      _buildInfoCard(
                        titulo: 'Dados pessoais',
                        itens: [
                          _PerfilItem(
                            icone: Icons.person,
                            titulo: 'Nome',
                            valor: nome,
                          ),
                          _PerfilItem(
                            icone: Icons.email,
                            titulo: 'Email',
                            valor: email,
                          ),
                          _PerfilItem(
                            icone: Icons.phone,
                            titulo: 'Telefone',
                            valor: telefone,
                          ),
                          _PerfilItem(
                            icone: Icons.badge,
                            titulo: 'CPF/CNPJ',
                            valor: cpfCnpj,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildInfoCard(
                        titulo: 'Dados da unidade',
                        itens: [
                          _PerfilItem(
                            icone: Icons.home,
                            titulo: 'Endereço',
                            valor: endereco,
                          ),
                          _PerfilItem(
                            icone: Icons.electrical_services,
                            titulo: 'Unidade consumidora',
                            valor: unidadeConsumidora,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Widget _buildPerfilSemDados(String? email) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Perfil do Cliente',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF222222),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Nenhum cadastro de cliente foi encontrado no Firestore.',
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 24),
          _buildHeaderCard(
            'Usuário',
            email ?? 'Email não informado',
          ),
          const SizedBox(height: 16),
          Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Para preencher esta tela, crie um documento em clientes/{uid} no Firestore com os campos nome, email, telefone, cpfCnpj, endereco e unidadeConsumidora.',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCard(String nome, String email) {
    return Card(
      color: const Color(0xFF042454),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 34,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                color: Color(0xFF042454),
                size: 38,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nome,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String titulo,
    required List<_PerfilItem> itens,
  }) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titulo,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF222222),
              ),
            ),
            const SizedBox(height: 16),
            ...itens.map((item) => _buildInfoTile(item)),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(_PerfilItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            item.icone,
            color: const Color(0xFF042454),
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.titulo,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.valor,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF222222),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
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
                Navigator.pushReplacement(
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContratosPage(),
                  ),
                );
              },
            ),
            const ListTile(
              leading: Icon(Icons.person, color: Colors.white),
              title: Text(
                'Perfil',
                style: TextStyle(color: Colors.white),
              ),
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
}

class _PerfilItem {
  final IconData icone;
  final String titulo;
  final String valor;

  const _PerfilItem({
    required this.icone,
    required this.titulo,
    required this.valor,
  });
}