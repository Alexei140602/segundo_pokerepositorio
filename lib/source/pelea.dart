import 'tablatipos.dart';
import 'dart:math';
import 'movimientos.dart';
import 'pokemon.dart';
import 'pokemones.dart';

class Pelea {
  late Pokemon _poke1;
  late Pokemon _poke2;
  final Movimiento _mov1;
  final Movimiento _mov2;
  
  int _danoPoke1 = 0;
  int _danoPoke2 = 0;
  int _estadoPoke1 = 0;
  int _estadoPoke2 = 0;
  
  // Constructor
  Pelea(int poke1id, int poke2id, int mov1id, int mov2id)
    : _mov1 = Movimientos.porId(mov1id)!,
      _mov2 = Movimientos.porId(mov2id)! {
    
    _inicializarPokemon(poke1id, poke2id);
    _ejecutarPelea();
  }
  
  void _inicializarPokemon(int poke1id, int poke2id) {
    final Pokemon? poketemporal1 = obtenerPokemonPorId(poke1id);
    final Pokemon? poketemporal2 = obtenerPokemonPorId(poke2id);
    
    //todo esto es para evitar que salga el error de que puede ser valor nulo
    if (poketemporal1 == null || poketemporal2 == null) {
      throw Exception('No se encontraron los Pokemon con IDs $poke1id y $poke2id');
    }
    
    // _poke1 siempre ataca primero, entonces depende de la velocidad
    if (poketemporal1.velocidad > poketemporal2.velocidad) {
      _poke1 = poketemporal1;
      _poke2 = poketemporal2;
    } else {
      _poke1 = poketemporal2;
      _poke2 = poketemporal1;
    }
    
    // Guardar estados iniciales
    _estadoPoke1 = _poke1.estado;
    _estadoPoke2 = _poke2.estado;
  }
  
  void _ejecutarPelea() {
    // Copiar valores para no modificar los originales
    int vidaPoke1 = _poke1.vidaActual;
    int vidaPoke2 = _poke2.vidaActual;
    int estadoPoke1 = _estadoPoke1;
    int estadoPoke2 = _estadoPoke2;
    
    // Primer ataque
    double resistencia = multiplicadorResistidoPor(_poke2.tipos ?? [], _mov1.tipo);
    double efectivo = multiplicadorSuperefectivoPor(_poke2.tipos ?? [], _mov1.tipo);
    bool fueinmune = false;
    int paralisis = Random().nextInt(21) + 80;
    
    if (inmune(_poke2.tipos ?? [], _mov1.tipo)) {
      resistencia = 0;
      efectivo = 0;
      fueinmune = true;
    }
    
    double calculo1 = ((2 * 10 + 2) * _mov1.poder / 50 + 2) * resistencia * efectivo;

    // Aplicar daño si no esta paralizado o supero la paralisis
    if (estadoPoke1 != 3 || paralisis > 80) {
      int damage = calculo1.round();
      vidaPoke2 = max(0, vidaPoke2 - damage);
      _danoPoke2 = damage;
    }

    // Aplicar estado alterado
    if (_mov1.estadoAlterado != 0 && !fueinmune) {
      int prob = Random().nextInt(21) + 70;
      if (prob > 60) {
        estadoPoke2 = _mov1.estadoAlterado;
      }
    }
        
    // Segundo ataque 
    resistencia = multiplicadorResistidoPor(_poke1.tipos ?? [], _mov2.tipo);
    efectivo = multiplicadorSuperefectivoPor(_poke1.tipos ?? [], _mov2.tipo);
    
    fueinmune = false;
    if (inmune(_poke1.tipos ?? [], _mov2.tipo)) {
      resistencia = 0;
      efectivo = 0;
      fueinmune = true;
    }
    
    double calculo2 = ((2 * 10 + 2) * _mov2.poder / 50 + 2) * resistencia * efectivo;
    
    // Aplicar daño si no esta paralizado o supero la paralisis
    if (estadoPoke2 != 3 || paralisis > 80) {
      int damage = calculo2.round();
      vidaPoke1 = max(0, vidaPoke1 - damage);
      _danoPoke1 = damage;
    }
      
    // Aplicar estado alterado del segundo movimiento
    if (_mov2.estadoAlterado != 0 && !fueinmune) {
      int prob = Random().nextInt(21) + 70;
      if (prob > 60) {
        estadoPoke1 = _mov2.estadoAlterado;
      }
    }
    
    // Efectos de estado al final del turno
    if (estadoPoke1 == 1 || estadoPoke1 == 2) { // Veneno o Quemado
      int danoEstado = (_poke1.vidaMax * 0.07).round();
      vidaPoke1 = max(0, vidaPoke1 - danoEstado);
    }
    
    if (estadoPoke2 == 1 || estadoPoke2 == 2) { // Veneno o Quemado
      int danoEstado = (_poke2.vidaMax * 0.07).round();
      vidaPoke2 = max(0, vidaPoke2 - danoEstado);
    }
    
    // Guardar resultados finales
    _estadoPoke1 = estadoPoke1;
    _estadoPoke2 = estadoPoke2;
    _danoPoke1 = _poke1.vidaActual - vidaPoke1;
    _danoPoke2 = _poke2.vidaActual - vidaPoke2;
  }
  
  // getters de soporte vital :P
  Pokemon get poke1 => _poke1;
  Pokemon get poke2 => _poke2;
  Movimiento get mov1 => _mov1;
  Movimiento get mov2 => _mov2;
  
  int get vidaPoke1 => max(0, _poke1.vidaActual - _danoPoke1);
  int get vidaPoke2 => max(0, _poke2.vidaActual - _danoPoke2);
  int get estadoPoke1 => _estadoPoke1;
  int get estadoPoke2 => _estadoPoke2;
  int get danoPoke1 => _danoPoke1;
  int get danoPoke2 => _danoPoke2;
  
  bool get poke1Debilitado => vidaPoke1 <= 0;
  bool get poke2Debilitado => vidaPoke2 <= 0;
  
  String get ganador {
    if (poke1Debilitado && !poke2Debilitado) return _poke2.nombre;
    if (!poke1Debilitado && poke2Debilitado) return _poke1.nombre;
    if (poke1Debilitado && poke2Debilitado) return "Empate";
    return "Batalla en curso";
  }
  
  String get resumen {
    return '''
    ${_poke1.nombre} (HP: $vidaPoke1/${_poke1.vidaMax}) vs ${_poke2.nombre} (HP: $vidaPoke2/${_poke2.vidaMax})
    Movimientos: ${_mov1.nombre} -> ${_danoPoke2} dano | ${_mov2.nombre} -> ${_danoPoke1} dano
    Estados: ${_estadoNombre(_estadoPoke1)} | ${_estadoNombre(_estadoPoke2)}
    Ganador: $ganador
    ''';
  }
  
  String _estadoNombre(int estado) {
    switch (estado) {
      case 0: return "Normal";
      case 1: return "Envenenado";
      case 2: return "Quemado";
      case 3: return "Paralizado";
      default: return "Desconocido";
    }
  }
}