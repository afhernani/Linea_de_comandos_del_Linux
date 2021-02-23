# <p style="text-align:center; color:red">3</p>
# <p style="text-align:center; color:red">Exploring the system<br /><span style="color:brown">Explorando el sistema</span></p>

Now that we know how to move around the file system, it’s time for a guided tour of our Linux system. Before we start, however, we’re going to learn some more commands that will be useful along the way.<br /><span style="color:green">Ahora que sabemos cómo movernos por el sistema de archivos, es hora de realizar una visita guiada a nuestro sistema Linux. Sin embargo, antes de comenzar, aprenderemos algunos comandos más que serán útiles en el camino.</span>

* **ls** -- List directory contents<br /><span style="color:green">**ls** -- Lista contenido del directorio</span>

* **file** -- Determine file type<br /><span style="color:green">**file** -- Determina el tipo de archivo</span>

* **less** -- View file contents<br /><span style="color:green">**less** -- ver el contenido del archivo</span>

# More Fun with ls<br /><span style="color:yellow">más divertido con ls</span>

The ls command is probably the most used command, and for good reason.<br /><span style="color:green">El comando ls es probablemente el comando más utilizado, y por una buena razón.</span>

With it, we can see directory contents and determine a variety of important file and directory attributes. As we have seen, we can simply enter ls to get a list of files and subdirectories contained in the current working directory.<br /><span style="color:green">Con él, podemos ver el contenido del directorio y determinar una variedad de atributos importantes de archivos y directorios. Como hemos visto, simplemente podemos ingresar ls para obtener una lista de archivos y subdirectorios contenidos en el directorio de trabajo actual.</span>

```
[me@linuxbox ~]$ ls
Desktop Documents Music Pictures Public Templates Videos
```

Besides the current working directory, we can specify the directory to list, like so:<br /><span style="color:green">Además del directorio de trabajo actual, podemos especificar el directorio a listar, así:</span>

```
me@linuxbox ~]$ ls /usr
bin games include lib local sbin share src
```

We can even specify multiple directories. In the following example, we list both the user’s home directory (symbolized by the ~ character) and the /usr directory:<br /><span style="color:green">Incluso podemos especificar varios directorios. En el siguiente ejemplo, enumeramos tanto el directorio de inicio del usuario (simbolizado por el carácter ~) como el directorio / usr:</span>

```bash
[me@linuxbox ~]$ ls ~/usr
/home/me:
Desktop Documents Music Pictures Public Templates Videos
/usr:
bin games include lib local sbin share src
```


We can also change the format of the output to reveal more detail.<br /><span style="color:green">También podemos cambiar el formato de la salida para revelar más detalles.</span>

```
[hernani@EliteDesk:~]$ ls -l
total 1520
-rw-r-----  1 root    root        329 ago 16 14:56 archivo.txt
drwxrwxr-x  2 hernani hernani    4096 ago 11  2020 bin
-rw-rw-r--  1 hernani hernani  114863 dic  4 14:01 bola-navidad.pdf
drwxr-xr-x  6 hernani hernani   12288 feb  6 22:21 Descargas
drwxr-xr-x 10 hernani hernani    4096 feb  8 17:05 Documentos
drwxrwxr-x  2 hernani hernani    4096 feb 11 12:33 dwhelper
drwx------  3 hernani hernani    4096 oct 25 15:54 easy-rsa
....
```

By adding -l to the command, we changed the output to the long format.<br /><span style="color:green">Al agregar -l al comando, cambiamos la salida al formato largo.</span>

# Options and Arguments<br /><span style="color:yellow">Opciones y argumentos</span>

This brings us to a very important point about how most commands work. Commands are often followed by one or more options that modify their behavior and, further, by one or more arguments, the items upon which the command acts. So, most commands look kind of like this:<br /><span style="color:green">Esto nos lleva a un punto muy importante sobre cómo funcionan la mayoría de los comandos. Los comandos suelen ir seguidos de una o más opciones que modifican su comportamiento y, además, de uno o más argumentos, los elementos sobre los que actúa el comando. Entonces, la mayoría de los comandos se ven así:</span>

`command -options arguments`

Most commands use options, which consist of a single character preceded by a dash, for example, -l . Many commands, however, including those from the GNU Project, also support long options, consisting of a word preceded by two dashes. Also, many commands allow multiple short options to be strung together. In the following example, the ls command is given two options, which are the l option to produce long format output, and the t option to sort the result by the file’s modification time.<br /><span style="color:green">La mayoría de los comandos usan opciones, que consisten en un solo carácter precedido por un guión, por ejemplo, -l. Sin embargo, muchos comandos, incluidos los del Proyecto GNU, también admiten opciones largas, que consisten en una palabra precedida por dos guiones. Además, muchos comandos permiten combinar varias opciones cortas. En el siguiente ejemplo, el comando ls tiene dos opciones, que son la opción l para producir una salida de formato largo y la opción t para ordenar el resultado por el tiempo de modificación del archivo.</span>

