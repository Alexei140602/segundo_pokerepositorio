import 'package:flutter/material.dart';
import 'views/menu_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokémon Style Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MenuView(), // Esta es tu pantalla de menú
      debugShowCheckedModeBanner: false,
    );
  }
}