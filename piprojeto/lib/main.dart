import 'package:flutter/material.dart';
import 'package:piprojeto/pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ativvo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF1A3D5D),
      ),
      // Definindo a SplashPage como a tela inicial
      home: const SplashPage(),
    );
  }
}