`[me@linuxbox ~]$ ls -lt`

We’ll add the long option --reverse to reverse the order of the sort.<br /><span style="color:green">Agregaremos la opción larga --reverse para invertir el orden de clasificación.</span>

`[me@linuxbox ~]$ ls -lt --reverse`

> Note:<br /><span style="color:green">Nota:</span>

> Command options, like filenames in Linux, are case sensitive.<br /><span style="color:green">Las opciones de comando, como los nombres de archivo en Linux, distinguen entre mayúsculas y minúsculas.</span>

The ls command has a large number of possible options, the most common of which are listed in Table 3-1.<br /><span style="color:green">El comando ls tiene una gran cantidad de opciones posibles, las más comunes de las cuales se enumeran en la Tabla 3-1.</span>

> Table 3-1: Common ls Options<br /><span style="color:blue">Tabla 3-1: Opciones comunes de ls</span>

| Option | Long option | Description |
|---------|------------|-------------|
| -a | --all | List all files, even those with names that begin with a period, which are normally not listed (that is, hidden).<br /><span style="color:green">Enumere todos los archivos, incluso aquellos con nombres que comienzan con un punto, que normalmente no se enumeran (es decir, ocultos).</span>|
| -A | --almost-all | Like the -a option except it does not list . (current directory) and .. (parent directory).<br /><span style="color:green">Como la opción -a, excepto que no aparece. (directorio actual) y .. (directorio principal).</span> |
| -d | --directory | Ordinarily, if a directory is specified, ls will list the contents of the directory, not the directory itself. Use this option in conjunction with the -l option to see details about the directory rather than its contents.<br /><span style="color:green">Por lo general, si se especifica un directorio, ls enumerará el contenido del directorio, no el directorio en sí. Utilice esta opción junto con la opción -l para ver detalles sobre el directorio en lugar de su contenido.</span>| 
| -F | --classify | This option will append an indicator character to the end of each listed name. For example, it will append a forward slash ( / ) if the name is a directory.<br /><span style="color:green">Esta opción agregará un carácter indicador al final de cada nombre listado. Por ejemplo, agregará una barra diagonal (/) si el nombre es un directorio.</span> |
| -h | --human-readable | In long format listings, display file sizes in human readable format rather than in bytes. <br /><span style="color:green">En listas de formato largo, muestre los tamaños de archivo en formato legible por humanos en lugar de en bytes.</span>|
| -l |  | Display results in long format. <br /><span style="color:green">Muestra los resultados en formato largo.</span>|
| -r | --reverse | Display the results in reverse order. Normally, ls displays its results in ascending alphabetical order.<br /><span style="color:green">Muestra los resultados en orden inverso. Normalmente, ls muestra sus resultados en orden alfabético ascendente.</span>| 
| -S |  | Sort results by file size.<br /><span style="color:green">Ordene los resultados por tamaño de archivo.</span>|
| -t |  | Sort by modification time. <br /><span style="color:green">Ordenar por hora de modificación.</span>|

______

# A Longer Look at Long Format<br /><span style="color:yellow">Una mirada más amplia al formato largo</span>

As we saw earlier, the -l option causes ls to display its results in long format. This format contains a great deal of useful information. Here is the Examples directory from an Ubuntu system:<br /><span style="color:green">Como vimos anteriormente, la opción -l hace que ls muestre sus resultados en formato largo. Este formato contiene una gran cantidad de información útil. Aquí está el directorio de ejemplos de un sistema Ubuntu:</span>

```
[hernani@EliteDesk:~]$ ls -l
total 1520
-rw-r-----  1 root    root        329 ago 16 14:56 archivo.txt
drwxrwxr-x  2 hernani hernani    4096 ago 11  2020 bin
-rw-rw-r--  1 hernani hernani  114863 dic  4 14:01 bola-navidad.pdf
drwxr-xr-x  6 hernani hernani   12288 feb  6 22:21 Descargas
drwxr-xr-x 10 hernani hernani    4096 feb  8 17:05 Documentos
drwxrwxr-x  2 hernani hernani    4096 feb 11 12:33 dwhelper
drwx------  3 hernani hernani    4096 oct 25 15:54 easy-rsa
....
```

Table 3-2 provides us with a look at the different fields from one of the files and their meanings.<br /><span style="color:green">La Tabla 3-2 nos proporciona una mirada a los diferentes campos de uno de los archivos y sus significados.</span>

> Table 3-2: ls Long Listing Fields<br /><span style="color:brown">Tabla 3-2: Campos de listado largo de ls</span>

