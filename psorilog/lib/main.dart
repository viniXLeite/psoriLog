import 'package:flutter/material.dart';
import 'cadastro_paciente_screen.dart';
import 'cadastro_medico_screen.dart';
import 'login_geral.dart';

void main() {
  runApp(const MaterialApp(
    home: HomeScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Função auxiliar para criar botões idênticos
  Widget _buildMenuButton(BuildContext context, String label, Widget screen) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0), // Espaçamento entre os botões
      child: SizedBox(
        width: 250, // LARGURA FIXA para todos
        height: 55, // ALTURA FIXA para todos
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent, 
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // Bordas arredondadas
            ),
          ),
          child: Text(label, style: const TextStyle(fontSize: 18)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => screen),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'PsoriLog',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 80),

            // botoes padronizados
            _buildMenuButton(context, "Login", const LoginGeral()),
            _buildMenuButton(context, "Cadastro paciente", const CadastroPacienteScreen()),
            _buildMenuButton(context, "Cadastro médico", const CadastroMedicoScreen()),
            
          ],
        ),
      ),
    );
  }
}