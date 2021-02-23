# Cotización
# Ahora que hemos visto de cuántas formas el shell puede realizar expansiones, es hora de aprender cómo podemos controlarlo. Tomemos, por ejemplo, lo siguiente:
echo this is a   test
# o tambien
echo the total es $100.00
# En el primer ejemplo, la división de palabras por el shell eliminó los espacios en blanco adicionales de la lista de argumentos del comando echo. En el segundo ejemplo, la expansión de parámetros sustituyó una cadena vacía por el valor de $ 1 porque era una variable indefinida. El caparazón proporciona un mecanismo llamado cotización para suprimir selectivamente expansiones no deseadas.

# Doble comillas
# El primer tipo de cita que veremos son las comillas dobles. Si colocamos texto entre comillas dobles, todos los caracteres especiales utilizados por el shell pierden su significado especial y se tratan como caracteres ordinarios. Las excepciones son $ (signo de dólar), \ (barra invertida) y `(tilde invertido). Esto significa que se suprimen la división de palabras, la expansión de nombre de ruta, la expansión de tilde y la expansión de llaves; sin embargo, todavía se llevan a cabo la expansión de parámetros, la expansión aritmética y la sustitución de comandos. Usando comillas dobles, podemos hacer frente a nombres de archivos que contienen espacios incrustados. Digamos que fuimos la desafortunada víctima de un archivo llamado two words.txt. Si intentáramos usar esto en la línea de comando, la división de palabras haría que esto se tratara como dos argumentos separados en lugar del único argumento deseado.

ls -l two words.txt

# Al usar comillas dobles, detenemos la división de palabras y obtenemos el resultado deseado; Además, incluso podemos reparar el daño.

ls -l "two words.txt"
mv "two words.txt" two_words.txt

# ¡Ahí! Ahora no tenemos que seguir escribiendo esas molestas comillas dobles. Recuerde, la expansión de parámetros, la expansión aritmética y la sustitución de comandos todavía tienen lugar entre comillas dobles.

echo "$USER $((2+2)) $(cal)"

# la diferencia con dobles comillas
echo "this is a   test"

# El hecho de que las nuevas líneas se consideren delimitadores por el mecanismo de división de palabras provoca un efecto interesante, aunque sutil, en la sustitución de comandos. Considera lo siguiente:
echo cal

echo $(cal)

echo "$(cal)"

# En la primera instancia, la sustitución de comandos sin comillas dio como resultado una línea de comandos que contenía 38 argumentos. En el segundo, resultó en una línea de comando con un argumento que incluye los espacios incrustados y las nuevas líneas.

# Comillas simples
# Si necesitamos suprimir todas las expansiones, usamos comillas simples. Aquí hay una comparación de comillas simples, dobles y sin comillas:

echo text ~/*.txt {a,b} $(echo foo) $((2+2)) $USER

echo "text ~/*.txt {a,b} $(echo foo) $((2+2)) $USER"

echo 'text ~/*.txt {a,b} $(echo foo) $((2+2)) $USER' #suprimimos toda la expansion de cadenas



