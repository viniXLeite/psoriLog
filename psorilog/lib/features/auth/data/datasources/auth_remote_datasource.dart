import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart'; // Seu arquivo de Dio
import '../../../../core/error/failures.dart'; // Suas exceções customizadas
import '../models/usuario_model.dart';

class AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSource(this.apiClient);

  Future<UsuarioModel> login(String email, String password) async {
    try {
      final response = await apiClient.dio.post('/login', data: {
        'email': email,
        'password': password,
      });

      // Se deu certo (200 OK), o response.data é o Map (JSON)
      return UsuarioModel.fromJson(response.data);
      
    } on DioException catch (e) {
      // Tratamento de erro robusto
      if (e.response?.statusCode == 401) {
        throw ServerFailure("Email ou senha incorretos.");
      } else {
        throw ServerFailure("Erro no servidor: ${e.message}");
      }
    }
  }
}