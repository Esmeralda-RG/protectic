import 'package:flutter/material.dart';
import 'package:protectic/widgets/section_title.dart';
import '../widgets/audio_voice_controls.dart';
import '../services/tts_service.dart';
import '../widgets/custom_home_button.dart';

class SimulationCallIntroScreen extends StatefulWidget {
  const SimulationCallIntroScreen({super.key});

  @override
  State<SimulationCallIntroScreen> createState() =>
      _SimulationCallIntroScreenState();
}

class _SimulationCallIntroScreenState extends State<SimulationCallIntroScreen> {
  final TtsService _ttsService = TtsService();

  final String _introTextoCompleto =
      'En este simulacro aprenderás a identificar llamadas telefónicas falsas que buscan engañarte. '
      'Podrían intentar asustarte, pedirte información personal o dinero. '
      'Escucha con atención. '
      'Cuando estés listo, presiona el botón o di iniciar para comenzar.';

  final String _introTextoCorto =
      'En este simulacro aprenderás a identificar llamadas telefónicas falsas que buscan engañarte. '
      'Cuando estés listo, presiona el botón o di iniciar para comenzar.';

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      _ttsService.speak(_introTextoCorto);
    });
  }

  void _iniciarSimulacro() async {
    await _ttsService.stop();
    Navigator.pushNamed(context, '/llamada-entrante');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simulacro de llamada'),
        backgroundColor: const Color(0xFF795548),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            const SectionTitle('Simulacro de llamada telefónica'),
            const SizedBox(height: 24),
            const Text(
              'En este simulacro aprenderás a identificar llamadas telefónicas falsas que buscan engañarte.',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Estas llamadas pueden intentar asustarte o presionarte para obtener información personal, como contraseñas o datos bancarios.',
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            const Text(
              'Cuando estés listo, presiona el botón o usa un comando de voz para comenzar.',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Center(
              child: CustomHomeButton(
                text: 'Iniciar simulacro',
                onPressed: _iniciarSimulacro,
              ),
            ),
            const SizedBox(height: 24),
            AudioVoiceControls(
              audioText: _introTextoCompleto,
              onVoiceCommand: (command) {
                final cmd = command.toLowerCase();
                if (cmd.contains('iniciar') ||
                    cmd.contains('comenzar') ||
                    cmd.contains('empezar')) {
                  _iniciarSimulacro();
                }
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
