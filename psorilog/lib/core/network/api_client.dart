import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:io'; // Para checar a plataforma
import 'package:flutter/foundation.dart'; // Para checar se é Web

class ApiClient {
  // Singleton para não abrir múltiplas conexões
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  late Dio dio;
  final _storage = const FlutterSecureStorage();

  ApiClient._internal() {
    String baseUrl;

    if (kIsWeb) {
      // Se for Chrome, usa localhost normal
      baseUrl = 'http://127.0.0.1:8000/api'; 
    } else if (Platform.isAndroid) {
      // Se for Android, usa o IP mágico
      baseUrl = 'http://10.0.2.2:8000/api'; 
    } else {
      // iOS ou outros
      baseUrl = 'http://127.0.0.1:8000/api';
    }

    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
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
          print("PASSO 3: Dio tentando enviar para: ${options.path}"); // <--- CONFIRA ISSO
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