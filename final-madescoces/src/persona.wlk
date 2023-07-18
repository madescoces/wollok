import exceptions.*
const ANCIANO = 65

class Persona{
	var property edad
	var property enFermedadPreexistente
	var property trabajos = []
	const salidas = []
	
	method salario() = trabajos.sum{ trabajo => trabajo.salario() }
	method enRiesgo() = self.soyAdultoMayor() or enFermedadPreexistente
	method soyAdultoMayor() = edad > ANCIANO
	method trabajoPrincipal() = trabajos.max{ trabajo => trabajo.salario()}
	method trabajoPrecencialmente() = trabajos.any{ trabajo => trabajo.presencial() }
	method puedoSalir(salida) = salida.puedeSalir(self)
	
	method salidasRealizadas() = salidas
	
	method registrarSalida(salida) {
		salidas.add(salida)
	}	
	
	method salir(salida){
		self.validarSalida(salida)
		self.registrarSalida(salida)
	}
	
	method validarSalida(salida) {
		if(!self.puedoSalir(salida)){
			throw new SalidaException()
		}
	}
}