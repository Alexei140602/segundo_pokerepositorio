import 'pokemon.dart';

final Pokemon tyranitar = Pokemon(
  id:1,
  nombre: "Tyranitar",
  tipos: [13,16],
  numeroEnPokedex: 0248,
  vidaMax: 500,
  velocidad: 100,
  estado:0
);

final Pokemon charizard = Pokemon(
  id:2,
  nombre: "Charizard",
  tipos: [10,2],
  numeroEnPokedex: 0006,
  vidaMax: 300,
  velocidad: 95,
  estado:0
);

final Pokemon pidgeot = Pokemon(
  id:3,
  nombre: "Pidgeot",
  tipos: [10,1],
  numeroEnPokedex: 0017,
  vidaMax: 100,
  velocidad: 110,
  estado:0
);

final Pokemon squirtle = Pokemon(
  id:4,
  nombre: "Squirtle",
  tipos: [2],
  numeroEnPokedex: 0007,
  vidaMax: 100,
  velocidad: 85,
  estado:0
);

final Pokemon tsareena = Pokemon(
  id:5,
  nombre: "Tsareena",
  tipos: [5],
  numeroEnPokedex: 0763,
  vidaMax: 120,
  velocidad: 110,
  estado:0
);

final Pokemon pachirisu = Pokemon(
  id:6,
  nombre: "Pachirisu",
  tipos: [4],
  numeroEnPokedex: 0417,
  vidaMax: 115,
  velocidad: 130,
  estado:0
);

final Pokemon glaceon = Pokemon(
  id:7,
  nombre: "Glaceon",
  tipos: [6],
  numeroEnPokedex: 0471,
  vidaMax: 140,
  velocidad: 110,
  estado:0
);

final Pokemon hawlucha = Pokemon(
  id:8,
  nombre: "Hawlucha",
  tipos: [10,7],
  numeroEnPokedex: 0701,
  vidaMax: 120,
  velocidad: 100,
  estado:0
);

final Pokemon drapion = Pokemon(
  id:8,
  nombre: "Drapion",
  tipos: [8,16],
  numeroEnPokedex: 0452,
  vidaMax: 400,
  velocidad: 60,
  estado:0
);

final Pokemon cubone = Pokemon(
  id:9,
  nombre: "Cubone",
  tipos: [9],
  numeroEnPokedex: 0104,
  vidaMax: 160,
  velocidad: 100,
  estado:0
);

final Pokemon dragonite = Pokemon(
  id:10,
  nombre: "Dragonite",
  tipos: [15],
  numeroEnPokedex: 0149,
  vidaMax: 250,
  velocidad: 150,
  estado:0
);

final Pokemon latias = Pokemon(
  id:11,
  nombre: "Latias",
  tipos: [15,11],
  numeroEnPokedex: 0380,
  vidaMax: 300,
  velocidad: 110,
  estado:0
);

final Pokemon heracross = Pokemon(
  id:12,
  nombre: "Heracross",
  tipos: [7,12],
  numeroEnPokedex: 0214,
  vidaMax: 120,
  velocidad: 90,
  estado:0
);

final Pokemon chandelure = Pokemon(
  id:13,
  nombre: "Chandelure",
  tipos: [2,14],
  numeroEnPokedex: 0609,
  vidaMax: 150,
  velocidad: 150,
  estado:0
);

final Pokemon garchomp = Pokemon(
  id:14,
  nombre: "Garchomp",
  tipos: [15,9],
  numeroEnPokedex: 0445,
  vidaMax: 280,
  velocidad: 100,
  estado:0
);

final Pokemon mimikyu = Pokemon(
  id:15,
  nombre: "Mimikyu",
  tipos: [14],
  numeroEnPokedex: 0778,
  vidaMax: 140,
  velocidad: 140,
  estado:0
);

final Pokemon metagross = Pokemon(
  id:16,
  nombre: "Metagross",
  tipos: [17,11],
  numeroEnPokedex: 0376,
  vidaMax: 280,
  velocidad: 40,
  estado:0
);


final List<Pokemon> pokedex = [
  tyranitar,
  charizard,
  pidgeot,
  squirtle,
  tsareena,
  pachirisu,
  glaceon,
  hawlucha,
  drapion,
  cubone,
  dragonite,
  latias,
  heracross,
  chandelure,
  garchomp,
  mimikyu,
  metagross,
];

Pokemon? obtenerPokemonPorId(int id) {
      return pokedex.firstWhere((pokemon) => pokemon.id == id);
  }
