import 'package:dartz/dartz.dart';
import '../../domain/entities/usuario.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../../../../core/error/failures.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final FlutterSecureStorage storage; // Para salvar o token

  AuthRepositoryImpl(this.remoteDataSource, this.storage);

  @override
  Future<Either<Failure, Usuario>> login(String email, String password) async {
    try {
      final usuarioModel = await remoteDataSource.login(email, password);
      
      // Salvar token persistente para o usuário não logar toda vez
      if (usuarioModel.token != null) {
        await storage.write(key: 'auth_token', value: usuarioModel.token);
      }

      return Right(usuarioModel); // Sucesso! Retorna a entidade
    } on ServerFailure catch (e) {
      return Left(e); // Falha controlada
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}