import pandemia.*

class Trabajo{
	var property bono
	var property base
			
	method salario() = base + self.extra()
	method extra()
	method presencial()
}

class TrabajoNormal inherits Trabajo{
	var property fasePermitida
	override method presencial() = fasePermitida <= pandemia.fase()
	override method extra() = if (self.presencial()) bono else 0
}

class TrabajoEscencial inherits Trabajo{
	override method presencial() = true
	override method extra() = bono*((5 - pandemia.fase())/4)
}

class TrabajoSanitario inherits TrabajoEscencial{
	override method extra() = super() + 5000
}