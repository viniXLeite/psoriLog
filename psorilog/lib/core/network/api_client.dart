import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiClient {
  // Singleton para não abrir múltiplas conexões
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  late Dio dio;
  final _storage = const FlutterSecureStorage();

  ApiClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://SEU_IP_LOCAL:8000/api', // Laravel local
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // O "Interceptor" é o segredo do Sênior.
    // Ele roda ANTES de toda requisição.
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // 1. Pega o token salvo no celular
          final token = await _storage.read(key: 'auth_token');
          
          // 2. Se tiver token, injeta no Header
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          
          print("REQ [${options.method}] => ${options.path}");
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          // Aqui trataremos erros globais (ex: Token expirado -> Logout forçado)
          print("ERRO: ${e.response?.statusCode} - ${e.message}");
          return handler.next(e);
        },
      ),
    );
  }
}