| Field | Meaning |
|-------|---------|
| -rw-r--r-- | Access rights to the file. The first character indicates the type of file. Among the different types, a leading dash means a regular file, while a d indicates a directory. The next three characters are the access rights for the file’s owner, the next three are for members of the file’s group, and the final three are for everyone else. Chapter 9 discusses the full meaning of this in more detail.  <br /><span style="color:green">Derechos de acceso al archivo. El primer carácter indica el tipo de archivo. Entre los diferentes tipos, un guión inicial significa un archivo normal, mientras que una d indica un directorio. Los siguientes tres caracteres son los derechos de acceso del propietario del archivo, los tres siguientes son para los miembros del grupo del archivo y los tres últimos son para todos los demás. El capítulo 9 analiza el significado completo de esto con más detalle.</span>|
| l  | File’s number of hard links. See “Symbolic Links” on page 21 and “Hard Links” on page 22.<br /><span style="color:green">Número de vínculos físicos del archivo. Consulte "Enlaces simbólicos" en la página 21 y "Enlaces físicos" en la página 22.</span> |
| root | The username of the file’s owner.<br /><span style="color:green">El nombre de usuario de la propietaria del archivo.</span> |
| root | The name of the group that owns the file.<br /><span style="color:green">El nombre del grupo propietario del archivo.</span> |
| 329 |  Size of the file in bytes.<br /><span style="color:green">Tamaño del archivo en bytes.</span>|
| ago 16 14:56 | Date and time of the file’s last modification.<br /><span style="color:green">Fecha y hora de la última modificación del archivo</span>|
| archivo.txt | Name of the file. <br /><span style="color:green">Nombre del archivo.</span>|

_____

# Determining a File’s Type with file<br /><span style="color:yellow">Determinar el tipo de archivo con archivo</span>

As we explore the system, it will be useful to know what files contain. To do this, we will use the file command to determine a file’s type. As we discussed earlier, filenames in Linux are not required to reflect a file’s contents. While a filename like picture.jpg would normally be expected to contain a JPEG-compressed image, it is not required to in Linux. We can invoke the file command this way:<br /><span style="color:green">A medida que exploramos el sistema, será útil saber qué archivos contienen. Para hacer esto, usaremos el comando de archivo para determinar el tipo de un archivo. Como discutimos anteriormente, los nombres de archivo en Linux no son necesarios para reflejar el contenido de un archivo. Aunque normalmente se esperaría que un nombre de archivo como picture.jpg contenga una imagen comprimida en JPEG, en Linux no es obligatorio. Podemos invocar el comando de archivo de esta manera:</span>

`file filename`

When invoked, the file command will print a brief description of the file’s contents. For example:<br /><span style="color:green">Cuando se invoca, el comando de archivo imprimirá una breve descripción del contenido del archivo. Por ejemplo:</span>

```
hernani@EliteDesk:~$ file archivo.txt
archivo.txt: regular file, no read permission
```

There are many kinds of files. In fact, one of the common ideas in Unix like operating systems such as Linux is that “everything is a file.” As we proceed with our lessons, we will see just how true that statement is.<br /><span style="color:green">Hay muchos tipos de archivos. De hecho, una de las ideas comunes en Unix, como los sistemas operativos como Linux, es que "todo es un archivo". A medida que avancemos con nuestras lecciones, veremos cuán cierta es esa afirmación.</span>

While many of the files on our system are familiar, for example, MP3 and JPEG files, there are many kinds that are a little less obvious and a few that are quite strange.<br /><span style="color:green">Si bien muchos de los archivos de nuestro sistema son familiares, por ejemplo, archivos MP3 y JPEG, hay muchos tipos que son un poco menos obvios y algunos que son bastante extraños.</span>

# Viewing File Contents with less<br /><span style="color:yellow">Ver el contenido del archivo con menos</span>

The less command is a program to view text files. Throughout our Linux system, there are many files that contain human-readable text. The less program provides a convenient way to examine them.<br /><span style="color:green">El comando less es un programa para ver archivos de texto. En todo nuestro sistema Linux, hay muchos archivos que contienen texto legible por humanos. El programa menos proporciona una forma conveniente de examinarlos.</span>

Why would we want to examine text files? Because many of the files that contain system settings (called configuration files) are stored in this format, and being able to read them gives us insight about how the system works. In addition, some of the actual programs that the system uses (called scripts) are stored in this format. In later chapters, we will learn how to edit text files in order to modify system settings and write our own scripts, but for now we will just look at their contents.<br /><span style="color:green">¿Por qué querríamos examinar archivos de texto? Porque muchos de los archivos que contienen la configuración del sistema (llamados archivos de configuración) se almacenan en este formato, y poder leerlos nos da una idea de cómo funciona el sistema. Además, algunos de los programas reales que utiliza el sistema (llamados scripts) se almacenan en este formato. En capítulos posteriores, aprenderemos cómo editar archivos de texto para modificar la configuración del sistema y escribir nuestros propios scripts, pero por ahora solo veremos su contenido.</span>

The less command is used like this:<br /><span style="color:green">El comando menos se usa así:</span>

`less filename`

_____

> # What Is "Text"?<br /><span style="color:yellow">¿Qué es "texto"?</span>

