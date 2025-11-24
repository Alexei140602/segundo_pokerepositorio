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
    numeroresiste: [2,15,3,13],
    numeroinmune: []);
  Tablatipos agua = Tablatipos(
    idtipo: 3,  
    numeroefectivo: [1], 
    numeroresiste: [1],
    numeroinmune: [-1]);
  Tablatipos electrico = Tablatipos(
    idtipo: 4,  
    numeroefectivo: [1], 
    numeroneutral: [1], 
     numeroresiste: [1],
    numeroinmune: [-1]);
  Tablatipos planta = Tablatipos(
    idtipo: 5,  
    numeroefectivo: [1], 
    numeroneutral: [1], 
    numeroresiste: [1],
    numeroinmune: [-1]);
  Tablatipos hielo = Tablatipos(
    idtipo: 6,  
    numeroefectivo: [1], 
    numeroneutral: [1], 
    numeroresiste: [1],
    numeroinmune: [-1]);
  Tablatipos lucha = Tablatipos(
    idtipo: 7,  
    numeroefectivo: [1], 
    numeroneutral: [1], 
     numeroresiste: [1],
    numeroinmune: [-1]);
  Tablatipos veneno = Tablatipos(
    idtipo: 8,  
    numeroefectivo: [1], 
    numeroneutral: [1], 
    numeroresiste: [1],
    numeroinmune: [-1]);
  Tablatipos tierra = Tablatipos(
    idtipo: 9,  
    numeroefectivo: [1], 
    numeroneutral: [1], 
     numeroresiste: [1],
    numeroinmune: [-1]);
  Tablatipos volador = Tablatipos(
    idtipo: 10,  
    numeroefectivo: [1], 
    numeroneutral: [1], 
     numeroresiste: [1],
    numeroinmune: [-1]);
  Tablatipos psiquico = Tablatipos(
    idtipo: 11,  
    numeroefectivo: [1], 
    numeroneutral: [1], 
     numeroresiste: [1],
    numeroinmune: [-1]);
  Tablatipos bicho = Tablatipos(
    idtipo: 12,  
    numeroefectivo: [1], 
    numeroneutral: [1], 
    numeroresiste: [1],
    numeroinmune: [-1]);
  Tablatipos roca = Tablatipos(
    idtipo: 13,  
    numeroefectivo: [1], 
    numeroneutral: [1], 
    numeroresiste: [1],
    numeroinmune: [-1]);
  Tablatipos fantasma = Tablatipos(
    idtipo: 14,  
    numeroefectivo: [1], 
    numeroneutral: [1], 
     numeroresiste: [1],
    numeroinmune: [-1]);
  Tablatipos dragon = Tablatipos(
    idtipo: 15,  
    numeroefectivo: [1], 
    numeroneutral: [1], 
    numeroresiste: [1],
    numeroinmune: [-1]);
  Tablatipos siniestro = Tablatipos(
    idtipo: 16,  
    numeroefectivo: [1], 
    numeroneutral: [1], 
     numeroresiste: [1],
    numeroinmune: [-1]);
  Tablatipos acero = Tablatipos(
    idtipo: 17,  
    numeroefectivo: [1], 
    numeroneutral: [1], 
   numeroresiste: [1],
    numeroinmune: [-1]);
}