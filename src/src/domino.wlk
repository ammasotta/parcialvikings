// Vikingos

class Vikingo {
	var casta
	var oro = 0
	
	constructor(_casta){
		casta = _casta
	}
	
	method casta() = casta
	
	method casta(_casta){
		casta=_casta
	}
	
	method oro() = oro
	
	method soyProductivo()

	method noTieneArmas()
	
	method puedoSubir() = self.soyProductivo() and casta.puedoSubir(self)
	
// Este es el punto de entrada para el punto 5 que es el de hacer que un vikingo escale socialmente.
	
	method ascender(){
		casta.ascender(self)
	}
	
	method mejorar()
	
	method agregarOro(_oro){
		oro += _oro
	}
	
	method cobrarVida()
	
	method vidasTomadas()
	
	method vidasTomadas(_vidasTomadas)
	

}

class Soldado inherits Vikingo {
	var armas = 0
	var vidasTomadas = 0
	
	method armas(_armas){
		armas=_armas
	}
	
	override method vidasTomadas() = vidasTomadas
	
	override method vidasTomadas(_vidasTomadas){
		vidasTomadas=_vidasTomadas
	}
	
	override method noTieneArmas() = armas==0
	
	override method soyProductivo() = not self.noTieneArmas() and vidasTomadas>20
	
	override method mejorar(){
		armas += 10
	}
	
	override method cobrarVida(){
		vidasTomadas += 1
	}
}

class Granjero inherits Vikingo {
	var hijos = 0
	var hectareas = 0
	
	override method noTieneArmas() = true
	
	override method soyProductivo() = hectareas >= hijos*2
	
	override method mejorar(){
		hijos += 2
		hectareas += 2
	}
	
	override method cobrarVida(){}
	
	override method vidasTomadas(){}
	
	override method vidasTomadas(_vidasTomadas){}
}




// Castas
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



//Expediciones
class Expedicion {
	var lugaresInvolucrados = #{}
	var vikingos = #{}
	
	constructor(_lugaresInvolucrados){
		lugaresInvolucrados = _lugaresInvolucrados
	}

// Este es el punto de entrada para el punto 1 que es el de subir un vikingo a una expedicion.

	method subirVikingo(vikingo){
		if(not vikingo.puedoSubir()){
			throw new NoPuedoSubirVikingoException()
		}
		else {
			vikingos.add(vikingo)
		}
	}
	
	method cantVikingos()=vikingos.size()

// Este es el punto de entrada para el punto 2 que es el de preguntarle a una expedicion si vale la pena.

	method valgoLaPena() = lugaresInvolucrados.all({lugar=>lugar.valgoLaPena(self.cantVikingos())})
	
	method botin() = lugaresInvolucrados.sum({lugar=>lugar.botin(self.cantVikingos())})
	
	method botinPorVikingo() = self.botin() / self.cantVikingos()
	
// Este es el punto de entrada para el punto 3 que es el de realizar una expedicion y que tenga su efecto.
	
	method realizarme(){
		vikingos.forEach({vikingo=>vikingo.agregarOro(self.botinPorVikingo())})
		lugaresInvolucrados.forEach({lugar=>lugar.serInvadidoEn(self)})
	}
	
	method tomarCiertaCantidadDeVikingos(cant)=vikingos.asList().take(cant)
	
	method agregarMuertes(defensoresDerrotados){
		(self.tomarCiertaCantidadDeVikingos(defensoresDerrotados)).forEach({vikingo=>vikingo.cobrarVida()})
	}

}



//Lugares
class Capital {
	var factorRiqueza
	var defensores
	
	constructor(_factorRiqueza,_defensores){
		factorRiqueza=_factorRiqueza
		defensores=_defensores
	}
	
	method defensores() = defensores
	
	method defensoresDerrotados(cantVikingos) = defensores.min(cantVikingos)
	
	method botin(cantVikingos) = self.defensoresDerrotados(cantVikingos)*factorRiqueza
	
	method valgoLaPena(cantVikingos) = self.botin(cantVikingos) >= cantVikingos*3
	
	method serInvadidoEn(expedicion){
		expedicion.agregarMuertes(self.defensoresDerrotados(expedicion.cantVikingos()))
		defensores -= self.defensoresDerrotados(expedicion.cantVikingos())
	}
}

class Aldea {
	var cantTotalDeCrucificos
	var sedDeSaqueo = 15
	
	constructor(_cantTotalDeCrucificos){
		cantTotalDeCrucificos = _cantTotalDeCrucificos
	}
	
	method cantTotalDeCrucificos() = cantTotalDeCrucificos
	
	method botin(vikingos) = cantTotalDeCrucificos
	
	method condicionExtra(vikingos) = true
	
	method valgoLaPena(cantVikingos) = self.botin(cantVikingos) >= sedDeSaqueo and self.condicionExtra(cantVikingos)
	
	method serInvadidoEn(expedicion){
		cantTotalDeCrucificos = 0
	}
}

class AldeaAmurallada inherits Aldea {
	var cantMinimaDeVikingos
	
	constructor(_cantTotalDeCrucificos,_catMinimaDeVikingos) = super(_cantTotalDeCrucificos){
		cantMinimaDeVikingos=_catMinimaDeVikingos
	}
	
	override method condicionExtra(cantVikingos) = cantVikingos >= cantMinimaDeVikingos
}

class NoPuedoSubirVikingoException inherits Exception {}




/*
 1. El punto de entrada es el metodo subirVikingo(vikingo) que pertenece a la expedicion y debe recibir el vikingo a subir.
 
 2. El punto de entrada es el metodo valgoLaPena() que pertenece a la expedicion y no recibe ningun parametro.

 3. El punto de entrada es el metodo realizarme() que pertenece a la expedicion y no recibe ningun parametro.

 4. Pregunta teórica

	Si aparecieran los castillos se podria agregar al codigo existente sin modificar nada, solo sería necesario que los 
castillos sean polimorficos con las capitales, las aldeas y las aldeas amuralladas, en los metodos necesarios para 
que se haga una expedicion (que son valgoLaPena, botin y serInvadidoEn).Es decir, es necesario que los castillos cumplan
con la interfaz que comparten las capitales, las aldeas y las aldeas amuralladas. Por lo tanto, la clase Castillo, deberia
de tener esos metodos implementados para que pueda entender los mismos mensajes.
 
 5. El punto de entrada es el metodo ascender() que pertenece al vikingo y no recibe ningun parametro.
 
 */

