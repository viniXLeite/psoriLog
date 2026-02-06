import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/relatorio_diario.dart';

abstract class DailyLogRepository {
  // O contrato: "Tente salvar um relatório. Retorne Falha ou Nada (Void)"
  Future<Either<Failure, void>> registrarSintoma(RelatorioDiario relatorio);
  
  // Se formos fazer a listagem no Domingo, já deixe o contrato pronto:
  // Future<Either<Failure, List<RelatorioDiario>>> lerDiarios();
}