import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemonpro/source/pokemon.dart';
import '../source/movimientos.dart';
import '../source/pelea.dart';
import '../source/pokemones.dart';
import 'dart:math';

// Remueve estos imports si causan problemas con dart:ffi
// o hazlos condicionales

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  int selectedIndex = 0;
  String fondo = 'assets/sprites/menu/background_menu.png';
  bool mostrarMochila = false;
  int pokemonSeleccionado = -1;

  final List<String> pokemones = [
    'tyranitar',
    'charizard',
    'pidgeot',
    'squirtle',
    'tsareena',
    'pachirisu',
    'glaceon',
    'hawlucha',
    'drapion',
    'cubone',
    'dragonite',
    'latias',
    'heracross',
    'chandelure',
    'garchomp',
    'mimikyu',
    'metagross'
  ];

  @override
  Widget build(BuildContext context) {
    if (mostrarMochila) {
      if (pokemonSeleccionado == -1) {
        return _buildMochilaLista();
      } else {
        return _buildPokemonDetalle();
      }
    }

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double screenW = constraints.maxWidth;
          final double screenH = constraints.maxHeight;

          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  fondo,
                  fit: BoxFit.cover,
                ),
              ),
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
                      color: const Color(0xFFFFFF00),
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
          setState(() {
            selectedIndex = index;
            if (index == 0) {
              // Navegar a la pantalla de combate
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BattleView(
                    // Pasar Pokémon reales
                    equipoAliado: generarEquipo(),
                    equipoEnemigo: generarEquipo(),
                  ),
                ),
              );
            } else {
              mostrarMochila = true;
              pokemonSeleccionado = -1;
            }
          });
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

  List<int> generarEquipo() {
    Random random = Random();
    List<int> equipo = [];

    while (equipo.length < 3) {
      int numeroAleatorio = random.nextInt(17) + 1;
      if (!equipo.contains(numeroAleatorio)) {
        equipo.add(numeroAleatorio);
      }
    }
    return equipo;
  }

  Widget _buildMochilaLista() {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/sprites/menu/background_menu.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "MOCHILA",
                style: GoogleFonts.pressStart2p(
                  fontSize: 20,
                  color: Colors.white,
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
          Positioned(
            top: 100,
            left: 20,
            right: 20,
            bottom: 80,
            child: ListView.builder(
              itemCount: pokemones.length,
              itemBuilder: (context, index) {
                return _buildItemPokemon(index);
              },
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: _buildBotonRegresar(
              onTap: () {
                setState(() {
                  mostrarMochila = false;
                });
              },
              texto: "VOLVER",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPokemonDetalle() {
    String nombrePokemon = pokemones[pokemonSeleccionado];
    
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/sprites/menu/background_menu.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: (MediaQuery.of(context).size.width * 0.8) * 9 / 16,
                  child: Image.asset(
                    'assets/menu/mochila/M${nombrePokemon.toLowerCase()}.png',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey,
                        child: Center(
                          child: Text(
                            'No se encontró\n$nombrePokemon',
                            style: GoogleFonts.pressStart2p(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  nombrePokemon.toLowerCase(),
                  style: GoogleFonts.pressStart2p(
                    fontSize: 18,
                    color: Colors.white,
                    shadows: const [
                      Shadow(
                        blurRadius: 8,
                        color: Colors.black,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: _buildBotonRegresar(
              onTap: () {
                setState(() {
                  pokemonSeleccionado = -1;
                });
              },
              texto: "VOLVER",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemPokemon(int index) {
    String nombrePokemon = pokemones[index];
    
    return GestureDetector(
      onTap: () {
        setState(() {
          pokemonSeleccionado = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.black, width: 1),
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: GoogleFonts.pressStart2p(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                nombrePokemon.toLowerCase(),
                style: GoogleFonts.pressStart2p(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
          ],
        ),
      ),
    );
  }

  Widget _buildBotonRegresar({required VoidCallback onTap, required String texto}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: Text(
          texto,
          style: GoogleFonts.pressStart2p(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

// NUEVA CLASE PARA LA PANTALLA DE COMBATE - SOLUCIÓN CORREGIDA
class BattleView extends StatefulWidget {
  final List<int> equipoAliado;
  final List<int> equipoEnemigo;

  const BattleView({
    super.key,
    required this.equipoAliado,
    required this.equipoEnemigo,
  });

  @override
  State<BattleView> createState() => _BattleViewState();
}

class _BattleViewState extends State<BattleView> {
  Pokemon? pokemonAliado;
  Pokemon? pokemonEnemigo;

  @override
  void initState() {
    super.initState();
    _cargarPokemons();
  }

  void _cargarPokemons() {
    // Cargar Pokémon aliado
    if (widget.equipoAliado.isNotEmpty) {
      pokemonAliado = obtenerPokemonPorId(widget.equipoAliado[0]);
    }
    
    // Cargar Pokémon enemigo
    if (widget.equipoEnemigo.isNotEmpty) {
      pokemonEnemigo = obtenerPokemonPorId(widget.equipoEnemigo[0]);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Si los Pokémon son null, mostrar placeholders
    final nombreAliado = pokemonAliado?.nombre ?? 'MissingNo';
    final nombreEnemigo = pokemonEnemigo?.nombre ?? 'MissingNo';
    
    return Scaffold(
      body: Stack(
        children: [
          // FONDO DE COMBATE
          Positioned.fill(
            child: Image.asset(
              'assets/sprites/menu/fondocombate.png',
              fit: BoxFit.cover,
            ),
          ),
          
          // BOTÓN PARA REGRESAR AL MENÚ PRINCIPAL (ESQUINA SUPERIOR IZQUIERDA)
          Positioned(
            top: 20,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context); // Regresar al menú principal
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 6,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back, color: Colors.white, size: 18),
                    SizedBox(width: 8),
                    Text(
                      'REGRESAR',
                      style: GoogleFonts.pressStart2p(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Pokémon ENEMIGO
          Positioned(
            top: 150,
            right: 300,
            child: Container(
              width: 480,
              height: 480,
              child: pokemonEnemigo != null
                  ? Image.asset(
                      '/sprites/pokemon/${pokemonEnemigo!.nombre}.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildPlaceholder(nombreEnemigo);
                      },
                    )
                  : _buildPlaceholder(nombreEnemigo),
            ),
          ),
          
          // Pokémon ALIADO
          Positioned(
            bottom: 150,
            left: 270,
            child: Container(
              width: 480,
              height: 480,
              child: pokemonAliado != null
                  ? Image.asset(
                      '/sprites/pokemon/${pokemonAliado!.nombre}.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildPlaceholder(nombreAliado);
                      },
                    )
                  : _buildPlaceholder(nombreAliado),
            ),
          ),
          
          // Menú de opciones de combate
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: _buildMenuCombate(context),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder(String nombre) {
    return Container(
      color: Colors.grey[300],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.question_mark, size: 50, color: Colors.black54),
            Text(
              nombre.toLowerCase(),
              style: GoogleFonts.pressStart2p(
                fontSize: 10,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCombate(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black, width: 3),
      ),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        padding: EdgeInsets.all(10),
        childAspectRatio: 2.5,
        children: [
          _buildBotonCombate('ATACAR', Icons.bolt, Colors.red, () {
            // Lógica de ataque
          }),
          _buildBotonCombate('CAMBIAR', Icons.swap_horiz, Colors.blue, () {
            // Lógica cambiar Pokémon
          }),
          _buildBotonCombate('MOCHILA', Icons.backpack, Colors.green, () {
            // Lógica usar item
          }),
          _buildBotonCombate('HUIDA', Icons.exit_to_app, Colors.orange, () {
            Navigator.pop(context);
          }),
        ],
      ),
    );
  }

  Widget _buildBotonCombate(String texto, IconData icono, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icono, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text(
              texto,
              style: GoogleFonts.pressStart2p(
                fontSize: 10,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}