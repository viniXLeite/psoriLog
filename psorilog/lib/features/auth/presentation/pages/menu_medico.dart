import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MenuMedico extends StatefulWidget {
  const MenuMedico({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MenuMedicoState createState() => _MenuMedicoState();
}

class _MenuMedicoState extends State<MenuMedico> with TickerProviderStateMixin {
  late TabController _tabController;
  final List<String> pacientes = ['Paciente A', 'Paciente B', 'Paciente C', 'Paciente D'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: pacientes.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),

      // O AppBar cria automaticamente a seta de voltar se houver uma tela anterior
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black), 
        title: Text(
          "Olá, Dr. Silva",
          style: TextStyle(
          fontSize: 22, // Diminuí levemente para caber melhor na barra
          fontWeight: FontWeight.bold, 
          color: Color(0xFF2D3142)
          ),
        ),
      ),

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Seletor de Pacientes (Estilo Etiquetas de Arquivo)
            TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: const Color.fromARGB(255, 145, 190, 234),
              labelColor: const Color.fromARGB(255, 0, 0, 0),
              unselectedLabelColor: Colors.grey,
              tabs: pacientes.map((nome) => Tab(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black12)
                  ),
                  child: Text(nome),
                ),
              )).toList(),
            ),

            // Conteúdo do Paciente Selecionado
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: pacientes.map((nome) => _buildPatientInfo(nome)).toList(),
              ),
            ),
          ],
        ),
      ),
      
      // Botão Flutuante para Relatório
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Lógica para emitir relatório
        },
        label: Text("Relatório"),
        icon: Icon(Icons.description),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  Widget _buildPatientInfo(String nome) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCard("Tratamento das Lesões", 
            "• Lesão 1: Braço esquerdo - Pomada X (2x/dia)\n"
            "• Lesão 2: Couro cabeludo - Fototerapia (3x/semana)\n"
            "• Lesão 2: Couro cabeludo - Pomada Y (2x/semana)"
            ),
          SizedBox(height: 30),
          // Gráfico de Evolução (usando fl_chart)
          // Gráfico coceira

          Text("Evolução coceira", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Container(
            height: 220,
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [BoxShadow(color: Colors.black, blurRadius: 10)],
            ),
            child: LineChart(_mainChartData()),
          ),

          SizedBox(height: 30),
          Text("Evolução vermelhidão", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          // Gráfico de Evolução (usando fl_chart)
          Container(
            height: 220,
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [BoxShadow(color: Colors.black, blurRadius: 10)],
            ),
            child: LineChart(_mainChartData()),
          ),

          SizedBox(height: 30),
          Text("Evolução área de lesão", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          // Gráfico de Evolução (usando fl_chart)
          Container(
            height: 220,
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [BoxShadow(color: Colors.black, blurRadius: 10)],
            ),
            child: LineChart(_mainChartData()),
          ),

        ],
      ),
    );
  }

  Widget _buildCard(String title, String content) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black, blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
          SizedBox(height: 10),
          Text(content, style: TextStyle(fontSize: 16, color: Colors.black87)),
        ],
      ),
    );
  }

  // Configuração do gráfico de evolução (exemplo genérico, pode ser adaptado para cada métrica)
  LineChartData _mainChartData() {
    return LineChartData(
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(show: false),
      borderData: FlBorderData(show: false),
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3), FlSpot(2, 2), FlSpot(4, 5), FlSpot(6, 3.1), FlSpot(8, 4), FlSpot(10, 3),
          ],
          isCurved: true,
          color: const Color.fromARGB(255, 130, 89, 89),
          barWidth: 4,
          belowBarData: BarAreaData(show: true, color: const Color.fromARGB(255, 253, 191, 191)),
        ),
      ],
    );
  }
}