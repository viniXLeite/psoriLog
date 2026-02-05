import 'package:flutter/material.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/usuario.dart';

enum AuthStatus { idle, loading, success, error }

class AuthProvider extends ChangeNotifier {
  final AuthRepository repository;

  AuthProvider({required this.repository});

  AuthStatus status = AuthStatus.idle;
  Usuario? usuario;
  String? errorMessage;

  Future<void> login(String email, String password) async {
    print("PASSO 2: Provider recebeu o pedido: $email"); // <--- ADICIONE ISSO
    
    status = AuthStatus.loading;
    errorMessage = null;
    notifyListeners(); // Avisa a UI para mostrar o Spinner

    // Chama o Repositório (que chama o DataSource -> API -> Laravel)
    final result = await repository.login(email, password);

    // O "fold" é do pacote dartz.
    // O primeiro param é o erro (Left), o segundo é o sucesso (Right).
    result.fold(
      (failure) {
        status = AuthStatus.error;
        errorMessage = failure.message;
        notifyListeners();
      },
      (userSuccess) {
        status = AuthStatus.success;
        usuario = userSuccess;
        notifyListeners();
      },
    );
  }
}