// login_viewmodel.dart
// Arquivo reservado para lógica do Login.
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
	String? _message;
	String? get message => _message;
	bool _isLogged = false;
	bool get isLogged => _isLogged;

	Future<void> login({required String email, required String password}) async {
		if (email.isEmpty || password.isEmpty) {
			_message = 'Preencha email e senha.';
			_isLogged = false;
			notifyListeners();
			return;
		}
		// Simulação de login válido
		if (email == 'teste@email.com' && password == '123456') {
			_message = null;
			_isLogged = true;
		} else {
			_message = 'E-mail ou senha inválidos';
			_isLogged = false;
		}
		notifyListeners();
	}

	void clearMessage() {
		_message = null;
		notifyListeners();
	}
}