> There are many ways to represent information on a computer. All methods involve defining a relationship between the information and some numbers that will be used to represent it. Computers, after all, understand only numbers, and all data is converted to numeric representation.<br /><span style="color:green">Hay muchas formas de representar información en una computadora. Todos los métodos implican definir una relación entre la información y algunos números que se utilizarán para representarla. Las computadoras, después de todo, solo entienden los números y todos los datos se convierten en representación numérica.</span>

> Some of these representation systems are very complex (such as compressed video files), while others are rather simple. One of the earliest and simplest is called ASCII text. ASCII (pronounced “as-key”) is short for American Standard Code for Information Interchange. This is a simple encoding scheme that was first used on Teletype machines to map keyboard characters to numbers.<br /><span style="color:green">Algunos de estos sistemas de representación son muy complejos (como archivos de video comprimidos), mientras que otros son bastante simples. Uno de los primeros y más simples se llama texto ASCII. ASCII (pronunciado "as-key") es la abreviatura de American Standard Code for Information Interchange. Este es un esquema de codificación simple que se utilizó por primera vez en máquinas de teletipo para asignar caracteres de teclado a números.</span>

> Text is a simple one-to-one mapping of characters to numbers. It is very compact. Fifty characters of text translates to fifty bytes of data. It is important to understand that text only contains a simple mapping of characters to numbers. It is not the same as a word processor document such as one created by Microsoft Word or LibreOffice Writer. Those files, in contrast to simple ASCII text, contain many non-text elements that are used to describe its structure and formatting. Plain ASCII text files contain only the characters themselves and a few rudimentary control codes such as tabs, carriage returns, and line feeds.<br /><span style="color:green">El texto es un simple mapeo uno a uno de caracteres a números. Es muy compacto. Cincuenta caracteres de texto se traducen en cincuenta bytes de datos. Es importante comprender que el texto solo contiene una simple asignación de caracteres a números. No es lo mismo que un documento de procesador de texto como el creado por Microsoft Word o LibreOffice Writer. Estos archivos, a diferencia del texto ASCII simple, contienen muchos elementos que no son texto que se utilizan para describir su estructura y formato. Los archivos de texto ASCII sin formato contienen solo los propios caracteres y algunos códigos de control rudimentarios, como pestañas, retornos de carro y avances de línea.</span>

> Throughout a Linux system, many files are stored in text format, and there are many Linux tools that work with text files. Even Windows recognizes the importance of this format. The well-known NOTEPAD.EXE program is an editor for plain ASCII text files.<br /><span style="color:green">En todo un sistema Linux, muchos archivos se almacenan en formato de texto y hay muchas herramientas de Linux que funcionan con archivos de texto. Incluso Windows reconoce la importancia de este formato. El conocido programa NOTEPAD.EXE es un editor de archivos de texto ASCII sin formato.</span>

Once started, the less program allows us to scroll forward and backward through a text file. For example, to examine the file that defines all the system’s user accounts, enter the following command:<br /><span style="color:green">Una vez iniciado, el programa less nos permite desplazarnos hacia adelante y hacia atrás a través de un archivo de texto. Por ejemplo, para examinar el archivo que define todas las cuentas de usuario del sistema, ingrese el siguiente comando:</span>

`[me@linuxbox ~]$ less /etc/passwd`

Once the less program starts, we can view the contents of the file. If the file is longer than one page, we can scroll up and down. To exit less , press q.<br /><span style="color:green">Una vez que se inicia el programa less, podemos ver el contenido del archivo. Si el archivo tiene más de una página, podemos desplazarnos hacia arriba y hacia abajo. Para salir menos, presione q.</span>

Table 3-3 lists the most common keyboard commands used by less.<br /><span style="color:green">La Tabla 3-3 enumera los comandos de teclado más comunes que usa less.</span>

> Table 3-3: less Commands<br /><span style="color:green">Tabla 3-3: menos comandos</span>

| Command | Action |
|---------|--------|
| page up or b | Scroll back one page<br /><span style="color:green">Retroceder una página</span>|
| page down or space | Scroll forward one page<br /><span style="color:green">Avanzar una página</span>|
| Up arrow | Scroll up one line <br /><span style="color:green">Desplazarse hacia arriba una línea</span>|
| Down arrow | Scroll down one line <br /><span style="color:green">Desplácese hacia abajo una línea</span>|
| G | Move to the end of the text file <br /><span style="color:green">Mover al final del archivo de texto</span>|
| 1G or g | Move to the beginning of the text file<br /><span style="color:green">Mover al principio del archivo de texto</span> |
| /characters | Search forward to the next occurrence of characters<br /><span style="color:green">Busque hacia adelante hasta la próxima aparición de caracteres</span> |
| n | Search for the next occurrence of the previous search<br /><span style="color:green">Buscar la siguiente aparición de la búsqueda anterior</span> |
| h | Display help screen<br /><span style="color:green">Mostrar pantalla de ayuda</span> |
| q | Quit less<br /><span style="color:green">Dejar menos</span> |

_______

> # Less Is More<br /><span style="color:yellow">Menos es más</span>

