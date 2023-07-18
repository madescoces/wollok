import elementos.*
import adultos.*
import legion.*

object macaria {
	var nivelIra= 10
	var disfraces = [ ]
	var caramelos = 0
	
	method capacidadSusto() = nivelIra + disfraces.sum({disfraz => disfraz.nivelSusto()}) 
		
	method disfrazar(_disfraz) = disfraces.add(_disfraz)		
	
	method quitarDisfraz(_disfraz) = disfraces.remove(_disfraz)	
	
	method recibirCaramelos(_cantidad) {
		caramelos += (_cantidad*3).div(4)
	}
	
	method disfraces() = disfraces
	method caramelos() = caramelos
	
	method dejarDeUsarMenosEfectivo() = self.quitarDisfraz(disfraces.min({disfraz => disfraz.nivelSusto()}))
	
}

object pancracio {
	var disfrazEnUso = mascaraDracula
	var gritoParaAsustar = 'buuuu'
	var caramelos = 0
	
	method capacidadSusto() = disfrazEnUso.nivelSusto() + gritoParaAsustar.size() - 1
	
	method disfrazar(_disfraz) { 
		disfrazEnUso = _disfraz
	}
	
	method quitarDisfraz(_disfraz) {
		gritoParaAsustar += 'uu'
	}
	
	method recibirCaramelos(_cantidad) {
		caramelos += _cantidad
	}
	
	method disfraces() = [disfrazEnUso]
	method caramelos() = caramelos	
}

// El chico inventado .

object pedro {
	var disfraces = [ ]
	var caramelos = 0	
	
	method capacidadSusto() {
		return if (disfraces.isEmpty()) 0 else disfraces.max({ _disfraz => _disfraz.nivelSusto()})
	} 
		
	method disfrazar(_disfraz) = disfraces.add(_disfraz)		
	
	method quitarDisfraz(_disfraz) = disfraces.remove(_disfraz)	
	
	method recibirCaramelos(_cantidad) = caramelos
		
	method tirarTodosLosDisfraces() = disfraces.clear() 
	
	method disfraces() = disfraces
	method caramelos() = caramelos
}

/*	Jaimito es tímido, sin disfraces no asusta nada y si tiene disfraces pierde parte de su capacidad de susto
	esto empeora cuando se quita un disfraz por que se siente doblemente inseguro, sin embargo si es un disfraz que uso
	muchas veces su timidez no cambia
*/

object jaimito {
	var disfraces = []
	var disfracesHistorial = []
	var caramelos = 0
	var timidez = 2
	
	method capacidadSusto() {
		return 	if (disfraces.isEmpty()) 0 
				else disfraces.sum({ _disfraz => _disfraz.nivelSusto()}).div(timidez)
	} 
		
	method disfrazar(_disfraz) = disfraces.add(_disfraz)		
	
	method quitarDisfraz(_disfraz) { 
		disfraces.remove(_disfraz)
		disfracesHistorial.add(_disfraz)
		if (disfracesHistorial.occurrencesOf(_disfraz) < 2)	timidez *= 2 else timidez = 2
	}	
	
	method recibirCaramelos(_cantidad) = caramelos
	
	method disfraces() = disfraces
	method caramelos() = caramelos
	
}

