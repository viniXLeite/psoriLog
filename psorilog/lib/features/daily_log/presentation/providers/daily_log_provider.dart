import 'package:flutter/material.dart';
import '../../domain/usecases/registrar_sintoma_usecase.dart';
import '../../domain/entities/relatorio_diario.dart';

enum DailyLogStatus { idle, loading, success, error }

class DailyLogProvider extends ChangeNotifier {
  final RegistrarSintomaUseCase registrarUseCase;

  DailyLogProvider({required this.registrarUseCase});

  DailyLogStatus status = DailyLogStatus.idle;
  String? errorMessage;

  Future<void> registrarSintoma({
    required int nivelDor,
    required String textoSintoma,
    required DateTime data,
  }) async {
    status = DailyLogStatus.loading;
    notifyListeners(); // Tela: "Mostre o spinner!"

    final novoRelatorio = RelatorioDiario(
      nivelDor: nivelDor,
      sintomas: textoSintoma,
      data: data,
    );

    final result = await registrarUseCase(novoRelatorio);

    result.fold(
      (failure) {
        status = DailyLogStatus.error;
        errorMessage = failure.message; // Mensagem que veio do Mock ou UseCase
        notifyListeners();
      },
      (sucesso) {
        status = DailyLogStatus.success;
        notifyListeners(); // Tela: "Mostre o feedback de sucesso!"
      },
    );
  }

  // Reseta o estado para quando o usuário voltar na tela depois
  void reset() {
    status = DailyLogStatus.idle;
    errorMessage = null;
    notifyListeners();
  }
}