> The less program was designed as an improved replacement of an earlier Unix program called more. The name less is a play on the phrase "less is more" -- a motto of modernist architects and designers.<br /><span style="color:green">El programa less fue diseñado como un reemplazo mejorado de un programa Unix anterior llamado more. El nombre menos es un juego de palabras con la frase "menos es más", un lema de los arquitectos y diseñadores modernistas.</span>

> less falls into the class of programs called pagers, programs that allow the easy viewing of long text documents in a page-by-page manner. Whereas the more program could only page forward, the less program allows paging both forward and backward and has many other features as well.<br /><span style="color:green">less entra en la clase de programas llamados buscapersonas, programas que permiten ver fácilmente documentos de texto extenso de una manera página por página. Mientras que el programa más solo puede avanzar página, el programa menos permite paginar tanto hacia adelante como hacia atrás y tiene muchas otras características también.</span>

# Taking a Guided Tour<br /><span style="color:yellow">Hacer una visita guiada</span>

The file system layout on a Linux system is much like that found on other Unix-like systems. The design is actually specified in a published standard called the Linux Filesystem Hierarchy Standard. Not all Linux distributions conform to the standard exactly, but most come pretty close.<br /><span style="color:green">El diseño del sistema de archivos en un sistema Linux es muy parecido al que se encuentra en otros sistemas similares a Unix. El diseño está realmente especificado en un estándar publicado llamado Estándar de jerarquía del sistema de archivos de Linux. No todas las distribuciones de Linux se ajustan exactamente al estándar, pero la mayoría se acerca bastante.</span>

> # Remember the Copy-and-Paste Trick!<br /><span style="color:yellow">¡Recuerde el truco de copiar y pegar!</span>

> If you are using a mouse, you can double-click a filename to copy it and middle-click to paste it into commands.<br /><span style="color:green">Si está utilizando un mouse, puede hacer doble clic en un nombre de archivo para copiarlo y hacer clic con el botón central para pegarlo en los comandos.</span>

Next, we are going to wander around the file system ourselves to see what makes our Linux system tick. This will give us a chance to practice our navigation skills. One of the things we will discover is that many of the interesting files are in plain human-readable text. As we go about our tour, try the following:<br /><span style="color:green">A continuación, vamos a recorrer el sistema de archivos nosotros mismos para ver qué hace que funcione nuestro sistema Linux. Esto nos dará la oportunidad de practicar nuestras habilidades de navegación. Una de las cosas que descubriremos es que muchos de los archivos interesantes están en texto simple legible por humanos. A medida que avanzamos en nuestro recorrido, intente lo siguiente:</span>

* cd into a given directory.<br /><span style="color:green">cd en un directorio dado</span>

* List the directory contents with `ls -l`.<br /><span style="color:green">Enumere el contenido del directorio con `ls -l`.</span>

* If you see an interesting file, determine its contents with file.<br /><span style="color:green">Si ve un archivo interesante, determine su contenido con file.</span>

* If it looks like it might be text, try viewing it with less.<br /><span style="color:green"></span>

If we accidentally attempt to view a non-text file and it scrambles the terminal window, we can recover by entering the reset command.<br /><span style="color:green">Si accidentalmente intentamos ver un archivo que no es de texto y codifica la ventana del terminal, podemos recuperarlo ingresando el comando de reinicio.</span>

As we wander around, don’t be afraid to look at stuff. Regular users are largely prohibited from messing things up. That’s the system administrator’s job! If a command complains about something, just move on to something else. Spend some time looking around. The system is ours to explore. Remember, in Linux, there are no secrets!<br /><span style="color:green">As we wander around, don’t be afraid to look at stuff. Regular users are largely prohibited from messing things up. That’s the system administrator’s job! If a command complains about something, just move on to something else. Spend some time looking around. The system is ours to explore. Remember, in Linux, there are no secrets!</span>

Table 3-4 lists just a few of the directories we can explore. There may be some slight differences depending on our Linux distribution. Don’t be afraid to look around and try more!<br /><span style="color:green">La tabla 3-4 enumera solo algunos de los directorios que podemos explorar. Puede haber algunas pequeñas diferencias dependiendo de nuestra distribución de Linux. ¡No tengas miedo de mirar a tu alrededor y probar más!</span>

> Table 3-4: Directories Found on Linux Systems<br /><span style="color:brown">Tabla 3-4: Directorios encontrados en sistemas Linux</span>

