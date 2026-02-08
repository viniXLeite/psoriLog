import 'package:flutter/material.dart';
import './cadastro_paciente_screen.dart';
import './cadastro_medico_screen.dart';


// Ela continua igual, mas agora quando navegar para LoginGeral,
// o LoginGeral vai conseguir acessar o AuthProvider!
class SeletorCadastro extends StatelessWidget {
  const SeletorCadastro({super.key});

  // Função auxiliar para criar botões idênticos
  Widget _buildMenuButton(BuildContext context, String label, Widget screen) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0), // Espaçamento entre os botões
      child: SizedBox(
        width: 250, // LARGURA FIXA para todos
        height: 55, // ALTURA FIXA para todos
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 133, 216, 225), 
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // Bordas arredondadas
            ),
          ),
          child: Text(label, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          onPressed: () {
            // Usando rotas nomeadas fica mais limpo -> trocar Widget screen por String routeName
            // Considerar usar Navigator.pushNamed(context, '/login');
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
      // O AppBar cria automaticamente a seta de voltar se houver uma tela anterior
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black), 
      ),

      backgroundColor: const Color.fromARGB(255, 255, 255, 255), // Cor de fundo padrão
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //const Icon(Icons.health_and_safety, size: 80, color: Colors.cyan),
            Image.asset(
              'assets/images/psorilog_logo.png', // Caminho do seu arquivo
              height: 200, // Ajuste o tamanho conforme desejar
              width: 200,
            ),
            //const SizedBox(height: 5),
            const Text('PsoriLog', style: TextStyle(
                  color: Color.fromARGB(255, 86, 130, 54),
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),

            // botoes padronizados
            _buildMenuButton(context, "Cadastro paciente", const CadastroPacienteScreen()),
            _buildMenuButton(context, "Cadastro médico", const CadastroMedicoScreen()),
          ],
        ),
      ),
    );
  }
}