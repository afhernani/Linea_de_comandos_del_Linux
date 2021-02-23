#!/bin/bash
<< 'Comment'
printenv : imprime parte del entorno del shell
set: establece opciones del shell
export: exporta el entorno al subsecuente programa en ejecución
alias: Crea un alias para un comando.
Comment

echo "Examinar el entorno:"
echo "printenv | less"
echo "para ver una variable de entorno especifica llamada USER."
echo "printenv USER"
echo "set sin obcion, veremos el shell y las variables de entrono:"
echo "set | less"
echo "tambien ver el contenido de la variable HOME, usando echo \$HOME"
echo "echo $HOME"
echo "un elemento del entorno que no puede ser vista con set o printenv"
echo "son los alias, para verlas usamos el comando alias sin argumentos"
echo "alias"
echo " "
alias
echo " "
echo "Algunas variables interesantes:"
#fichero='enviromentVariables.txt'
echo """
Variable    Contenido

DISPLAY     El nombre de su pantalla si está ejecutando un entorno gráfico. Por lo general, esto es: 0, lo que significa la primera pantalla generada por el servidor X.

EDITOR      El nombre del programa que se utilizará para la edición de texto.

SHELL       El nombre de su programa de shell.

HOME        El nombre de ruta de su directorio personal.

LANG        Define el juego de caracteres y el orden de clasificación de su idioma.

OLDPWD      El directorio de trabajo anterior.

PAGER       El nombre del programa que se utilizará para la salida de paginación. Suele estar configurado en / usr / bin / less.

PATH        RUTA, una lista de directorios separados por dos puntos que se buscan cuando ingresa
nombre de un programa ejecutable.

PS1         Significa "cadena de solicitud 1". Esto define el contenido del indicador de shell. Como veremos más adelante, esto se puede personalizar ampliamente.

PWD         El directorio de trabajo actual.

TERM        El nombre de su tipo de terminal. Los sistemas similares a Unix admiten muchos protocolos de terminal; esta variable establece el protocolo que se utilizará con su emulador de terminal.

TZ          Especifica su zona horaria. La mayoría de los sistemas similares a Unix mantienen el reloj interno de la computadora en la hora universal coordinada (UTC) y luego muestran la hora local aplicando un desplazamiento especificado por esta variable.

USER        USUARIO, Su nombre de usuario. 
""" #>> $fichero
#cat $fichero

echo "COMO SE ESTABLECE EL ENTORNO"
echo """
Cuando inicia cesion del shell, se abre lee los ficheros startup que pueden ser de configuracion, compartidos,
el propio entorno de usuario, y dependiendo del tipo de shell sera:
login - shell con usuario y password
non - login -shell : ocurre al lanzar el shell mediante GUI

tabla 11-2
Archivos de inicio para sesiones login- shell lee, los estart-ups:

Archivo                          Descripción.
/etc/profile        Un script de configuración global que se aplica a todos los usuarios.
~/.bash_profile     El archivo de inicio personal de un usuario. Puede usarse para extender o anular ajustes en el script de configuración global.
~/.bash_login       si ~/.bash_profile no se encuentra, bash intenta leer este script.
~/.profile          Si no se encuentran ~/.bash_profile ni ~/.bash_login, bash intenta para leer este archivo. Este es el valor predeterminado en las distribuciones basadas en Debian, como Ubuntu.
"""
echo " "
echo """
tabla 11-3
Archivos de inicio para sesiones de shell sin inicio de sesión

Archivo                          Contenido
/etc/bash.bashrc    Un script de configuración global que se aplica a todos los usuarios.
~/.bashrc           Archivo de inicio personal de un usuario. Se puede utilizar para ampliar o anular la configuración en el script de configuración global.
"""
echo """
Además de leer los archivos de inicio enumerados en la Tabla 11-3, los shells sin inicio de sesión heredan el entorno de su proceso principal, generalmente un shell de inicio de sesión.

Eche un vistazo y vea cuáles de estos archivos de inicio están instalados. Recuerde: debido a que la mayoría de los nombres de archivo enumerados comienzan con un punto (lo que significa que están ocultos), necesitaremos usar la opción -a cuando use ls.

El archivo ~/.bashrc es probablemente el archivo de inicio más importante desde el punto de vista del usuario común, porque casi siempre se lee. Los shells que no son de inicio de sesión lo leen de forma predeterminada, y la mayoría de los archivos de inicio para los shells de inicio de sesión se escriben de tal manera que también pueden leer el archivo ~/.bashrc.
"""
echo """
¿Qué hay en un archivo de inicio?
Si echamos un vistazo dentro de un típico .bash_profile (tomado de un sistema CentOS 6), se ve así:

# .bash_profile
# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    .~/.bashrc
fi
# User specific environment and startup programs
PATH=$PATH:$HOME/bin  # expansion de parametros.
export PATH

Este es un ejemplo de expansión de parámetros, que mencionamos en el Capítulo 7. Para demostrar cómo funciona, intente lo siguiente:

~]$ foo="This is some "
~]$ echo $foo
This is some
~]$ foo=$foo"text."
~]$ echo $foo
This is some text.

El comando export le dice al shell que haga que el contenido de PATH esté disponible para los procesos secundarios de este shell.

"""

