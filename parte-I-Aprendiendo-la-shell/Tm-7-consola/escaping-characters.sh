# Escaping Characters
# Sometimes we want to quote only a single character. To do this, we can precede a character with a backslash, which in this context is called the escape character. Often this is done inside double quotes to selectively prevent an expansion.
# Personajes que escapan
# A veces queremos citar solo un carácter. Para hacer esto, podemos preceder un carácter con una barra invertida, que en este contexto se denomina carácter de escape. A menudo, esto se hace entre comillas dobles para evitar selectivamente una expansión.

echo "The balance for user $USER is: \$5.00"

# También es común utilizar el escape para eliminar el significado especial de un carácter en un nombre de archivo. Por ejemplo, es posible utilizar caracteres en nombres de archivos que normalmente tienen un significado especial para el shell. Estos incluirían $,! , &, espacios y otros. Para incluir un carácter especial en un nombre de archivo, podemos hacer esto:

mv bad\&filename good_filename

# Para permitir que aparezca un carácter de barra invertida, escriba \\ para escapar de él. Tenga en cuenta que entre comillas simples, la barra invertida pierde su significado especial y se trata como un carácter ordinario.


# Secuencias de escape de barra invertida

# Además de su función como carácter de escape, la barra invertida se usa como parte de una notación para representar ciertos caracteres especiales llamados códigos de control. Los primeros 32 caracteres del esquema de codificación ASCII se utilizan para transmitir comandos a dispositivos similares a teletipos. Algunos de estos códigos son familiares (tabulación, retroceso, avance de línea y retorno de carro), mientras que otros no lo son (nulo, fin de transmisión y reconocimiento).
# La Tabla 7-2 enumera algunas de las secuencias de escape de barra invertida comunes.

# Secuencia de escape Significado
# \a Bell (una alerta que hace que la computadora emita un pitido)
# \b Retroceso
# \n Nueva línea; en sistemas similares a Unix, esto produce un avance de línea
# \r Retorno de carro
# \t Tab

# Agregar la opción -e a echo permitirá la interpretación de las secuencias de escape. También puede colocarlos dentro de $ ''. Aquí, usando el comando sleep, un programa simple que solo espera el número especificado de segundos y luego sale, podemos crear un temporizador de cuenta regresiva primitivo:

sleep 10; echo -e "Time's up\a"
# tambien
sleep 10; echo "Time's up" $'\a'

# Resumiendo
# A medida que avancemos en el uso del shell, descubriremos que las expansiones y las citas se usarán con una frecuencia cada vez mayor, por lo que tiene sentido comprender bien cómo funcionan. De hecho, se podría argumentar que son los temas más importantes para aprender sobre el caparazón. Sin una comprensión adecuada de la expansión, el caparazón siempre será una fuente de misterio y confusión, con gran parte de su poder potencial desperdiciado.
