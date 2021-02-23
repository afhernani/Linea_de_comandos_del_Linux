echo """

# Archivado y copia de seguridad

    One of the primary tasks of a computer system’s administrator is keeping the system’s data secure. One way this is done is by performing timely backups of the system’s files.

    Even if you’re not a system administrator, it is often useful to make copies of things and move large collections of files from place to place and from device to device.

    In this chapter, we will look at several common programs that are used to manage collections of files. These are the file compression programs:

    gzip | Comprimir o expandir archivos
    bzip2 | Un compresor de archivos de clasificación de bloques

    Estos son los programas de archivo:

    tar | Utilidad de archivo de cinta
    zip | Empaquetar y comprimir archivos
    
    Este es el programa de sincronización de archivos:

    rsync | Sincronización remota de archivos y directorios

    
 # Comprimir archivos

    A lo largo de la historia de la informática, ha habido una lucha para obtener la mayor cantidad de datos en el espacio más pequeño disponible, ya sea memoria, dispositivos de almacenamiento o ancho de banda de red. Muchos de los servicios de datos que damos por sentado en la actualidad, como el servicio de telefonía móvil, la televisión de alta definición o Internet de banda ancha, deben su existencia a técnicas eficaces de compresión de datos.

    La compresión de datos es el proceso de eliminar la redundancia de los datos. Consideremos un ejemplo imaginario. Supongamos que tuviéramos un archivo de imagen completamente negro con las dimensiones de 100 píxeles por 100 píxeles. En términos de almacenamiento de datos (asumiendo 24 bits o 3 bytes por píxel), la imagen ocupará 30.000 bytes de almacenamiento.
    
    100 x 100 x 3 = 30.000
    
    Una imagen de un solo color contiene datos completamente redundantes. Si fuéramos inteligentes, podríamos codificar los datos de tal manera que simplemente describiéramos el hecho de que tenemos un bloque de 10,000 píxeles negros. Entonces, en lugar de almacenar un bloque de datos que contenga 30,000 ceros (el negro generalmente se representa en archivos de imagen como cero), podríamos comprimir los datos en el número 10,000, seguido de un cero para representar nuestros datos. Este esquema de compresión de datos se denomina codificación de longitud de ejecución y es una de las técnicas de compresión más rudimentarias. Las técnicas actuales son mucho más avanzadas y complejas, pero el objetivo básico sigue siendo el mismo: deshacerse de los datos redundantes. Los algoritmos de compresión (las técnicas matemáticas utilizadas para realizar la compresión) se dividen en dos categorías generales.
    
    Sin pérdidas (lossless). La compresión sin pérdida conserva todos los datos contenidos en el original. Esto significa que cuando se restaura un archivo desde una versión comprimida, el archivo restaurado es exactamente el mismo que la versión original sin comprimir.
    
    Pérdida (lossy). La compresión con pérdida, por otro lado, elimina los datos a medida que se realiza la compresión para permitir que se aplique más compresión. Cuando se restaura un archivo con pérdida, no coincide con la versión original; más bien, es una aproximación cercana. Ejemplos de compresión con pérdida son JPEG (para imágenes) y MP3 (para música).
    
   En nuestra discusión, analizaremos exclusivamente la compresión sin pérdida, ya que la mayoría de los datos en las computadoras no pueden tolerar ninguna pérdida de datos.
   
   # gzip

   El programa gzip se utiliza para comprimir uno o más archivos. Cuando se ejecuta, reemplaza el archivo original con una versión comprimida del original. El programa gunzip correspondiente se utiliza para restaurar archivos comprimidos a su forma original sin comprimir. Aquí hay un ejemplo: 
   
   [~]$ ls -l /etc > foo.txt 
   [~]$ ls -l foo.*
   [~]$ gzip foo.txt
   [~]$ ls -l foo.*
   [~]$ gunzip foo.txt
   [~]$ ls -l foo.*
   
   En este ejemplo, creamos un archivo de texto llamado foo.txt a partir de una lista de directorios. A continuación, ejecutamos gzip, que reemplaza el archivo original con una versión comprimida llamada foo.txt.gz. En la lista de directorios de foo.*, Vemos que el archivo original ha sido reemplazado por la versión comprimida y que la versión comprimida tiene aproximadamente una quinta parte del tamaño del original. También podemos ver que el archivo comprimido tiene los mismos permisos y marca de tiempo que el original.

    A continuación, ejecutamos el programa gunzip para descomprimir el archivo. Luego, podemos ver que la versión comprimida del archivo ha sido reemplazada por la original, nuevamente con los permisos y la marca de tiempo conservados.

    gzip tiene muchas opciones, como se describe en la Tabla :

    Opciones de gzip
    
    Opción | Opción larga | Descripción
    
    -c  | --stdout      |
        | --to-stdout   | Escriba la salida en la salida estándar y conserve los archivos originales.

    -d  | --decompress  |
        | --uncompress  | Descomprimir. Esto hace que gzip actúe como gunzip.

    -f  | --force       | Fuerza la compresión incluso si ya existe una versión comprimida del archivo original.

    -h  | --help        | Muestra información de uso.

    -l  | --list        | Enumere las estadísticas de compresión para cada archivo comprimido.

    -r  | --recursive   | Si uno o más argumentos en la línea de comando es un directorio, comprima de forma recursiva los archivos contenidos en ellos.

    -t  | --test (prueba)| Pruebe la integridad de un archivo comprimido.

    -v  | --verbose     | Muestra mensajes detallados mientras comprime.

    -number | Establecer la cantidad de compresión. número es un número entero en el rango de 1 (más rápido, menor compresión) a 9 (más lento, mayor compresión). Los valores 1 y 9 también pueden expresarse como --fast (rápido) y --best (mejor), respectivamente. El valor predeterminado es 6.
    
    
    # Volvamos a nuestro ejemplo anterior.
    
       [~]$ gzip foo.txt
       [~]$ gzip -tv foo.txt.gz
       [~]$ gzip -d foo.txt.gz
       
    Aquí, reemplazamos foo.txt con una versión comprimida llamada foo.txt.gz. A continuación, probamos la integridad de la versión comprimida, usando las opciones -t y -v. Finalmente, descomprimimos el archivo a su forma original.

    gzip también se puede utilizar de formas interesantes a través de la entrada y salida estándar.
    
    [~]$ ls -l /etc | gzip > foo.txt.gz
    
    Este comando crea una versión comprimida de una lista de directorios. El programa gunzip, que descomprime archivos gzip, asume que los nombres de los archivos terminan en la extensión .gz, por lo que no es necesario especificarlo, siempre que el nombre especificado no entre en conflicto con un archivo sin comprimir existente.
    
    [~]$ gunzip foo.txt
    
    Si nuestro objetivo fuera solo ver el contenido de un archivo de texto comprimido, podríamos hacer esto:
    
    [~]$ gunzip -c foo.txt | less
    alternativamente:
    [~]$ zcat foo.txt.gz | less
    
    Anotacion: También hay un programa zless. Realiza la misma función que la canalización anterior.
    
 # bzip2
    
    El programa bzip2, de Julian Seward, es similar a gzip pero usa un algoritmo de compresión diferente que logra niveles más altos de compresión a costa de la velocidad de compresión. En la mayoría de los casos, funciona de la misma forma que gzip. Un archivo comprimido con bzip2 se denota con la extensión .bz2.
    
   [~]$ ls -l /etc > foo.txt 
   [~]$ ls -l foo.txt
   [~]$ bzip2 foo.txt
   [~]$ ls -l foo.txt.bz2
   [~]$ bunzip2 foo.txt.bz2
   [~]$ ls -l foo.*
   
    Como podemos ver, bzip2 se puede utilizar de la misma forma que gzip. Todas las opciones (excepto -r) que discutimos para gzip también son compatibles con bzip2. Sin embargo, tenga en cuenta que la opción de nivel de compresión (-number) tiene un significado algo diferente a bzip2. bzip2 viene con bunzip2 y bzcat para descomprimir archivos.

    bzip2 también viene con el programa bzip2recover, que intentará recuperar archivos .bz2 dañados.
    
   # Archivar archivos

    Una tarea común de administración de archivos que se usa a menudo junto con la compresión es el archivo. Archivar es el proceso de reunir muchos archivos y agruparlos en un solo archivo grande. El archivado se suele realizar como parte de las copias de seguridad del sistema. También se utiliza cuando los datos antiguos se mueven de un sistema a algún tipo de almacenamiento a largo plazo. 
    
    # tar
    
    En el mundo del software similar a Unix, el programa tar es la herramienta clásica para archivar archivos. Su nombre, abreviatura de archivo en cinta, revela sus raíces como una herramienta para hacer cintas de respaldo. Si bien todavía se usa para esa tarea tradicional, es igualmente hábil en otros dispositivos de almacenamiento. A menudo vemos nombres de archivo que terminan con la extensión .tar o .tgz, que indican un archivo tar \"simple\" y un archivo comprimido con gzip, respectivamente. Un archivo tar puede constar de un grupo de archivos separados, una o más jerarquías de directorios o una combinación de ambos. La sintaxis del comando funciona así:
    
    tar mode[options] pathname ...
    
    Aquí, el modo es uno de los modos de funcionamiento enumerados en la Tabla tar Modos. (aquí solo se muestra una lista parcial; consulte la página de manual de tar para obtener una lista completa).
    
    tar Modos.
    Modo | Descripción
    c    | Cree un archivo a partir de una lista de archivos y / o directorios.
    x    | Extrae un archivo.
    r    | Agrega los nombres de ruta especificados al final de un archivo.
    t    | Enumere el contenido de un archivo.
    
    tar utiliza una forma un poco extraña de expresar opciones, por lo que necesitaremos algunos ejemplos para mostrar cómo funciona. Primero, recreemos nuestro patio de recreo del capítulo anterior.
    
    [~]$ mkdir -p playground/dir-{001..100}
    [~]$ touch playground/dir-{001..100}/file-{A..Z}
    
    A continuación, creemos un archivo tar de todo el patio de recreo.
    
    [~]$ tar cf playground.tar playground
    
    Este comando crea un archivo tar llamado playground.tar que contiene toda la jerarquía del directorio de juegos. Podemos ver que el modo y la opción f, que se usa para especificar el nombre del archivo tar, pueden unirse y no requieren un guión inicial. Sin embargo, tenga en cuenta que el modo siempre debe especificarse primero, antes que cualquier otra opción.

    Para listar el contenido del archivo, podemos hacer esto:
    
    [~]$ tar tf playground.tar
    
    Para una lista más detallada, podemos agregar la opción v (detallado).
    
    [~]$ tar tvf playground.tar
    
    Ahora, extraigamos el parque infantil en una nueva ubicación. Haremos esto creando un nuevo directorio llamado foo, cambiando el directorio y extrayendo el archivo tar.
    
    [~]$ mkdir foo
    [~]$ cd foo
    [foo]$ tar xf ../playground.tar
    [foo]$ ls
    playground
    
    Si examinamos el contenido de ~/foo/playground, vemos que el archivo se instaló correctamente, creando una reproducción precisa de los archivos originales. Sin embargo, hay una advertencia. A menos que estemos operando como superusuario, los archivos y directorios extraídos de los archivos adquieren la propiedad del usuario que realiza la restauración, en lugar del propietario original.
    
    Otro comportamiento interesante de tar es la forma en que maneja los nombres de ruta en archivos. El valor predeterminado para los nombres de ruta es relativo, en lugar de absoluto. tar hace esto simplemente eliminando cualquier barra inclinada inicial del nombre de la ruta al crear el archivo. Para demostrarlo, volveremos a crear nuestro archivo, esta vez especificando un nombre de ruta absoluto.
    
    [foo]$ cd
    [~]$ tar cf playground2.tar ~/playground
    
    Recuerde, ~/playground se expandirá a /home/me/playground cuando presionemos enter, por lo que obtendremos un nombre de ruta absoluto para nuestra demostración. A continuación, extraeremos el archivo como antes y observaremos qué sucede.
    
    [~]$ cd foo
    [foo]$ tar xf ../playground2.tar
    [foo]$ ls
        home playground
    [foo]$ ls home
        me
    [foo]$ ls home/me
        playground
    
    Aquí podemos ver que cuando extrajimos nuestro segundo archivo, volvió a crear el directorio home/me/playground relativo a nuestro directorio de trabajo actual, ~/foo, no relativo al directorio raíz, como habría sido el caso con un absoluto nombre de ruta. Esto puede parecer una forma extraña de que funcione, pero en realidad es más útil de esta manera porque nos permite extraer archivos a cualquier ubicación en lugar de vernos obligados a extraerlos a sus ubicaciones originales.
    Repetir el ejercicio con la inclusión de la opción detallada (v) dará una idea más clara de lo que está sucediendo.
    
    Consideremos un ejemplo hipotético, pero práctico, de alquitrán en acción. Imagine que queremos copiar el directorio de inicio y su contenido de un sistema a otro y tenemos un disco duro USB grande que podemos usar para la transferencia. En nuestro moderno sistema Linux, la unidad se monta \"automágicamente\" en el directorio / media. Imaginemos también que el disco tiene un nombre de volumen de BigDisk cuando lo adjuntamos. Para hacer el archivo tar, podemos hacer lo siguiente:
    
    [~]$ sudo tar cf /media/BigDisk/home.tar /home
    
    Después de escribir el archivo tar, desmontamos la unidad y la conectamos a la segunda computadora. Nuevamente, está montado en /media/BigDisk. Para extraer el archivo, hacemos esto:
    
    [~]$ cd /
    [/]$ sudo tar xf /media/BigDisk/home.tar
    
    Lo que es importante ver aquí es que primero debemos cambiar el directorio a / para que la extracción sea relativa al directorio raíz, ya que todos los nombres de ruta dentro del archivo son relativos.
    
    Al extraer un archivo, es posible limitar lo que se extrae del archivo. Por ejemplo, si quisiéramos extraer un solo archivo de un archivo, podría hacerse así:
    
    tar xf archive.tar pathname
    
    Al agregar el nombre de la ruta final al comando, tar restaurará solo el archivo especificado. Se pueden especificar varios nombres de ruta. Tenga en cuenta que el nombre de ruta debe ser el nombre de ruta relativo completo y exacto tal como se almacena en el archivo.
    
    Al especificar nombres de ruta, normalmente no se admiten comodines; sin embargo, la versión GNU de tar (que es la versión que se encuentra con mayor frecuencia en las distribuciones de Linux) los admite con la opción --wildcards. Aquí hay un ejemplo usando nuestro archivo playground.tar anterior:
    
    [~]$ cd foo
    [foo]$ tar xf ../playground2.tar --wildcards 'home/me/playground/dir-*/file-A'
    
    Este comando extraerá solo los archivos que coincidan con el nombre de ruta especificado, incluido el comodín dir- *.
    tar se utiliza a menudo junto con find para producir archivos. En este ejemplo, usaremos find para producir un conjunto de archivos para incluir en un archivo.
    
    [~]$ find playground -name 'file-A' -exec tar rf playground.tar '{}' '+'
    
    Aquí usamos find para hacer coincidir todos los archivos en el patio de recreo llamado file-A y luego, usando la acción -exec, invocamos tar en el modo de adición (r) para agregar los archivos coincidentes al archivo playground.tar.
    Usar tar con find es una buena forma de crear copias de seguridad incrementales de un árbol de directorios o de un sistema completo. Al usar buscar para hacer coincidir archivos más nuevos que un archivo de marca de tiempo, podríamos crear un archivo que contenga solo aquellos archivos más nuevos que el último archivo, asumiendo que el archivo de marca de tiempo se actualiza inmediatamente después de que se crea cada archivo.
tar también puede utilizar tanto la entrada como la salida estándar. Aquí hay un ejemplo completo:

    [foo]$ cd
    [~]$ find playground -name 'file-A' | tar cf - --files-from=- | gzip > playground.tgz
    
    En este ejemplo, usamos el programa de búsqueda para producir una lista de archivos coincidentes y los canalizamos a tar. Si se especifica el nombre de archivo -, se considera que significa entrada o salida estándar, según sea necesario. (Por cierto, esta convención de usar - para representar entrada / salida estándar también es usada por varios otros programas). La opción --files-from (que también se puede especificar como -T) hace que tar lea su lista de nombres de ruta de un archivo en lugar de la línea de comando. Por último, el archivo producido por tar se canaliza a gzip para crear el archivo comprimido playground.tgz. La extensión .tgz es la extensión convencional que se da a los archivos tar comprimidos con gzip. La extensión .tar.gz también se usa a veces.
    
    Si bien usamos el programa gzip externamente para producir nuestro archivo comprimido, las versiones modernas de GNU tar admiten la compresión gzip y bzip2 directamente con el uso de las opciones zy j, respectivamente. Usando nuestro ejemplo anterior como base, podemos simplificarlo de esta manera:
    
    [~]$ find playground -name 'file-A' | tar czf playground.tgz -T -
    
    Si hubiéramos querido crear un archivo comprimido con bzip2 en su lugar, podríamos haber hecho esto:
    
    [~]$ find playground -name 'file-A' | tar cjf playground.tbz -T -
    
    Simplemente cambiando la opción de compresión de z a j (y cambiando la extensión del archivo de salida a .tbz para indicar un archivo comprimido con bzip2), habilitamos la compresión bzip2.
    
    Otro uso interesante de la entrada y salida estándar con el comando tar implica la transferencia de archivos entre sistemas a través de una red. Imagine que tenemos dos máquinas ejecutando un sistema similar a Unix equipado con tar y ssh. En tal escenario, podríamos transferir un directorio desde un sistema remoto (llamado remote-sys para este ejemplo) a nuestro sistema local.
    
    [~]$ mkdir remote-stuff
    [~]$ cd remote-stuff
    [remote-stuff]$ ssh remote-sys 'tar cf - Documents' | tar xf -
        me@remote-sys's password:
    [remote-stuff]$ ls
        Documents
    
    
    Aquí pudimos copiar un directorio llamado Documents desde el sistema remoto remote-sys a un directorio dentro del directorio llamado remote-stuff en el sistema local. ¿Cómo hicimos esto? Primero, lanzamos el programa tar en el sistema remoto usando ssh. Recordará que ssh nos permite ejecutar un programa de forma remota en una computadora en red y \"ver\" los resultados en el sistema local; la salida estándar producida en el sistema remoto se envía al sistema local para su visualización. Podemos aprovechar esto haciendo que tar cree un archivo (el modo c) y lo envíe a la salida estándar, en lugar de un archivo (la opción f con el argumento del guión), transportando así el archivo a través del túnel encriptado proporcionado por ssh a el sistema local. En el sistema local, ejecutamos tar y hacemos que expanda un archivo (el modo x) proporcionado desde la entrada estándar (nuevamente, la opción f con el argumento del guión).
    
    
    # zip
    
    El programa zip es tanto una herramienta de compresión como un archivador. El formato de archivo utilizado por el programa es familiar para los usuarios de Windows, ya que lee y escribe archivos .zip. En Linux, sin embargo, gzip es el programa de compresión predominante, con bzip2 en segundo lugar.

    En su uso más básico, zip se invoca así:
    
    zip options zipfile file ...
    Por ejemplo, para hacer un archivo zip de nuestro patio de recreo -playground- deberiamos hacer esto:
    
    [~$] zip -r playground.zip playground
    
    A menos que incluyamos la opción -r para la recursividad, solo se almacena el directorio del patio de recreo (pero ninguno de sus contenidos). Aunque la adición de la extensión .zip es automática, incluiremos la extensión del archivo para mayor claridad.

    Durante la creación del archivo zip, zip normalmente mostrará una serie de mensajes como este:
    
    Estos mensajes muestran el estado de cada archivo agregado al archivo. zip agregará archivos al archivo usando uno de dos métodos de almacenamiento: o \"almacenará\" -> \"store\" un archivo sin compresión, como se muestra aquí, o \"desinflará\" -> \"deflate\" el archivo que realiza la compresión. El valor numérico que se muestra después del método de almacenamiento indica la cantidad de compresión lograda. Dado que nuestro patio de juegos contiene solo archivos vacíos, no se realiza ninguna compresión en su contenido. Extraer el contenido de un archivo zip es sencillo cuando se usa el programa de descompresión.
    
    [~]$ cd foo
    [foo]$ unzip ../playground.zip
    
    Una cosa a tener en cuenta sobre zip (a diferencia de tar) es que si se especifica un archivo existente, se actualiza en lugar de reemplazarlo. Esto significa que el archivo existente se conserva, pero se agregan nuevos archivos y se reemplazan los archivos coincidentes.
    Podemos enumerar y extraer archivos de forma selectiva de un archivo zip especificándolos para descomprimirlos.
    
    [~]$ unzip -l playground.zip playground/dir-087/file-Z
    ...
    [~]$ cd foo
    [foo]$ unzip ../playground.zip playground/dir-087/file-Z
        Archive: ../playground.zip
        replace playground/dir-087/file-Z? [y]es, [n]o, [A]ll, [N]one, [r]ename: y
        extracting: playground/dir-087/file-Z
        
    El uso de la opción -l hace que descomprimir simplemente enumere el contenido del archivo sin extraer el archivo. Si no se especifican archivos, descomprimir mostrará una lista de todos los archivos en el archivo. Se puede agregar la opción -v para aumentar la verbosidad del listado. Tenga en cuenta que cuando la extracción del archivo entra en conflicto con un archivo existente, se le solicita al usuario antes de reemplazar el archivo.
    Como tar, zip puede hacer uso de entrada y salida estándar, aunque su implementación es algo menos útil. Es posible canalizar una lista de nombres de archivos para comprimir mediante la opción - @.
    
    [foo]$ cd
    [~]$ find playground -name \"file-A\" | zip -@ file-A.zip
    
    Aquí usamos find para generar una lista de archivos que coinciden con el nombre de prueba "archivo-A" y luego canalizar la lista en zip, lo que crea el archivo de almacenamiento-A.zip que contiene los archivos seleccionados.
    zip también admite la escritura de su salida en una salida estándar, pero su uso es limitado porque pocos programas pueden hacer uso de la salida. Desafortunadamente, el programa de descompresión no acepta la entrada estándar. Esto evita que zip y unzip se usen juntos para realizar copias de archivos de red como tar.
    zip puede, sin embargo, aceptar entrada estándar, por lo que se puede utilizar para comprimir la salida de otros programas.
    
    [~]$ ls -l /etc/ | zip ls-etc.zip -
        adding: - (deflated 80%)
    
    En este ejemplo, canalizamos la salida de ls a zip. Al igual que tar, zip interpreta el guión final como \"use la entrada estándar para el archivo de entrada\".
    El programa de descompresión permite que su salida se envíe a la salida estándar cuando se especifica la opción -p (para tubería).
    
    [~]$ unzip -p ls-etc.zip | less
    
    Tocamos algunas de las cosas básicas que puede hacer zip/unzip. Ambos tienen muchas opciones que se suman a su flexibilidad, aunque algunas son específicas de la plataforma de otros sistemas. Las páginas de manual para zip y unzip son bastante buenas y contienen ejemplos útiles; sin embargo, el uso principal de estos programas es para intercambiar archivos con sistemas Windows, en lugar de realizar la compresión y el archivo en Linux, donde se prefieren tar y gzip.
    
    
    
    # Sincronizar archivos y directorios (rsync)
    
    Una estrategia común para mantener una copia de seguridad de un sistema implica mantener uno o más directorios sincronizados con otro directorio (o directorios) ubicados en el sistema local (generalmente un dispositivo de almacenamiento extraíble de algún tipo) o en un sistema remoto. Podríamos, por ejemplo, tener una copia local de un sitio web en desarrollo y sincronizarla de vez en cuando con la copia \"en vivo\" en un servidor web remoto.
    
    Protocolo de actualización remota rsync, que permite a rsync detectar rápidamente las diferencias entre dos directorios y realizar la cantidad mínima de copia necesaria para sincronizarlos. Esto hace que rsync sea muy rápido y económico de usar, en comparación con otros tipos de programas de copia.

    rsync se invoca así:
    
    rsync options source destination
    
    donde el origen (source) y el destino (destination) son uno de los siguientes:

        Un archivo o directorio local
        Un archivo o directorio remoto en forma de [user@]host:path
        Un servidor rsync remoto especificado con un URI de rsync://[user@] host[:port]/path
    
    Tenga en cuenta que el origen o el destino deben ser un archivo local. No se admite la copia de remoto a remoto.
    Probemos con rsync en algunos archivos locales. Primero, limpiemos nuestro directorio foo.
    
    [~]$ rm -rf foo/*
    
    A continuación, sincronizaremos el directorio del patio de recreo con una copia correspondiente en foo.
    
    [~]$ rsync -av playground foo
    
    Hemos incluido tanto la opción -a (para archivar: provoca la recursividad y conservación de los atributos del archivo) como la opción -v (salida detallada) para hacer un espejo del directorio de juegos dentro de foo. Mientras se ejecuta el comando, veremos una lista de los archivos y directorios que se están copiando. Al final, veremos un mensaje resumen como este indicando la cantidad de copias realizadas:
    si ejecutamos el comando otra vez, veremos un resultado diferente, indicando que la lista de archivos copiada, se hizo.
    Darse cuenta que no hay lista de archivos. esto es porque rsync detectó que no hubo ninguna diferencia entre ~/playground y ~/foo/playground y por tanto no necesita copiar nada. si modificamos un archivo en playground y ejecutamos otra vez rsync, 
    
    [~]$ touch playground/dir-099/file-Z
    [~]$ rsync -av playground foo
        building file list ... done
        playground/dir-099/file-Z
        sent 22685 bytes received 42 bytes 45454.00 bytes/sec
        total size is 3230 speedup is 0.14
    
    Como vemos, rsync detecto el cambio y copió solo los archivos actualizados.
    Hay una característica sutil pero útil que podemos usar cuando especificamos una fuente rsync. Consideremos dos directorios.
    
    [~]$ ls
    source   desination
    
    el directorio fuente (source) contiene un archivo llamado file1, y un directorio llamado destino (destination) que está vacio. si realizamos una copia de source a destination tal que asi:
    
    [~]$ rsync source desination
    
    entonces rsync copia el directorio source dentro de destination.
    
    [~]$ ls destination
    source
    
    Sin embargo, si agregamos un / al final del nombre del directorio de origen, rsync copiará solo el contenido del directorio de origen y no el directorio en sí.
    
    [~]$ rsync source/ destination
    [~]$ ls destination
        file1
    
    Esto es útil si solo queremos copiar el contenido de un directorio sin crear otro nivel de directorios dentro del destino. Podemos pensar en él como fuente /* en su resultado, pero este método copiará todo el contenido del directorio fuente, incluidos los archivos ocultos.
    Como ejemplo práctico, consideremos el disco duro externo imaginario que usamos anteriormente con tar. Si conectamos la unidad a nuestro sistema y, una vez más, está montada en /media/BigDisk, podemos realizar una copia de seguridad útil del sistema creando primero un directorio llamado /backup en la unidad externa y luego usando rsync para copiar las cosas más importante de nuestro sistema a la unidad externa.
    
    [~]$ mkdir /media/BigDisk/backup
    [~]$ sudo rsync -av --delete /etc /home /usr/local /media/BigDisk/backup
    
    En este ejemplo, copiamos los directorios / etc, / home y / usr / local de nuestro sistema a nuestro dispositivo de almacenamiento imaginario. Incluimos la opción --delete para eliminar archivos que pueden haber existido en el dispositivo de respaldo que ya no existían en el dispositivo de origen (esto es irrelevante la primera vez que hacemos un respaldo, pero será útil en copias posteriores). Repetir el procedimiento de conectar la unidad externa y ejecutar este comando rsync sería una forma útil (aunque no ideal) de mantener una copia de seguridad de un sistema pequeño. Por supuesto, un alias también sería útil aquí. Podríamos crear un alias y agregarlo a nuestro archivo .bashrc para proporcionar esta función.
    
    [~] nano ~/.bashrc
    # añadimos al final del archivo.
    alias backup='sudo rsync -av --delete /etc /home /usr/local /media/BigDisk/backup'
    [~]$ source ~/.bashrc
    
    Ahora todo lo que tenemos que hacer es conectar nuestro disco externo y ejecutar el comando de respaldo para hacer el trabajo.
    
    ## Usar rsync en una red

    Una de las verdaderas maravillas de rsync es que se puede utilizar para copiar archivos a través de una red. Después de todo, la r en rsync significa \"remoto\". La copia remota se puede realizar de dos formas. La primera forma es con otro sistema que tiene rsync instalado, junto con un programa de shell remoto como ssh. Supongamos que teníamos otro sistema en nuestra red local con mucho espacio disponible en el disco duro y queríamos realizar nuestra operación de copia de seguridad utilizando el sistema remoto en lugar de una unidad externa. Suponiendo que ya tenía un directorio llamado / backup donde podríamos entregar nuestros archivos, podríamos hacer esto:
    
    [~]$ sudo rsync -av --delete --rsh=ssh /etc /home /usr/local remote-sys:/backup
    
    Hicimos dos cambios en nuestro comando para facilitar la copia de red. Primero, agregamos la opción --rsh = ssh, que indica a rsync que use el programa ssh como su shell remoto. De esta manera, pudimos utilizar un túnel cifrado con ssh para transferir de forma segura los datos del sistema local al host remoto. En segundo lugar, especificamos el host remoto anteponiendo su nombre (en este caso, el host remoto se llama remote-sys) al nombre de la ruta de destino.
    
    La segunda forma en que se puede utilizar rsync para sincronizar archivos en una red es mediante un servidor rsync. rsync se puede configurar para ejecutarse como un demonio y escuchar las solicitudes entrantes de sincronización. Esto se hace a menudo para permitir la duplicación de un sistema remoto. Por ejemplo, Red Hat Software mantiene un gran repositorio de paquetes de software en desarrollo para su distribución de Fedora. Es útil para los probadores de software reflejar esta colección durante la fase de prueba del ciclo de lanzamiento de la distribución. Dado que los archivos en el repositorio cambian con frecuencia (a menudo más de una vez al día), es deseable mantener un espejo local mediante sincronización periódica, en lugar de realizar copias masivas del repositorio. Uno de estos repositorios se mantiene en la Universidad de Duke; podríamos reflejarlo usando nuestra copia local de rsync y su servidor rsync así:
    
    [~]$ mkdir fedora-devel
    [~]$ rsync -av --delete rsync://archive.linux.duke.edu/fedora/
        linux/development/rawhide/Everything/x86_64/os/ fedora-devel
    
    En este ejemplo, usamos el URI del servidor rsync remoto, que consta de un protocolo (rsync://), seguido del nombre de host remoto (archive.linux.duke.edu), seguido del nombre de la ruta del repositorio.
    
Fin """

