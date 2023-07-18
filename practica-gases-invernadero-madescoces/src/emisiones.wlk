object ley {
	var property max = null	
}

class Region{
	const property campos = #{}
	
	method addCampo(campo){
		campos.addAll(campo)
	}
		
	method maximosEmisores() = campos.flatMap( { campo => campo.maxEmisor() } )
			
	method esSana() = campos.all({ campo => campo.emisionSuperficial() < 300 })
	
	method campoContaminate() = campos.filter({ campo => campo.emisionSuperficial() >= 300 })
}

class Campo{
	
	const property superficie
	const actividades = #{}
	
		
	method emisionSuperficial() = self.emisionAnual()/superficie
	method emisionAnual() = actividades.sum({ act => act.emisionAnual()}) 
	
	method addActividad(act){
		if(self.leyPermiteActividad(act)) {
			actividades.add(act) 
		} else {
			throw new BussinessException(message = 'No se puede agregar otra actividad, se superó el máximo de emisiones')
		}
	}
	
	method maxEmisor() = #{actividades.max({ act => act.emisionAnual() })}
	method leyPermiteActividad(act) = ((act.emisionAnual()+self.emisionAnual()) < ley.max())
	method existe(act) = actividades.any({ activ => activ.equals(act)})		
}

class Actividad{
	var property elementosDeProduccion
	var property elementos = #{}
	method emisionAnual()
	
	method agregarElemento(gen){
		elementos.addAll(gen)	
	}
}

class Ganaderia inherits Actividad{
	override method emisionAnual() = elementosDeProduccion*elementos.sum({ e => e.emisionAnual(elementosDeProduccion) })
}

class Forestacion inherits Actividad{
	override method emisionAnual() = (-100 * elementosDeProduccion + elementos.sum({ e => e.emisionAnual() }))
}

class Industrial inherits Actividad{		
	override method emisionAnual() = elementos.sum({ e => e.emisionAnual(self)})
}

class IndustrialCapturaGas inherits Industrial{
	override method emisionAnual() = super()/3
}

class MaquinaForestacion{
	const property emisionAnual
}

class Generador{
	method emisionArranque() = null
	method emisionPorUnidad() = null
	method emisionAnual(act)
}

class GeneradorDiesel inherits Generador{
	const emisionPorUnidad
	method emisionArranque(act) = act.elementosDeProduccion()/10
	override method emisionAnual(act) = ( self.emisionArranque(act) + act.elementosDeProduccion()*emisionPorUnidad)
}

class GeneradorEcoDiesel inherits GeneradorDiesel{
	override method emisionArranque(act) = super(act)*0.2
}

class GeneradorEolico inherits Generador{
	const emisionArranque
	const property mantenido = true
	
	override method emisionAnual(act) = (emisionArranque + act.elementosDeProduccion() * (if (mantenido) 2 else 3))
}

class Animal{
	method emisionAnual(cant)
}

class Vaca inherits Animal{
	override method emisionAnual(cant) = 1500
}

class Cerdo inherits Animal{
	override method emisionAnual(cant) = if(cant > 100) 1200 else 1000
}

class BussinessException inherits Exception{}