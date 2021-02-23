echo """
# Mover datos directamente hacia y desde dispositivos

Si bien generalmente pensamos que los datos en nuestras computadoras están organizados en archivos, también es posible pensar en los datos en forma 'sin procesar'. Si miramos una unidad de disco, por ejemplo, vemos que consta de una gran cantidad de 'bloques' de datos que el sistema operativo ve como directorios y archivos. Sin embargo, si pudiéramos tratar una unidad de disco como simplemente una gran colección de bloques de datos, podríamos realizar tareas útiles, como clonar dispositivos.

El programa dd realiza esta tarea. Copia bloques de datos de un lugar a otro. Utiliza una sintaxis única (por razones históricas) y generalmente se usa de esta manera:

    [~]$ dd if=input_file of=output_file [bs=block_size [count= blocks]]

Advertencia:

El comando dd es muy poderoso. Aunque su nombre deriva de 'definición de datos', a veces se le llama 'destruir disco' si los usuarios a menudo escriben mal la especificación. ¡Siempre verifique sus especificaciones de entrada y salida antes de presionar Enter!

Supongamos que teníamos dos unidades flash USB del mismo tamaño y queríamos copiar exactamente la primera unidad a la segunda. Si conectamos ambas unidades a la computadora y están asignadas a los dispositivos /dev/sdb y /dev/sdc, respectivamente, podríamos copiar todo en la primera unidad a la segunda unidad con lo siguiente:

    [~]$ dd if=/dev/sdb of=/dev/sdc


# Creación de imágenes de CD-ROM

La escritura de un CD-ROM grabable (ya sea un CD-R o CD-RW) consta de dos pasos.
1. Construir un archivo de imagen ISO que sea la imagen exacta del sistema de archivos del CD-ROM
2. Escribir el archivo de imagen en el CD-ROM.

# Creación de una copia de imagen de un CD-ROM

Si queremos hacer una imagen ISO de un CD-ROM existente, podemos usar dd para leer todos los bloques de datos del CD-ROM y copiarlos a un archivo local. Digamos que teníamos un CD de Ubuntu y queríamos hacer un archivo ISO que luego pudiéramos usar para hacer más copias. Después de insertar el CD y determinar el nombre de su dispositivo (asumiremos /dev/cdrom), podemos hacer el archivo ISO así:

    [~]$ dd if=/dev/cdrom of=ubuntu.iso

Esta técnica también funciona con los DVD de datos, pero no con los CD de audio, ya que no utilizan un sistema de archivos para el almacenamiento. Para CD de audio, mire el comando cdrdao.

# Crear una imagen a partir de una colección de archivos

Para crear un archivo de imagen ISO que contenga el contenido de un directorio, usamos el programa genisoimage. Para hacer esto, primero creamos un directorio que contiene todos los archivos que queremos incluir en la imagen y luego ejecutamos el comando genisoimage para crear el archivo de imagen. Por ejemplo, si hubiéramos creado un directorio llamado ~/cd-rom-files y lo hubiéramos llenado con archivos para nuestro CD-ROM, podríamos crear un archivo de imagen llamado cd-rom.iso con el siguiente comando:

    [~]$ genisoimage -o cd-rom.iso -R -J ~/cd-rom-files
    
La opción -R agrega metadatos para las extensiones de Rock Ridge, lo que permite el uso de nombres de archivo largos y permisos de archivo de estilo POSIX. Asimismo, la opción -J habilita las extensiones Joliet, que permiten nombres de archivo largos para Windows.

# Escritura de imágenes de CD-ROM

Una vez que tenemos un archivo de imagen, podemos grabarlo en nuestro medio óptico. La mayoría de los comandos que analizaremos en las secciones siguientes se pueden aplicar tanto a soportes de CD-ROM grabables como de DVD.

## Montaje de una imagen ISO directamente
Existe un truco que podemos utilizar para montar una imagen ISO mientras aún está en nuestro disco duro y tratarla como si ya estuviera en un medio óptico. Al agregar la opción -o loop para montar (junto con el tipo de sistema de archivos -t iso9660 requerido), podemos montar el archivo de imagen como si fuera un dispositivo y adjuntarlo al árbol del sistema de archivos.

    [~]$ mkdir /mnt/iso_image
    [~]$ mount -t iso9660 -o loop image.iso /mnt/iso_image

En este ejemplo, creamos un punto de montaje llamado /mnt/iso_image y luego montamos el archivo de imagen image.iso en ese punto de montaje. Una vez montada la imagen, puede tratarse como si fuera un CD-ROM o DVD real. Recuerde desmontar la imagen cuando ya no la necesite.

## Borrar un CD-ROM regrabable

Los soportes CD-RW regrabables deben borrarse o borrarse antes de poder reutilizarlos. Para hacer esto, podemos usar wodim, especificando el nombre del dispositivo para la grabadora de CD y el tipo de supresión a realizar. El programa wodim ofrece varios tipos. El más mínimo (y más rápido) es el tipo 'rápido'.

    [~]$ wodim dev=/dev/cdrw blank=fast
    
## Escribir una imagen
Para escribir una imagen, usamos nuevamente wodim, especificando el nombre del dispositivo de grabación de medios ópticos y el nombre del archivo de imagen.

    [~]$ wodim dev=/dev/cdrw image.iso

Además del nombre del dispositivo y el archivo de imagen, wodim admite un gran conjunto de opciones. Dos comunes son -v para salida detallada y -dao, que escribe el disco en modo disc-at-once. Este modo debe utilizarse si está preparando un disco para reproducción comercial. El modo predeterminado para wodim es track-at-once, que es útil para grabar pistas de música. 

## Crédito adicional

Suele ser útil verificar la integridad de una imagen ISO que hemos descargado. En la mayoría de los casos, un distribuidor de una imagen ISO también proporcionará un archivo de suma de comprobación. Una suma de comprobación es el resultado de un cálculo matemático exótico que da como resultado un número que representa el contenido del archivo de destino.
Si el contenido del archivo cambia incluso un bit, la suma de comprobación resultante será muy diferente. El método más común de generación de suma de comprobación utiliza el programa md5sum. Cuando usa md5sum, produce un número hexadecimal único.

    [~]$ md5sum image.iso
    [~]$ 34e354760f9bb7fbf85c96f6a3f94ece image.iso
    
Después de descargar una imagen, debe ejecutar md5sum en ella y comparar los resultados con el valor de md5sum proporcionado por el editor. Además de verificar la integridad de un archivo descargado, podemos usar md5sum para verificar los medios ópticos recién escritos. Para hacer esto, primero calculamos la suma de verificación del archivo de imagen y luego calculamos una suma de verificación para el medio.
El truco para verificar el medio es limitar el cálculo a solo la parte del medio óptico que contiene la imagen. Hacemos esto determinando el número de bloques de 2,048 bytes que contiene la imagen (el medio óptico siempre se escribe en bloques de 2,048 bytes) y leyendo esa cantidad de bloques del medio.
En algunos tipos de medios, esto no es necesario. Los discos CD-R y CD-RW escritos en modo disc-at-once se pueden verificar de esta manera.

    [~]$ md5sum /dev/cdrom
    [~]$ 34e354760f9bb7fbf85c96f6a3f94ece /dev/cdrom
    
Muchos tipos de medios, como los DVD, requieren un cálculo preciso del número de bloques. En el siguiente ejemplo, verificamos la integridad del archivo de imagen dvd-image.iso y el disco en el lector de DVD /dev/dvd. ¿Puedes averiguar cómo funciona esto?

    [~]$ md5sum dvd-image.iso; dd if=/dev/dvd bs=2048 count=\$(( \$(stat -c "%s" dvd-image.iso) / 2048 )) | md5sum
"""
