import 'package:flutter/material.dart';

class RegistroSintomaScreen extends StatefulWidget {
  const RegistroSintomaScreen({super.key});

  @override
  State<RegistroSintomaScreen> createState() => _RegistroSintomaScreenState();
}

class _RegistroSintomaScreenState extends State<RegistroSintomaScreen> {
  // Controles dos Sliders
  double _nivelDor = 0;
  double _nivelCoceira = 0;
  double _nivelDescamacao = 0;

  // Controller para o texto e data
  final _dataController = TextEditingController(text: "10/02/2026");
  final _descricaoController = TextEditingController();

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
              fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF2D3142)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Registro de Sintomas',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 25),

            // Campo de Data
            _buildLabel("Data do registro"),
            TextField(
              controller: _dataController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.calendar_today),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none),
              ),
              readOnly: true, // Idealmente abriria um DatePicker aqui
            ),

            const SizedBox(height: 25),

            // Campo de Foto da Lesão
            _buildLabel("Foto da lesão"),
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey[300]!, style: BorderStyle.solid),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.camera_alt, size: 40, color: Colors.grey),
                  Text("Toque para anexar foto", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Seletores (Sliders)
            _buildSliderLabel("Nível de Dor", _nivelDor),
            _buildSlider(value: _nivelDor, onChanged: (v) => setState(() => _nivelDor = v), color: Colors.redAccent),

            _buildSliderLabel("Nível de Coceira", _nivelCoceira),
            _buildSlider(value: _nivelCoceira, onChanged: (v) => setState(() => _nivelCoceira = v), color: Colors.orange),

            _buildSliderLabel("Descamação", _nivelDescamacao),
            _buildSlider(value: _nivelDescamacao, onChanged: (v) => setState(() => _nivelDescamacao = v), color: Colors.blueGrey),

            const SizedBox(height: 20),

            // Caixa de Texto
            _buildLabel("Observações adicionais"),
            TextField(
              controller: _descricaoController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Descreva como você está se sentindo...",
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none),
              ),
            ),

            const SizedBox(height: 30),

            // Botão Enviar
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // Lógica para salvar o registro
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Registro enviado com sucesso!")),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 133, 216, 225),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text("Enviar Registro", 
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helpers para organização
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildSliderLabel(String label, double value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLabel(label),
        Text(value.toInt().toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.cyan)),
      ],
    );
  }

  Widget _buildSlider({required double value, required Function(double) onChanged, required Color color}) {
    return Slider(
      value: value,
      min: 0,
      max: 10,
      divisions: 10,
      label: value.toInt().toString(),
      activeColor: color,
      onChanged: onChanged,
    );
  }
}