class Marca {
	method utilidad(cosa)
}

object cuchuFlicto inherits Marca{
	override method utilidad(cosa) = 0
}

object acme inherits Marca{
	override method utilidad(cosa) = cosa.volumen() / 2
}

object fenix inherits Marca{
	override method utilidad(cosa) = if (cosa.reliquia()) 3 else 0
}

