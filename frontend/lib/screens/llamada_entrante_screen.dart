import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:audioplayers/audioplayers.dart';

class LlamadaEntranteScreen extends StatefulWidget {
  const LlamadaEntranteScreen({super.key});

  @override
  State<LlamadaEntranteScreen> createState() => _LlamadaEntranteScreenState();
}

class _LlamadaEntranteScreenState extends State<LlamadaEntranteScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _iniciarVibracion();
    _iniciarSonido();
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _iniciarVibracion() async {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate(duration: 1000);
    }
  }

  void _iniciarSonido() async {
    await _audioPlayer.play(
      AssetSource('sounds/ringtone.mp3'),
      volume: 1.0,
    );
  }

  void _contestarLlamada() {
    _audioPlayer.stop();
    Navigator.pushReplacementNamed(context, '/simulacro-llamada');
  }

  void _rechazarLlamada() {
    _audioPlayer.stop();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person_outline, size: 60, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text(
              'Número desconocido',
              style: TextStyle(color: Colors.white, fontSize: 28),
            ),
            const SizedBox(height: 10),
            const Text(
              'Llamada entrante...',
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: 'contestar',
                  onPressed: _contestarLlamada,
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.call),
                ),
                FloatingActionButton(
                  heroTag: 'colgar',
                  onPressed: _rechazarLlamada,
                  backgroundColor: Colors.red,
                  child: const Icon(Icons.call_end),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
