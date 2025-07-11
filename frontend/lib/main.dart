import 'package:flutter/material.dart';
import 'package:protectic/screens/entities_screen.dart';
import 'screens/home_screen.dart';
import 'screens/user_home_screen.dart';
import 'screens/simulacro_screen.dart';
import 'package:protectic/screens/progreso_screen.dart';
import 'screens/ensenanza_screen.dart';

void main() {
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
      // home: HomeScreen(),
      // Pantalla inicial
      home: const UserHomeScreen(name: 'fabi'),

      //  Aquí la ruta de Simulacros y otros del menu principal
      routes: {
        '/simulacros': (context) => const SimulacroScreen(),
        '/progreso': (context) => const ProgresoScreen(),
        '/ensenanza': (context) => const EnsenanzaScreen(),
        '/entities': (context) => const EntitiesScreen(),
      },
    );
  }
}
