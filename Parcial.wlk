object intensidadGlobal {
    var property intensidadLimite = 20
    const personas = []
    method agregarPersonas (persona) = personas.add(persona)
    method vivirEventoEnGrupo (evento) {
        personas.forEach{persona=>persona.vivirEvento(evento)}
    }

  
}
class Persona {
    var edad
    const emociones=[]

    method esAdolecente () = edad.between(12, 19)

    method adquerirEmocion (emocion) = emociones.add(emocion)

    method vaExplotar () = emociones.all{emocion=>emocion.puedeLiberarse()}

    method vivirEvento (evento) {
        emociones.forEach{emocion => emocion.intentarSerLiberada(evento)}

    }

}

class Evento {
    var property impacto 
    var property descripcion 

}
class Emocion {
    var eventosVividos = 0
    var property intensidad 
    method condicion ()
    method puedeLiberarse () = intensidad > intensidadGlobal.intensidadLimite() and  self.condicion()
    
    method liberarse (evento) {
        self.intensidad(intensidad-evento.impacto())
    }

    method intentarSerLiberada(evento) {
        if (self.puedeLiberarse())
        self.liberarse(evento)
        eventosVividos +=1  
    }


}
class Furia inherits Emocion(intensidad=100) {
    const palabrota = []
    override method condicion ()= 
        palabrota.any{p=>p.size()>=7}
    
    override method liberarse (evento) {
        super(evento) 
        palabrota.remove(palabrota.first())
    }
    method aprenderPal (p) = palabrota.add(p)    
}

class Alegria inherits Emocion {
override method condicion () =
    eventosVividos.even()   
override method intensidad (valor) {intensidad = valor.abs()} 
}


class Tristeza inherits Emocion {
    var property causa = "melancolia"

override method condicion() =
    causa != "melancolia"


override method liberarse(evento){
        super(evento)
        causa = evento.descripcion()

     }
}

class DesagradoyTemor inherits Emocion {
    override method condicion () = eventosVividos >  self.intensidad()
}



class Ansiedad inherits Emocion{
    override method condicion() = eventosVividos >= 5
    override method intensidad (evento) { intensidad = evento.impacto()*10} 
}


// Los conceptos de herencia y polimorfismo , me sirvieron para ahorrar codigo y hacerlos mas optimo
// ya que no solo en ansiedad , si no que todas las emociones entendian el mismo mensaje
// ademas de que en su mayoria heredaban los mismos atributos y entendian los mismos mensajes lo que esto hacia mas facil su implementacion.
