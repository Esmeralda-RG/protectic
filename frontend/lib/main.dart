import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

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
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
