// lib/core/error/failures.dart

// Classe base para todos os erros do sistema
abstract class Failure {
  final String message;
  
  const Failure(this.message);
}

// Falha específica do Servidor (ex: erro 500, 404, senha errada)
class ServerFailure extends Failure {
  // O [message] é opcional, se não passar nada usa o padrão
  const ServerFailure([super.message = "Erro no servidor"]);
}

// Falha de Conexão (ex: sem internet)
class NetworkFailure extends Failure {
  const NetworkFailure() : super("Sem conexão com a internet");
}

// Falha de Cache/Storage (ex: erro ao ler o token salvo)
class CacheFailure extends Failure {
  const CacheFailure() : super("Erro ao carregar dados locais");
}