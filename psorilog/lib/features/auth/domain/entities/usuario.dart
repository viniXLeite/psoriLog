class Usuario {
  final String id;
  final String nome;
  final String email;
  final String? token; // Opcional, pois as vezes só queremos os dados do user

  const Usuario({
    required this.id,
    required this.nome,
    required this.email,
    this.token,
  });
}