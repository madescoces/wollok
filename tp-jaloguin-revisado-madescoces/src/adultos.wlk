import chicos.*
import legion.*

object mirca {
	var tolerancia = 22

	method tolerancia() = tolerancia
		
	method serAsustadoPor(_entidad) {		
		_entidad.recibirCaramelos(self.caramelosAEntregar(_entidad))	
		tolerancia -= 1
	}
		
	method caramelosAEntregar(_entidad) {
		return (_entidad.capacidadSusto() - self.tolerancia()).max(0)		
	}
}
