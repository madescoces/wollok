import poder.*
import exceptions.*

class Personaje{
	var property estrategia 
	var property espiritualidad
	const property poderes = []
	
	method capacidadBatalla() = poderes.sum({ poder => poder.capacidadBatalla(self) })
	method mejorPoder() = poderes.max({ poder => poder.capacidadBatalla(self) })	
	method soyInmuneRadiactividad() = poderes.any({ poder => poder.imunidadRadiactividad(self) })
	method masPoderQue(peligro) = peligro.capacidadBatalla() < self.capacidadBatalla()
	method puedoEnfrentar(peligro) = if (peligro.radiactivo() && !self.soyInmuneRadiactividad()) false else self.masPoderQue(peligro)
	method aumentarEstrategia(cant) {
		estrategia += cant
	}
	
	method aumentarEspiritualidad(cant){
		espiritualidad += cant
	}
	
	method enfrentarPeligro(peligro) {
		 self.validarPeligro(peligro)
		 self.aumentarEstrategia(peligro.complejidad())
	}
	
	method validarPeligro(peligro){
		if (!self.puedoEnfrentar(peligro)) {
		 	throw new PeligroPeligrosoException()
		}
	} 
}

class MetaHumano inherits Personaje{
	override method capacidadBatalla() = super()*2
	override method soyInmuneRadiactividad() = true
	override method enfrentarPeligro(peligro) {
		super(peligro)
		self.aumentarEspiritualidad(peligro.complejidad())
	}
}

class Mago inherits MetaHumano{
	var property poderAcumulado
	override method capacidadBatalla() = super() + poderAcumulado
	override method enfrentarPeligro(peligro){
		if (poderAcumulado > 10) {
			super(peligro)
		}
		self.perderPoder()
			
	}
	
	method perderPoder(){
		poderAcumulado = (poderAcumulado - 5).max(0)
	}	
}