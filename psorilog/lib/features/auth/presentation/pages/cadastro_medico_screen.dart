// cadastro_screen.dart
import 'package:flutter/material.dart';

class CadastroMedicoScreen extends StatefulWidget {
  const CadastroMedicoScreen({super.key});

  @override
  State<CadastroMedicoScreen> createState() => _CadastroMedicoScreenState();
}

class _CadastroMedicoScreenState extends State<CadastroMedicoScreen> {
  bool aceitouTermos = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      // O AppBar cria automaticamente a seta de voltar se houver uma tela anterior
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black), 
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const Text(
              'Cadastro de Médico',
              style: TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            _buildInput(label: "Nome completo"),
            _buildInput(label: "CRM"),
            _buildInput(label: "Email"),
            _buildInput(label: "telefone"),
            Row(
              children: [
                Checkbox(value: aceitouTermos, onChanged: (v) => setState(() => aceitouTermos = v!)),
                const Text("Termos e condições de usuário"),
              ],
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 133, 216, 225), 
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text("Cadastrar", style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInput({required String label}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: BorderSide.none),
        ),
      ),
    );
  }
}