import 'package:flutter/material.dart';
import 'package:pokemonpro/views/menu_view.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokémon Battle',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MenuView(), // Ahora debería funcionar, sino me doy un tiro
    );
  }
}