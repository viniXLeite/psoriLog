import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/usuario.dart';
import '../entities/medico.dart';

abstract class AuthRepository {
  // O contrato diz: "Tente fazer login. 
  // Retorne OU uma Falha (Failure) OU um Usuário (Usuario)"
  Future<Either<Failure, Usuario>> login(String email, String password);

  Future<Either<Failure, Usuario>> cadastrarMedico(Medico medico);
}