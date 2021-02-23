#  Copiar y pegar en Vi/Vim


nullDesde un tiempo a esta parte, influenciado por la presencia en mi lugar de trabajo de uno de mis mejores amigos de la facultad, ando trabajando con el editor de textos Vi.

Siempre había querido aprender a utilizarlo pero no terminaba de encontrarle la gracia a memorizar n-cientas combinaciones de teclas para hacer cosas que, al fin y al cabo, podía hacer con editores que tuviesen una interfaz gráfica como Gedit o **Mousepad**.

Vaya por delante que no soy un “máquina” con él pero poco a poco voy añadiendo nuevos conocimientos que voy adquiriendo conforme me va haciendo falta y cada día observo que lo uso más.

He empezado con las combinaciones para hacer búsquedas en el texto (que me sirven con el comando less y son útiles a la hora de buscar en los logs de los servidores) pero venía echando de menos el uso del “porta papeles” para cortar/copiar y pegar líneas de texto (ya me cansé de escribir “a mano” contenidos que tenía que cambiar de sitio o repetir en otro lugar :()

A modo de chuleta personal, que espero sirva para los lectores curiosos que abundan en este blog, he optado por escribir el presente artículo: ¡qué aproveche!
Cortar y Copiar

Debemos colocarnos en la primera línea que contiene el texto que nos interesa y pulsar

1. el número de líneas a utilizar y
2. si queremos copiarlas (yy) o cortarlas (dd)

Así tenemos que pulsar (todo seguido):

* **3yy** copia 3 líneas contando aquella en la que nos encontramos.
* **10dd** corta 10 líneas a partir de la actual.

# Pegar

Una vez realizado el paso anterior sólo tenemos que situarnos donde queremos colocar el texto que hemos copiado (o cortado) y pulsar

* **p** si queremos pegar DEBAJO de la línea actual.
* **P** para pegar ENCIMA de la línea en la que nos encontramos.

# Cortar y copiar bloques de líneas

Es más que posible que te resulte incómodo y/o imposible tener que contar cuántas líneas queremos copiar o mover de sitio.

Para evitarlo siempre podemos optar por marcar zonas utilizando el comando m (colócate antes al comienzo del bloque que vas a utilizar) y seguidamente el nombre que queremos darle a la marca.

Así tenemos que:

* **mc** crearía una marca que identificaremos como c.
* **mp** haría lo mismo pero dándole por nombre p.

Colócate al final del bloque de texto que te interesa (ojo, funciona para líneas completas; independientemente de la columna en la que coloques el cursor utilizará toda la línea, por lo que no tiene sentido que te mates ubicándolo: baja hasta donde te interesa y listo) y pulsa:

* **y’c** para COPIAR (observa la y) el bloque c (podríamos haber hecho lo mismo para el p con y’p)
* **d’p** para CORTAR (observa la d) el bloque p


# ¿Cómo pegar un bloque?

Pues igual que hemos hecho hasta ahora: utilizando p o P según quieras pegar debajo (p) o encima (P) de la línea en la que se encuentra situado el cursor.

# Conclusión

Vi y Vim son unas herramientas muy potentes que requieren un esfuerzo (de memoria ;)) aprender a utilizar en todo su esplendor.

Personalmente he optado por ir aprendiendo aquello que más utilizo y, por tanto, me hace falta en el día a día.

En esta ocasión ha sido el uso del “porta papeles” como medio de duplicar y mover la información existente en cualquier fichero de texto.

Espero que os sea de utilidad a aquellos que, como yo, comenzáis a utilizar este

extendido (suele venir instalado por defecto en cualquier distribución Linux) potente (no he hecho más que rascar la superficie y ya me siento atraído por él) liviano (ocupa pocos recursos en lo que a memoria y disco se refiere frente a otras soluciones que no hacen ni la mitad que éste) y útil editor.

# Activar números de línea relativos

# Ejemplo

Para eliminar algunas líneas de texto cuando no conoce el número exacto de líneas que desea eliminar, pruebe con 10dd, 5dd, 3dd hasta que elimine todas las líneas.

Los números de línea relativos resuelven este problema, supongamos que tenemos un archivo que contiene:

```
sometimes, you see a block of
text. You want to remove
it but you
cannot directly get the
exact number of
lines to delete
so you try
10d , 5d
3d until
you
remove all the block.
```

Ingrese al modo NORMAL: Esc

Ahora, ejecutar **:set relativenumber.** Una vez hecho esto, el archivo se mostrará como:

```
3 sometimes, you see a block of
2 text. You want to remove
1 it but you
0 cannot directly get the
1 exact number of
2 lines to delete
3 so you try
4 10d , 5d
5 3d until
6 you
7 remove all the block.
```

donde 0 es el número de línea de la línea actual y también muestra el número de línea real delante del número relativo, por lo que ahora no tiene que estimar el número de líneas de la línea actual para cortar o eliminar o peor contarlas una por uno.

Ahora puede ejecutar su comando habitual como 6dd y está seguro del número de líneas.

También puede utilizar la forma abreviada del mismo comando: set rnu para activar números relativos y: set nornu para desactivar los mismos.

Si también: establece el número o tiene: establece el número ya activado, obtendrá el número de línea de la línea en la que se encuentra el cursor.

```
3 sometimes, you see a block of
2 text. You want to remove
1 it but you
4 cannot directly get the
1 exact number of
2 lines to delete
3 so you try
4 10d , 5d
5 3d until
6 you
7 remove all the block.
```
