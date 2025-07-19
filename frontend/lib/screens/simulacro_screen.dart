import 'package:flutter/material.dart';
import 'package:protectic/screens/simulation_call_intro_screen.dart';
import '../widgets/audio_voice_controls.dart';
import '../services/tts_service.dart';

class SimulacroScreen extends StatefulWidget {
  const SimulacroScreen({super.key});

  @override
  State<SimulacroScreen> createState() => _SimulacroScreenState();
}

class _SimulacroScreenState extends State<SimulacroScreen> {
  final TtsService _ttsService = TtsService();

  @override
  void initState() {
    super.initState();
    // Reproducir el mensaje apenas entra
    Future.delayed(const Duration(milliseconds: 300), () {
      _ttsService.speak(
        'Bienvenido a los simulacros. Elige el tipo de simulacro que deseas hacer. Puedes decir mensaje, correo o llamada para comenzar.',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simulacros'),
        backgroundColor: const Color(0xFF795548),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Elige el tipo de simulacro que deseas hacer:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            _buildSimulacroCard(
              context,
              title: 'Simulacro de mensaje de texto',
              description:
                  'Practica cómo detectar un mensaje falso que llega por WhatsApp o SMS. Estos mensajes pueden tener enlaces peligrosos.',
              icon: Icons.sms,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Simulacro de SMS en construcción')),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildSimulacroCard(
              context,
              title: 'Simulacro de correo electrónico',
              description:
                  'Aprende a identificar correos electrónicos falsos que intentan robar tus datos. Este tipo de ataque se llama "Phishing".',
              icon: Icons.email,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Simulacro de correo en construcción')),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildSimulacroCard(
              context,
              title: 'Simulacro de llamada telefónica',
              description:
                  'Descubre cómo reconocer una llamada falsa que intenta asustarte o pedirte datos personales o dinero.',
              icon: Icons.phone,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SimulationCallIntroScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 40),
            AudioVoiceControls(
              audioText:
                  'Bienvenido a los simulacros. Elige el tipo de simulacro que deseas hacer. Puedes decir mensaje, correo o llamada para comenzar.',
              onVoiceCommand: (command) {
                final cmd = command.toLowerCase();
                if (cmd.contains('mensaje') ||
                    cmd.contains('sms') ||
                    cmd.contains('texto')) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Simulacro de SMS en construcción')),
                  );
                } else if (cmd.contains('correo') || cmd.contains('email')) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Simulacro de correo en construcción')),
                  );
                } else if (cmd.contains('llamada') ||
                    cmd.contains('teléfono')) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SimulationCallIntroScreen(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            'No entendí esa opción. Intenta decir mensaje, correo o llamada.')),
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

  Widget _buildSimulacroCard(BuildContext context,
      {required String title,
      required String description,
      required IconData icon,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        color: const Color(0xFFF5F5F5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFF795548), width: 2),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 36, color: Color(0xFF795548)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
