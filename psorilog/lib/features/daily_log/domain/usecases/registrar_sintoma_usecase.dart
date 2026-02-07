import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/relatorio_diario.dart';
import '../repositories/daily_log_repository.dart';

class RegistrarSintomaUseCase {
  final DailyLogRepository repository;

  RegistrarSintomaUseCase(this.repository);

  Future<Either<Failure, void>> call(RelatorioDiario relatorio) async {
    // REGRA DE NEGÓCIO: Validação simples antes de tentar salvar
    if (relatorio.sintomas.isEmpty) {
      return const Left(ServerFailure("A descrição do sintoma é obrigatória"));
    }
    
    // Se passou, chama o repositório (que hoje é o Mock)
    return await repository.registrarSintoma(relatorio);
  }
}