| Directory | Comments |
|-----------|-----------|
| /  | The root directory, where everything begins.<br /><span style="color:green">El directorio raíz, donde comienza todo.</span> |
| /bin | Contains binaries (programs) that must be present for the system to boot and run.<br /><span style="color:green">Contiene binarios (programas) que deben estar presentes para que el sistema se inicie y se ejecute.</span>| 
| /boot | Contains the Linux kernel, initial RAM disk image (for drivers needed at boot time), and the boot loader. Interesting files include /boot/grub/grub.conf, or menu.lst, which is used to configure the boot loader, and /boot/vmlinuz (or something similar), the Linux kernel.<br /><span style="color:green">Contiene el kernel de Linux, la imagen del disco RAM inicial (para los controladores necesarios en el momento del arranque) y el cargador de arranque. Los archivos interesantes incluyen /boot/grub/grub.conf, o menu.lst, que se usa para configurar el cargador de arranque, y /boot/vmlinuz (o algo similar), el kernel de Linux.</span> |
| /dev | This is a special directory that contains device nodes. "Everything is a file" also applies to devices. Here is where the kernel maintains a list of all the devices it understands.<br /><span style="color:green">Este es un directorio especial que contiene nodos de dispositivo. "Todo es un archivo" también se aplica a los dispositivos. Aquí es donde el kernel mantiene una lista de todos los dispositivos que comprende.</span> |
| /etc | The /etc directory contains all the system-wide configuration files. It also contains a collection of shell scripts that start each of the system services at boot time. Everything in this directory should be readable text. While everything in /etc is interesting, here are some all-time favorites: /etc/crontab, a file that defines when automated jobs will run; /etc/fstab, a table of storage devices and their associated mount points; and /etc/passwd, a list of the user accounts.<br /><span style="color:green">El directorio /etc contiene todos los archivos de configuración de todo el sistema. También contiene una colección de scripts de shell que inician cada uno de los servicios del sistema en el momento del arranque. Todo en este directorio debe ser texto legible. Si bien todo en / etc es interesante, aquí hay algunos favoritos de todos los tiempos: /etc/crontab, un archivo que define cuándo se ejecutarán los trabajos automatizados; /etc/fstab, una tabla de dispositivos de almacenamiento y sus puntos de montaje asociados; y /etc/passwd, una lista de las cuentas de usuario.</span> |
| /home | In normal configurations, each user is given a directory in /home.<br />Ordinary users can write files only in their home directories. This limitation protects the system from errant user activity.<br /><span style="color:green">En configuraciones normales, a cada usuario se le asigna un directorio en /home. <br /> Los usuarios comunes pueden escribir archivos solo en sus directorios de inicio. Esta limitación protege al sistema de la actividad errante del usuario.</span> |
| /lib | Contains shared library files used by the core system programs.<br />These are similar to dynamic link libraries (DLLs) in Windows.<br /><span style="color:green">Contiene archivos de bibliotecas compartidas que utilizan los programas principales del sistema.<br /> Son similares a las bibliotecas de vínculos dinámicos (DLL) de Windows.</span> |
| /lost+found | Each formatted partition or device using a Linux file system, such as ext3, will have this directory. It is used in the case of a partial recovery from a file system corruption event. Unless something really bad has happened to your system, this directory will remain empty.<br /><span style="color:green">Cada partición o dispositivo formateado que utilice un sistema de archivos Linux, como ext3, tendrá este directorio. Se utiliza en el caso de una recuperación parcial de un evento de corrupción del sistema de archivos. A menos que le haya ocurrido algo realmente malo a su sistema, este directorio permanecerá vacío.</span> |
| /media | On modern Linux systems, the /media directory will contain the mount points for removable media such as USB drives, CD-ROMs, and so on, that are mounted automatically at insertion.<br /><span style="color:green">En los sistemas Linux modernos, el directorio /media contendrá los puntos de montaje de los medios extraíbles, como unidades USB, CD-ROM, etc., que se montan automáticamente al insertarlos.</span> |
| /mnt | On older Linux systems, the /mnt directory contains mount points for removable devices that have been mounted manually. <br /><span style="color:green">En sistemas Linux más antiguos, el directorio / mnt contiene puntos de montaje para dispositivos extraíbles que se han montado manualmente.</span>|
| /opt | The /opt directory is used to install “optional” software. This is mainly used to hold commercial software products that might be installed on the system. <br /><span style="color:green">El directorio / opt se utiliza para instalar software "opcional". Se utiliza principalmente para contener productos de software comerciales que pueden estar instalados en el sistema.</span>|
| /proc | The /proc directory is special. It’s not a real file system in the sense of files stored on your hard drive. Rather, it is a virtual file system maintained by the Linux kernel. The "files" it contains are peepholes into the kernel itself. The files are readable and will give you a picture of how the kernel sees your computer. <br /><span style="color:green">El directorio /proc es especial. No es un sistema de archivos real en el sentido de archivos almacenados en su disco duro. Más bien, es un sistema de archivos virtual mantenido por el kernel de Linux. Los "archivos" que contiene son mirillas en el propio kernel. Los archivos son legibles y le darán una imagen de cómo ve el kernel su computadora.</span>|
| /root | This is the home directory for the root account.<br /><span style="color:green">Este es el directorio de inicio de la cuenta raíz.</span> |
| /sbin | This directory contains "system" binaries. These are programs that perform vital system tasks that are generally reserved for the superuser.<br /><span style="color:green">Este directorio contiene binarios del "sistema". Estos son programas que realizan tareas vitales del sistema que generalmente están reservadas para el superusuario.</span> |
| /tmp | The /tmp directory is intended for the storage of temporary, transient files created by various programs. Some configurations cause this directory to be emptied each time the system is rebooted. <br /><span style="color:green">El directorio /tmp está destinado al almacenamiento de archivos temporales y transitorios creados por varios programas. Algunas configuraciones hacen que este directorio se vacíe cada vez que se reinicia el sistema.</span>|
| /usr | The /usr directory tree is likely the largest one on a Linux system. It contains all the programs and support files used by regular users.<br /><span style="color:green">El árbol de directorios / usr es probablemente el más grande en un sistema Linux. Contiene todos los programas y archivos de soporte que utilizan los usuarios habituales.</span> |
| /usr/bin | /usr/bin contains the executable programs installed by your Linux distribution. It is not uncommon for this directory to hold thousands of programs.<br /><span style="color:green">/usr/bin contiene los programas ejecutables instalados por su distribución de Linux. No es raro que este directorio contenga miles de programas.</span> |
| /usr/lib  | The shared libraries for the programs in /usr/bin.<br /><span style="color:green">Las bibliotecas compartidas para los programas en /usr/bin.</span>|
| /usr/local | The /usr/local tree is where programs that are not included with your distribution but are intended for system-wide use are installed. Programs compiled from source code are normally installed in /usr/local/bin. On a newly installed Linux system, this tree exists, but it will be empty until the system administrator puts something in it. <br /><span style="color:green">El árbol /usr/local es donde se instalan los programas que no están incluidos con su distribución pero que están pensados para su uso en todo el sistema. Los programas compilados a partir del código fuente se instalan normalmente en /usr/local/bin. En un sistema Linux recién instalado, este árbol existe, pero estará vacío hasta que el administrador del sistema introduzca algo en él.</span>|
| /usr/sbin | Contains more system administration programs.<br /><span style="color:green">Contiene más programas de administración del sistema.</span> |
| /usr/share | /usr/share contains all the shared data used by programs in /usr/bin. This includes things such as default configuration files, icons, screen backgrounds, sound files, and so on.<br /><span style="color:green">/usr/share contiene todos los datos compartidos utilizados por los programas en /usr/bin. Esto incluye cosas como archivos de configuración predeterminados, iconos, fondos de pantalla, archivos de sonido, etc.</span> |
| /usr/share/doc | Most packages installed on the system will include some kind of documentation. In /usr/share/doc, we will find documentation files organized by package.<br /><span style="color:green">La mayoría de los paquetes instalados en el sistema incluirán algún tipo de documentación. En /usr/share/doc, encontraremos archivos de documentación organizados por paquete.</span> |
| /var | With the exception of /tmp and /home, the directories we have looked at so far remain relatively static; that is, their contents don’t change. The /var directory tree is where data that is likely to change is stored. Various databases, spool files, user mail, and so forth, are located here.<br /><span style="color:green">Con la excepción de /tmp y /home, los directorios que hemos visto hasta ahora permanecen relativamente estáticos; es decir, su contenido no cambia. El árbol de directorios / var es donde se almacenan los datos que pueden cambiar. Aquí se encuentran varias bases de datos, archivos de cola, correo de usuario, etc.</span> |
| /var/log | /var/log contains log files, records of various system activity. These are important and should be monitored from time to time. The most useful ones are /var/log/messages and /var/log/syslog. Note that for security reasons on some systems, you must be the superuser to view log files.<br /><span style="color:green">/var/log contiene archivos de registro, registros de diversas actividades del sistema. Estos son importantes y deben monitorearse de vez en cuando. Los más útiles son /var/log/messages y /var/log/syslog. Tenga en cuenta que por razones de seguridad en algunos sistemas, debe ser el superusuario para ver los archivos de registro.</span> | 
______

