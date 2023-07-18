import exceptions.*

class Equipo {
	var property miembros = []
	
	method miembroMasVulnerable() = miembros.min({ miembro => miembro.capacidadBatalla() })
	method calidadEquipo() = miembros.sum({ miembro => miembro.capacidadBatalla() }).div(miembros.size())
	method mejoresPoderes() = miembros.map({ miembro => miembro.mejorPoder() })	
	method esSensatoAfrontar(peligro) = miembros.all({ miembro => miembro.puedoEnfrentar(peligro)})
	method puedenEnfrentar(peligro) = miembros.filter({ miembro => miembro.puedoEnfrentar(peligro)})
	method cantidadQuePuedenEnfrentar(peligro) = self.puedenEnfrentar(peligro).size()
	
	method enfrentarPeligro(peligro) {
		self.validarCantidadPersonajes(peligro)
		self.puedenEnfrentar(peligro).forEach({ miembro => miembro.enfrentarPeligro(peligro)})
	}
	
	method validarCantidadPersonajes(peligro){
		if (self.cantidadQuePuedenEnfrentar(peligro) <= peligro.personajesQueSeBanca()){
			throw new MiembrosInsuficientesException()
		}
	}
}
