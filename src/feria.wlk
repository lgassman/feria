/** First Wollok example */
class Feria {
	
	const puestos=#{}
	
	method visitables(visitante) {
		return puestos.filter({puesto=> puesto.puedeUsar(visitante)})
	}
	
	method uso(visitante) {
		return puestos.any({puesto => puesto.uso(visitante)})
	}
	method agregar(puesto) {
		puestos.add(puesto)
	}

	method cuantosApadrina(municipio) {
		return puestos.count({puesto => puesto.municipio() == municipio})
	}
	method municipios() {
		return puestos.map({puesto => puesto.municipio()}).asSet()
	}
	method promedioRecaudacion() {
		return self.municipios().sum({municipio => municipio.recaudacion()}) / self.municipios().size()
	}
	method menosRecaudador() {
		return self.municipios().min({municipio => municipio.recaudacion()})
	}
}

class Puesto {
	
	const property visitantes=#{}
	const property municipio
	
	method puedeUsar(visitante)
	
	method uso(visitante) {
		return visitantes.contains(visitante)
	}
	
	method validarVisita(visitante) {
		if(not self.puedeUsar(visitante)) {
			self.error(visitante + " no puede usar " + self)
		}
	}
	method usar(visitante) {
		self.validarVisita(visitante)
		visitantes.add(visitante)
	}
}

class PuestoInfantil inherits Puesto {
	override method puedeUsar(visitante) {
		return visitante.esMenor()
	}	
	
	override method usar(visitante) {
		super(visitante)
		visitante.ganar(10)
	}
}

class PuestoComercial inherits Puesto{
	const costo
	
	override method puedeUsar(visitante) {
		return visitante.dinero() >= costo
	}
	
	override method usar(visitante){
		super(visitante)
		visitante.pagar(costo)
	}
} 

class Visitante {
	
	var property edad
	var property municipio
	var property dinero
	var property deuda
	
	method esMenor() {
		return edad < 18
	}
	
	method puedePagarDeuda() {
		return dinero > deuda
	}
	
	method pagarDeuda(valor) {
		console.println("valor" + valor + " diner " + dinero + " deuda " + deuda)
		dinero = dinero - valor
		deuda = deuda - valor
		console.println("valor" + valor + " diner " + dinero + " deuda " + deuda)
	}
	
	method pagar(costo) {
		dinero-=costo
	}
	
	method ganar(cuanto) {
		dinero +=cuanto
	}
	
	method residente(_municipio) {
		 return municipio == _municipio
	}
}


class Municipio{
	
	var property recaudacion=0
	method puedePagarDeuda(visitante) {
		return visitante.deuda() > 0  and 
				visitante.residente(self) and 
				self.montoExigible(visitante) <= visitante.dinero()
	}
	
	method pagarDeuda(visitante) {
		const rec = self.montoExigible(visitante)
		visitante.pagarDeuda(rec)
		recaudacion += rec
	}
	
	
	method montoExigible(visitante) {
		return self.bruto(visitante) - self.prorrogable(visitante)
	}
	
	method bruto(visitante) {		
 		return visitante.deuda()
	}
	
	method prorrogable(visitante) {
		return if (visitante.edad() > self.edadProrroga()) {
			self.bruto(visitante)*0.1
		} 
		else {
			0
		}
	} 
	
	method edadProrroga() {
		return 75
	}
}

class MunicipioRelajado inherits Municipio {
	
	override method bruto(visitante) {
		return visitante.deuda().min(visitante.dinero())
	}
}

class MunicipioHiperRelajado inherits MunicipioRelajado {
	
	override method bruto(visitante) {
		return super(visitante) * 0.80
	}
	override method prorrogable(visitante) {
		return super(visitante) * 2
	}
	override method edadProrroga() {
		return 60
	}
}

class Impositivo inherits Puesto{
	var property recaudado = 0
	
	override method puedeUsar(visitante) {
		return municipio.puedePagarDeuda(visitante)
	}
	
	override method usar(visitante){
		super(visitante)
		municipio.pagarDeuda(visitante)
	}
} 



