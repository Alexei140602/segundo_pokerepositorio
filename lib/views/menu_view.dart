import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double screenW = constraints.maxWidth;
          final double screenH = constraints.maxHeight;

          return Stack(
            children: [
              // Fondo
              Positioned.fill(
                child: Image.asset(
                  'assets/sprites/menu/background_menu.png',
                  fit: BoxFit.cover,
                ),
              ),

              // Menu de opciones estilo videojuego (horizontal)
              Positioned(
                top: screenH * 0.52,
                left: screenW * 0.5 - 150,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildMenuItem(0, "LUCHA"),
                    const SizedBox(width: 40),
                    _buildMenuItem(1, "MOCHILA"),
                  ],
                ),
              ),

              // Triángulo selector
              Positioned(
                top: screenH * 0.52 + 5,
                left: screenW * 0.5 - 165 + (selectedIndex * 140),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 150),
                  child: Text(
                    "▶",
                    key: ValueKey(selectedIndex),
                    style: GoogleFonts.pressStart2p(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFFFFFF00), // Amarillo
                      shadows: const [
                        Shadow(
                          blurRadius: 6,
                          color: Colors.black,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMenuItem(int index, String text) {
    return MouseRegion(
      onEnter: (_) => setState(() => selectedIndex = index),
      child: GestureDetector(
        onTap: () {
          setState(() => selectedIndex = index);
          debugPrint("$text seleccionada");
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Text(
            text,
            style: GoogleFonts.pressStart2p(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
              color: selectedIndex == index ? const Color(0xFFFFFF00) : Colors.white,
              shadows: const [
                Shadow(
                  blurRadius: 8,
                  color: Colors.black,
                  offset: Offset(3, 3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}