import exceptions.*

const UNITARIOARMARIO = 5
const EXTRARELIQUIAS = 2

class Mueble {
	const property cosas = []
	
	method precio()
	method puedeGuardar(cosa)
	method utilidad() = self.utilidadCosas()/self.precio()
	method tieneCosa(cosaBuscada) = cosas.contains(cosaBuscada)
	method utilidadCosas() = cosas.sum{cosa => cosa.utilidad()}
	method cosaMenosUtil() = cosas.min{cosa => cosa.utilidad()}
	
	method guardarCosa(cosa) {
		cosas.add(cosa)
	}	
	
	method removerCosa(cosa){
		cosas.remove(cosa)
	}
}

class Armario inherits Mueble {
	var property maximaCantidadCosas
	
	override method precio() = maximaCantidadCosas*UNITARIOARMARIO
	override method puedeGuardar(cosa) = cosas.size() < maximaCantidadCosas
}

class GabineteMagico inherits Mueble {
	var property precio
	override method precio() = precio
	override method puedeGuardar(cosa) = cosa.magica()
}

class Baul inherits Mueble {
	var property volumenMaximo
	
	method volumenUsado() = cosas.sum{cosa => cosa.volumen()}
	method volumenLibre() = volumenMaximo - self.volumenUsado()
	method soloReliquias() = cosas.all{cosa => cosa.reliquia()}
	method extra() = if (self.soloReliquias()) EXTRARELIQUIAS else 0
	override method utilidad() = super() + self.extra()
	override method precio() = volumenMaximo + 2
	override method puedeGuardar(cosa) = self.volumenLibre() >= cosa.volumen()
}

class BaulMagico inherits Baul{
	method extraMagico() = cosas.count{cosa => cosa.magica()}
	override method utilidad() = super() + self.extraMagico()
	override method precio() = super()*2
}

