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
      double resistencia = multiplicadorResistidoPor(poke2.tipos??[], mov1?.tipo);
      double efectivo= multiplicadorSuperefectivoPor(poke2.tipos??[], mov1?.tipo);
      bool fueinmune=false;
      int damage;
      int paralisis=Random().nextInt(21) + 80;
      if (inmune(poke2.tipos??[], mov1?.tipo))
      {
        resistencia=0;
        efectivo=0;
        fueinmune=true;
      }
      double calculo1 = ((2 * 10 + 2) * mov1!.poder / 50 + 2) * resistencia * efectivo;

      if(poke1.estado==3 && paralisis>80)
      {
        damage=calculo1.round();
        poke2.damage(damage);
      }

      if ((mov1?.estadoAlterado?? 0) !=0 && fueinmune==false)
      {
         int prob=0;
            prob= Random().nextInt(21) + 70;
            if(prob>60)
            {
              poke2.estado=mov1?.estadoAlterado?? 0;
            }
           
        }
        
      //segundo ataque
      resistencia = multiplicadorResistidoPor(poke1.tipos??[], mov2?.tipo) ;
      efectivo= multiplicadorSuperefectivoPor(poke1.tipos??[], mov2?.tipo);
      if (inmune(poke1.tipos??[], mov2?.tipo))
      {
        resistencia=0;
        efectivo=0;
      }
      double calculo2 = ((2 * 10 + 2) * mov2!.poder / 50 + 2) * resistencia * efectivo;
      if(poke1.estado==3 && paralisis>80)
      {
        damage=calculo2.round();
        poke1.damage(damage);
      }
      
      
      if ((mov2?.estadoAlterado?? 0) !=0 && fueinmune==false)
      {
         int prob=0;
            prob= Random().nextInt(21) + 70;
            if(prob>60)
            {
              poke1.estado=mov2?.estadoAlterado?? 0;
            }
      }
      switch (poke1.estado) {
        case 0: 
        break;
        case 1:
        poke1.damage(poke1.vidaMax*.07.round());
        case 2:
        poke1.damage(poke1.vidaMax*.07.round());
        default:
      }
  }
  
}