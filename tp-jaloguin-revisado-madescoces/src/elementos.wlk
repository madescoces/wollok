object trajeDeBruja {
	method nivelSusto() = 10
} 

object barba {
	var property tamanio = 2
	method nivelSusto() = tamanio * 5 	
}

object mascaraDracula {
	const tamanio = 2
	method nivelSusto() = tamanio * 2
}

object mascaraFrankenstein {
	const tamanio = 22
	method nivelSusto() = tamanio
}

object mascaraPolitico {
	var politico = macri
	method nivelSusto() = politico.promesasPoliticas()
	
}

object macri {
	method promesasPoliticas() = 10
}