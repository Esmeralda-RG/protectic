import 'package:flutter/material.dart';
import '../widgets/audio_voice_controls.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ConsejosScreen extends StatefulWidget {
  const ConsejosScreen({super.key});

  @override
  State<ConsejosScreen> createState() => _ConsejosScreenState();
}

class _ConsejosScreenState extends State<ConsejosScreen> {
  final FlutterTts _flutterTts = FlutterTts();

  final Map<String, bool> _checks = {
    'Lo que publicas en redes puede ser usado para estafarte.': false,
    'Desconfía de mensajes o llamadas que te piden datos personales.': false,
    'Nunca hagas clic en enlaces sospechosos o de números desconocidos.': false,
    'No compartas códigos de verificación con nadie, ni con “soporte técnico”.': false,
    'Si te sientes mal por haber sido estafado, no te culpes.': false,
    'El miedo, la prisa o la confianza excesiva te vuelven más vulnerable.': false,
    'Habla con tus hijos o nietos si tienes dudas, no es motivo de vergüenza.': false,
    'Si un amigo fue estafado, escúchalo y ayúdalo a reportar sin juzgar.': false,
  };

  bool _modalMostrado = false;

  @override
  Widget build(BuildContext context) {
    final int total = _checks.length;
    final int marcados = _checks.values.where((val) => val).length;
    final double progreso = marcados / total;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F4D3),
      appBar: AppBar(
        title: const Text('Consejos'),
        backgroundColor: const Color(0xFF795548),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: LinearProgressIndicator(
              value: progreso,
              backgroundColor: Colors.brown.shade100,
              color: const Color(0xFF795548),
              minHeight: 10,
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildSection(
                  title: 'Prevención de fraudes digitales',
                  icon: Icons.lightbulb_outline,
                  consejos: _checks.keys.toList().sublist(0, 3),
                ),
                _buildSection(
                  title: 'Comportamiento seguro',
                  icon: Icons.verified_user,
                  consejos: [_checks.keys.elementAt(3)],
                ),
                _buildSection(
                  title: 'Bienestar emocional',
                  icon: Icons.favorite,
                  consejos: _checks.keys.toList().sublist(4, 6),
                ),
                _buildSection(
                  title: 'Consejos familiares y comunitarios',
                  icon: Icons.group,
                  consejos: _checks.keys.toList().sublist(6),
                ),
                const SizedBox(height: 40),
                AudioVoiceControls(
                  audioText: 'Puedes decir: “marcar todo”, “desmarcar todo”, o decir una frase para marcar un consejo específico.',
                  onVoiceCommand: (command) {
                    final cmd = command.toLowerCase();
                    setState(() {
                      if (cmd.contains('marcar todo')) {
                        _checks.updateAll((key, value) => true);
                      } else if (cmd.contains('desmarcar todo')) {
                        _checks.updateAll((key, value) => false);
                      } else {
                        _checks.forEach((key, value) {
                          if (cmd.contains(key.toLowerCase().split(' ').first)) {
                            _checks[key] = true;
                          }
                        });
                      }
                      _verificarProgreso();
                    });
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<String> consejos,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: const Color(0xFF795548)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF795548),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...consejos.map((texto) => CheckboxListTile(
                  value: _checks[texto],
                  onChanged: (val) {
                    setState(() {
                      _checks[texto] = val!;
                      _verificarProgreso();
                    });
                  },
                  title: Text(texto, style: const TextStyle(fontSize: 16)),
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: const Color(0xFF795548),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                )),
          ],
        ),
      ),
    );
  }

  void _verificarProgreso() {
    final bool todosMarcados = _checks.values.every((v) => v);
    if (todosMarcados && !_modalMostrado) {
      _modalMostrado = true;
      _mostrarModalCompletado();
      _guardarProgresoUsuario();
    }
  }

  void _mostrarModalCompletado() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.verified, color: Color(0xFF795548), size: 60),
              const SizedBox(height: 16),
              const Text(
                '¡Felicidades!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF795548),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Completaste todos los consejos.\nEstás más preparado para prevenir estafas.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 6),
                  Text('1. Leído'),
                  SizedBox(width: 6),
                  Icon(Icons.arrow_forward_ios, size: 12),
                  SizedBox(width: 6),
                  Icon(Icons.school, color: Colors.grey),
                  SizedBox(width: 6),
                  Text('2. Practicar'),
                  SizedBox(width: 6),
                  Icon(Icons.arrow_forward_ios, size: 12),
                  SizedBox(width: 6),
                  Icon(Icons.shield, color: Colors.grey),
                  SizedBox(width: 6),
                  Text('3. Proteger'),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _flutterTts.speak(
                      'Completaste todos los consejos. Estás más preparado para prevenir estafas.',
                    ),
                    icon: const Icon(Icons.volume_up),
                    label: const Text('Escuchar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.check),
                    label: const Text('Leer'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _guardarProgresoUsuario() {
    debugPrint('✅ Progreso guardado aqui se conecta la data en la db');
  }
}
