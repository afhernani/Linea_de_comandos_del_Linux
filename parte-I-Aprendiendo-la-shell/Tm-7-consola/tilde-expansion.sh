# Expansión de nombre de ruta
# El mecanismo por el cual funcionan los comodines se llama expansión de nombre de ruta. Si probamos algunas de las técnicas que empleamos en capítulos anteriores, veremos que en realidad son expansiones. Dado un directorio de inicio que se ve así:

ls

# iden

echo *

# podríamos realizar las siguientes ampliaciones:

ls D*
echo D* #lista ficheros, archivos, etc que empiezen en D

# lista todos los ficheros y directorios que empiezen con D

ls *s #lista directorios en subdirectorios
echo *s # lista subdirectorios

echo [[:upper:]]* #lista todo que empieza con mayusculas

# Buscando más alla del directorio home

echo /usr/*/share #nos dice si existe un directorio share en algun subdirectorio de usr
ls /usr/*/share # lista los directorios contenidos en los subdirectorios de usr share

#A primera vista, podría parecer que podríamos incluir archivos ocultos en una expansión iniciando el patrón con un punto inicial, como este:
echo .*

# Casi funciona. Sin embargo, si examinamos los resultados de cerca, veremos que los nombres. y .. también aparecerán en los resultados. Debido a que estos nombres se refieren al directorio de trabajo actual y su directorio padre, el uso de este patrón probablemente producirá un resultado incorrecto. Podemos ver esto si probamos el siguiente comando:

ls -d .* | less

# emplear un patrón más especifico para saber si existe algún fichero oculto

echo .[!.]*

# Mas especifico, seria: El comando ls con la opción -A ("casi todos") proporcionará una lista correcta de archivos ocultos.

ls -A

# Tilde expansion.

# Como podemos recordar de nuestra introducción al comando cd, el carácter tilde (~) tiene un significado especial. Cuando se usa al comienzo de una palabra, se expande al nombre del directorio de inicio del usuario designado o, si no se nombra ningún usuario, al directorio de inicio del usuario actual.

echo ~
# si existe un usrio foo
echo ~foo


