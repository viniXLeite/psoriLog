// cadastro_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import '../providers/auth_provider.dart';
import 'menu_medico.dart'; 

class CadastroMedicoScreen extends StatefulWidget {
  const CadastroMedicoScreen({super.key});

  @override
  State<CadastroMedicoScreen> createState() => _CadastroMedicoScreenState();
}

class _CadastroMedicoScreenState extends State<CadastroMedicoScreen> {
  final _nomeController = TextEditingController();
  final _crmController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _senhaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool aceitouTermos = false;

  // Limpa a memória quando sai da tela
  @override
  void dispose() {
    _nomeController.dispose();
    _crmController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        child: Form( // <--- Envolvemos tudo num Form
          key: _formKey,
          child: Column(
            children: [
              const Text(
                'Cadastro de Médico',
                style: TextStyle(color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),

              // Campos com validação
              _buildInput(label: "Nome completo", controller: _nomeController),
              _buildInput(label: "CRM", controller: _crmController, isNumber: true),
              _buildInput(label: "Email", controller: _emailController, isEmail: true),
              _buildInput(label: "Telefone", controller: _telefoneController, isNumber: true),
              _buildInput(label: "Senha", controller: _senhaController, isPassword: true),

              Row(
                children: [
                  Checkbox(value: aceitouTermos, onChanged: (v) => setState(() => aceitouTermos = v!)),
                  const Text("Termos e condições de usuário"),
                ],
              ),
              const SizedBox(height: 30),

              // Mensagem de Erro (se houver)
              if (authProvider.status == AuthStatus.error)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    authProvider.errorMessage ?? "Erro desconhecido",
                    style: const TextStyle(color: Colors.red),
                  ),
                ),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: authProvider.status == AuthStatus.loading 
                      ? null // Desabilita se estiver carregando
                      : () => _realizarCadastro(authProvider),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 133, 216, 225), 
                    // Cor quando desabilitado
                    disabledBackgroundColor: const Color.fromARGB(255, 133, 216, 225).withOpacity(0.6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: authProvider.status == AuthStatus.loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Cadastrar", style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // Lógica separada para ficar limpo
  Future<void> _realizarCadastro(AuthProvider authProvider) async {
    // 1. Valida campos de texto
    if (!_formKey.currentState!.validate()) return;

    // 2. Valida Checkbox
    if (!aceitouTermos) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Você precisa aceitar os termos.")),
      );
      return;
    }

    // 3. Chama o Provider (Backend/Mock)
    await authProvider.cadastrarMedico(
      nome: _nomeController.text,
      crm: _crmController.text,
      email: _emailController.text,
      password: _senhaController.text,
    );

    // 4. Se deu certo, navega
    if (authProvider.status == AuthStatus.success && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MenuMedico()),
      );
    }
  }

  Widget _buildInput({
    required String label,
    required TextEditingController controller,
    bool isPassword = false,
    bool isNumber = false,
    bool isEmail = false,
    }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: isNumber ? TextInputType.number : (isEmail ? TextInputType.emailAddress : TextInputType.text),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Campo obrigatório';
          }
          if (isEmail && !value.contains('@')) {
            return 'Email inválido';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: BorderSide.none),
          // Exibe o erro vermelhinho embaixo
          errorStyle: const TextStyle(color: Colors.redAccent),
        ),
      ),
    );
  }
}