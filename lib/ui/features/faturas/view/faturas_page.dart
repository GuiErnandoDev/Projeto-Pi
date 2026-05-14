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
      body: Center(
        child: Text(
          'Aqui você verá a lista de faturas!',
          style: TextStyle(fontSize: 18, color: Colors.black54),
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


Widget _buildDrawerItem(IconData icon, String title, BuildContext context) {
  return ListTile(
    leading: Icon(icon, color: Colors.white),
    title: Text(title, style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255))),
    onTap: () {},
  );
}
