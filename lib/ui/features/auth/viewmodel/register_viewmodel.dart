// register_viewmodel.dart
// Arquivo reservado para lógica do Register.
import 'package:flutter/material.dart';

class RegisterViewModel extends ChangeNotifier {
	String? _message;
	String? get message => _message;
	bool _isRegistered = false;
	bool get isRegistered => _isRegistered;
	final List<String> _registeredEmails = [];

	Future<void> register({required String name, required String email, required String password}) async {
		if (name.isEmpty || email.isEmpty || password.isEmpty) {
			_message = 'Preencha todos os campos.';
			_isRegistered = false;
			notifyListeners();
			return;
		}
		if (!email.contains('@')) {
			_message = 'Informe um email válido';
			_isRegistered = false;
			notifyListeners();
			return;
		}
		if (_registeredEmails.contains(email)) {
			_message = 'E-mail já cadastrado';
			_isRegistered = false;
			notifyListeners();
			return;
		}
		_registeredEmails.add(email);
		_message = 'Cadastro realizado com sucesso';
		_isRegistered = true;
		notifyListeners();
	}

	void clearMessage() {
		_message = null;
		notifyListeners();
	}
}
