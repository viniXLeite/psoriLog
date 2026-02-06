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

    // MOCK: Simular login sem backend
    print("MOCK LOGIN:");
    await Future.delayed(const Duration(seconds: 2)); // Finge que a internet é lenta

    if (email == "teste@email.com" && password == "12345678") {
      // Simula Sucesso
      final usuarioFake = Usuario(
        id: "1", 
        nome: "Paciente Teste", 
        email: email, 
        token: "TOKEN_FAKE_JWT_XYZ"
      );
      
      // Salva o token fake para o app achar que está logado
      await storage.write(key: 'auth_token', value: usuarioFake.token);
      
      return Right(usuarioFake);
    } else {
      // Simula Erro
      return const Left(ServerFailure("Email ou senha incorretos (Mock)"));
    }
    // -----------------------------------------------------------
    

    // O código original fica comentado aqui embaixo para quando o backend voltar
    /*
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
  */
  }

}