# Symbolic Links<br /><span style="color:yellow">Vínculos simbólicos</span>

As we look around, we are likely to see a directory listing (for example, /lib ) with an entry like this:<br /><span style="color:green">Cuando miramos a nuestro alrededor, es probable que veamos una lista de directorios (por ejemplo, / lib) con una entrada como esta:</span>

`lrwxrwxrwx 1 root root 11 2018-08-11 07:34 libc.so.6 -> libc-2.6.so`

Notice how the first letter of the listing is l and the entry seems to have two filenames? This is a special kind of a file called a symbolic link (also known as a soft link or symlink). In most Unix-like systems, it is possible to have a file referenced by multiple names. While the value of this might not be obvious, it is really a useful feature.<br /><span style="color:green">¿Observa cómo la primera letra de la lista es ly la entrada parece tener dos nombres de archivo? Este es un tipo especial de archivo llamado enlace simbólico (también conocido como enlace flexible o enlace simbólico). En la mayoría de los sistemas similares a Unix, es posible tener un archivo referenciado por varios nombres. Si bien el valor de esto puede no ser obvio, es realmente una característica útil</span>

Picture this scenario: a program requires the use of a shared resource of some kind contained in a file named "foo," but "foo" has frequent version changes. It would be good to include the version number in the filename so the administrator or other interested party could see what version of "foo" is installed. This presents a problem. If we change the name of the shared resource, we have to track down every program that might use it and change it to look for a new resource name every time a new version of the resource is installed. That doesn’t sound like fun at all.<br /><span style="color:green">Imagínese este escenario: un programa requiere el uso de un recurso compartido de algún tipo contenido en un archivo llamado "foo", pero "foo" tiene cambios de versión frecuentes. Sería bueno incluir el número de versión en el nombre del archivo para que el administrador u otra parte interesada pueda ver qué versión de "foo" está instalada. Esto presenta un problema. Si cambiamos el nombre del recurso compartido, tenemos que rastrear todos los programas que podrían usarlo y cambiarlo para buscar un nuevo nombre de recurso cada vez que se instala una nueva versión del recurso. Eso no suena para nada divertido.</span>

