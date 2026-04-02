import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  // Definição das cores da marca baseadas na imagem
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
            // Parte Superior: Logo e Identidade
            Column(
              children: [
                const SizedBox(height: 60),
                Center(
                  child: Column(
                    children: [
                      // Representação do Logo (Pode substituir por Image.asset)
                      _buildLogoSimulado(),
                      const SizedBox(height: 16),
                      const Text(
                        'ATIVVO',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: azulEscuro,
                          letterSpacing: 2,
                        ),
                      ),
                      const Text(
                        'CONSULTORIA ENERGÉTICA',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: azulEscuro,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Divisor azul sutil no meio (conforme a imagem)
            Positioned(
              top: MediaQuery.of(context).size.height * 0.45,
              left: 0,
              right: 0,
              child: Container(
                height: 2,
                color: azulClaro.withOpacity(0.3),
              ),
            ),

            // Parte Inferior: Texto e Ação
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
                        // Ação de login
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

  // Widget apenas para simular o ícone do logo da imagem
  Widget _buildLogoSimulado() {
    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        children: [
          Positioned(
            top: 0, right: 10,
            child: _logoBar(azulEscuro, 45),
          ),
          Positioned(
            top: 25, left: 10,
            child: _logoBar(azulClaro, -45),
          ),
          Positioned(
            bottom: 10, right: 25,
            child: _logoBar(verdeLima, -45),
          ),
        ],
      ),
    );
  }

  Widget _logoBar(Color color, double angle) {
    return Transform.rotate(
      angle: angle * 3.14 / 180,
      child: Container(
        width: 12,
        height: 45,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}