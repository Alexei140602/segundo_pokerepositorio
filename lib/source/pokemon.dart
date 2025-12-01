import 'tablatipos.dart';
import 'pokemones.dart';

class Pokemon 
{
  final String nombre;
  int id;
  List <int> tipos;
  int vidaMax;
  int vidaActual;
  int velocidad;
  int numeroEnPokedex;
  int estado;
  Pokemon
  ({
    required this.tipos,
    required this.id,
    required this.nombre,
    required this.vidaMax,
    required this.velocidad,
    required this.numeroEnPokedex,
    required this.estado
  }) : vidaActual = vidaMax;


  void damage(int damage)
  {
    vidaActual-=damage;
    if (vidaActual<0)
    {
      vidaActual=0;
    }
  }

  bool muerto ()
  {
    return vidaActual==0;
  }

  void move(int indicemovimiento)
  {

  }
  
}
 