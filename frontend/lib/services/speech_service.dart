import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechService {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isInitialized = false;

  Future<bool> initialize() async {
    _isInitialized = await _speech.initialize();
    return _isInitialized;
  }

  bool get isListening => _speech.isListening;

  Future<void> startListening(Function(String) onResult) async {
    if (!_isInitialized) await initialize();

    _speech.listen(
      onResult: (result) {
        final spokenText = result.recognizedWords.toLowerCase();
        onResult(spokenText);
      },
      localeId: 'es_CO',
    );
  }

  Future<void> stopListening() async {
    await _speech.stop();
  }

  Future<void> cancel() async {
    await _speech.cancel();
  }
}
