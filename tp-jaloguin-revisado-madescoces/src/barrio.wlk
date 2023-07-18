object barrio {

	var property chicos = []

	method algunoMuyAsustador() = chicos
		.any({ _chico => _chico.capacidadSusto() > 42 })
	
	method chicosConMasCaramelos(_cantidadChicos) = chicos
		.sortedBy({ x, y => x.caramelos() > y.caramelos()})
		.take(_cantidadChicos)	
}