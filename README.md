# Examen Parcial: Feria Municipal

## Aclaraciones sobre el parcial

- El parcial es **individual** y se entrega **pusheando a este repositorio** como en las entregas anteriores. Recomendamos _ir pusheando cada cierto tiempo_ para evitar inconvenientes, lo ideal es después de cada punto resuelto.
- No se tendrán en cuenta los commits realizados después de la hora de finalización del examen.
- Una vez hecho el _push_ final, **verifiquen en github.com** que haya quedado la versión final. Nosotros corregiremos lo que está en github, si ustedes lo pueden ver ahí entonces nosotros también.
- No olvidarse de **los conceptos aprendidos**: polimorfismo, delegación, buenas abstracciones, no repetir lógica, guardar vs calcular, lanzar excepción cuando un método no puede cumplir con su responsabilidad, etc. Eso es lo que se está evaluando.
- La solución del examen consiste en la **implementación de un programa** que resuelva los requerimientos pedidos y sus **tests automatizados**.
- Este enunciado es acompañado con un archivo `.wtest` que tiene diseñado los test a realizar. Es importante aclarar que:
  - Estos tests se proponen para facilitar el desarrollo. Se puede diseñar otros si así se considera necesario.
  - El conjunto de tests propuesto es suficiente para este ejercicio. No hace falta agregar nuevos, pero tampoco se prohibe hacerlo.
  - Todos los objetos allí usados se asumen como instancias de una clase. Si el diseño de la solución utiliza objetos bien conocidos en algunos casos entonces se debe remover la declaración de la variable y la línea en que se sugiere la instanciación
  - Según el diseño de la solución, es probable que se requiera agregar más objetos a los sugeridos en los tests
  - Los tests están comentados de manera de poder _ir incorporándolos a medida que se avanza_ con la solución del ejercicio

# Feria Municipal

En una región se desarrolla periódicamente ferias con varios puestos para que disfrute la ciudadanía. 
A través de este sistema se pretende tener las herramientas para simular el evento y poder tomar así decisiones sobre
como organizar el evento real.

## Parte 1.1: Feria, Puestos y Visitantes

De una **feria** se conoce que puestos la componenen.

De una persona **visitante** se conoce, en principio, la edad y el dinero que tiene disponible.  

Según esa información se puede determinar si un puesto puede ser usado por ella o no, ya que hay distintas variantes de puestos: 

- Existen puestos de juegos y artes pensados para el sector **infantil**. Estos puestos solo pueden ser usados por personas que tienen menos de
18 años.
- Los puestos **comerciales** tienen un costo que se conoce para cada puesto. Una persona visitante puede usarlo si tiene suficiente dinero para pagar
 el costo.
 
 **Nota:** Mas variantes de puestos aparecerán 

### Requerimientos

- Saber si un visitante puede visitar un puesto
- Saber todos los puestos que un visitante puede vistar en la feria

### Casos de ejemplo

Visitantes:
- Remedios tiene 72 años, tiene 500 pesos disponible.
- Manuel tiene 7 años y tiene 30 pesos.
- Martin tiene 16 años y tiene 120 pesos.


La feria de la Av. Azurduy cuenta con 2 puestos:
- Un puesto comercial para jugar dardos con costo 50 pesos
- Un puesto infantil de arte  

Resultados:
- Remedios solo puede visitar los dardos de la feria. 
- Manuel solo puede visitar el puesto de arte.
- Martin puede visitar los los dardos y el puesto de arte.


**Nota** Pensar que puede haber muchos puestos comerciales e infantiles distintos. El puesto municipal siempre es único

## 1.2 Usar puesto

Cuando un visitante usa un puesto el sistema debe registrarlo, ya que es un requerimiento importante el 
saber cuales fueron los visitantes que han usado un determinado puesto.

Además, al usar el puesto ocurre algo dependiendo del puesto:
- Si se usa un puesto comercial, el visitante debe pagar el costo del mismo, por lo que se disminuye el dinero disponible).
- Si se usa un puesto infantil, el visitante gana 10 pesos

**Nota:** Tener en cuenta que un visitante solo tiene que poder usar un puesto que cumpla con las condiciones del punto anterior.

### Requerimientos:

- Saber que visitantes han usado un puesto.
- Saber el dinero de un visitante luego de haber usado uno o más puestos. 
- Saber si un visitante usó al menos un puesto de la feria.

### Casos de ejemplo

#### usar y comprobar efectos
- hacer que el puesto de dardos sea usado por remedios. 
- el puesto de arte no debe poder ser usado por remedios
- el puesto de dardos no debe poder ser usado por manuel 
- hacer que el puesto de arte sea usado por manuel 
- hacer que el puesto de dardos sea usado por martin. 
- hacer que el puesto de arte sea usado por martin

Luego de estas acciones comprobar que:
- El dinero de remedios es 450
- El dinero de manuel es  40
- El dinero de martín es 80
-el puesto de arte fue usado  por martin y manuel
-el puesto de dardos due usados por remedios y martin

#### seber si se usó o no una feria
- hacer que el puesto de dardos sea usado por remedios. 
- hacer que el puesto de dardos sea usado por manuel (NO SE PUEDE!)
- revisar que remedios usó la feria azurduy
- revisar que manuel no usó la feria azurduy
- revisar que martin no uso la feria azurduy

#### uso de la feria
- Verificar en este punto que tanto remedios como manuel han usado algún puesto de feria, pero martin no.

## 2. Municipios y Puestos municipales de impuesto

