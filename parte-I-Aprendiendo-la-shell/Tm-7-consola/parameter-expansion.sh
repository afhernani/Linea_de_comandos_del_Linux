# Expansión de parámetros
# En este capítulo, solo tocaremos brevemente la expansión de parámetros, pero lo cubriremos ampliamente más adelante. Es una función que es más útil en los scripts de shell que directamente en la línea de comandos. Muchas de sus capacidades tienen que ver con la capacidad del sistema para almacenar pequeños fragmentos de datos y darle un nombre a cada fragmento. Muchos de esos fragmentos, más propiamente llamados variables, están disponibles para su examen. Por ejemplo, la variable denominada USUARIO contiene su nombre de usuario. Para invocar la expansión de parámetros y revelar el contenido de USER, debe hacer esto:
echo $USER
# ver las variables disponibles:
printenv | less
# si no existe la variable devuelve nada
echo $SUER
# Sustitución de comando
# La sustitución de comandos nos permite usar la salida de un comando como expansión.
echo $(ls)
# tambien.
ls -l $(which cp)
# Aquí pasamos los resultados de los cuales cp como argumento al comando ls, obteniendo así la lista del programa cp sin tener que conocer su ruta completa. No estamos limitados a simples comandos. Se pueden utilizar tuberías completas (aquí solo se muestra la salida parcial).
file $(ls -d /usr/bin/* | grep zip)
# En este ejemplo, los resultados de la canalización se convirtieron en la lista de argumentos del comando de archivo.

# Existe una sintaxis alternativa para la sustitución de comandos en programas de shell más antiguos que también es compatible con bash. Utiliza comillas inversas en lugar del signo de dólar y paréntesis.
ls -l `which cp`
