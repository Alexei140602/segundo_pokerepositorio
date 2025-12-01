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

  static Tablatipos normal = Tablatipos(
    idtipo: 1,  
    numeroefectivo: [], 
    numeroresiste: [],
    numeroinmune: [14]);

  static Tablatipos  fuego = Tablatipos(
    idtipo: 2,  
    numeroefectivo: [5,6,12,17], 
    numeroresiste: [12,17,2,5,6],
    numeroinmune: []);
  
  static Tablatipos agua = Tablatipos(
    idtipo: 3,  
    numeroefectivo: [2,9,13], 
    numeroresiste: [2,3,6,17],
    numeroinmune: []);
  
  static Tablatipos electrico = Tablatipos(
    idtipo: 4,  
    numeroefectivo: [3,10], 
    numeroresiste: [10,4,17],
    numeroinmune: []);
  static Tablatipos planta = Tablatipos(
    idtipo: 5,  
    numeroefectivo: [13,9,13], 
    numeroresiste: [10,3,5,4],
    numeroinmune: []);
  static Tablatipos hielo = Tablatipos(
    idtipo: 6,  
    numeroefectivo: [10,9,5,15], 
    numeroresiste: [6],
    numeroinmune: []);
  static Tablatipos lucha = Tablatipos(
    idtipo: 7,  
    numeroefectivo: [1,13,17,6,16], 
    numeroresiste: [13,12,16],
    numeroinmune: []);
  static Tablatipos veneno = Tablatipos(
    idtipo: 8,  
    numeroefectivo: [5], 
    numeroresiste: [7,8,12,5],
    numeroinmune: []);
  static Tablatipos tierra = Tablatipos(
    idtipo: 9,  
    numeroefectivo: [8,13,17,4,2], 
    numeroresiste: [8,13],
    numeroinmune: [4]);
  static Tablatipos volador = Tablatipos(
    idtipo: 10,  
    numeroefectivo: [7,12,5], 
    numeroresiste: [7,12,5],
    numeroinmune: [9]);
  static Tablatipos psiquico = Tablatipos(
    idtipo: 11,  
    numeroefectivo: [7,8], 
    numeroresiste: [11,7],
    numeroinmune: []);
  static Tablatipos bicho = Tablatipos(
    idtipo: 12,  
    numeroefectivo: [11,5,16], 
    numeroresiste: [7,9,5],
    numeroinmune: []);
  static Tablatipos roca = Tablatipos(
    idtipo: 13,  
    numeroefectivo: [10,12,2,6], 
    numeroresiste: [1,10,8,2],
    numeroinmune: []);
  static Tablatipos fantasma = Tablatipos(
    idtipo: 14,  
    numeroefectivo: [14,11], 
    numeroresiste: [1,8,12],
    numeroinmune: [7]);
  static Tablatipos dragon = Tablatipos(
    idtipo: 15,  
    numeroefectivo: [15], 
    numeroresiste: [2,3,4,5],
    numeroinmune: []);
  static Tablatipos siniestro = Tablatipos(
    idtipo: 16,  
    numeroefectivo: [14,11], 
    numeroresiste: [14,16],
    numeroinmune: [11]);
  static Tablatipos acero = Tablatipos(
    idtipo: 17,  
    numeroefectivo: [13,6], 
    numeroresiste: [1,5,6,10,11,12,13,15,17],
    numeroinmune: [8]);
}
   Tablatipos obtenerTipoPorId(int id) {
    switch (id) {
      case 1: return Tablatipos.normal;
      case 2: return Tablatipos.fuego;
      case 3: return Tablatipos.agua;
      case 4: return Tablatipos.electrico;
      case 5: return Tablatipos.planta;
      case 6: return Tablatipos.hielo;
      case 7: return Tablatipos.lucha;
      case 8: return Tablatipos.veneno;
      case 9: return Tablatipos.tierra;
      case 10: return Tablatipos.volador;
      case 11: return Tablatipos.psiquico;
      case 12: return Tablatipos.bicho;
      case 13: return Tablatipos.roca;
      case 14: return Tablatipos.fantasma;
      case 15: return Tablatipos.dragon;
      case 16: return Tablatipos.siniestro;
      case 17: return Tablatipos.acero;
      default: return Tablatipos.normal;
    }
  }


double multiplicadorResistidoPor(List<int> tiposDefensa,int? tipoAtacante) {
    double multiplicador = 1.0;
    int contadorResistencia = 0;
    for (var i = 0; i < tiposDefensa.length; i++) 
    {
    i=0;
    Tablatipos comparar= obtenerTipoPorId(tiposDefensa[i]);
    if (comparar.numeroresiste.contains(tipoAtacante)) {
        contadorResistencia++;
      }
    }
  
    if (contadorResistencia == 1) {
      multiplicador = 0.5;
    } else if (contadorResistencia >= 2) {
      multiplicador = 0.25;
    }
    return multiplicador;
  }

double multiplicadorSuperefectivoPor(List<int> tiposDefensa,tipoAtacante) {
    double multiplicador = 1.0;
    int contadorEfectivo = 0;
    for (var i = 0; i < tiposDefensa.length; i++) 
    {
    i=0;
    Tablatipos comparar= obtenerTipoPorId(tiposDefensa[i]);
    if (comparar.numeroefectivo.contains(tipoAtacante)) {
        contadorEfectivo++;
      }
    }
  
    if (contadorEfectivo == 1) {
      multiplicador = 2;
    } else if (contadorEfectivo >= 2) {
      multiplicador = 4;
    }
    return multiplicador;
  }

  bool inmune(List<int> tiposDefensa,tipoAtacante) 
  {
    for (var i = 0; i < tiposDefensa.length; i++) 
    {
    i=0;
    Tablatipos comparar= obtenerTipoPorId(tiposDefensa[i]);
    if (comparar.numeroinmune.contains(tipoAtacante)) {
       return true;
      }
    }
    return false;
  }

