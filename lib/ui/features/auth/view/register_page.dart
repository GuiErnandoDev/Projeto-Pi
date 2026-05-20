import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../home/view/home_page.dart';




/// Tela de registro de novo usuário.
/// Permite criar conta, preencher dados pessoais e salvar no Firestore.
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

/// Estado da tela de registro, gerencia campos, validação e cadastro.
class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmarSenhaController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _cpfCnpjController = TextEditingController();
  final TextEditingController _enderecoController = TextEditingController();
  final TextEditingController _unidadeConsumidoraController = TextEditingController();

  bool _senhaOculta = true;
  bool _confirmarSenhaOculta = true;

  static const Color azulFundoTopo = Color(0xFF67E6DC);
  static const Color azulFundoBase = Color(0xFFC9F7F1);
  static const Color verdeBotao = Color(0xFFD4E157);
  static const Color textoPrincipal = Color(0xFF131A2D);
  static const Color textoSecundario = Color(0xFF767F8D);

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    _confirmarSenhaController.dispose();
    _telefoneController.dispose();
    _cpfCnpjController.dispose();
    _enderecoController.dispose();
    _unidadeConsumidoraController.dispose();
    super.dispose();
  }

  /// Realiza o cadastro do usuário, salva dados no Firestore e trata erros.
  Future<void> _registrarUsuario() async {
    if (_senhaController.text != _confirmarSenhaController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('As senhas não conferem!')),
      );
      return;
    }

    try {
      UserCredential cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _senhaController.text.trim(),
      );

      // Salva os dados do cliente no Firestore
      await FirebaseFirestore.instance.collection('clientes').doc(cred.user!.uid).set({
        'nome': _nomeController.text.trim(),
        'email': _emailController.text.trim(),
        'telefone': _telefoneController.text.trim(),
        'cpfCnpj': _cpfCnpjController.text.trim(),
        'endereco': _enderecoController.text.trim(),
        'unidadeConsumidora': _unidadeConsumidoraController.text.trim(),
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cadastro realizado com sucesso!')),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      String msg = 'Erro ao cadastrar';

      if (e.code == 'email-already-in-use') {
        msg = 'E-mail já cadastrado';
      } else if (e.code == 'weak-password') {
        msg = 'Senha muito fraca';
      } else if (e.code == 'invalid-email') {
        msg = 'E-mail inválido';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg)),
      );
    }
  }

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Registrar',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                            color: textoPrincipal,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'Nome:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: textoSecundario,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _nomeController,
                        keyboardType: TextInputType.text,
                        decoration: _inputStyle(),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Telefone:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: textoSecundario,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _telefoneController,
                        keyboardType: TextInputType.phone,
                        decoration: _inputStyle(),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'CPF/CNPJ:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: textoSecundario,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _cpfCnpjController,
                        keyboardType: TextInputType.text,
                        decoration: _inputStyle(),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Endereço:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: textoSecundario,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _enderecoController,
                        keyboardType: TextInputType.text,
                        decoration: _inputStyle(),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Unidade Consumidora:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: textoSecundario,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _unidadeConsumidoraController,
                        keyboardType: TextInputType.text,
                        decoration: _inputStyle(),
                      ),
                      const SizedBox(height: 20),
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
                      const SizedBox(height: 20),
                      const Text(
                        'Confirmar Senha:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: textoSecundario,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _confirmarSenhaController,
                        obscureText: _confirmarSenhaOculta,
                        decoration: _inputStyle().copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _confirmarSenhaOculta
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: textoSecundario,
                            ),
                            onPressed: () {
                              setState(() {
                                _confirmarSenhaOculta = !_confirmarSenhaOculta;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: _registrarUsuario,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: verdeBotao,
                            foregroundColor: textoPrincipal,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Registrar',
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