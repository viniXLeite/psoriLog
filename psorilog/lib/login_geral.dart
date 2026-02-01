// cadastro_screen.dart
import 'package:flutter/material.dart';
import 'recuperar_senha.dart';

class LoginGeral extends StatefulWidget {
  const LoginGeral({super.key});

  @override
  State<LoginGeral> createState() => _LoginGeralState();
}

class _LoginGeralState extends State<LoginGeral> {
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
              'Login',
              style: TextStyle(color: Colors.black, fontSize: 36, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            _buildInput(label: "Email"),
            _buildInput(label: "Senha"),
            
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text("Entrar", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),

            const SizedBox(height: 20),

            TextButton(
              onPressed: () {
                // Redireciona para a tela de recuperar senha
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RecuperarSenha()),
                );
              },
              child: const Text(
                "Recuperar senha",
                style: TextStyle(
                  color: Colors.black, // Cor azul para parecer um link
                  decoration: TextDecoration.underline, // Linha embaixo opcional
                ),
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