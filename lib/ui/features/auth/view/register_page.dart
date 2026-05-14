import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../home/view/home_page.dart';

class RegisterPage extends StatefulWidget {
	const RegisterPage({super.key});

	@override
	State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
	final TextEditingController _emailController = TextEditingController();
	final TextEditingController _senhaController = TextEditingController();
	final TextEditingController _confirmarSenhaController = TextEditingController();

	bool _senhaOculta = true;
	bool _confirmarSenhaOculta = true;

	static const Color azulFundoTopo = Color(0xFF67E6DC);
	static const Color azulFundoBase = Color(0xFFC9F7F1);
	static const Color verdeBotao = Color(0xFFD4E157);
	static const Color textoPrincipal = Color(0xFF131A2D);
	static const Color textoSecundario = Color(0xFF767F8D);

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
														style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
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
										color: Colors.white.withOpacity(0.9),
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
												'Email:',
												style: TextStyle(
													fontSize: 14,
													fontWeight: FontWeight.w600,
													color: textoSecundario,
