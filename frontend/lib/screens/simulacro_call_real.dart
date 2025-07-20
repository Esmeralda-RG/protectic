import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import '../services/tts_service.dart';

class SimulacroCallReal extends StatefulWidget {
  const SimulacroCallReal({super.key});

  @override
  State<SimulacroCallReal> createState() => _SimulacroCallRealState();
}

class _SimulacroCallRealState extends State<SimulacroCallReal> {
  final TtsService _ttsService = TtsService();

  final String _mensajeFalso =
      'Hola, habla del Banco Nacional. Su cuenta ha sido comprometida. Para continuar, por favor ingrese el PIN de su tarjeta.';

  Timer? _timer;
  int _seconds = 0;
  String _input = '';

  @override
  void initState() {
    super.initState();
    _startTimer();
    Future.delayed(const Duration(milliseconds: 800), () {
      _ttsService.speak(_mensajeFalso);
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _onKeyPress(String value) {
    HapticFeedback.lightImpact();
    setState(() {
      _input += value;
    });
  }

  void _onBackspace() {
    HapticFeedback.selectionClick();
    if (_input.isNotEmpty) {
      setState(() {
        _input = _input.substring(0, _input.length - 1);
      });
    }
  }

  void _endCall() {
    _timer?.cancel();
    Navigator.pushNamed(
      context,
      '/evaluacion-llamada',
      arguments: _input,
    );
  }

  String _formatDuration(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  Widget _buildKeypad(double fontSize, double buttonSize) {
    final rows = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['*', '0', 'del'],
    ];

    return Table(
      children: rows.map((row) {
        return TableRow(
          children: row.map((key) {
            return Padding(
              padding: const EdgeInsets.all(6.0),
              child: SizedBox(
                height: buttonSize,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                    shape: const CircleBorder(),
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    if (key == 'del') {
                      _onBackspace();
                    } else {
                      _onKeyPress(key);
                    }
                  },
                  child: key == 'del'
                      ? Icon(Icons.backspace,
                          color: Colors.white, size: fontSize + 2)
                      : Text(
                          key,
                          style: TextStyle(
                              fontSize: fontSize, color: Colors.white),
                        ),
                ),
              ),
            );
          }).toList(),
        );
      }).toList(),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;

    final baseText = height * 0.02;
    final largeText = height * 0.035;
    final pinText = height * 0.045;
    final keypadFont = height * 0.035;
    final buttonSize = height * 0.09;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: height * 0.05,
                        backgroundColor: Colors.grey,
                        child: Icon(
                          Icons.person_outline,
                          size: height * 0.05,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Text(
                        'Número desconocido',
                        style:
                            TextStyle(color: Colors.white, fontSize: largeText),
                      ),
                      Text(
                        _formatDuration(_seconds),
                        style: TextStyle(
                            color: Colors.white70, fontSize: baseText),
                      ),
                      SizedBox(height: height * 0.015),
                      Text(
                        _input.isEmpty
                            ? ''
                            : _input.replaceAll(RegExp('.'), '•'),
                        style:
                            TextStyle(fontSize: pinText, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: _buildKeypad(keypadFont, buttonSize),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: FloatingActionButton(
                    onPressed: _endCall,
                    backgroundColor: Colors.red,
                    child: Icon(Icons.call_end,
                        color: Colors.white, size: height * 0.035),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
