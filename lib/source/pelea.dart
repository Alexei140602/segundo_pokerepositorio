import 'tablatipos.dart';
import 'dart:math';
import 'movimientos.dart';
import 'pokemon.dart';
import 'pokemones.dart';

class Pelea 
{
  late Pokemon poke1;
  late Pokemon poke2;
  late Movimiento mov1;
  late Movimiento mov2;
  pelea(int poke1id, int poke2id, int mov1id, int mov2id)
  {
    Movimiento? mov1= Movimientos.porId(mov1id);
    Movimiento? mov2= Movimientos.porId(mov2id);
    Pokemon? poketemporal1=obtenerPokemonPorId(poke1id);
    Pokemon? poketemporal2=obtenerPokemonPorId(poke2id);
    //poke1 siempre ataca primero, entonces depende de la velocidad quien es poke1
    if ((poketemporal1?.velocidad ?? 0) > (poketemporal2?.velocidad ?? 0))    
    {
    Pokemon? poke1=poketemporal1;
    Pokemon? poke2=poketemporal2;
    }
    else
    {
      Pokemon? poke1=poketemporal2;
      Pokemon? poke2=poketemporal1;
    }
      //primer ataque
      double resistencia = multiplicadorResistidoPor(poke2.tipos??[], mov1?.tipo) ;
      double efectivo= multiplicadorSuperefectivoPor(poke2.tipos??[], mov1?.tipo);
      if (inmune(poke2.tipos??[], mov1?.tipo))
      {
        resistencia=0;
        efectivo=0;
      }
      double calculo1 = ((2 * 10 + 2) * mov1!.poder / 50 + 2) * resistencia * efectivo;
      int damage=calculo1.round();
      poke2.damage(damage);

      //segundo ataque
      resistencia = multiplicadorResistidoPor(poke1.tipos??[], mov2?.tipo) ;
      efectivo= multiplicadorSuperefectivoPor(poke1.tipos??[], mov2?.tipo);
      if (inmune(poke1.tipos??[], mov2?.tipo))
      {
        resistencia=0;
        efectivo=0;
      }
      double calculo2 = ((2 * 10 + 2) * mov1!.poder / 50 + 2) * resistencia * efectivo;
      damage=calculo2.round();
      poke2.damage(damage);  
  }
  
}