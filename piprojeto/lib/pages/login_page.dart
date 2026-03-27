import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controladores para capturar o que o usuário digita
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  // Estados dos inputs
  bool _senhaOculta = true;
  bool _lembrarSenha = false;

  // Definição das cores da marca (ajustadas conforme a imagem de login)
  static const Color azulFundoTopo = Color(0xFF67E6DC); // Ciano claro do degradê
  static const Color azulFundoBase = Color(0xFFC9F7F1); // Ciano quase branco
  static const Color verdeBotao = Color(0xFFD4E157);   // Amarelo esverdeado
  static const Color textoPrincipal = Color(0xFF131A2D); // Quase preto/azul escuro
  static const Color textoSecundario = Color(0xFF767F8D); // Cinza para labels
  static const Color azulLink = Color(0xFF3B67D3);       // Azul para links

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fundo com Degradê conforme imagem
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
            stops: [0.0, 0.4], // Ajuste onde o degradê começa a clarear
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            // Permite rolar a tela se o teclado abrir
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 60),

                // --- ÁREA DA LOGO ---
                // Para ficar igual à imagem, use um Image.asset() com fundo transparente.
                // Exemplo: Image.asset('assets/logo_branca.png', height: 80),
                Center(
                  child: SizedBox(
                    width: 340, // Ajuste a largura conforme o formato da sua logo
                    height: 160, // Ajuste a altura conforme necessário
                    child: Image.asset(
                      'assets/Horizontal Padrão Branco.png', // CAMINHO DO SEU ARQUIVO
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        // Caso a imagem falhe, mostra o texto para não ficar vazio
                        return const Center(
                          child: Text(
                            'ATIVVO',
                            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 50),

                // --- CARD BRANCO DO FORMULÁRIO ---
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9), // Leve transparência
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Título "Login"
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

                      // --- Campo Email ---
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

                      // --- Campo Senha ---
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

                      // --- Lembrar Senha e Esqueceu a Senha ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Checkbox Lembrar Senha
                          Row(
                            children: [
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: Checkbox(
                                  value: _lembrarSenha,
                                  activeColor: verdeBotao,
                                  onChanged: (value) {
                                    setState(() {
                                      _lembrarSenha = value!;
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Lembrar senha',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: textoSecundario,
                                ),
                              ),
                            ],
                          ),
                          // Link Esqueceu a senha
                          TextButton(
                            onPressed: () {
                              // Ação para recuperar senha
                              print("Esqueceu a senha");
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'Esqueceu a senha ?',
                              style: TextStyle(
                                fontSize: 13,
                                color: azulLink,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // --- BOTÃO LOGIN ---
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {
                            // Ação de Login real
                            print("Tentando logar com: ${_emailController.text}");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: verdeBotao,
                            foregroundColor: textoPrincipal, // Texto escuro no botão claro
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Estilo padrão para os inputs de texto
  InputDecoration _inputStyle() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFD6D6D6)), // Cinza claro
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFD6D6D6)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: verdeBotao, width: 2), // Cor do botão no foco
      ),
    );
  }
}