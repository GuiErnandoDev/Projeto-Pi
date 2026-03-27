import 'package:flutter/material.dart';
import 'package:piprojeto/pages/login_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  // Cores da marca
  static const Color azulEscuro = Color(0xFF1A3D5D);
  static const Color verdeLima = Color(0xFFD4E157);
  static const Color azulClaro = Color(0xFF00BCD4);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // --- Parte Superior: Logo ---
            Column(
              children: [
                const SizedBox(height: 80),
                Center(
                  child: SizedBox(
                    width: 360,
                    height: 240,
                    child: Image.asset(
                      'assets/Horizontal Padrão.png',
                      fit: BoxFit.contain,
                      // Caso a imagem não carregue, adicione um erro de log
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.broken_image, size: 50, color: Colors.grey);
                      },
                    ),
                  ),
                ),
              ],
            ),

            // --- Divisor Central ---
            Positioned(
              top: MediaQuery.of(context).size.height * 0.45,
              left: 0,
              right: 0,
              child: Container(
                height: 2,
                color: azulClaro.withOpacity(0.3),
              ),
            ),

            // --- Parte Inferior: Texto e Botão ---
            Positioned(
              bottom: 60,
              left: 32,
              right: 32,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tenha Acesso A Suas Faturas E\nAcompanhe Seu Desempenho No\nMercado Livre De Energia',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: azulEscuro,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        // CORREÇÃO AQUI: Apenas chama a classe LoginPage()
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: verdeLima,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Entrar',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
}