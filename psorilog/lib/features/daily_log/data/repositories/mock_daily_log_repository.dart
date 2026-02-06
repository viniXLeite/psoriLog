import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/relatorio_diario.dart';
import '../../domain/repositories/daily_log_repository.dart';

class MockDailyLogRepository implements DailyLogRepository {
  @override
  Future<Either<Failure, void>> registrarSintoma(RelatorioDiario relatorio) async {
    // 1. Fingir que estamos pensando (Delay de rede)
    await Future.delayed(const Duration(seconds: 2));

    // 2. Simular validação ou erro aleatório (útil para testar UI)
    if (relatorio.sintomas.contains("erro")) {
        return const Left(ServerFailure("Erro simulado: Sistema instável"));
    }

    // 3. Sucesso!
    print("MOCK DB: Salvando relatório do dia ${relatorio.data}");
    print("MOCK DB: Dor ${relatorio.nivelDor} - '${relatorio.sintomas}'");
    
    return const Right(null);
  }
}