import exceptions.*

const CONTENEDORESMINIMOS = 3

class Academia {
	const property contenedores = new List()
	
	method estaEnAcademia(cosa) = contenedores.any{contenedor => contenedor.tieneCosa(cosa)}
	method estaEnElMueble(cosa) = contenedores.findOrElse({ contenedor => contenedor.tieneCosa(cosa)}, {false})
	method hayDondeGuardar(cosa) = contenedores.any{ contenedor => contenedor.puedeGuardar(cosa)}
	method puedeGuardar(cosa) = !self.estaEnAcademia(cosa) && self.hayDondeGuardar(cosa)
	method sePuedeGuardarEn(cosa) = contenedores.filter{ contenedor => contenedor.puedeGuardar(cosa) }
	method cosasMenosUtiles() = contenedores.map{contenedor => contenedor.cosaMenosUtil()}	
	method cosasMenosUtilesNoMagicas() = self.cosasMenosUtiles().filter{cosa => !cosa.magica()}	
	method cosaMenosUtil() = self.cosasMenosUtiles().min{ cosa => cosa.utilidad()}
	method marcaMenosUtil() = self.cosaMenosUtil().marca()
			
	method guardarCosa(cosa){		
		self.validarGuardado(cosa)
		self.sePuedeGuardarEn(cosa).first().guardarCosa(cosa)
	}
	
	method removerMenosUtiles(){
		self.validarCantidadContenedores()
		self.cosasMenosUtilesNoMagicas().forEach{cosa => self.removerCosa(cosa)}
	}
	
	method removerCosa(cosa){
		contenedores.forEach{contenedor => contenedor.removerCosa(cosa)}
	}
	
	method validarCantidadContenedores(){
		if (contenedores.size() < CONTENEDORESMINIMOS){
			throw new NoPuedoRemvoerException()
		}
	}
	
	method removerContenedor(contenedor){
		contenedores.remove(contenedor)
	}
	
	method validarGuardado(cosa){
		if (!self.puedeGuardar(cosa)){
			throw new NoPuedoGuardarException()
		}
	}
}
