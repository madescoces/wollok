import personaje.*

class Poder {
	method capacidadBatalla(personaje) = (self.agilidad(personaje) + self.fuerza(personaje)) * self.habilidadEspecial(personaje)
	method agilidad(personaje)
	method fuerza(personaje)
	method habilidadEspecial(personaje)	= personaje.espiritualidad() + personaje.estrategia()
	method imunidadRadiactividad(personaje)
}


class Velocidad inherits Poder{
	var property rapidez
	override method agilidad(personaje) = personaje.estrategia()*rapidez
	override method fuerza(personaje) = personaje.espiritualidad()*rapidez
	override method imunidadRadiactividad(personaje) = false
}

class Vuelo inherits Poder{
	var property alturaMaxima
	var property energiaDespegue 
	override method agilidad(personaje) = personaje.estrategia()*alturaMaxima/energiaDespegue
	override method fuerza(personaje) = personaje.espiritualidad() + alturaMaxima - energiaDespegue
	override method imunidadRadiactividad(personaje) = alturaMaxima > 200
}

class Amplificador inherits Poder{
	var property poderBase
	var property amplificador
	override method agilidad(personaje) = poderBase.agilidad(personaje)
	override method fuerza(personaje) = poderBase.fuerza(personaje)
	override method habilidadEspecial(personaje) = poderBase.habilidadEspecial(personaje)*amplificador
	override method imunidadRadiactividad(personaje) = true
}

