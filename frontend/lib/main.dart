import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:protectic/screens/evaluacion_llamada_screen.dart';
import 'package:protectic/screens/llamada_entrante_screen.dart';
import 'package:protectic/screens/simulacro_call_real.dart';
import 'screens/preview_screen.dart';
import 'screens/home_screen.dart';
import 'screens/user_home_screen.dart';
import 'screens/simulacro_screen.dart';
import 'screens/progreso_screen.dart';
import 'screens/ensenanza_screen.dart';
import 'screens/entities_screen.dart';
import 'screens/consejos_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(); // Descomenta si usas Firebase
  runApp(ProtecTICApp());
}

class ProtecTICApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ProtecTIC',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: const Color(0xFFFDF6D8),
        fontFamily: 'Arial',
      ),
      debugShowCheckedModeBanner: false,
      home: const PreviewScreen(), // ← Pantalla de bienvenida
      // home: const UserHomeScreen(name: 'fabi'),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/user_home': (context) => const UserHomeScreen(name: 'Usuario'),
        '/consejos': (context) => const ConsejosScreen(),
        '/simulacros': (context) => const SimulacroScreen(),
        '/progreso': (context) => const ProgresoScreen(),
        '/ensenanza': (context) => const EnsenanzaScreen(),
        '/entities': (context) => const EntitiesScreen(),
        '/llamada-entrante': (_) => const LlamadaEntranteScreen(),
        '/simulacro-llamada': (_) => const SimulacroCallReal(),
        '/evaluacion-llamada': (context) {
          final args = ModalRoute.of(context)!.settings.arguments;
          final input = (args is String) ? args : '';
          return EvaluacionLlamadaScreen(pinIngresado: input);
        },
      },
    );
  }
}
