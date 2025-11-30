class Tablatipos 
{
  int idtipo;
  List <int> numeroefectivo;
  List <int> numeroresiste;
  List <int> numeroinmune;

  Tablatipos
  ({
    required this.idtipo,
    required this.numeroefectivo,
    required this.numeroresiste,
    required this.numeroinmune,
  });

  Tablatipos normal = Tablatipos(
    idtipo: 1,  
    numeroefectivo: [], 
    numeroresiste: [],
    numeroinmune: [14]);

  Tablatipos  fuego = Tablatipos(
    idtipo: 2,  
    numeroefectivo: [5,6,12,17], 
    numeroresiste: [12,17,2,5,6],
    numeroinmune: []);
  
  Tablatipos agua = Tablatipos(
    idtipo: 3,  
    numeroefectivo: [2,9,13], 
    numeroresiste: [2,3,6,17],
    numeroinmune: []);
  
  Tablatipos electrico = Tablatipos(
    idtipo: 4,  
    numeroefectivo: [3,10], 
    numeroresiste: [10,4,17],
    numeroinmune: []);
  Tablatipos planta = Tablatipos(
    idtipo: 5,  
    numeroefectivo: [13,9,13], 
    numeroresiste: [10,3,5,4],
    numeroinmune: []);
  Tablatipos hielo = Tablatipos(
    idtipo: 6,  
    numeroefectivo: [10,9,5,15], 
    numeroresiste: [6],
    numeroinmune: []);
  Tablatipos lucha = Tablatipos(
    idtipo: 7,  
    numeroefectivo: [1,13,17,6,16], 
    numeroresiste: [13,12,16],
    numeroinmune: []);
  Tablatipos veneno = Tablatipos(
    idtipo: 8,  
    numeroefectivo: [5], 
    numeroresiste: [7,8,12,5],
    numeroinmune: []);
  Tablatipos tierra = Tablatipos(
    idtipo: 9,  
    numeroefectivo: [8,13,17,4,2], 
    numeroresiste: [8,13],
    numeroinmune: [4]);
  Tablatipos volador = Tablatipos(
    idtipo: 10,  
    numeroefectivo: [7,12,5], 
    numeroresiste: [7,12,5],
    numeroinmune: [9]);
  Tablatipos psiquico = Tablatipos(
    idtipo: 11,  
    numeroefectivo: [7,8], 
    numeroresiste: [11,7],
    numeroinmune: []);
  Tablatipos bicho = Tablatipos(
    idtipo: 12,  
    numeroefectivo: [11,5,16], 
    numeroresiste: [7,9,5],
    numeroinmune: []);
  Tablatipos roca = Tablatipos(
    idtipo: 13,  
    numeroefectivo: [10,12,2,6], 
    numeroresiste: [1,10,8,2],
    numeroinmune: []);
  Tablatipos fantasma = Tablatipos(
    idtipo: 14,  
    numeroefectivo: [14,11], 
    numeroresiste: [1,8,12],
    numeroinmune: [7]);
  Tablatipos dragon = Tablatipos(
    idtipo: 15,  
    numeroefectivo: [15], 
    numeroresiste: [2,3,4,5],
    numeroinmune: []);
  Tablatipos siniestro = Tablatipos(
    idtipo: 16,  
    numeroefectivo: [14,11], 
    numeroresiste: [14,16],
    numeroinmune: [11]);
  Tablatipos acero = Tablatipos(
    idtipo: 17,  
    numeroefectivo: [13,6], 
    numeroresiste: [1,5,6,10,11,12,13,15,17],
    numeroinmune: [8]);
}

bool esEfectivo(Tablatipos tipo, int tipoBuscado) {
  return tipo.numeroefectivo.contains(tipoBuscado);
}

// Función para buscar coincidencias en numeroresiste
bool esResistente(Tablatipos tipo, int tipoBuscado) {
  return tipo.numeroresiste.contains(tipoBuscado);
}