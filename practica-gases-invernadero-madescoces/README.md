# Emisiones de gases de efecto invernadero

El calentamiento global es uno de los problemas más importantes de la actualidad y del futuro cercano. La emisión de gases
de invernadero, entre los que se destaca el dióxido de carbono, es una de las causas más influyentes. Por ese motivo nos han 
pedido un programa que ayude a tomar decisiones sobre el uso de las tierras.

*** 
Nota: Las reglas de negocio y los valores aquí expresados son elegidos con fines didácticos para el ejercicio
de la programación con objetos. Para interiorizarse en el problema real se puede consultar muchas fuentes,
un buen lugar para arrancar siempre es la [wikipedia](https://es.wikipedia.org/wiki/Emisiones_de_di%C3%B3xido_de_carbono)
***


## Aclaraciones sobre el parcial
- El parcial es **individual** y se entrega **pusheando a este repositorio** como en las entregas anteriores. Recomendamos _ir pusheando cada cierto tiempo_ para evitar inconvenientes, lo ideal es después de cada punto resuelto.
- No se tendrán en cuenta los commits realizados después de la hora de finalización del examen.
- Una vez hecho el _push_ final, **verifiquen en github.com** que haya quedado la versión final. Nosotros corregiremos lo que está en github, si ustedes lo pueden ver ahí entonces nosotros también.
- No olvidarse de **los conceptos aprendidos**: polimorfismo, delegación, buenas abstracciones, no repetir lógica, guardar vs calcular, lanzar excepción cuando un método no puede cumplir con su responsabilidad, etc. Eso es lo que se está evaluando.
- La solución del examen consiste en la **implementación de un programa** que resuelva los requerimientos pedidos y sus **tests automatizados**.
- Este enunciado es acompañado con un archivo `.wtest` que tiene diseñado los test a realizar. Es importante aclarar que:
  - Estos tests se proponen para facilitar el desarrollo. Se puede diseñar otros si así se considera necesario.
  - El conjunto de tests propuesto es suficiente para este ejercicio. No hace falta agregar nuevos, pero tampoco se prohíbe hacerlo.
  - Todos los objetos allí usados se asumen como instancias de una clase. Si el diseño de la solución utiliza objetos bien conocidos en algunos casos entonces se debe remover la declaración de la variable y la línea en que se sugiere la instanciación
  - Según el diseño de la solución, es probable que se requiera agregar más objetos a los sugeridos en los tests
  - Los tests están comentados de manera de poder _ir incorporándolos a medida que se avanza_ con la solución del ejercicio

## 1. Emisiones de un campo

Un **campo**  es una porción de tierra que tiene una **superficie** y en la cuál se pueden realizar muchas **actividades** distintas a la vez.

Interesa saber **la emisión superficial** anual de un campo. 
Ésto es un calculo que significa cuánto gas emite un campo por cada hectárea de superficie durante un año.
Para poder calcularlo es necesario obtener la **emisión total** anual, que es la sumatoria de las emisiones de gas que cada actividad produce al año.
Luego, al dividirlo por por la superficie se obtiene la emisión superficial 

```
emision total de un campo: sumatoria de las emisiones de las actividades
emisión superficial de un campo:  emisión total / superficie
```

Nota: Todos los valores están expresados en las mismas unidades para evitar tener
que pensar en eso durante el examen. Solo preocuparse por resolver bien las cuentas. 

Para este primer punto sólo se piden dos sabores de actividades: **Ganadería** y **Forestación**

### Ganadería: 

De una actividad ganadera se conoce la cantidad de animales y el tipo de animal. La emisión anual es la multiplicación de la 
cantidad de animales por la emisión que produce cada animal al año. Se sabe que las vacas emiten 1500 kg al año mientras que 
los cerdos dependen de que tan amontonados estén: si la actividad ganadera tiene más de 100 animales entonces cada uno emite 1200
si no cada uno emite 1000. 

```
emisión anual: cantidad * emisión del tipo de animal
```

Nota: En un futuro se espera poder agregar nuevo tipos de animales de una manera sencilla 
 
### Forestación:

La forestación es una actividad que ayuda a reducir la cantidad de emisiones, por eso la fórmula de cálculo
suele devolver un valor negativo. De una actividad forestal se conoce la cantidad de árboles plantados y la cantidad de emisiones
de gases que emiten las herramientas usadas. La fórmula es:

```
emisión anual: (-100 * cantidad) + emisiones de herramientas
```
### Requerimientos:

1.1 Saber la emisión de una actividad (tanto ganadera como forestal)
1.2 Saber la emisión total de un campo  
1.2 Saber la emisión superficial de un campo
 
### Ejemplo:

La hacienda "La Ponderosa" es un campo de una superficie de 1000 hectáreas.
Tiene 3 actividades:

1.1. Una actividad ganadera denominada "principal" que trabaja con 200 cerdos. 
1.2. Una actividad ganadera denominada "secundaria" que trabaja con 50 vacas
1.3. Un bosque de pinos, que es una actividad forestal de 100 pinos, cuyas herramientas tienen una emisión anual de 50.

Las emisiones para cada actividad deberían ser:

* Ganadera principal: 240000
* Ganadera secundaria: 75000
* bosque de pinos: -9950


La emisión total de La Ponderosa es *** 305050 ***
La emisión superficial de La Ponderosa es de ***305.05*** 

Para una actividad ganadera de **10** cerdos la emisión es de  **10000**, ya que son pocos cerdos

## 2. Agregar una actividad a un campo

Un campo puede agregar cualquier actividad siempre y cuando
dicha acción no haga que el campo supere el valor máximo de emisiones totales 
determinado por ley.

Este valor máximo es configurable para todo el sistema y puede variar. 
Siempre es el mismo para todos los campos

** TIP: ** Modelen el objeto ley!

## Requerimientos
2.1. Saber si una actividad se puede agregar a un campo
2.2. Agregar una actividad a un campo

**Recordatorio:** Qué pasa si se pide agregar una actividad que viola la ley?  

### Ejemplo
La ponderosa tiene una emisión total de 305050, si 
la ley permite un máximo de  315000 no se podría agregar
una nueva actividad ganandera de 10 cerdos, ya que esta actividad haría que la
emisión total de la ponderosa se vaya a 315050. Pero en cambio si la ley
permitiera un máximo de 320000 sí podría.

## 3. Actividad Industrial

Una actividad industrial también se puede realizar en un campo,
al igual que las otras actividades emiten cierta cantidad de gases al año.

La cantidad que emite depende de los **generadores** de energía que utilice
para lograr satisfacer la **producción**.

La producción es un número de unidades que se indica para cada actividad industrial.

```
	emisión: sumatoria de los emisiones de generadores
```
Un generador emite una cantidad de gases debido a la puesta en marcha
y otra cantidad debida a la fabricación de cada unidad de producción:
```
   emisión de un generador: emisión puesta en marcha + emisión para la fabricación
``` 

Los valores de puesta en marcha y de emisión para la fabricación se calculan según 
la tecnología del generador:


Un **generador diésel** emite `producción / 10` para ponerse en marcha. 
Para la fabricación emite una cantidad de gas configurable multiplicado por la producción. 

```
   emisión: (producción/10) + (producción * emisionPorUnidad)
```

Un **generador eólico** emite para la puesta en marcha un valor que se indica para cada
generador. Para la fabricación  gasta 2 por cada unidad de producción si es que el mismo
recibe mantenimiento regularmente o 3 si no lo recibe. Se conoce
para cada generador si se mantiene regularmente o no.

```
   emisión: (emisionDeArranque) + (producción * (2 ó 3) )
```

### Requerimientos:

3.1 Agregar al modelo las actividades industriales.
Ahora un campo puede tener actividades ganaderas, forestales y/o industriales.
Obviamente, hacer que la actividad insdustrial pueda calcular la emisión según 
lo explicado hasta aquí.


### Ejemplo

La industria Acme tiene una producción anual de 500 unidades,
cuenta con dos generadores. Uno diésel que gasta 100 por cada unidad de producción 
y uno eólico que recibe mantenimiento regularmente emitiendo
10 en cada arranque. 

Por lo tanto la emisión del diésel es de 
``` 
 (500 / 10) + (500 * 100) = 50050
``` 
y la emisión del eólico:
```
  (10) + (500 * 2) = 1010
```

En total industria Acme emite 

```
 50050 + 1010 = 51060
```

## 4. Técnicas para reducir las emisiones

### 4.1 Industrias capturadoras de gases

La captura y almacenamiento es una técnica que evita emitir todos los gases,
capturándolos en contenedores y/o inyectándolos de nuevo en la tierra. Podés leer más
[acá](https://es.wikipedia.org/wiki/Captura_y_almacenamiento_de_carbono) luego de resolver el ejercicio.

Una industria capturadora de gases emite 3 veces menos que una normal.

### 4.2 Generadores EcoDisesel

Existe un modelo de generador EcoDiesel que funciona
igual que un diésel pero emite solo un 20% de gases en la puesta en marcha
que un diésel común.

### Requerimientos

4.1 Agregar al modelo la capacidad de que un campo posea actividades industriales capturadoras de gases
4.2 Agregar al modelo la capacidad de que una actividad industrial tenga generadores ecodiesels
 
### Ejemplos

 * La Industria Vandelay, una industria que captura los gases y tiene la misma producción y generadores 
 que Acme (ver punto anterior) emite 17.020
 
 * La aceitera Genco, una industria común, tiene una producción de 100 unidades 
 y un generador Ecodisel que gasta 50 por unidad de consumo.
 La emisión es de:
 
``` 
 (100 / 10)*0.2 + (50 * 100) = 5002 
``` 
  
## 5. Regiones

 Una región contiene un conjunto de campos. 

### Requerimientos
 1. Saber las actividades que más gases emiten de la región: De cada campo
 nos interesa la que emite más gases
 2. Saber si una región es sana: Es sana cuando todos 
 los campos tienen una emisión superficial menor a 300
 3. Saber cuales campos de una región impiden que la region sea sana,
 Es decir, cuales son los campos con una emisión superficial mayor o igual a 300 
 
### Ejemplos:
 El centro industrial es un campo de superficie 200 que tiene como actividades la indutria
 Vandelay y la aceitera Genco.
 La región norte tiene los campos la ponderoza y el centro industrial.
 
 1. Las actividades que más gases emiten en la región norte son la ganadería primaria por
 parte de la Ponderosa e Industria Vandelay por parte del centro industrial
 2. La región norte, no es sana.
 3. Al consultar por los campos que impiden que la region norte sea sana sólo se obtiene La Ponderosa.
 
 Pero si se agrega un bosque de cedros a La Ponderosa (una actividad forestal de 1000 unidades con emisión
 de 10 por sus herramientas), la región pasa a ser sana y al consultar por los campos que impiden
 a que la región norte sea sana no se encuentra ninguno.
  
 Para poder agregar el bosque de cedros sin problemas a la ponderosa, se puede configurar la ley con el mismo
 valor usado en el punto 2: 315000
 
 
 
 
 
 
 
 
 
 
 
  




