import 'dart:math';

class Movimiento {
  final int id;
  final String nombre;
  final int tipo; // ID del tipo (1-17)
  final int poder;
  final String descripcion;

  const Movimiento({
    required this.id,
    required this.nombre,
    required this.tipo,
    required this.poder,
    required this.descripcion,
  });
}

class Movimientos {
  // Movimientos por tipo
  static Movimiento placaje = Movimiento(
    id: 1,
    nombre: "Placaje",
    tipo: 1, // Normal
    poder: _poderAleatorio(),
    descripcion: "Ataca con golpes físicos",
  );

  static Movimiento lanzallamas = Movimiento(
    id: 2,
    nombre: "Lanzallamas",
    tipo: 2, // Fuego
    poder: _poderAleatorio(),
    descripcion: "Lanza una potente llama",
  );

  static Movimiento hidrobomba = Movimiento(
    id: 3,
    nombre: "Hidrobomba",
    tipo: 3, // Agua
    poder: _poderAleatorio(),
    descripcion: "Dispara un potente chorro de agua",
  );

  static Movimiento impactrueno = Movimiento(
    id: 4,
    nombre: "Impactrueno",
    tipo: 4, // Eléctrico
    poder: _poderAleatorio(),
    descripcion: "Ataca con una descarga eléctrica",
  );

  static Movimiento latigocepa = Movimiento(
    id: 5,
    nombre: "Latigo Cepa",
    tipo: 5, // Planta
    poder: _poderAleatorio(),
    descripcion: "Golpea con látigos de plantas",
  );

  static Movimiento rayoHielo = Movimiento(
    id: 6,
    nombre: "Rayo Hielo",
    tipo: 6, // Hielo
    poder: _poderAleatorio(),
    descripcion: "Lanza un rayo de hielo",
  );

  static Movimiento golpeKarate = Movimiento(
    id: 7,
    nombre: "Golpe Karate",
    tipo: 7, // Lucha
    poder: _poderAleatorio(),
    descripcion: "Ataca con técnicas de karate",
  );

  static Movimiento toxico = Movimiento(
    id: 8,
    nombre: "Tóxico",
    tipo: 8, // Veneno
    poder: _poderAleatorio(),
    descripcion: "Envenena gravemente al objetivo",
  );

  static Movimiento terremoto = Movimiento(
    id: 9,
    nombre: "Terremoto",
    tipo: 9, // Tierra
    poder: _poderAleatorio(),
    descripcion: "Crea un poderoso terremoto",
  );

  static Movimiento tornado = Movimiento(
    id: 10,
    nombre: "Tornado",
    tipo: 10, // Volador
    poder: _poderAleatorio(),
    descripcion: "Crea un tornado que levanta al objetivo",
  );

  static Movimiento psiquico = Movimiento(
    id: 11,
    nombre: "Psíquico",
    tipo: 11, // Psíquico
    poder: _poderAleatorio(),
    descripcion: "Ataque psíquico que puede bajar la defensa especial",
  );

  static Movimiento picotazo = Movimiento(
    id: 12,
    nombre: "Picotazo",
    tipo: 12, // Bicho
    poder: _poderAleatorio(),
    descripcion: "Ataca con un picotazo veloz",
  );

  static Movimiento rocaAfilada = Movimiento(
    id: 13,
    nombre: "Roca Afilada",
    tipo: 13, // Roca
    poder: _poderAleatorio(),
    descripcion: "Lanza rocas afiladas al objetivo",
  );

  static Movimiento bolaSombra = Movimiento(
    id: 14,
    nombre: "Bola Sombra",
    tipo: 14, // Fantasma
    poder: _poderAleatorio(),
    descripcion: "Lanza una esfera de sombras",
  );

  static Movimiento danzaDragon = Movimiento(
    id: 15,
    nombre: "Danza Dragón",
    tipo: 15, // Dragón
    poder: 100, // Siempre 100 como solicitaste
    descripcion: "Danza misteriosa que aumenta el ataque y velocidad",
  );

  static Movimiento mordisco = Movimiento(
    id: 16,
    nombre: "Mordisco",
    tipo: 16, // Siniestro
    poder: _poderAleatorio(),
    descripcion: "Muerde ferozmente, puede hacer retroceder",
  );

  static Movimiento cabezaHierro = Movimiento(
    id: 17,
    nombre: "Cabeza Hierro",
    tipo: 17, // Acero
    poder: _poderAleatorio(),
    descripcion: "Golpea con la cabeza de acero",
  );

  // Función para generar poder aleatorio entre 80-100
  static int _poderAleatorio() {
    return Random().nextInt(21) + 80; // 80-100 (21 números: 0-20 + 80)
  }

  // Lista con todos los movimientos
  static List<Movimiento> get todos => [
        placaje,
        lanzallamas,
        hidrobomba,
        impactrueno,
        latigocepa,
        rayoHielo,
        golpeKarate,
        toxico,
        terremoto,
        tornado,
        psiquico,
        picotazo,
        rocaAfilada,
        bolaSombra,
        danzaDragon,
        mordisco,
        cabezaHierro,
      ];

  // Obtener movimiento por nombre
  static Movimiento? porNombre(String nombre) {
    try {
      return todos.firstWhere((movimiento) => movimiento.nombre == nombre);
    } catch (e) {
      return null;
    }
  }
}