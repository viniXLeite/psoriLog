class RelatorioDiario {
  final int nivelDor; // 1 a 10
  final String sintomas;
  final DateTime data;
  final String? fotoPath; // Opcional para Sprint 1

  RelatorioDiario({
    required this.nivelDor,
    required this.sintomas,
    required this.data,
    this.fotoPath,
  });
}