import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemonpro/source/pokemon.dart';
import '../source/movimientos.dart';
import '../source/pelea.dart';
import '../source/pokemones.dart';
import 'dart:math';

import '../source/AudioManager.dart';

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
  void initState() {
    super.initState();
    AudioManager().playBackgroundMusic("audio/menu_theme.mp3");
  }

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
              AudioManager().playBackgroundMusic("audio/battle_theme.mp3");

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BattleView(
                    equipoAliado: generarEquipo(),
                    equipoEnemigo: generarEquipo(),
                  ),
                ),
              ).then((_) {
                AudioManager().playBackgroundMusic("audio/menu_theme.mp3");
              });
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
  bool mostrandoMovimientos = false;
  List<Movimiento> movimientosDisponibles = [];
  String mensajeBatalla = '';
  bool mostrandoMensaje = false;
  int vidaAliado = 100;
  int vidaEnemigo = 100;
  bool batallaActiva = true;
  bool turnoEnProgreso = false; 


  final Map<int, String> nombresTipos = {
    1: 'Normal',
    2: 'Fuego',
    3: 'Agua',
    4: 'Eléctrico',
    5: 'Planta',
    6: 'Hielo',
    7: 'Lucha',
    8: 'Veneno',
    9: 'Tierra',
    10: 'Volador',
    11: 'Psíquico',
    12: 'Bicho',
    13: 'Roca',
    14: 'Fantasma',
    15: 'Dragón',
    16: 'Siniestro',
    17: 'Acero',
  };

  
  final Map<int, Color> coloresTipo = {
    1: Colors.grey,
    2: Colors.red,
    3: Colors.blue,
    4: Colors.yellow[700]!,
    5: Colors.green,
    6: Colors.cyan,
    7: Colors.orange,
    8: Colors.purple,
    9: Colors.brown,
    10: Colors.lightBlue,
    11: Colors.pink,
    12: Colors.lightGreen,
    13: Colors.brown[300]!,
    14: Colors.deepPurple,
    15: Colors.indigo,
    16: Colors.grey[800]!,
    17: Colors.grey[500]!,
  };

  double menuWidth = 300;
  double menuHeight = 90;
  double buttonFontSize = 7;
  double iconSize = 14;
  double menuPadding = 4;
  double horizontalSpacing = 4;
  double verticalSpacing = 4;
  double borderRadius = 6;
  double menuBottom = 20;
  double menuLeft = 20;

  @override
  void initState() {
    super.initState();
    _cargarPokemons();
    _generarMovimientosAleatorios();
    _inicializarVidas();
  }

  void _cargarPokemons() {
    if (widget.equipoAliado.isNotEmpty) {
      pokemonAliado = obtenerPokemonPorId(widget.equipoAliado[0]);
    }
    
    if (widget.equipoEnemigo.isNotEmpty) {
      pokemonEnemigo = obtenerPokemonPorId(widget.equipoEnemigo[0]);
    }
  }

  void _inicializarVidas() {
    if (pokemonAliado != null) {
      vidaAliado = pokemonAliado!.vidaActual; 
    }
    if (pokemonEnemigo != null) {
      vidaEnemigo = pokemonEnemigo!.vidaActual; 
    }
  }

  void _generarMovimientosAleatorios() {
    final idsMovimientos = Movimientos().generarMovimientosAleatorios();
    
    movimientosDisponibles = idsMovimientos
        .map((id) => Movimientos.porId(id) ?? Movimiento(
          id: 0,
          nombre: "Movimiento Desconocido",
          tipo: 1, 
          poder: 50,
          descripcion: "Movimiento básico",
          estadoAlterado: 0,
        ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final nombreAliado = pokemonAliado?.nombre ?? 'MissingNo';
    final nombreEnemigo = pokemonEnemigo?.nombre ?? 'MissingNo';
    final vidaMaxAliado = pokemonAliado?.vidaMax ?? 100;
    final vidaMaxEnemigo = pokemonEnemigo?.vidaMax ?? 100;
    
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/sprites/menu/fondocombate.png',
              fit: BoxFit.cover,
            ),
          ),
          
          Positioned(
            top: 20,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
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
          
         
          Positioned(
            top: 50, 
            right: 50,
            child: Column(
              children: [
                Text(
                  nombreEnemigo,
                  style: GoogleFonts.pressStart2p(
                    fontSize: 12,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 4,
                        color: Colors.black,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
               
                Container(
                  width: 200,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Stack(
                    children: [
                    
                      Container(
                        width: 200,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      
                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        width: 200 * (vidaEnemigo / vidaMaxEnemigo),
                        height: 20,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.red,
                              Colors.orange,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                   
                      Center(
                        child: Text(
                          'HP: $vidaEnemigo/$vidaMaxEnemigo',
                          style: GoogleFonts.pressStart2p(
                            fontSize: 8,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 200,
                  height: 200,
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
              ],
            ),
          ),
          
         //Pokemon aliado
          Positioned(
            bottom: 200,
            left: 450,
            child: Column(
              children: [
                Text(
                  nombreAliado,
                  style: GoogleFonts.pressStart2p(
                    fontSize: 12,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 4,
                        color: Colors.black,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  width: 200,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        width: 200,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        width: 200 * (vidaAliado / vidaMaxAliado),
                        height: 20,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.green,
                              Colors.lightGreen,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Center(
                        child: Text(
                          'HP: $vidaAliado/$vidaMaxAliado',
                          style: GoogleFonts.pressStart2p(
                            fontSize: 8,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 200,
                  height: 200,
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
              ],
            ),
          ),
          
          // mensajes de pelea
          if (mostrandoMensaje && mensajeBatalla.isNotEmpty)
            Positioned(
              top: MediaQuery.of(context).size.height / 3,
              left: 50,
              right: 50,
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.yellow, width: 3),
                ),
                child: Text(
                  mensajeBatalla,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.pressStart2p(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          
          // menu de seleccion de movimientos
          if (batallaActiva && !turnoEnProgreso) 
            Positioned(
              bottom: menuBottom,
              left: menuLeft,
              right: menuLeft,
              child: Center(
                child: mostrandoMovimientos
                    ? _buildSeleccionMovimientos()
                    : Container(
                        width: menuWidth,
                        height: menuHeight,
                        padding: EdgeInsets.all(menuPadding),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(borderRadius),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: _buildMenuCombate(),
                      ),
              ),
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

  // menu de combate
  Widget _buildMenuCombate() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: horizontalSpacing / 2),
                  child: _buildBotonCombate(
                    texto: 'ATACAR',
                    icono: Icons.bolt,
                    color: Colors.red,
                    onTap: () {
                      if (!mostrandoMensaje) {
                        setState(() {
                          mostrandoMovimientos = true;
                        });
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: horizontalSpacing / 2),
                  child: _buildBotonCombate(
                    texto: 'CAMBIAR',
                    icono: Icons.swap_horiz,
                    color: Colors.blue,
                    onTap: () {
                      _mostrarMensaje('Cambio de Pokémon no implementado');
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(height: verticalSpacing),
        
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: horizontalSpacing / 2),
                  child: _buildBotonCombate(
                    texto: 'MOCHILA',
                    icono: Icons.backpack,
                    color: Colors.green,
                    onTap: () {
                      _mostrarMensaje('Mochila no implementada');
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: horizontalSpacing / 2),
                  child: _buildBotonCombate(
                    texto: 'HUIDA',
                    icono: Icons.exit_to_app,
                    color: Colors.orange,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // menu de seleccion de movimientos
  Widget _buildSeleccionMovimientos() {
    return Container(
      width: menuWidth * 1.5,
      height: menuHeight * 1.8,
      padding: EdgeInsets.all(menuPadding * 2),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: Colors.black, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'SELECCIONAR MOVIMIENTO',
            style: GoogleFonts.pressStart2p(
              fontSize: 8,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
              childAspectRatio: 2.5,
              children: movimientosDisponibles
                  .asMap()
                  .entries
                  .map((entry) => _buildBotonMovimiento(entry.value, entry.key))
                  .toList(),
            ),
          ),
          
          SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              setState(() {
                mostrandoMovimientos = false;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_back, color: Colors.white, size: 12),
                  SizedBox(width: 6),
                  Text(
                    'VOLVER',
                    style: GoogleFonts.pressStart2p(
                      fontSize: 7,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // botones de movimientos
  Widget _buildBotonMovimiento(Movimiento movimiento, int index) {
    final tipoNombre = nombresTipos[movimiento.tipo] ?? 'Normal';
    final color = coloresTipo[movimiento.tipo] ?? Colors.grey;
    
    // Icono según estado alterado
    IconData? estadoIcono;
    Color estadoColor = Colors.white;
    
    switch (movimiento.estadoAlterado) {
      case 1: // Veneno
        estadoIcono = Icons.water_drop;
        estadoColor = Colors.purple;
        break;
      case 2: // Quemado
        estadoIcono = Icons.local_fire_department;
        estadoColor = Colors.orange;
        break;
      case 3: // Parálisis
        estadoIcono = Icons.bolt;
        estadoColor = Colors.yellow;
        break;
    }
    
    return GestureDetector(
      onTap: () {
        _ejecutarAtaque(movimiento);
      },
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.9),
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: Colors.black, width: 1.5),
        ),
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      movimiento.nombre,
                      style: GoogleFonts.pressStart2p(
                        fontSize: 6,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (estadoIcono != null)
                    Icon(estadoIcono, color: estadoColor, size: 10),
                ],
              ),
              SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tipoNombre,
                    style: GoogleFonts.pressStart2p(
                      fontSize: 5,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'PWR: ${movimiento.poder}',
                    style: GoogleFonts.pressStart2p(
                      fontSize: 5,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
                Text(
                _acortarDescripcion(movimiento.descripcion),
                style: GoogleFonts.pressStart2p(
                  fontSize: 4,
                  color: Colors.white.withOpacity(0.9),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _acortarDescripcion(String descripcion) {
    if (descripcion.length <= 20) return descripcion;
    return '${descripcion.substring(0, 17)}...';
  }

  // Funcion que ejecuta el proceso de ataque, conectado con pelea.dart
  void _ejecutarAtaque(Movimiento movimientoAliado) {
    if (pokemonAliado == null || pokemonEnemigo == null || !batallaActiva || turnoEnProgreso) return;
    
    setState(() {
      mostrandoMovimientos = false;
      mostrandoMensaje = true;
      turnoEnProgreso = true;
    });
    
    _procesarTurnoBatalla(movimientoAliado);
  }
  
  void _procesarTurnoBatalla(Movimiento movimientoAliado) async {
    try {
      // 1. Genera un movimiento aleatorio para el rival
      Movimiento movimientoEnemigo = movimientosDisponibles[Random().nextInt(movimientosDisponibles.length)];
      
      // 2. Mensaje del ataque aliado
      setState(() {
        mensajeBatalla = '¡${pokemonAliado!.nombre} usó ${movimientoAliado.nombre}!';
      });
      await Future.delayed(Duration(milliseconds: 1000));
      
      // 3. Ejecuta pelea.dart
      final pelea = Pelea(
        pokemonAliado!.id,
        pokemonEnemigo!.id,
        movimientoAliado.id,
        movimientoEnemigo.id,
      );
      
      // 4. Mensaje del ataque enemigo
      setState(() {
        mensajeBatalla = '¡${pokemonEnemigo!.nombre} usó ${movimientoEnemigo.nombre}!';
      });
      await Future.delayed(Duration(milliseconds: 1000));
      
      // 5. Acutualiza barras de vida
      setState(() {
        vidaAliado = pelea.vidaPoke1;
        vidaEnemigo = pelea.vidaPoke2;

        if (pokemonAliado != null) {
          pokemonAliado!.vidaActual = vidaAliado;
        }
        if (pokemonEnemigo != null) {
          pokemonEnemigo!.vidaActual = vidaEnemigo;
        }
        
        // Mensjades de daño
        String mensaje = '${pokemonAliado!.nombre}: $vidaAliado HP\n';
        mensaje += '${pokemonEnemigo!.nombre}: $vidaEnemigo HP\n';
        
        if (pelea.danoPoke2 > 0) {
          mensaje += '\n${pokemonEnemigo!.nombre} recibió ${pelea.danoPoke2} de daño';
        }
        if (pelea.danoPoke1 > 0) {
          mensaje += '\n${pokemonAliado!.nombre} recibió ${pelea.danoPoke1} de daño';
        }
        
        // Mensajes de estados
        if (pelea.estadoPoke1 > 0) {
          mensaje += '\n${pokemonAliado!.nombre} ${_getEstadoTexto(pelea.estadoPoke1)}';
        }
        if (pelea.estadoPoke2 > 0) {
          mensaje += '\n${pokemonEnemigo!.nombre} ${_getEstadoTexto(pelea.estadoPoke2)}';
        }
        
        mensajeBatalla = mensaje;
      });
      
      await Future.delayed(Duration(seconds: 4));
      
      // 6. Verificar si la batalla terminó
      if (vidaAliado <= 0 || vidaEnemigo <= 0) {
        _finalizarBatalla(pelea);
      } else {
        // Continuar la batalla
        setState(() {
          mostrandoMensaje = false;
          turnoEnProgreso = false;
        });
      }
    //verifica si no hubo problemas en la pelea (errores)
    } catch (e) {
      print('Error en la pelea: $e');
      setState(() {
        mensajeBatalla = 'Error: $e';
        mostrandoMensaje = false;
        turnoEnProgreso = false;
      });
    }
  }
  
  void _finalizarBatalla(Pelea pelea) {
    String mensajeFinal;
    
    if (pelea.poke1Debilitado && pelea.poke2Debilitado) {
      mensajeFinal = '¡Empate! Ambos Pokémon se debilitaron.';
    } else if (pelea.poke1Debilitado) {
      mensajeFinal = '¡${pelea.poke1.nombre} se debilitó!\n¡Has perdido la batalla!';
    } else {
      mensajeFinal = '¡${pelea.poke2.nombre} se debilitó!\n¡Has ganado la batalla!';
    }
    
    setState(() {
      mensajeBatalla = mensajeFinal;
      batallaActiva = false;
      turnoEnProgreso = false;
    });
    
    // Mostrar diálogo después de un teimpo
    Future.delayed(Duration(seconds: 4), () {
      if (mounted) {
        _mostrarDialogoFinBatalla(mensajeFinal);
      }
    });
  }
  
  void _mostrarDialogoFinBatalla(String mensaje) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black.withOpacity(0.9),
        title: Text(
          'FIN DE LA BATALLA',
          style: GoogleFonts.pressStart2p(
            fontSize: 12,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        content: Text(
          mensaje,
          style: GoogleFonts.pressStart2p(
            fontSize: 10,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.pop(context); // Cerrar diálogo
                Navigator.pop(context); // Volver al menú principal
              },
              child: Text(
                'VOLVER AL MENÚ',
                style: GoogleFonts.pressStart2p(
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  String _getEstadoTexto(int estado) {
    switch (estado) {
      case 1: return 'fue envenenado';
      case 2: return 'fue quemado';
      case 3: return 'fue paralizado';
      default: return '';
    }
  }

  void _mostrarMensaje(String mensaje) {
    setState(() {
      mensajeBatalla = mensaje;
      mostrandoMensaje = true;
    });
    
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          mostrandoMensaje = false;
        });
      }
    });
  }

  Widget _buildBotonCombate({
    required String texto,
    required IconData icono,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius - 2),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icono, 
                color: Colors.white, 
                size: iconSize,
              ),
              SizedBox(width: 3),
              Flexible(
                child: Text(
                  texto,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.pressStart2p(
                    fontSize: buttonFontSize,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}