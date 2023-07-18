// Refiere a familia de mafiosos
class Familia{
	const property mafiosos = []
	
	method mafiosoMasPeligroso() = mafiosos.max({ mafioso => mafioso.nivelIntimidacion() })
	
	method agregarMafioso(mafioso){
		mafiosos.add(mafioso)
	}
	
	method sonSoldados() = mafiosos.filter({ mafioso => mafioso.tipoMafioso() == soldado })	
	method sonSubjefes() = mafiosos.filter({ mafioso => mafioso.tipoMafioso() == subjefe })	
		
	method promoverADon() { 
		self.mafiosoMasPeligroso().tipoMafioso(don)
	}
	
	method promoverSoldados() {
		self.soldadosPromovibles().forEach({ soldado => soldado.promover()})
	}
	
	method soldadosPromovibles() = self.sonSoldados().filter({ soldado => soldado.armasEnCondiciones() > 2 and soldado.vivo()})
	
	method subjefesDegradables() = self.sonSubjefes().filter({ subjefe => subjefe.armasEnCondiciones() < 2 and subjefe.vivo()})
	
	method degradarSubjefes() {
		self.subjefesDegradables().forEach({ subjefe => subjefe.degradar()})
	}
	
	method miembrosVivos() = mafiosos.filter({ mafioso => mafioso.vivo()})
	
	method don() = mafiosos.find({ mafioso => mafioso.tipoMafioso() == don })
	
	method donVivo() = self.don().vivo()
	
	method velar(){
		self.validar()		
		self.promoverSoldados()
		self.degradarSubjefes()
		self.miembrosVivos().forEach({ mafioso => mafioso.agregarArma(new Revolver()) })
		self.promoverADon()
	}
	
	method validar() {
		if(self.donVivo()){
			throw new DonExecption()
		}
	}
}

class DonExecption inherits Exception( message= "El don esta vivo"){}

class Arma {
	method buenEstado()
	method peligrosidadBase()
	method peligrosidad() = if (self.buenEstado()) self.peligrosidadBase() else 1
	
	method atacar(victima) {
		if(self.buenEstado()) self.ataqueMortal(victima) else self.ataqueFallido(victima)
	}
	
	method ataqueMortal(victima) {
		victima.morir()
	}
	
	method ataqueFallido(victima) {
		victima.recibirHerida()
	} 
}

class Revolver inherits Arma{
	var property balas = 6
	var property disparos = 0
	
	override method peligrosidadBase() = balas*2
	override method buenEstado() = balas > 0
	
	override method atacar(victima){
		super(victima)
		self.disparar()
	}
	
	override method ataqueFallido(victima) {} 
	
	method disparar() {
		disparos += 1
		balas -= 1
	}
	
	method recargar() {
		balas = 6
	}
	
}

class RevolverOxidado inherits Revolver{
	
	override method peligrosidadBase() = super().div(2)
	
	override method atacar(victima){
		if (disparos == 3) {
			self.ataqueFallido(victima)
			disparos = 0
		} else {
			super(victima)
		}
	}
}

class Daga inherits Arma{
	const property peligrosidadBase
	override method buenEstado() = true
	
	override method atacar(victima) {
		victima.recibirHerida()
	}
	
	override method ataqueFallido(victima) {}
}

class CuerdaPiano inherits Arma{
	var property tensa
	override method buenEstado() = tensa
	override method peligrosidadBase() = 5
}

class Persona{	
	const property armas = []
	var property vivo = true
	var property tipoMafioso
	var heridas = 0	
	
	method recibirHerida(){			
		heridas += 1
		self.heridaFatal()
	}
	
	method heridaFatal(){
		if( heridas >= 3 ){
			self.morir()
		}
	}
	
	method morir() {
		vivo = false
	}
	
	method promover(){
		if (tipoMafioso == soldado){
			tipoMafioso = subjefe
		}
	}
	
	method degradar(){
		if (tipoMafioso == subjefe){
			tipoMafioso = soldado
		}
	}		
	
	method cambiarTipoMafioso(tipo) {
		tipoMafioso = tipo
	}
	
	method removerArma(arma) { armas.remove(arma) }
	
	method agregarArma(arma) { armas.add(arma) }
	
	method armasEnCondiciones() = armas.count({ arma => arma.buenEstado() })
	
	method trabajar(victima) {
		if(tipoMafioso == don) victima.perderArmas() else victima.recibirAtaque(self)
	}
	
	method ataqueSorpresa(familia){
		self.trabajar(familia.mafiosoMasPeligroso())
	}
	
	method perderArmas() {
		armas.clear()
	}
	
	method recibirAtaque(mafioso){
		mafioso.armaElegida().atacar(self)	 
	}
	
	method nivelIntimidacion() = tipoMafioso.nivelIntimidacion(armas)
	method armaElegida() = tipoMafioso.armaElegida(armas)		
}

class Mafioso{	
	method armaElegida(armas)
	method nivelIntimidacion(armas) = armas.sum( { arma => arma.peligrosidad() })		
}

object don inherits Mafioso{
	override method armaElegida(armas) {}
	override method nivelIntimidacion(armas) = super(armas) + 20
}

object subjefe inherits Mafioso{
	override method armaElegida(armas) = armas.findOrElse({ arma => arma.buenEstado() }, { armas.first() })
	override method nivelIntimidacion(armas) = super(armas)*2	
}

object soldado inherits Mafioso{
	override method armaElegida(armas) = armas.first()
}