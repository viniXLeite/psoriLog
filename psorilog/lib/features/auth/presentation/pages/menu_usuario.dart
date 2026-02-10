import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'registro_sintomas.dart';

class MenuUsuario extends StatefulWidget {
  const MenuUsuario({super.key});

  @override
  _MenuUsuarioState createState() => _MenuUsuarioState();
}

class _MenuUsuarioState extends State<MenuUsuario> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        titleSpacing: 0,
        title: const Text(
          "Olá, José",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF2D3142)),
        ),
      ),
      body: SafeArea(
        // Chamando a função que constrói o conteúdo
        child: _buildPatientInfo("José"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RegistroSintomaScreen()),
          );
        },
        label: const Text("+ Novo Registro", style: TextStyle(color: Colors.white, fontSize: 16)),
        backgroundColor: const Color.fromARGB(255, 179, 28, 28),
      ),
    );
  }

  Widget _buildPatientInfo(String nome) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. LEMBRETE DE MEDICAÇÃO (Destaque visual)
          _buildAlertCard(
            "Lembrete de Hoje",
            "Próxima aplicação: Pomada X\nHorário: 20:00",
            Icons.alarm,
            Colors.orangeAccent,
          ),
          
          const SizedBox(height: 25),

          // 2. GRÁFICO DE EVOLUÇÃO
          const Text("Evolução dos Sintomas",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Container(
            height: 220,
            padding: const EdgeInsets.only(top: 20, right: 20, left: 10, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 2)
              ],
            ),
            child: LineChart(_mainChartData()),
          ),

          const SizedBox(height: 25),

          // 3. ÚLTIMO SINTOMA DESCRITO
          const Text("Último Sintoma Registrado",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildCard(
            "Registrado em: 09/02/2026",
            "\"Senti uma leve coceira no antebraço após o banho. A pele parece menos avermelhada que ontem, mas ainda descama um pouco.\"",
          ),
          
          const SizedBox(height: 80), // Espaço para não cobrir pelo FAB
        ],
      ),
    );
  }

  // Widget para o Card de Alerta/Medicação
  Widget _buildAlertCard(String title, String content, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 40),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 16)),
                Text(content, style: const TextStyle(color: Colors.black87)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String title, String content) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 10)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey)),
          const SizedBox(height: 8),
          Text(content,
              style: const TextStyle(
                  fontSize: 15, fontStyle: FontStyle.italic, color: Colors.black87)),
        ],
      ),
    );
  }

  LineChartData _mainChartData() {
    return LineChartData(
      gridData: const FlGridData(show: false),
      titlesData: const FlTitlesData(
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(show: false),
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 4),
            FlSpot(2, 3),
            FlSpot(4, 5),
            FlSpot(6, 2),
            FlSpot(8, 2.5),
            FlSpot(10, 1.5),
          ],
          isCurved: true,
          color: const Color.fromARGB(255, 179, 28, 28),
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: true),
          belowBarData: BarAreaData(
            show: true,
            color: const Color.fromARGB(255, 179, 28, 28).withOpacity(0.1),
          ),
        ),
      ],
    );
  }
}