Todos los puestos tienen un municipio que los apadrina. 

Existen Los **puestos impositivos** a través de los cuales los visitantes 
puedan pagar toda o parte de su deuda municipal.

Por eso de cada visitante se conoce, además de lo explicado en el punto anterior, cuál es su municipio de residencia
y cuánto dinero le debe éste. De cada puesto (impositivo o no) se conoce, también, el municipio que lo apadrina.

Para que un puesto impositivo pueda ser usado por un visitante debe cumplirse que:
- El visitante debe residir en el mismo municipio que apadrina el puesto impositivo. 
- El visitante debe tener deuda 
- El visitante debe ser capaz de pagar el monto que el municipio exigible por el municipio. 

El monto exigible siempre se calcula como la resta de un monto bruto y un monto prorrogable.

```
   monto exigible = monto bruto - monto prorrogable
```

Para los ** municipios normales **, el monto bruto es la totalidad de la deuda del visitante, y el monto prorrogable
es el 10 por ciento del monto bruto si la persona es mayor de 75 años o 0 en otro caso.

Para los **municipios relajados ** el monto bruto es el número menor de entre la deuda y el dinero disponible,
mientras que el monto prorrogable es igual que los municipios normales

Para los **municipios hiper relajados", el monto bruto es el 80% del bruto de los **municipios relajados** y el 
monto prorrogable es el doble que el del resto de los municipios. pero además la edad para saber si corresponde o no
baja a 60 años.

### 2.1 Requerimientos:
- Saber el monto exigible por un municipio
- Saber si una persona visitante puede visitar un puesto impositivo

Nota: Es muy importante en este punto demostrar el dominio de la herencia para no duplicar código!

#### Ejemplo de monto exigible y puede visitar puesto municipal

Dado que:
- San Martín es un municipio normal
- Quilmes es un municipio Relajado
- Tigre es un municipio Hiper Relajado

Los valores de deuda y residencia de los mismos objetos usados en el punto anterior:
- Martin tiene una deuda de 80 pesos, vive en San Martin
- Manuel tiene una deuda de 0 pesos, vive en Quilmes
- Remedios tiene una deuda de 700 pesos, vive en Tigre

tanto puesto de arte como el de dardos es apadrinado por San Martin

Entonces:
- El monto exigible para martín es de 80, ya que la totalidad de su deuda es 80 y por tener mas de 75 años lo prorrogable es 0.
Cómo él posee 120 pesos puede usar un puesto impositivo de san martin. (pero ninguno impositivo de otro municipio)
- El monto exigible para manuel es de 0, ya que el número menor entre 0 (su deuda) y 30 (su dinero), es 0. la prorrogable es 0. 
Cómo él posee no posee deuda, no puede usar un puesto impositivo de Quilmes
- El monto exigible para remedios es 320, ya que el bruto es 400 por ser el 80% de 500, que es
 el menor numero entre 700 (su deuda) y 500 (su dinero), pero al tener más de 60 años recibe una prorraga de 80 pesos 
 (ya que 80 es el doble de 40, que es lo que recibiría de un municipio relajado) 
Cómo posee 500 pesos, es capaz de usar un puesto impositivo de Tigre

Por otro lado: 
-si remedios viviese en San Martín, el monto exigible sería de 700 (no entraría a la prórroga). Y por lo tanto no podría
usar un puesto impositivo de san martín
-si remedios viviese en Quilmes, el monto exigible sería de 500 (todo su dinero dispoble, pero sin prórroga porque no le da la edad),
peto si tuviera 80 años el monto exigible sería de 450, ya que recibiría 50 de prórroga. En ambos casos podría usar un puesto impositivo 
de Quilmes
 
### Usar puestos municipales

Cuando un visitante usa un puesto impositivo ocurre lo siguiente:

- queda registrado que la persona usó el puesto (como en todos los puestos)
- se le resta al visitante el monto exigible tanto de la deuda como del dinero
- se registra en algún lugar que el municipió recaudó el monto exigible, ya que es requerimiento saber cuanto es el total recaudado 
por un municipio

### 2.2 requerimientos

- hacer que un visitante pueda visitar un puesto impositivo
- saber el total recaudado por un municipio 
- saber cuantos puestos apadrina un municipio en una feria
- saber todos los municipios que apadrinan al menos un puesto en una feria
- saber el promedio de recaudación de los municipios de una feria
- saber el municipio que menos recaudó de una feria


### Caso de ejemplo

- Agregar en la feria de la avenida Azurduy un puesto impositivo para  Tigre y otro para  San Martín (no para quilmes)
(además de la de arte y dardos usado en puntos anteriores)
- juana reside en San Martin, tiene 20 años, 1000 pesos y una deuda de 300. 
- hacer que el puesto impositivo de tigre sea usado por remedios
- hacer que e puesto impositivo de san martin sea usado por Juana y por Martín
verificar que:
- martín no tiene mas deuda y le queda 40 de dinero
- juana no tiene más deuda y le queda 700 de dinero
- remedios tiene 380 de deuda y 180 de dinero
- tigre recaudó 320
- san martín recaudó 380
- tigre apadrina 1 puesto de la feria azurduy
- san martín apadrina 3 puestos de la feria azurduy
- quilmes no apadrina a nadie en la feria azurduy
- los municipios apadrinantes de la feria azurduy son tigre y san martín
- el promedio de racaudación de la feria azurduy es 350
- el municipio que menos recaudó en la feria es tigre


 

   




