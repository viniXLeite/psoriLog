// cadastro_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'recuperar_senha.dart';

class LoginGeral extends StatefulWidget {
  const LoginGeral({super.key});

  @override
  State<LoginGeral> createState() => _LoginGeralState();
}

class _LoginGeralState extends State<LoginGeral> {
  // 1. CRIAR OS CONTROLLERS (Para capturar o que for digitado)
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //bool aceitouTermos = false;

  // Boa prática: Limpar memória quando sair da tela
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {    
    // ACESSAR O PROVIDER (O "Cérebro" da tela)
    // O 'listen: true' faz a tela redesenhar quando o status mudar (ex: loading)
    final authProvider = Provider.of<AuthProvider>(context);

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

            // 3. PASSAR OS CONTROLLERS PARA OS INPUTS
            _buildInput(
              label: "Email", 
              controller: _emailController,
              icon: Icons.email_outlined,
            ),
            _buildInput(
              label: "Senha", 
              controller: _passwordController,
              isPassword: true, // Avisa que é senha
              icon: Icons.lock_outline,
            ),
            
            const SizedBox(height: 30),

            // MENSAGEM DE ERRO (Aparece só se der erro)
            if (authProvider.status == AuthStatus.error)
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  authProvider.errorMessage ?? 'Erro desconhecido',
                  style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(

                // 4. LÓGICA DO BOTÃO
                // Se estiver carregando, desabilita o botão (null)
                onPressed: authProvider.status == AuthStatus.loading
                    ? null 
                    : () async {
                        print("PASSO 1: Botão clicado!"); // <--- ADICIONE ISSO
                        // Chama o método de login no Provider
                        await authProvider.login(
                          _emailController.text,
                          _passwordController.text,
                        );

                        // Verifica se deu certo após o await
                        if (authProvider.status == AuthStatus.success && context.mounted) {
                          // Navega para a Home e remove a tela de Login da pilha
                          // Certifique-se de ter definido a rota '/home' no main.dart
                          // Ou use Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Bem-vindo de volta!")),
                          );
                          // Navigator.pushReplacementNamed(context, '/home'); // Exemplo
                        }
                      },

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 133, 216, 225), 
                  // Muda cor se estiver desabilitado
                  disabledBackgroundColor: Colors.red.withOpacity(0.6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                // 5. FEEDBACK VISUAL (Loading ou Texto)
                child: authProvider.status == AuthStatus.loading
                    ? const SizedBox(
                        height: 24, 
                        width: 24, 
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                      )
                    : const Text("Entrar",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
              ),
            ),

            const SizedBox(height: 20),

            // Texto para clicável para recuperar senha
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
                  fontSize: 18,
                  color: Color.fromARGB(255, 33, 50, 21), // Cor azul para parecer um link
                  decoration: TextDecoration.underline, // Linha embaixo opcional
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildInput({
    required String label, 
    required TextEditingController controller, // <--- Novo parametro
    bool isPassword = false, // <--- Novo parametro
    IconData? icon,
  }) {
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller, // <--- Atribui o controller
        obscureText: isPassword, // <--- Define se é senha
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon != null ? Icon(icon, color: Colors.grey) : null,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: BorderSide.none),
        ),
      ),
    );
  }
}