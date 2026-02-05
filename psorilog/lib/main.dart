import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'injection_container.dart' as di;
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/auth/presentation/pages/cadastro_paciente_screen.dart';
import 'features/auth/presentation/pages/cadastro_medico_screen.dart';
import 'features/auth/presentation/pages/login_geral.dart';

void main() async {
  // Garante que o motor gráfico iniciou antes de rodar códigos assíncronos
  WidgetsFlutterBinding.ensureInitialized();

  // INICIALIZAÇÃO DA CLEAN ARCHITECTURE
  // Aqui ele cria o Dio, os Repositórios e prepara os Providers na memória
  await di.init(); 

  runApp(const PsoriLogApp());
}

class PsoriLogApp extends StatelessWidget {
  const PsoriLogApp({super.key});

  @override
  Widget build(BuildContext context) {
    // O MultiProvider envolve todo o app. Assim, a tela de Login (que é filha)
    // consegue achar o AuthProvider lá no topo da árvore.
    return MultiProvider(
      providers: [
        // Usamos o 'di.sl<AuthProvider>()' para pegar a instância pronta do Injection Container
        ChangeNotifierProvider(create: (_) => di.sl<AuthProvider>()),

        // Futuramente, adicionar o DailyLogProvider aqui:
        // ChangeNotifierProvider(create: (_) => di.sl<DailyLogProvider>()),
      ],
      child: MaterialApp(
        title: 'PsoriLog',
        theme: ThemeData(
          primarySwatch: Colors.red,
          useMaterial3: true,
        ),
        // Defina rotas nomeadas para facilitar a navegação (Opcional, mas recomendado)
        routes: {
          '/': (context) => const HomeScreen(),
          '/login': (context) => const LoginGeral(),
          '/home': (context) => const HomeScreen(), // Ou sua futura HomeReal
        },
        initialRoute: '/',
        //home: const HomeScreen(),
      ),
    );
  }
}

// Ela continua igual, mas agora quando navegar para LoginGeral,
// o LoginGeral vai conseguir acessar o AuthProvider!
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.health_and_safety, size: 80, color: Colors.cyan),
            const SizedBox(height: 20),
            const Text('PsoriLog', style: TextStyle(
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