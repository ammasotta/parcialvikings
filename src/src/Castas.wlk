/* 
	Hice que cada casta social sea un objeto porque las castas siempre se comportan igual y no varia dependiendo del vikingo,
entonces no es necesario hacer una clase por cada casta e instanciarla para cada uno de los vikingos.
	Si despues apareciera un comportamiento especifico en alguna de las castas que hace que dependa de cada vikingo, ahi si
habría que hacer que esa casta sea una clase.
	Siempre todas las castas tienen que ser polimorficas, independientemente si son todas objetos o clases, 
o si algunas son objetos y otras clases.
*/

object jarl {
	method puedoSubir(vikingo) = vikingo.noTieneArmas()
	
	method ascender(vikingo){
		vikingo.casta(karl)
		vikingo.mejorar()
	}
}

object karl {
	method puedoSubir(vikingo) = true
	
	method ascender(vikingo){
		vikingo.casta(thrall)
	}
}

object thrall {
	method puedoSubir(vikingo) = true
	
	method ascender(vikingo){}
}