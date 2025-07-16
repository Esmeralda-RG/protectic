import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'home_screen.dart';
import '../widgets/audio_voice_controls.dart';

class PreviewScreen extends StatefulWidget {
  const PreviewScreen({super.key});

  @override
  State<PreviewScreen> createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  final FlutterTts flutterTts = FlutterTts();

  final String audioText =
      "Bienvenido a ProtecTIC. Esta es una aplicación diseñada para ayudarte a identificar y evitar ciberestafas. "
      "Haz clic en empezar o di empezar para continuar.";

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    _controller.forward();

    _speakIntro();
  }

  Future<void> _speakIntro() async {
    await flutterTts.setLanguage("es-ES");
    await flutterTts.setPitch(1.1);
    await flutterTts.speak(audioText);
  }

  void _goToHome() {
    flutterTts.stop();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C1B14),
      body: Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            padding: const EdgeInsets.all(24),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: const Color(0xFFFDF6D8),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black45,
                  offset: Offset(0, 8),
                  blurRadius: 16,
                )
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Bienvenido a ProtecTIC',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3E2723),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Image.asset('assets/logo.png', height: 150),
                  const SizedBox(height: 24),
                  const Text(
                    'ProtecTIC es una aplicación diseñada para educar, prevenir y acompañar a las personas en el uso seguro de la tecnología. '
                    'Su objetivo es ayudarte a identificar y evitar ciberestafas de manera sencilla y accesible.',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 28),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF795548),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'EMPEZAR',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    onPressed: _goToHome,
                  ),
                  const SizedBox(height: 24),
                  AudioVoiceControls(
                    audioText: audioText,
                    onVoiceCommand: (command) {
                      final cmd = command.toLowerCase();
                      if (cmd.contains("empezar") || cmd.contains("continuar")) {
                        _goToHome();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
