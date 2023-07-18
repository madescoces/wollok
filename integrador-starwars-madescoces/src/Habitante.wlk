
class Habitante {

	const inteligencia
	const valentia
		
	method poder() = (valentia + inteligencia)

}

class HabitanteSoldado inherits Habitante{
	const equipo = []
	
	override method poder() = (super() + armas.sum({ arma => arma.poder() }))
	
	method addArma(arma) { equipo.add(arma) }
	method remArma(arma) { equipo.remove(arma) }
}

class Maestro inherits HabitanteSoldado{
	var estadoDeLaFuerza
	var midiclorianos
	var tiempoEnSuLadoDeLaFuerza
}

class Jedi inherits Maestro {
	var pazInterior 
	
		
	override method poder() = ( super() + midiclorianos/1000 + self.potenciaSable() )
	method energiaSable() = equipo.filter({ arma => arma.tipo().equals('sableLuz') }).uniqueElement().energia()
	method potenciaSable() = self.energiaSable()*tiempoEnSuLadoDeLaFuerza
	
	method modificarPazInterior() {}
}

class Sith inherits Jedi {
	override method potenciaSable() = self.energiaSable()*2 + tiempoEnSuLadoDeLaFuerza
}

class Arma {
	var desgastada
	var property energia
	var poder
	var poderMaximo
	
	method poder() = poder
	method util() = poder > 10 and !desgastada
	method reparar() { 
		desgastada = false
		self.regenerarPoder()
	}
	method regenerarPoder() { poder = poderMaximo}
	method usar(cuanto) { poder -= cuanto  }
}

object sableLuz inherits Arma( desgastada = false, energia = 100, poder = 50, poderMaximo = 100){
	
	method tipo() = if (self.kindName().contains('un/a  ')) self.kindName().drop(6) else self.kindName()
}

object planeta{
	const habitantes = []
	
	method agregarHabitante(habitante){	habitantes.add(habitante) }
	method poder() = habitantes.sum({ hab => hab.poder() })
	method ordenarPorPoder() = habitantes.sortedBy( { hx, hy => hx > hy } )
	method tresMasFuertes() = self.ordenarPorPoder().take(3)
	method poseeOrden() = self.tresMasFuertes().sum( { hab => hab.poder() }) > self.poder()/2
}
