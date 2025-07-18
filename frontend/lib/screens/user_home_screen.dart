import 'package:flutter/material.dart';
import '../widgets/audio_voice_controls.dart';
import '../services/tts_service.dart';

class UserHomeScreen extends StatefulWidget {
  final String name;

  const UserHomeScreen({super.key, required this.name});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final TtsService _ttsService = TtsService();

  @override
  void initState() {
    super.initState();
    _ttsService.speak("Hola ${widget.name}, ¿Cómo puedo ayudarte?");
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F4D3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F4D3),
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Color(0xFF795548)),
            tooltip: 'Perfil / Cerrar sesión',
            onPressed: () {
              _showLogoutDialog(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            Text(
              'Hola ${widget.name},\n¿Cómo puedo ayudarte?',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 32),
            GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: isMobile ? 1.2 : 1.4,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                _buildMenuButton(context, Icons.quiz, 'Simulacros', isMobile),
                _buildMenuButton(context, Icons.lightbulb_outline, 'Consejos', isMobile),
                _buildMenuButton(context, Icons.account_balance, 'Entidades Oficiales', isMobile),
                _buildMenuButton(context, Icons.bar_chart, 'Ver progreso', isMobile),
                _buildMenuButton(context, Icons.school, 'Zona de enseñanza', isMobile),
                _buildMenuButton(context, Icons.school, 'Otros', isMobile),
              ],
            ),
            const SizedBox(height: 40),
            AudioVoiceControls(
              audioText: 'Estas son las opciones disponibles: Simulacros, Consejos, Entidades Oficiales, Ver progreso, Zona de enseñanza. '
                  'Dime cuál deseas abrir diciendo su nombre.',
              onVoiceCommand: (command) {
                final cmd = command.toLowerCase();

                if (cmd.contains('simulacro')) {
                  Navigator.pushNamed(context, '/simulacros');
                } else if (cmd.contains('consejo')) {
                  Navigator.pushNamed(context, '/consejos');
                } else if (cmd.contains('entidad')) {
                  Navigator.pushNamed(context, '/entities');
                } else if (cmd.contains('progreso')) {
                  Navigator.pushNamed(context, '/progreso');
                } else if (cmd.contains('enseñanza')) {
                  Navigator.pushNamed(context, '/ensenanza');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('No entendí esa opción. Intenta de nuevo.'),
                    ),
                  );
                }
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cerrar sesión'),
        content: const Text('¿Estás seguro de que deseas cerrar sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF795548),
              foregroundColor: Colors.white,
            ),
            child: const Text('Cerrar sesión'),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton(
      BuildContext context, IconData icon, String label, bool isMobile) {
    return ElevatedButton(
      onPressed: () {
        if (label == 'Simulacros') {
          Navigator.pushNamed(context, '/simulacros');
        } else if (label == 'Ver progreso') {
          Navigator.pushNamed(context, '/progreso');
        } else if (label == 'Zona de enseñanza') {
          Navigator.pushNamed(context, '/ensenanza');
        } else if (label == 'Consejos') {
          Navigator.pushNamed(context, '/consejos');
        } else if (label == 'Entidades Oficiales') {
          Navigator.pushNamed(context, '/entities');
        } else {
          print('Botón presionado: $label');
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF795548),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.all(8),
        minimumSize: isMobile ? const Size(100, 100) : const Size(80, 80),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: isMobile ? 28 : 22),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 13 : 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
