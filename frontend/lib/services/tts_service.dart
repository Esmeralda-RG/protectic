import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  final FlutterTts _flutterTts = FlutterTts();
  bool _isInitialized = false;

  Future<void> _initTts() async {
    if (_isInitialized) return;

    await _flutterTts.setLanguage('es-CO');
    await _flutterTts.setSpeechRate(0.6);
    await _flutterTts.setPitch(1.0);

    _isInitialized = true;
  }

  Future<void> speak(String text) async {
    await _initTts(); // Asegura configuración
    await _flutterTts.stop(); // Detén cualquier audio anterior
    await _flutterTts.speak(text);
  }

  Future<void> stop() async {
    await _flutterTts.stop();
  }
}
