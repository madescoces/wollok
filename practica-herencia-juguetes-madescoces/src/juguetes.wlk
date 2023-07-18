class Juguete{
	const property cuv
	method costoFabricacion()
	method eficaciaEntretenimiento()
	method precio()
}

class JugueteConPiezas inherits Juguete{
	const piezas = []
	
	//Metodos heredados de juguete
	override method costoFabricacion() = self.costoBase() + cuv*self.cantidadPiezas()*self.piezaMasGrande().volumen() 
	override method eficaciaEntretenimiento() = self.cantidadPiezas()	
	override method precio() {
		if (piezas.any({pieza => pieza.color() == 'rosa'})){
			return self.costoFabricacion() + self.eficaciaEntretenimiento()*10 + 20
		} else {
			return self.costoFabricacion() + self.eficaciaEntretenimiento()*10
		}
	}
	
	//Metodo propio
	method agregarPieza(pieza){
		piezas.addAll(pieza)
	}
	
	method piezaMasGrande() = piezas.max({ pieza => pieza.volumen() })
	
	method volumenTotalPiezas() = piezas.sum({ pieza => pieza.volumen() })
	
	method cantidadPiezas() = piezas.size()
	
	method costoBase() = 0	
	
	method piezas() = piezas
}

class Pelota inherits Juguete{
	override method costoFabricacion() = self.radio()*3*cuv
	override method eficaciaEntretenimiento() = 12
	override method precio() = (self.costoFabricacion() + self.eficaciaEntretenimiento()*10)
	method radio() = 4	
}

class Tachitos inherits JugueteConPiezas{
	override method costoBase() = 3
	override method eficaciaEntretenimiento() = self.volumenTotalPiezas()
}

class Baldecitos inherits JugueteConPiezas{
	override method costoBase() = 5
	override method eficaciaEntretenimiento() = self.cantidadPiezas()*3
}

class Pieza{
	const property color
	const property volumen	
}

class Ninix{
	const property mesesEdad
	const juguetes = #{}
	method entretenido(juguete) = juguete.eficaciaEntretenimiento()*(1 + self.mesesEdad()/100)
	
	method agregarJuguete(juguete){
		if (!self.aceptaJuguetes(juguete).isEmpty()) juguetes.addAll(self.aceptaJuguetes(juguete))
	}
	
	method aceptaJuguetes(juguete) = juguete
	
	method removerJuguete(juguete) {
		juguetes.removeAll(juguete)
	}
	
	method donarJuguete(juguete, ninix) {
		if (!ninix.aceptaJuguetes(juguete).isEmpty()) {
			ninix.agregarJuguete(ninix.aceptaJuguetes(juguete))
			self.removerJuguete(ninix.aceptaJuguetes(juguete))
		}		
	}
	
	method juguetes() = juguetes	
}

class NinixCuriosx inherits Ninix{
	override method entretenido(juguete) = super(juguete)*1.5
	override method aceptaJuguetes(juguete) = juguete.filter({ j => j.precio() < 150 }) 
}

class NinixRevoltosx inherits Ninix{
	override method entretenido(juguete) = super(juguete)/2
	override method aceptaJuguetes(juguete) = juguete.filter({ j => self.entretenido(j) > 7 })
}
