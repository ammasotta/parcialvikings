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