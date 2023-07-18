import chicos.*
import elementos.*
import adultos.*
import barrio.*

object legionDelTerror {
	var integrantes = [ ]
		
	method agregarIntegrantes(_integrantes) = integrantes.addAll(_integrantes)
	
	method lider() {
		return integrantes.max({_integrante => _integrante.capacidadSusto()})
	}
	
	method caramelos() = integrantes.sum({_integrante => _integrante.caramelos()})
	
	method normaSinRepetidos() {
		 self.disfracesRepetidos().forEach({ _disfraz => self.quitarDisfrazRepetido(_disfraz)})
	}
	
	method quitarDisfrazRepetido(_disfraz){
		integrantes.forEach({ _integrante => _integrante.quitarDisfraz(_disfraz)})
	}
	
	method recibirCaramelos(_cantidad) = self.lider().recibirCaramelos(_cantidad)
	
	method todosLosDisfraces() = integrantes
		.map({ _chico => _chico.disfraces().withoutDuplicates()})
		.flatten()		
	
	method disfracesRepetidos() = self.todosLosDisfraces()
		.filter({_disfraz => self.todosLosDisfraces().occurrencesOf(_disfraz) != 1})
	
	method capacidadSusto() = integrantes
		.sum({_integrante => _integrante.capacidadSusto()})
}

