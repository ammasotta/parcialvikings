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
	
	method valgoLaPena(vikingos) = self.botin(vikingos) >= sedDeSaqueo and self.condicionExtra(vikingos)
	
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