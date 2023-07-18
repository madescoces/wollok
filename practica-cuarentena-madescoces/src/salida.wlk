import pandemia.*

class Salida {
	method puedeSalir(persona) = !persona.enRiesgo()
}

class Trabajar inherits Salida{
	override method puedeSalir(persona) = !persona.enRiesgo() and persona.trabajoPrecencialmente()
}

class Comprar inherits Salida{
	
}

class Ejercitarse inherits Salida{
	override method puedeSalir(persona) = pandemia.fase() > 3
}

class Caminar inherits Ejercitarse{
	override method puedeSalir(persona) = if (pandemia.fase() == 5) true else super(persona) 
}