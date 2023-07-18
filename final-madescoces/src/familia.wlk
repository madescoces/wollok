import exceptions.*

class Familia {
	var property personas = []	
	
	method salarioFamilia() = personas.sum{ persona => persona.salario() }
	method estaAislada() = personas.all{ persona => persona.enRiesgo() }
	method trabajosPrincipales() = personas.map{ persona => persona.trabajoPrincipal() }
	method trabajadoresInactivos() = personas.filter{ persona => !persona.trabajoPrecencialmente()}	
	method puedenSalir(salida) = personas.filter{ persona => persona.puedoSalir(salida) }
	
	method salir(salida){
		self.validarSiAlguienPuedeSalir(salida)
		self.puedenSalir(salida).forEach{ persona => persona.salir(salida) }
	}
	
	method validarSiAlguienPuedeSalir(salida){
		if (self.puedenSalir(salida).isEmpty()){
			throw new SalidaException()
		}
	}
}
