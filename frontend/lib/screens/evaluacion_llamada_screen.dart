import 'package:flutter/material.dart';
import 'package:protectic/widgets/custom_home_button.dart';
import 'package:protectic/widgets/section_title.dart';

class EvaluacionLlamadaScreen extends StatelessWidget {
  final String pinIngresado;

  const EvaluacionLlamadaScreen({super.key, required this.pinIngresado});

  @override
  Widget build(BuildContext context) {
    final bool ingresoPin = pinIngresado.length == 4;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F4D3),
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF795548), width: 8),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top,
                  ),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SectionTitle('Resultado de la llamada'),
                          const SizedBox(height: 24),
                          Text(
                            ingresoPin
                                ? 'Ingresaste tu PIN. Esto es un error común que puede llevar al robo de tu información personal.'
                                : 'Decidiste colgar la llamada. ¡Bien hecho! Esa es la decisión correcta ante una posible estafa.',
                            style: const TextStyle(fontSize: 22),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            ingresoPin
                                ? 'Nunca compartas tu PIN ni claves por teléfono. Las entidades bancarias jamás solicitan esta información por llamada y siempre puedes verificar con la entidad correspondiente.'
                                : 'Recuerda: si una llamada suena sospechosa o te pide datos personales, cuelga y verifica con tu banco o entidad oficial.',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 32),
                          Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 300),
                              child: CustomHomeButton(
                                text: 'Consultar entidades oficiales',
                                onPressed: () {
                                  Navigator.pushNamed(context, '/entities');
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 300),
                              child: CustomHomeButton(
                                text: 'Volver a los simulacros',
                                onPressed: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/simulacros',
                                    (route) => false,
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
