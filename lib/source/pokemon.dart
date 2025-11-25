import 'tablatipos.dart';

class Pokemon 
{
  final String nombre;
  int vidaMax;
  int vidaActual;
  int velocidad;
  
  Pokemon
  ({
    required this.nombre,
    required this.vidaMax,
    required this.velocidad
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
