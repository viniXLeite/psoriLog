import '../../domain/entities/usuario.dart';

class UsuarioModel extends Usuario {
  const UsuarioModel({
    required String id,
    required String nome,
    required String email,
    String? token,
  }) : super(id: id, nome: nome, email: email, token: token);

  // A Mágica: JSON -> Dart (Factory Constructor)
  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    // Proteção contra nulos: se o campo não vier, usamos um valor padrão ou tratamos
    return UsuarioModel(
      // O Laravel retorna id como int, convertemos para String para padronizar
      id: json['user']['id'].toString(), 
      nome: json['user']['name'] ?? '',
      email: json['user']['email'] ?? '',
      token: json['token'], // Pode ser null se o endpoint não retornar token
    );
  }

  // A Volta: Dart -> JSON (Para enviar dados pro backend, se precisar)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': nome,
      'email': email,
      // Não enviamos o token de volta no corpo geralmente, vai no header
    };
  }
}