Here is where symbolic links save the day. Suppose we install version 2.6 of "foo," which has the filename "foo-2.6," and then create a symbolic link simply called "foo" that points to "foo-2.6." This means that when a program opens the file "foo," it is actually opening the file "foo-2.6." Now everybody is happy. The programs that rely on "foo" can find it, and we can still see what actual version is installed. When it is time to upgrade to "foo-2.7," we just add the file to our system, delete the symbolic link "foo," and create a new one that points to the new version. Not only does this solve the problem of the version upgrade, it also allows us to keep both versions on our machine.<br /><span style="color:green">Aquí es donde los enlaces simbólicos salvan el día. Supongamos que instalamos la versión 2.6 de "foo", que tiene el nombre de archivo "foo-2.6", y luego creamos un enlace simbólico llamado simplemente "foo" que apunta a "foo-2.6". Esto significa que cuando un programa abre el archivo "foo", en realidad está abriendo el archivo "foo-2.6". Ahora todo el mundo está feliz. Los programas que dependen de "foo" pueden encontrarlo y aún podemos ver qué versión real está instalada. Cuando llega el momento de actualizar a "foo-2.7", simplemente agregamos el archivo a nuestro sistema, eliminamos el enlace simbólico "foo" y creamos uno nuevo que apunta a la nueva versión. Esto no solo resuelve el problema de la actualización de la versión, sino que también nos permite mantener ambas versiones en nuestra máquina.</span>

Imagine that "foo-2.7" has a bug (damn those developers!), and we need to revert to the old version. Again, we just delete the symbolic link pointing to the new version and create a new symbolic link pointing to the old version.<br /><span style="color:green">Imagina que "foo-2.7" tiene un error (¡malditos sean los desarrolladores!), Y necesitamos volver a la versión anterior. Nuevamente, simplemente eliminamos el enlace simbólico que apunta a la nueva versión y creamos un nuevo enlace simbólico que apunta a la versión anterior.</span>

The directory listing at the beginning of this section (from the /lib directory of a Fedora system) shows a symbolic link called libc.so.6 that points to a shared library file called libc-2.6.so. This means that programs looking for libc.so.6 will actually get the file libc-2.6.so. We will learn how to create symbolic links in the next chapter.<br /><span style="color:green">La lista de directorios al principio de esta sección (del directorio / lib de un sistema Fedora) muestra un enlace simbólico llamado libc.so.6 que apunta a un archivo de biblioteca compartida llamado libc-2.6.so. Esto significa que los programas que buscan libc.so.6 obtendrán el archivo libc-2.6.so. Aprenderemos a crear enlaces simbólicos en el próximo capítulo.</span>

# Hard Links<br /><span style="color:yellow">Enlaces duros</span>

While we are on the subject of links, we need to mention that there is a second type of link called hard links. Hard links also allow files to have multiple names, but they do it in a different way. We’ll talk more about the differences between symbolic and hard links in the next chapter.<br /><span style="color:green">Ya que estamos en el tema de los enlaces, debemos mencionar que existe un segundo tipo de enlace llamado enlaces físicos. Los enlaces duros también permiten que los archivos tengan varios nombres, pero lo hacen de una manera diferente. Hablaremos más sobre las diferencias entre enlaces simbólicos y duros en el próximo capítulo.</span>

# Summing Up<br /><span style="color:yellow">Resumen</span>

With our tour behind us, we have learned a lot about our system. We’ve seen various files and directories and their contents. One thing you should take away from this is how open the system is. In Linux there are many important files that are plain human-readable text. Unlike many proprietary systems, Linux makes everything available for examination and study.<br /><span style="color:green">Con nuestro recorrido detrás de nosotros, hemos aprendido mucho sobre nuestro sistema. Hemos visto varios archivos y directorios y su contenido. Una cosa que debe sacar de esto es cuán abierto es el sistema. En Linux hay muchos archivos importantes que son texto simple legible por humanos. A diferencia de muchos sistemas propietarios, Linux hace que todo esté disponible para su examen y estudio.</span>