echo """
Modificar el medio ambiente

Como sabemos dónde están los archivos de inicio y qué contienen, podemos modificarlos para personalizar nuestro entorno.

¿Qué archivos debemos modificar?

Como regla general, para agregar directorios a su PATH o definir variables de entorno adicionales, coloque esos cambios en .bash_profile (o el equivalente, según su distribución; por ejemplo, Ubuntu usa .profile). Para todo lo demás, coloque los cambios en .bashrc.

Nota
A menos que sea el administrador del sistema y necesite cambiar los valores predeterminados para todos los usuarios del sistema, restrinja sus modificaciones a los archivos de su directorio personal. Ciertamente es posible cambiar los archivos en /etc, como el perfil, y en muchos casos sería sensato hacerlo, pero por ahora, vayamos a lo seguro.

Editores de Texto;
nano, gedit y otros más...

Usando el editor de texto:
gedit some_file
    o
nano some_file

Crear una copia de seguridad del ~/.bashrc
~]$ cp ~/.bashrc ~/.bashrc.bak

Las extensiones .bak, .sav, .old y .orig son formas populares de indicar un archivo de respaldo. Ah, y recuerde que cp sobrescribirá los archivos existentes de forma silenciosa.


Editando el fichero ~/.bashrc

nano ~/.bashrc

Añadimos al final del fichero lo siguiente:

# Change umask to make directory sharing easier
umask 0002
# Ignore duplicates in command history and increase
# history size to 1000 lines
export HISTCONTROL=ignoredups
export HISTSIZE=1000
# Add some helpful aliases
alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'

EXPLICACIÓN:

umask 0002 
Establece la umask para resolver el problema con los directorios compartidos que discutimos en el Capítulo 9.

export HISTCONTROL = ignoredups 
Hace que la función de registro del historial del shell ignore un comando si se acaba de grabar el mismo comando.

export HISTSIZE = 1000 
Aumenta el tamaño del historial de comandos del valor predeterminado habitual de 500 líneas a 1000 líneas.

alias l. = 'ls -d. * --color = auto' 
Crea un nuevo comando llamado l. , que muestra todas las entradas del directorio que comienzan con un punto.

alias ll = 'ls -l --color = auto' 
Crea un nuevo comando llamado ll, que muestra una lista de directorios de formato largo.

Tambien algunos comentarios:
# some more ls aliases
# alias ll='ls -l'
# alias la='ls -A'
# alias l='ls -CF'

Guardar con Ctr+O
salir  con Ctr+X

ACTIVAR LOS CAMBIOS

source ~/.bashrc


"""


