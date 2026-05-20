import 'package:flutter/material.dart';
import '../../auth/view/register_page.dart';
import '../../home/view/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Tela de login principal do app.
/// Permite autenticação do usuário e navegação para registro.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

/// Estado da tela de login, gerencia campos, visibilidade da senha e autenticação.
class _LoginPageState extends State<LoginPage> {
  /// Controlador do campo de email.
  final TextEditingController _emailController = TextEditingController();
  /// Controlador do campo de senha.
  final TextEditingController _senhaController = TextEditingController();

  /// Controla se a senha está oculta ou visível.
  bool _senhaOculta = true;

  // Cores utilizadas na tela
  static const Color azulFundoTopo = Color(0xFF67E6DC);
  static const Color azulFundoBase = Color(0xFFC9F7F1);
  static const Color verdeBotao = Color(0xFFD4E157);
  static const Color textoPrincipal = Color(0xFF131A2D);
  static const Color textoSecundario = Color(0xFF767F8D);
  static const Color azulLink = Color(0xFF3B67D3);

  @override
  void dispose() {
    // Libera os controladores ao destruir o widget
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  /// Realiza o login do usuário usando Firebase Auth.
  /// Exibe mensagens de erro ou sucesso e navega para a Home em caso positivo.
  Future<void> _fazerLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _senhaController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login realizado com sucesso!')),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      String msg = 'Erro ao fazer login';

      if (e.code == 'user-not-found') {
        msg = 'Usuário não encontrado';
      } else if (e.code == 'wrong-password') {
        msg = 'Senha incorreta';
      } else if (e.code == 'invalid-email') {
        msg = 'Email inválido';
      } else if (e.code == 'invalid-credential') {
        msg = 'Email ou senha incorretos';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg)),
      );
    }
  }

  /// Monta a interface da tela de login.
  /// Inclui campos de email, senha, botão de login e link para registro.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              azulFundoTopo,
              azulFundoBase,
            ],
            stops: [0.0, 0.4],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 60),
                Center(
                  child: SizedBox(
                    width: 340,
                    height: 160,
                    child: Image.asset(
                      'assets/Horizontal Padrão Branco.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Text(
                            'ATIVVO',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                            color: textoPrincipal,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'Email:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: textoSecundario,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: _inputStyle(),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Senha:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: textoSecundario,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _senhaController,
                        obscureText: _senhaOculta,
                        decoration: _inputStyle().copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _senhaOculta
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: textoSecundario,
                            ),
                            onPressed: () {
                              setState(() {
                                _senhaOculta = !_senhaOculta;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: _fazerLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: verdeBotao,
                            foregroundColor: textoPrincipal,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Não tem uma conta? Registre-se',
                      style: TextStyle(
                        color: azulLink,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Estilização padrão dos campos de texto.
  InputDecoration _inputStyle() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFD6D6D6)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFD6D6D6)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: verdeBotao, width: 2),
      ),
    );
  }
}