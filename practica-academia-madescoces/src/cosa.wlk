class Cosa {
	var property marca
	var property magica
	var property volumen
	var property reliquia
	
	method utilidad() = volumen + self.utilidadAdicional(magica, 3) + self.utilidadAdicional(reliquia, 5) + marca.utilidad(self)
	method utilidadAdicional(tipo, cant) = if (tipo) cant else 0
}