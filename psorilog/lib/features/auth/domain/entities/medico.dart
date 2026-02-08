class Medico {
  final String nome;
  final String crm;
  final String email;
  final String password; // Apenas para transitar dados no cadastro

  Medico({
    required this.nome,
    required this.crm,
    required this.email,
    required this.password,
  });
}