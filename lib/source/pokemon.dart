import 'tablatipos.dart';

class Pokemon 
{
  final String nombre;
  List <int> tipos;
  int vidaMax;
  int vidaActual;
  int velocidad;
  int numeroEnPokedex;
  Pokemon
  ({
    required this.tipos,
    required this.nombre,
    required this.vidaMax,
    required this.velocidad,
    required this.numeroEnPokedex
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
