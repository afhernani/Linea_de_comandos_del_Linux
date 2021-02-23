# <p style="text-align:center;color:red">15</p>
# <p style="text-align:center;color:red">Storage media<br /><span style="color:brown">Medios de almacenamiento</span></p>

In previous chapters, we looked at manipulating data at the file level. In this chapter, we will consider data at the device level.<br /><span style="color:brown">En capítulos anteriores, analizamos la manipulación de datos a nivel de archivo. En este capítulo, consideraremos los datos a nivel de dispositivo.</span>

Linux has amazing capabilities for handling storage devices, whether physical storage such as hard disks, network storage, or virtual storage devices such as RAID (Redundant Array of Independent Disks) and LVM (Logical Volume Manager).<br /><span style="color:brown">Linux tiene capacidades asombrosas para manejar dispositivos de almacenamiento, ya sea almacenamiento físico como discos duros, almacenamiento en red o dispositivos de almacenamiento virtual como RAID (Redundant Array of Independent Disks) y LVM (Logical Volume Manager).</span>

However, because this is not a book about system administration, we will not try to cover this entire topic in depth. What we will try to do is introduce some of the concepts and key commands that are used to manage storage devices.<br /><span style="color:brown">Sin embargo, debido a que este no es un libro sobre administración de sistemas, no intentaremos cubrir todo este tema en profundidad. Lo que intentaremos hacer es presentar algunos de los conceptos y comandos clave que se utilizan para administrar dispositivos de almacenamiento.</span>

To carry out the exercises in this chapter, we will use a USB flash drive and a CD-RW disc (for systems equipped with a CD-ROM burner).<br /><span style="color:brown">Para realizar los ejercicios de este capítulo, utilizaremos una unidad flash USB y un disco CD-RW (para sistemas equipados con una grabadora de CD-ROM).</span>

We will look at the following commands:<br /><span style="color:brown">Veremos los siguientes comandos:</span>

* mount -- Mount a file system<br /><span style="color:brown">mount -- monta un sistema de archivos</span>

* unmount -- Unmount a file system<br /><span style="color:brown">unmoutn -- desmonta un sistema de archivos</span>

* fsck -- Check and repair a file system<br /><span style="color:brown">fsck -- comprobar y reparar un sistema de archivos</span>

* fdisk -- Manipulate disk partition table<br /><span style="color:brown">fdisk -- manipula la tabla de particiones del disco</span>

* mkfs -- Create a file system<br /><span style="color:brown">mkfs -- crea un sistema de archivos</span>

* dd -- Convert and copy a file<br /><span style="color:brown">dd -- convierte y copia un archivo</span>

* genisoimage (mkisofs) -- Create an ISO 9660 image file<br /><span style="color:brown">genisoimage (mkisofs) -- crea un archivo de imagen ISO 9660</span>

* wodim (cdrecord) -- Write data to optical storage media<br /><span style="color:brown">wodim (cdrecord)-- escribe datos en un medio de almacenamiento óptico</span>

* md5sum -- Calculate an MD5 checksum<br /><span style="color:brown">md5sum - Calcular una suma de comprobación MD5</span>

# Mounting and Unmounting Storage Devices<br /><span style="color:yellow">Montaje y desmontaje de dispositivos de almacenamiento</span>

Recent advances in the Linux desktop have made storage device management extremely easy for desktop users. For the most part, we attach a device to our system and it “ just works.” In the old days (say, 2004), this stuff had to be done manually. On non-desktop systems (i.e., servers) this is still a largely manual procedure since servers often have extreme storage needs and com- plex configuration requirements.<br /><span style="color:brown">Los avances recientes en el escritorio de Linux han hecho que la administración de dispositivos de almacenamiento sea extremadamente fácil para los usuarios de escritorio. En su mayor parte, conectamos un dispositivo a nuestro sistema y "simplemente funciona". En los viejos tiempos (digamos, 2004), estas cosas tenían que hacerse manualmente. En sistemas que no son de escritorio (es decir, servidores), este sigue siendo un procedimiento en gran parte manual, ya que los servidores a menudo tienen necesidades extremas de almacenamiento y requisitos de configuración complejos.</span>

The first step in managing a storage device is attaching the device to the file system tree. This process, called mounting, allows the device to interact with the operating system. As we recall from Chapter 2, Unixlike operating systems (like Linux) maintain a single file system tree with devices attached at various points. This contrasts with other operating systems such as Windows that maintain separate file system trees for each device (for example C:\ , D:\ , etc.).<br /><span style="color:brown">El primer paso para administrar un dispositivo de almacenamiento es adjuntar el dispositivo al árbol del sistema de archivos. Este proceso, llamado montaje, permite que el dispositivo interactúe con el sistema operativo. Como recordamos del Capítulo 2, los sistemas operativos tipo Unix (como Linux) mantienen un único árbol de sistema de archivos con dispositivos conectados en varios puntos. Esto contrasta con otros sistemas operativos, como Windows, que mantienen árboles de sistema de archivos separados para cada dispositivo (por ejemplo, C: \, D: \, etc.).</span>

A file named /etc/fstab (short for “file system table”) lists the devices (typically hard disk partitions) that are to be mounted at boot time. Here is an example /etc/fstab file from an early Fedora system:<br /><span style="color:brown">Un archivo llamado / etc / fstab (abreviatura de “tabla del sistema de archivos”) enumera los dispositivos (típicamente particiones del disco duro) que deben montarse en el momento del arranque. Aquí hay un ejemplo de archivo / etc / fstab de uno de los primeros sistemas Fedora:</span>

```
LABEL=/12           /           ext4   defaults         1   1
LABEL=/home         /home       ext4   defaults         1   2
LABEL=/boot         /boot       ext4   defaults         1   2
tmpfs               /dev/shm    tmpfs  defaults         0   0
devpts              /dev/pts    devpts gid=5,mode=620   0   0
sysfs               /sys        sysfs  defaults         0   0
proc                /proc       proc   defaults         0   0
LABEL=SWAP-sda3     swap        swap   defaults         0   0
```

Most of the file systems listed in this example file are virtual and not applicable to our discussion. For our purposes, the interesting ones are the first three.<br /><span style="color:brown">La mayoría de los sistemas de archivos enumerados en este archivo de ejemplo son virtuales y no se aplican a nuestra discusión. Para nuestros propósitos, los interesantes son los tres primeros.</span>

```
LABEL=/12           /           ext4   defaults         1   1
LABEL=/home         /home       ext4   defaults         1   2
LABEL=/boot         /boot       ext4   defaults         1   2
```

These are the hard disk partitions. Each line of the file consists of six fields, as described in Table 15-1.<br /><span style="color:brown">Estas son las particiones del disco duro. Cada línea del archivo consta de seis campos, como se describe en la Tabla 15-1.</span>

> Table 15-1: /etc/fstab Fields<br /><span style="color:brown">Tabla 15-1: Campos / etc / fstab</span>

| Field | Contents | Description |
|--------|----------|-------------|
| 1 | Device<br /><span style="color:brown">dispositivo</span> | Traditionally, this field contains the actual name of a device file associated with the physical device, such as /dev/sda1 (the first partition of the first detected hard disk). But with today’s computers, which have many devices that are hot pluggable (like USB drives), many modern Linux distributions associate a device with a text label instead. This label (which is added to the storage media when it is formatted) can be either a simple text label or a randomly generated UUID (Universally Unique Identifier). This label is read by the operating system when the device is attached to the system. That way, no matter which device file is assigned to the actual physical device, it can still be correctly identified.<br /><span style="color:brown">Tradicionalmente, este campo contiene el nombre real de un archivo de dispositivo asociado con el dispositivo físico, como / dev / sda1 (la primera partición del primer disco duro detectado). Pero con las computadoras de hoy, que tienen muchos dispositivos que se pueden conectar en caliente (como unidades USB), muchas distribuciones modernas de Linux asocian un dispositivo con una etiqueta de texto. Esta etiqueta (que se agrega al medio de almacenamiento cuando se formatea) puede ser una etiqueta de texto simple o un UUID (Identificador universalmente único) generado aleatoriamente. El sistema operativo lee esta etiqueta cuando el dispositivo está conectado al sistema. De esa manera, no importa qué archivo de dispositivo esté asignado al dispositivo físico real, aún se puede identificar correctamente.</span> |
| 2  | Mount point<br /><span style="color:brown">punto de montaje</span> | The directory where the device is attached to the file system tree.<br /><span style="color:brown">El directorio donde se adjunta el dispositivo al árbol del sistema de archivos.</span>|
| 3 | File system type<br /><span style="color:brown">Tipo de sistema de archivos</span> | Linux allows many file system types to be mounted. Most native Linux file systems are Fourth Extended File System ( ext4 ), but many others are supported, such as FAT16 ( msdos ), FAT32 ( vfat ), NTFS ( ntfs ), CD-ROM ( iso9660 ), etc. <br /><span style="color:brown">Linux permite montar muchos tipos de sistemas de archivos. La mayoría de los sistemas de archivos nativos de Linux son el cuarto sistema de archivos extendido (ext4), pero se admiten muchos otros, como FAT16 (msdos), FAT32 (vfat), NTFS (ntfs), CD-ROM (iso9660), etc.</span>|
| 4 | Options<br /><span style="color:brown">Opciones</span> | File systems can be mounted with various options. It is possible, for example, to mount file systems as read-only or to prevent any programs from being executed from them (a useful security feature for removable media). <br /><span style="color:brown">Los sistemas de archivos se pueden montar con varias opciones. Es posible, por ejemplo, montar sistemas de archivos como de solo lectura o evitar que se ejecuten programas desde ellos (una característica de seguridad útil para los medios extraíbles).</span>|
| 5 | Frequency<br /><span style="color:brown">Frecuencia</span> | A single number that specifies if and when a file system is to be backed up with the dump command.<br /><span style="color:brown">Un solo número que especifica si un sistema de archivos debe ser respaldado con el comando dump y cuándo.</span>|
| 6 | Order<br /><span style="color:brown">Orden</span> | A single number that specifies in what order file systems should be checked with the fsck command.<br /><span style="color:brown">Un solo número que especifica en qué orden se deben verificar los sistemas de archivos con el comando fsck.</span> |

______

# Viewing a List of Mounted File Systems<br /><span style="color:yellow">Visualización de una lista de sistemas de archivos montados</span>

The mount command is used to mount file systems. Entering the command without arguments will display a list of the file systems currently mounted.<br /><span style="color:brown">El comando mount se utiliza para montar sistemas de archivos. Al ingresar el comando sin argumentos, se mostrará una lista de los sistemas de archivos montados actualmente.</span>

```
[me@linuxbox ~]$ mount
/dev/sda2 on / type ext4 (rw)
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/sda5 on /home type ext4 (rw)
/dev/sda1 on /boot type ext4 (rw)
tmpfs on /dev/shm type tmpfs (rw)
none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw)
fusectl on /sys/fs/fuse/connections type fusectl (rw)
/dev/sdd1 on /media/disk type vfat (rw,nosuid,nodev,noatime,
uhelper=hal,uid=500,utf8,shortname=lower)
twin4:/musicbox on /misc/musicbox type nfs4 (rw,addr=192.168.1.4)
```
_________


The format of the listing is as follows: device on mount_point type filesystem_type (options) . For example, the first line shows that device /dev/sda2 is mounted as the root file system, is of type ext4, and is both readable and writable (the option rw ). This listing also has two interesting entries at the bottom of the list. The next-to-last entry shows a 2GB SD memory card in a card reader mounted at /media/disk, and the last entry is a network drive mounted at /misc/musicbox.<br /><span style="color:brown">El formato de la lista es el siguiente: dispositivo en punto_montaje tipo tipo_sistema_archivos (opciones). Por ejemplo, la primera línea muestra que el dispositivo / dev / sda2 está montado como el sistema de archivos raíz, es de tipo ext4 y se puede leer y escribir (la opción rw). Este listado también tiene dos entradas interesantes al final de la lista. La penúltima entrada muestra una tarjeta de memoria SD de 2GB en un lector de tarjetas montado en / media / disk, y la última entrada es una unidad de red montada en / misc / musicbox.</span>

For our first experiment, we will work with a CD-ROM. First, let’s look at a system before a CD-ROM is inserted.<br /><span style="color:brown">Para nuestro primer experimento, trabajaremos con un CD-ROM. Primero, veamos un sistema antes de insertar un CD-ROM.</span>

_________

```
[me@linuxbox ~]$ mount
/dev/mapper/VolGroup00-LogVol00 on / type ext4 (rw)
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/sda1 on /boot type ext4 (rw)
tmpfs on /dev/shm type tmpfs (rw)
none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw)
```

______

This listing is from a CentOS system, which is using LVM (Logical Volume Manager) to create its root file system. Like many modern Linux distributions, this system will attempt to automatically mount the CD-ROM after insertion. After we insert the disc, we see the following:<br /><span style="color:brown">Esta lista es de un sistema CentOS, que utiliza LVM (Logical Volume Manager) para crear su sistema de archivos raíz. Como muchas distribuciones modernas de Linux, este sistema intentará montar automáticamente el CD-ROM después de la inserción. Después de insertar el disco, vemos lo siguiente:</span>

```
[me@linuxbox ~]$ mount
/dev/mapper/VolGroup00-LogVol00 on / type ext4 (rw)
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
/dev/hda1 on /boot type ext4 (rw)
tmpfs on /dev/shm type tmpfs (rw)
none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw)
/dev/sdc on /media/live-1.0.10-8 type iso9660 (ro,noexec,nosuid,nodev,uid=500)
```
_________

After we insert the disc, we see the same listing as before with one additional entry. At the end of the listing we see that the CD-ROM (which is device /dev/sdc on this system) has been mounted on /media/live-1.0.10-8 and is type iso9660 (a CD-ROM). For the purposes of our experiment, we’re interested in the name of the device. When you conduct this experiment yourself, the device name will most likely be different.<br /><span style="color:brown">Después de insertar el disco, vemos la misma lista que antes con una entrada adicional. Al final de la lista, vemos que el CD-ROM (que es dispositivo / dev / sdc en este sistema) se ha montado en /media/live-1.0.10-8 y es de tipo iso9660 (un CD-ROM). A los efectos de nuestro experimento, nos interesa el nombre del dispositivo. Cuando realice este experimento usted mismo, lo más probable es que el nombre del dispositivo sea diferente.</span>

> # Warning<br /><span style="color:blue">Aviso</span>

> In the examples that follow, it is vitally important that you pay close attention to the actual device names in use on your system and do not use the names used in this text! Also note that audio CDs are not the same as CD-ROMs. Audio CDs do not contain file systems and thus cannot be mounted in the usual sense.<br /><span style="color:brown">En los ejemplos que siguen, es de vital importancia que preste mucha atención a los nombres reales de los dispositivos que se utilizan en su sistema y no utilice los nombres utilizados en este texto. También tenga en cuenta que los CD de audio no son lo mismo que los CD-ROM. Los CD de audio no contienen sistemas de archivos y, por lo tanto, no se pueden montar en el sentido habitual.</span>

Now that we have the device name of the CD-ROM drive, let’s unmount the disc and remount it at another location in the file system tree. To do this, we become the superuser (using the command appropriate for our system) and unmount the disc with the umount (notice the spelling) command.<br /><span style="color:brown">Ahora que tenemos el nombre del dispositivo de la unidad de CD-ROM, desmontemos el disco y volvamos a montarlo en otra ubicación del árbol del sistema de archivos. Para hacer esto, nos convertimos en superusuario (usando el comando apropiado para nuestro sistema) y desmontamos el disco con el comando umount (observe la ortografía)</span>

```
[me@linuxbox ~]$ su -
Password:
[root@linuxbox ~]# umount /dev/sdc
```

The next step is to create a new mount point for the disk. A mount point is simply a directory somewhere on the file system tree. There’s nothing special about it. It doesn’t even have to be an empty directory, though if you mount a device on a non-empty directory, you will not be able to see the directory’s previous contents until you unmount the device. For our purposes, we will create a new directory.<br /><span style="color:brown">El siguiente paso es crear un nuevo punto de montaje para el disco. Un punto de montaje es simplemente un directorio en algún lugar del árbol del sistema de archivos. No tiene nada de especial. Ni siquiera tiene que ser un directorio vacío, aunque si monta un dispositivo en un directorio que no esté vacío, no podrá ver el contenido anterior del directorio hasta que lo desmonte. Para nuestros propósitos, crearemos un nuevo directorio.</span>

`[root@linuxbox ~]# mkdir /mnt/cdrom`

Finally, we mount the CD-ROM at the new mount point. The -t option is used to specify the file system type.<br /><span style="color:brown">Finalmente, montamos el CD-ROM en el nuevo punto de montaje. La opción -t se utiliza para especificar el tipo de sistema de archivos.</span>

`[root@linuxbox ~]# mount -t iso9660 /dev/sdc /mnt/cdrom`

Afterward, we can examine the contents of the CD-ROM via the new mount point.<br /><span style="color:brown">Luego, podemos examinar el contenido del CD-ROM a través del nuevo punto de montaje.</span>

```
[root@linuxbox ~]# cd /mnt/cdrom
[root@linuxbox cdrom]# ls
```

Notice what happens when we try to unmount the CD-ROM.<br /><span style="color:brown">Observe lo que sucede cuando intentamos desmontar el CD-ROM.</span>

```
[root@linuxbox cdrom]# umount /dev/sdc
umount: /mnt/cdrom: device is busy
```

Why is this? The reason is that we cannot unmount a device if the device is being used by someone or some process. In this case, we changed our working directory to the mount point for the CD-ROM, which causes the device to be busy. We can easily remedy the issue by changing the working directory to something other than the mount point.<br /><span style="color:brown">¿Por qué es esto? La razón es que no podemos desmontar un dispositivo si alguien o algún proceso lo está utilizando. En este caso, cambiamos nuestro directorio de trabajo al punto de montaje del CD-ROM, lo que hace que el dispositivo esté ocupado. Podemos solucionar fácilmente el problema cambiando el directorio de trabajo a otro que no sea el punto de montaje.</span>

```
[root@linuxbox cdrom]# cd
[root@linuxbox ~]# umount /dev/hdc
```

Now the device unmounts successfully.<br /><span style="color:brown">Ahora el dispositivo se desmonta correctamente.</span>

______

> # Why Unmounting Is Important<br /><span style="color:blue">Por qué es importante desmontar</span>

> If you look at the output of the free command, which displays statistics about memory usage, you will see a statistic called buffers. Computer systems are designed to go as fast as possible. One of the impediments to system speed is slow devices. Printers are a good example. Even the fastest printer is extremely slow by computer standards. A computer would be very slow indeed if it had to stop and wait for a printer to finish printing a page. In the early days of PCs (before multitasking), this was a real problem. If you were working on a spreadsheet or text document, the computer would stop and become unavailable every time you printed. The computer would send the data to the printer as fast as the printer could accept it, but it was very slow because printers don’t print very fast. This problem was solved by the advent of the printer buffer, a device containing some RAM memory that would sit between the computer and the printer. With the printer buffer in place, the computer would send the printer output to the buffer, and it would quickly be stored in the fast RAM so the computer could go back to work without waiting. Meanwhile, the printer buffer would slowly spool the data to the printer from the buffer’s memory at the speed at which the printer could accept it.<br /><span style="color:brown">Si observa la salida del comando gratuito, que muestra estadísticas sobre el uso de la memoria, verá una estadística llamada búfer. Los sistemas informáticos están diseñados para funcionar lo más rápido posible. Uno de los impedimentos para la velocidad del sistema son los dispositivos lentos. Las impresoras son un buen ejemplo. Incluso la impresora más rápida es extremadamente lenta para los estándares informáticos. Una computadora sería muy lenta si tuviera que detenerse y esperar a que una impresora termine de imprimir una página. En los primeros días de las PC (antes de la multitarea), esto era un problema real. Si estuviera trabajando en una hoja de cálculo o un documento de texto, la computadora se detendría y dejaría de estar disponible cada vez que imprimiera. La computadora enviaría los datos a la impresora tan rápido como la impresora pudiera aceptarlos, pero fue muy lento porque las impresoras no imprimen muy rápido. Este problema se resolvió con la llegada del búfer de la impresora, un dispositivo que contiene algo de memoria RAM que se ubicaría entre la computadora y la impresora. Con el búfer de la impresora en su lugar, la computadora enviaría la salida de la impresora al búfer y se almacenaría rápidamente en la RAM rápida para que la computadora pudiera volver a funcionar sin esperar. Mientras tanto, el búfer de la impresora enviaría lentamente los datos a la impresora desde la memoria del búfer a la velocidad a la que la impresora podría aceptarlos.</span>

> This idea of buffering is used extensively in computers to make them faster. Don’t let the need to occasionally read or write data to or from slow devices impede the speed of the system. Operating systems store data that has been read from and is to be written to storage devices in memory for as long as possible before actually having to interact with the slower device. On a Linux system, for example, you will notice that the system seems to fill up memory the longer it is used. This does not mean Linux is “using” all the memory; it means that Linux is taking advantage of all the available memory to do as much buffering as it can.<br /><span style="color:brown">Esta idea de almacenamiento en búfer se utiliza ampliamente en las computadoras para hacerlas más rápidas. No permita que la necesidad de leer o escribir datos ocasionalmente hacia o desde dispositivos lentos impida la velocidad del sistema. Los sistemas operativos almacenan datos que se han leído y que se escribirán en los dispositivos de almacenamiento en la memoria durante el mayor tiempo posible antes de tener que interactuar con el dispositivo más lento. En un sistema Linux, por ejemplo, notará que el sistema parece llenar la memoria cuanto más tiempo se usa. Esto no significa que Linux esté "usando" toda la memoria; significa que Linux está aprovechando toda la memoria disponible para hacer el mayor almacenamiento en búfer posible.</span>

> This buffering allows writing to storage devices to be done very quickly because writing to the physical device is being deferred to a future time. In the meantime, the data destined for the device is piling up in memory. From time to time, the operating system will write this data to the physical device.<br /><span style="color:brown">Este almacenamiento en búfer permite que la escritura en dispositivos de almacenamiento se realice muy rápidamente porque la escritura en el dispositivo físico se difiere para un tiempo futuro. Mientras tanto, los datos destinados al dispositivo se acumulan en la memoria. De vez en cuando, el sistema operativo escribirá estos datos en el dispositivo físico.</span>

> Unmounting a device entails writing all the remaining data to the device so that it can be safely removed. If the device is removed without unmounting it first, the possibility exists that not all the data destined for the device has been transferred. In some cases, this data may include vital directory updates, which will lead to file system corruption, one of the worst things that can happen on a computer.<br /><span style="color:brown">Desmontar un dispositivo implica escribir todos los datos restantes en el dispositivo para que se pueda quitar de forma segura. Si el dispositivo se retira sin desmontarlo primero, existe la posibilidad de que no se hayan transferido todos los datos destinados al dispositivo. En algunos casos, estos datos pueden incluir actualizaciones de directorios vitales, lo que provocará daños en el sistema de archivos, una de las peores cosas que pueden suceder en una computadora.</span>

_________

# Determining Device Names<br /><span style="color:yellow">Determinar los nombres de los dispositivos</span>

It’s sometimes difficult to determine the name of a device. In the old days, it wasn’t very hard. A device was always in the same place, and it didn’t change. Unix-like systems like it that way. When Unix was developed, “changing a disk drive” involved using a forklift to remove a washing machine–sized device from the computer room. In recent years, the typical desktop hardware configuration has become quite dynamic, and Linux has evolved to become more flexible than its ancestors.<br /><span style="color:brown">A veces es difícil determinar el nombre de un dispositivo. En los viejos tiempos, no era muy difícil. Un dispositivo siempre estuvo en el mismo lugar y no cambió. A los sistemas similares a Unix les gusta así. Cuando se desarrolló Unix, "cambiar una unidad de disco" implicaba el uso de una carretilla elevadora para retirar un dispositivo del tamaño de una lavadora de la sala de ordenadores. En los últimos años, la configuración típica de hardware de escritorio se ha vuelto bastante dinámica y Linux ha evolucionado para volverse más flexible que sus antepasados.</span>

In the examples in the previous section, we took advantage of the modern Linux desktop’s capability to “automagically” mount the device and then determine the name after the fact. But what if we are managing a server or some other environment where this does not occur? How can we figure it out?<br /><span style="color:brown">En los ejemplos de la sección anterior, aprovechamos la capacidad del escritorio Linux moderno para montar "automágicamente" el dispositivo y luego determinar el nombre después del hecho. Pero, ¿qué pasa si estamos administrando un servidor o algún otro entorno donde esto no ocurre? ¿Cómo podemos resolverlo?</span>

First, let’s look at how the system names devices. If we list the contents of the /dev directory (where all devices live), we can see that there are lots and lots of devices.<br /><span style="color:brown">Primero, veamos cómo el sistema nombra los dispositivos. Si enumeramos el contenido del directorio / dev (donde viven todos los dispositivos), podemos ver que hay muchos, muchos dispositivos.</span>

`[me@linuxbox ~]$ ls /dev`

The contents of this listing reveal some patterns of device naming.<br /><span style="color:brown">El contenido de esta lista revela algunos patrones de denominación de dispositivos.</span>

Table 15-2 outlines a few of these patterns.<br /><span style="color:brown">La tabla 15-2 describe algunos de estos patrones.</span>

> Table 15-2: Linux Storage Device Names<br /><span style="color:blue">Tabla 15-2: Nombres de dispositivos de almacenamiento de Linux</span>

| Pattern | Device |
|---------|--------|
| /dev/fd* | Floppy disk drives. <br /><span style="color:brown">Unidades de disquete.</span>|
| /dev/hd* | IDE (PATA) disks on older systems. Typical motherboards contain two IDE connectors or channels, each with a cable with two attachment points for drives. The first drive on the cable is called the master device, and the second is called the slave device. The device names are ordered such that /dev/hda refers to the master device on the first channel, /dev/hdb is the slave device on the first channel; /dev/hdc is the master device on the second channel, and so on. A trailing digit indicates the partition number on the device. For example, /dev/hda1 refers to the first partition on the first hard drive on the system, while /dev/hda refers to the entire drive. <br /><span style="color:brown">Discos IDE (PATA) en sistemas antiguos. Las placas base típicas contienen dos conectores o canales IDE, cada uno con un cable con dos puntos de conexión para unidades. La primera unidad del cable se llama dispositivo maestro y la segunda, dispositivo esclavo. Los nombres de los dispositivos están ordenados de manera que /dev/hda se refiere al dispositivo maestro en el primer canal, /dev/hdb es el dispositivo esclavo en el primer canal; /dev/hdc es el dispositivo maestro en el segundo canal, y así sucesivamente. Un dígito final indica el número de partición en el dispositivo. Por ejemplo, /dev/hda1 se refiere a la primera partición del primer disco duro del sistema, mientras que /dev/hda se refiere a todo el disco.an style="color:brown"></span>|
| /dev/sd* | SCSI disks. On modern Linux systems, the kernel treats all disk-like devices (including PATA/SATA hard disks, flash drives, and USB mass storage devices such as portable music players and digital cameras) as SCSI disks. The rest of the naming system is similar to the older /dev/hd* naming scheme previously described.<br /><span style="color:brown">Discos SCSI. En los sistemas Linux modernos, el kernel trata todos los dispositivos similares a discos (incluidos los discos duros PATA / SATA, unidades flash y dispositivos de almacenamiento masivo USB como reproductores de música portátiles y cámaras digitales) como discos SCSI. El resto del sistema de nombres es similar al anterior esquema de nombres /dev/hd * descrito anteriormente.</span> |
| /dev/sr* | Optical drives (CD/DVD readers and burners).<br /><span style="color:brown">Unidades ópticas (lectores y grabadoras de CD / DVD).</span> |

_________

In addition, we often see symbolic links such as /dev/cdrom, /dev/dvd, and /dev/floppy, which point to the actual device files, provided as a convenience.<br /><span style="color:brown">Además, a menudo vemos enlaces simbólicos como / dev / cdrom, / dev / dvd y / dev / floppy, que apuntan a los archivos reales del dispositivo, proporcionados para su comodidad.</span>

If you are working on a system that does not automatically mount removable devices, you can use the following technique to determine how the removable device is named when it is attached. First, start a real-time view of the /var/log/messages or /var/log/syslog file (you may require superuser privileges for this).<br /><span style="color:brown">Si está trabajando en un sistema que no monta automáticamente dispositivos extraíbles, puede utilizar la siguiente técnica para determinar cómo se nombra el dispositivo extraíble cuando se conecta. Primero, inicie una vista en tiempo real del archivo / var / log / messages o / var / log / syslog (es posible que necesite privilegios de superusuario para esto).</span>

`[me@linuxbox ~]$ sudo tail -f /var/log/messages`

The last few lines of the file will be displayed and then will pause. Next, plug in the removable device. In this example, we will use a 16MB flash drive. Almost immediately, the kernel will notice the device and probe it.<br /><span style="color:brown">Se mostrarán las últimas líneas del archivo y luego se detendrá. A continuación, conecte el dispositivo extraíble. En este ejemplo, usaremos una unidad flash de 16 MB. Casi de inmediato, el kernel notará el dispositivo y lo probará.</span>


After the display pauses again, press ctrl -C to get the prompt back. The interesting parts of the output are the repeated references to [sdb], which matches our expectation of a SCSI disk device name. Knowing this, these two lines become particularly illuminating:<br /><span style="color:brown">Después de que la pantalla se detenga nuevamente, presione ctrl -C para recuperar el mensaje. Las partes interesantes de la salida son las referencias repetidas a [sdb], que coincide con nuestra expectativa de un nombre de dispositivo de disco SCSI. Sabiendo esto, estas dos líneas se vuelven particularmente esclarecedoras:</span>

This tells us the device name is /dev/sdb for the entire device and /dev/sdb1 for the first partition on the device. As we have seen, working with Linux is full of interesting detective work!<br /><span style="color:brown">Esto nos dice que el nombre del dispositivo es / dev / sdb para todo el dispositivo y / dev / sdb1 para la primera partición del dispositivo. Como hemos visto, ¡trabajar con Linux está lleno de trabajos detectivescos interesantes!</span>

______
> # Tip<br /><span style="color:brown">Consejo</span>

> Using the tail -f /var/log/messages technique is a great way to watch what the system is doing in near real-time.<br /><span style="color:brown">Usar la técnica tail -f /var/log/messages es una excelente manera de observar lo que hace el sistema casi en tiempo real.</span>
______

With our device name in hand, we can now mount the flash drive.<br /><span style="color:brown">Con el nombre de nuestro dispositivo en la mano, ahora podemos montar la unidad flash.</span>

```
[me@linuxbox ~]$ sudo mkdir /mnt/flash
[me@linuxbox ~]$ sudo mount /dev/sdb1 /mnt/flash
[me@linuxbox ~]$ df
```

The device name will remain the same as long as it remains physically attached to the computer and the computer is not rebooted.<br /><span style="color:brown">El nombre del dispositivo seguirá siendo el mismo siempre que permanezca conectado físicamente a la computadora y la computadora no se reinicie.</span>

# Creating New File Systems<br /><span style="color:yellow">Creación de nuevos sistemas de archivos</span>

Suppose that we want to reformat the flash drive with a Linux native file system, rather than the FAT32 system it has now. This involves two steps.<br /><span style="color:brown">Supongamos que queremos reformatear la unidad flash con un sistema de archivos nativo de Linux, en lugar del sistema FAT32 que tiene ahora. Esto implica dos pasos.</span>

1. (optional) Create a new partition layout if the existing one is not to our liking.<br /><span style="color:brown">(opcional) Cree un nuevo diseño de partición si el existente no es de nuestro agrado.</span>

2. Create a new, empty file system on the drive.<br /><span style="color:brown">Cree un nuevo sistema de archivos vacío en la unidad</span>
______
> # Warning<br /><span style="color:red">Aviso</span>

> In the following exercise, we are going to format a flash drive. Use a drive that contains nothing you care about because it will be erased! Again, make absolutely sure you are specifying the correct device name for your system, not the one shown in the text. Failure to heed this warning could result in you formatting (i.e., erasing) the wrong drive!<br /><span style="color:brown">En el siguiente ejercicio vamos a formatear una unidad flash. Utilice una unidad que no contenga nada que le importe porque se borrará. Nuevamente, asegúrese de especificar el nombre de dispositivo correcto para su sistema, no el que se muestra en el texto. Si no hace caso de esta advertencia, podría formatear (es decir, borrar) la unidad incorrecta.</span>
_________

# Manipulating Partitions with fdisk<br /><span style="color:yellow">Manipular particiones con fdisk</span>

fdisk is one of a host of available programs (both command line and graphical) that allows us to interact directly with disk-like devices (such as hard disk drives and flash drives) at a very low level. With this tool we can edit delete, and create partitions on the device. To work with our flash drive, we must first unmount it (if needed) and then invoke the fdisk program as follows:<br /><span style="color:brown">fdisk es uno de una gran cantidad de programas disponibles (tanto de línea de comandos como gráficos) que nos permite interactuar directamente con dispositivos similares a discos (como unidades de disco duro y unidades flash) a un nivel muy bajo. Con esta herramienta podemos editar, eliminar y crear particiones en el dispositivo. Para trabajar con nuestra unidad flash, primero debemos desmontarla (si es necesario) y luego invocar el programa fdisk de la siguiente manera:</span>
______

```
[me@linuxbox ~]$ sudo umount /dev/sdb1
[me@linuxbox ~]$ sudo fdisk /dev/sdb
```
______

Notice that we must specify the device in terms of the entire device, not by partition number. After the program starts up, we will see the following prompt:<br /><span style="color:brown">Tenga en cuenta que debemos especificar el dispositivo en términos de todo el dispositivo, no por número de partición. Después de que se inicie el programa, veremos el siguiente mensaje:</span>

`Command (m for help):`

Entering an m will display the program menu.<br /><span style="color:brown">Al ingresar una m, se mostrará el menú del programa.</span>

```
Command action
a   toggle a bootable flag
b   edit bsd disklabel
c   toggle the dos compatibility flag
d   delete a partition
l   list known partition types
m   print this menu
n   add a new partition
o   create a new empty DOS partition table
p   print the partition table
q   quit without saving changes
s   create a new empty Sun disklabel
t   change a partition's system id
u   change display/entry units
v   verify the partition table
w   write table to disk and exit
x   extra functionality (experts only)

Command (m for help):
```
______

The first thing we want to do is examine the existing partition layout.<br /><span style="color:brown">Lo primero que queremos hacer es examinar el diseño de la partición existente.</span>

We do this by entering p to print the partition table for the device.<br /><span style="color:brown">Hacemos esto ingresando p para imprimir la tabla de particiones para el dispositivo.</span>

______

```
Command (m for help): p

Disk /dev/sdb: 16 MB, 16006656 bytes
1 heads, 31 sectors/track, 1008 cylinders
Units = cylinders of 31 * 512 = 15872 bytes

Device Boot     Start   End     Blocks  Id  System
/dev/sdb1       2       1008    15608+  b   W95 FAT32
```
______

In this example, we see a 16MB device with a single partition (1) that uses 1,006 of the available 1,008 cylinders on the device. The partition is identified as a Windows 95 FAT32 partition. Some programs will use this identifier to limit the kinds of operations that can be done to the disk, but most of the time it is not critical to change it. However, in the interest of this demonstration, we will change it to indicate a Linux partition. To do this, we must first find out what ID is used to identify a Linux partition. In the previous listing, we see that the ID b is used to specify the existing partition.<br /><span style="color:brown">En este ejemplo, vemos un dispositivo de 16 MB con una sola partición (1) que usa 1,006 de los 1,008 cilindros disponibles en el dispositivo. La partición se identifica como una partición de Windows 95 FAT32. Algunos programas utilizarán este identificador para limitar los tipos de operaciones que se pueden realizar en el disco, pero la mayoría de las veces no es fundamental cambiarlo. Sin embargo, en interés de esta demostración, la cambiaremos para indicar una partición Linux. Para hacer esto, primero debemos averiguar qué ID se usa para identificar una partición de Linux. En la lista anterior, vemos que el ID b se usa para especificar la partición existente.</span>

To see a list of the available partition types, we refer to the program menu.<br /><span style="color:brown">Para ver una lista de los tipos de particiones disponibles, nos referimos al menú del programa.</span>

There we can see the following choice:<br /><span style="color:brown">Allí podemos ver la siguiente elección:</span>

`1 list known partition types`

If we enter l at the prompt, a large list of possible types is displayed.<br /><span style="color:brown">Si ingresamos l en el indicador, se muestra una gran lista de tipos posibles.</span>

Among them we see b for our existing partition type and 83 for Linux.<br /><span style="color:brown">Entre ellos, vemos b para nuestro tipo de partición existente y 83 para Linux.</span>

Going back to the menu, we see this choice to change a partition ID:<br /><span style="color:brown">Volviendo al menú, vemos esta opción para cambiar un ID de partición:</span>

`t change a partition's system id`

We enter t at the prompt and enter the new ID.<br /><span style="color:brown">Ingresamos t en el indicador e ingresamos el nuevo ID.</span>

```
Command (m for help): t
Selected partition 1
Hex code (type L to list codes): 83
Changed system type of partition 1 to 83 (Linux)
```

This completes all the changes we need to make. Up to this point, the device has been untouched (all the changes have been stored in memory, not on the physical device), so we will write the modified partition table to the device and exit. To do this, we enter w at the prompt.<br /><span style="color:brown">Esto completa todos los cambios que debemos realizar. Hasta este punto, el dispositivo no ha sido tocado (todos los cambios se han almacenado en la memoria, no en el dispositivo físico), por lo que escribiremos la tabla de particiones modificada en el dispositivo y saldremos. Para hacer esto, ingresamos w en el indicador.</span>

```
Command (m for help): w
The partition table has been altered!
Calling ioctl() to re-read partition table.
WARNING: If you have created or modified any DOS 6.x
partitions, please see the fdisk manual page for additional
information.
Syncing disks.
[me@linuxbox ~]$
```

______

If we had decided to leave the device unaltered, we could have entered q at the prompt, which would have exited the program without writing the changes. We can safely ignore the ominous-sounding warning message.<br /><span style="color:brown">Si hubiéramos decidido dejar el dispositivo inalterado, podríamos haber ingresado q en el indicador, lo que habría salido del programa sin escribir los cambios. Podemos ignorar con seguridad el mensaje de advertencia que suena siniestro.</span>

# Creating a New File System with mkfs<br /><span style="color:yellow">Crear un nuevo sistema de archivos con mkfs</span>

With our partition editing done (lightweight though it might have been), it’s time to create a new file system on our flash drive. To do this, we will use mkfs (short for “make file system”), which can create file systems in a variety of formats. To create an ext4 file system on the device, we use the -t option to specify the “ext4” system type, followed by the name of the device containing the partition we want to format.<br /><span style="color:brown">Con la edición de nuestra partición terminada (aunque podría haber sido liviana), es hora de crear un nuevo sistema de archivos en nuestra unidad flash. Para hacer esto, usaremos mkfs (abreviatura de “hacer sistema de archivos”), que puede crear sistemas de archivos en una variedad de formatos. Para crear un sistema de archivos ext4 en el dispositivo, usamos la opción -t para especificar el tipo de sistema "ext4", seguido del nombre del dispositivo que contiene la partición que queremos formatear</span>

```
[me@linuxbox ~]$ sudo mkfs -t ext4 /dev/sdb1
mke2fs 2.23.2 (12-Jul-2011)
Filesystem label=
OS type: Linux
Block size=1024 (log=0)
Fragment size=1024 (log=0)
3904 inodes, 15608 blocks
780 blocks (5.00%) reserved for the super user
First data block=1
Maximum filesystem blocks=15990784
2 block groups
8192 blocks per group, 8192 fragments per group
1952 inodes per group
Superblock backups stored on blocks:
8193
Writing inode tables: done
Creating journal (1024 blocks): done
Writing superblocks and filesystem accounting information: done
This filesystem will be automatically checked every 34 mounts or
180 days, whichever comes first. Use tune2fs -c or -i to override.
[me@linuxbox ~]$
```
______

The program will display a lot of information when ext4 is the chosen file system type. To reformat the device to its original FAT32 file system, specify vfat as the file system type.<br /><span style="color:brown">El programa mostrará mucha información cuando ext4 sea el tipo de sistema de archivos elegido. Para reformatear el dispositivo a su sistema de archivos FAT32 original, especifique vfat como el tipo de sistema de archivos.</span>

`[me@linuxbox ~]$ sudo mkfs -t vfat /dev/sdb1`

This process of partitioning and formatting can be used anytime additional storage devices are added to the system. While we worked with a tiny flash drive, the same process can be applied to internal hard disks and other removable storage devices like USB hard drives.<br /><span style="color:brown">Este proceso de partición y formateo se puede utilizar siempre que se agreguen dispositivos de almacenamiento adicionales al sistema. Si bien trabajamos con una pequeña unidad flash, el mismo proceso se puede aplicar a los discos duros internos y otros dispositivos de almacenamiento extraíbles como los discos duros USB.</span>

# Testing and Repairing File Systems<br /><span style="color:yellow">Prueba y reparación de sistemas de archivos</span>

In our earlier discussion of the /etc/fstab file, we saw some mysterious digits at the end of each line. Each time the system boots, it routinely checks the integrity of the file systems before mounting them. This is done by the fsck program (short for “file system check”). The last number in each fstab entry specifies the order in which the devices are to be checked. In our previous example, we see that the root file system is checked first, followed by the home and boot file systems. Devices with a zero as the last digit are not routinely checked.<br /><span style="color:brown">En nuestra discusión anterior del archivo / etc / fstab, vimos algunos dígitos misteriosos al final de cada línea. Cada vez que se inicia el sistema, comprueba de forma rutinaria la integridad de los sistemas de archivos antes de montarlos. Esto lo hace el programa fsck (abreviatura de "verificación del sistema de archivos"). El último número de cada entrada de fstab especifica el orden en el que se comprobarán los dispositivos. En nuestro ejemplo anterior, vemos que primero se comprueba el sistema de archivos raíz, seguido de los sistemas de archivos de inicio y de inicio. Los dispositivos con un cero como último dígito no se controlan de forma rutinaria.</span>

In addition to checking the integrity of file systems, fsck can also repair corrupt file systems with varying degrees of success, depending on the amount of damage. On Unix-like file systems, recovered portions of files are placed in the lost+found directory, located in the root of each file system.<br /><span style="color:brown">Además de verificar la integridad de los sistemas de archivos, fsck también puede reparar sistemas de archivos corruptos con diversos grados de éxito, dependiendo de la cantidad de daño. En sistemas de archivos similares a Unix, las partes recuperadas de los archivos se colocan en el directorio perdido + encontrado, ubicado en la raíz de cada sistema de archivos.</span>

To check our flash drive (which should be unmounted first), we could do the following:<br /><span style="color:brown">Para verificar nuestra unidad flash (que debe desmontarse primero), podríamos hacer lo siguiente:</span>

```
[me@linuxbox ~]$ sudo fsck /dev/sdb1
fsck 1.40.8 (13-Mar-2016)
e2fsck 1.40.8 (13-Mar-2016)
/dev/sdb1: clean, 11/3904 files, 1661/15608 blocks
```

These days, file system corruption is quite rare unless there is a hardware problem, such as a failing disk drive. On most systems, file system corruption detected at boot time will cause the system to stop and direct you to run fsck before continuing.<br /><span style="color:brown">En estos días, la corrupción del sistema de archivos es bastante rara a menos que haya un problema de hardware, como una unidad de disco defectuosa. En la mayoría de los sistemas, la corrupción del sistema de archivos detectada durante el arranque hará que el sistema se detenga y le indique que ejecute fsck antes de continuar.</span>

______

> # What the fsck?<br /><span style="color:brown">¿Qué fsck?</span>

> In Unix culture, the word fsck is often used in place of a popular word with which it shares three letters. This is especially appropriate, given that you will probably be uttering the aforementioned word if you find yourself in a situation where you are forced to run fsck.<br /><span style="color:brown">En la cultura Unix, la palabra fsck se usa a menudo en lugar de una palabra popular con la que comparte tres letras. Esto es especialmente apropiado, dado que probablemente estará pronunciando la palabra antes mencionada si se encuentra en una situación en la que se ve obligado a ejecutar fsck.</span>
______

# Moving Data Directly to and from Devices<br /><span style="color:yellow">Mover datos directamente hacia y desde dispositivos</span>

While we usually think of data on our computers as being organized into files, it is also possible to think of the data in “raw” form. If we look at a disk drive, for example, we see that it consists of a large number of “blocks” of data that the operating system sees as directories and files. However, if we could treat a disk drive as simply a large collection of data blocks, we could perform useful tasks, such as cloning devices.<br /><span style="color:brown">Si bien generalmente pensamos que los datos de nuestras computadoras están organizados en archivos, también es posible pensar en los datos en forma "sin procesar". Si miramos una unidad de disco, por ejemplo, vemos que consta de una gran cantidad de "bloques" de datos que el sistema operativo ve como directorios y archivos. Sin embargo, si pudiéramos tratar una unidad de disco simplemente como una gran colección de bloques de datos, podríamos realizar tareas útiles, como clonar dispositivos.</span>

The dd program performs this task. It copies blocks of data from one place to another. It uses a unique syntax (for historical reasons) and is usually used this way:<br /><span style="color:brown">El programa dd realiza esta tarea. Copia bloques de datos de un lugar a otro. Utiliza una sintaxis única (por razones históricas) y generalmente se usa de esta manera:</span>

`dd if=input_file of=output_file [bs=block_size [count=blocks]]`

______

> # Warning<br /><span style="color:blue">Aviso</span>

> The dd command is very powerful. Though its name derives from “data definition,” it is sometimes called “destroy disk” because users often mistype either the if or of specification. Always double-check your input and output specifications before pressing enter !<br /><span style="color:brown">El comando dd es muy poderoso. Aunque su nombre deriva de "definición de datos", a veces se le llama "destruir disco" porque los usuarios a menudo escriben mal la especificación si o la especificación. ¡Siempre verifique sus especificaciones de entrada y salida antes de presionar enter!</span>
_________

Let’s say we had two USB flash drives of the same size and we wanted to exactly copy the first drive to the second. If we attached both drives to the computer and they are assigned to devices /dev/sdb and /dev/sdc, respectively, we could copy everything on the first drive to the second drive with the following:<br /><span style="color:brown">Supongamos que teníamos dos unidades flash USB del mismo tamaño y queríamos copiar exactamente la primera unidad a la segunda. Si conectamos ambas unidades a la computadora y están asignadas a los dispositivos /dev/sdb y /dev/sdc, respectivamente, podríamos copiar todo en la primera unidad a la segunda unidad con lo siguiente:</span>

`dd if=/dev/sdb of=/dev/sdc`

Alternately, if only the first device were attached to the computer, we could copy its contents to an ordinary file for later restoration or copying.<br /><span style="color:brown">Alternativamente, si solo el primer dispositivo estuviera conectado a la computadora, podríamos copiar su contenido a un archivo ordinario para su posterior restauración o copia.</span>

`dd if=/dev/sdb of=flash_drive.img`

# Creating CD-ROM Images<br /><span style="color:yellow">Creación de imágenes de CD-ROM</span>

Writing a recordable CD-ROM (either a CD-R or CD-RW) consists of two steps.<br /><span style="color:brown">La escritura de un CD-ROM grabable (ya sea un CD-R o CD-RW) consta de dos pasos</span>

1. Constructing an ISO image file that is the exact file system image of the CD-ROM<br /><span style="color:brown">Construir un archivo de imagen ISO que sea la imagen exacta del sistema de archivos del CD-ROM</span>

2. Writing the image file onto the CD-ROM media<br /><span style="color:brown">Escribir el archivo de imagen en el soporte CD-ROM</span>

# Creating an Image Copy of a CD-ROM<br /><span style="color:yellow">Creación de una copia de imagen de un CD-ROM</span>

If we want to make an ISO image of an existing CD-ROM, we can use dd to read all the data blocks off the CD-ROM and copy them to a local file. Say we had an Ubuntu CD and we wanted to make an ISO file that we could later use to make more copies. After inserting the CD and determining its device name (we’ll assume /dev/cdrom), we can make the ISO file like so:<br /><span style="color:brown">Si queremos hacer una imagen ISO de un CD-ROM existente, podemos usar dd para leer todos los bloques de datos del CD-ROM y copiarlos a un archivo local. Digamos que teníamos un CD de Ubuntu y queríamos hacer un archivo ISO que luego pudiéramos usar para hacer más copias. Después de insertar el CD y determinar el nombre de su dispositivo (asumiremos / dev / cdrom), podemos hacer el archivo ISO así:</span>

`dd if=/dev/cdrom of=ubuntu.iso`

This technique works for data DVDs as well but will not work for audio CDs, as they do not use a file system for storage. For audio CDs, look at the cdrdao command.<br /><span style="color:brown">Esta técnica también funciona con los DVD de datos, pero no con los CD de audio, ya que no utilizan un sistema de archivos para el almacenamiento. Para CD de audio, mire el comando cdrdao.</span>

# Creating an Image from a Collection of Files<br /><span style="color:red">Crear una imagen a partir de una colección de archivos</span>

To create an ISO image file containing the contents of a directory, we use the genisoimage program. To do this, we first create a directory containing all the files we want to include in the image and then execute the genisoimage command to create the image file. For example, if we had created a directory called ~/cd-rom-files and filled it with files for our CD-ROM, we could create an image file named cd-rom.iso with the following command:<br /><span style="color:brown">Para crear un archivo de imagen ISO que contenga el contenido de un directorio, usamos el programa genisoimage. Para hacer esto, primero creamos un directorio que contiene todos los archivos que queremos incluir en la imagen y luego ejecutamos el comando genisoimage para crear el archivo de imagen. Por ejemplo, si hubiéramos creado un directorio llamado ~ / cd-rom-files y lo hubiéramos llenado con archivos para nuestro CD-ROM, podríamos crear un archivo de imagen llamado cd-rom.iso con el siguiente comando:</span>

`genisoimage -o cd-rom.iso -R -J ~/cd-rom-files`

The -R option adds metadata for the Rock Ridge extensions, which allows the use of long filenames and POSIX-style file permissions. Likewise, the -J option enables the Joliet extensions, which permit long filenames for Windows.<br /><span style="color:brown">La opción -R agrega metadatos para las extensiones de Rock Ridge, lo que permite el uso de nombres de archivo largos y permisos de archivo de estilo POSIX. Asimismo, la opción -J habilita las extensiones Joliet, que permiten nombres de archivo largos para Windows.</span>

______

> # A Program by AnyOther Name . . .<br /><span style="color:blue">Un programa con cualquier otro nombre. . .</span>

>If you look at online tutorials for creating and burning optical media like CD-ROMs and DVDs, you will frequently encounter two programs called mkisofs and cdrecord . These programs were part of a popular package called cdrtools authored by Jörg Schilling. In the summer of 2006, Mr. Schilling made a license change to a portion of the cdrtools package, which, in the opinion of many in the Linux community, created a license incompatibility with the GNU GPL. As a result, a fork of the cdrtools project was started that now includes replacement programs for cdrecord and mkisofs named wodim and genisoimage , respectively.<br /><span style="color:brown">Si consulta los tutoriales en línea para crear y grabar medios ópticos como CD-ROM y DVD, con frecuencia encontrará dos programas llamados mkisofs y cdrecord. Estos programas eran parte de un paquete popular llamado cdrtools escrito por Jörg Schilling. En el verano de 2006, el Sr. Schilling hizo un cambio de licencia en una parte del paquete cdrtools, que, en opinión de muchos en la comunidad Linux, creó una licencia incompatible con GNU GPL. Como resultado, se inició una bifurcación del proyecto cdrtools que ahora incluye programas de reemplazo para cdrecord y mkisofs llamados wodim y genisoimage, respectivamente,</span>

>Writing CD-ROM Images After we have an image file, we can burn it onto our optical media. Most of the commands we will discuss in the sections that follow can be applied to both recordable CD-ROM and DVD media.<br /><span style="color:brown">Escribir imágenes de CD-ROM Una vez que tenemos un archivo de imagen, podemos grabarlo en nuestro medio óptico. La mayoría de los comandos que analizaremos en las secciones siguientes se pueden aplicar tanto a soportes de CD-ROM grabables como de DVD.</span>

_________

# Writing CD-ROM Images<br /><span style="color:orange">Escritura de imágenes de CD-ROM</span>

After we have an image file, we can burn it onto our optical media. Most of the commands we will discuss in the sections that follow can be applied to both recordable CD-ROM and DVD media.<br /><span style="color:brown">Una vez que tenemos un archivo de imagen, podemos grabarlo en nuestro medio óptico. La mayoría de los comandos que analizaremos en las secciones siguientes se pueden aplicar tanto a soportes de CD-ROM grabables como de DVD.</span>

# Mounting an ISO Image Directly<br /><span style="color:brown">Montaje de una imagen ISO directamente</span>

There is a trick that we can use to mount an ISO image while it is still on our hard disk and treat it as though it were already on optical media. By adding the -o loop option to mount (along with the required -t iso9660 file system type), we can mount the image file as though it were a device and attach it to the file system tree.<br /><span style="color:brown">Existe un truco que podemos usar para montar una imagen ISO mientras aún está en nuestro disco duro y tratarla como si ya estuviera en un medio óptico. Al agregar la opción -o loop para montar (junto con el tipo de sistema de archivos -t iso9660 requerido), podemos montar el archivo de imagen como si fuera un dispositivo y adjuntarlo al árbol del sistema de archivos.</span>

```
mkdir /mnt/iso_image
mount -t iso9660 -o loop image.iso /mnt/iso_image
```

In this example, we created a mount point named /mnt/iso_image and then mounted the image file image.iso at that mount point. After the image is mounted, it can be treated just as though it were a real CD-ROM or DVD.<br /><span style="color:brown">En este ejemplo, creamos un punto de montaje llamado / mnt / iso_image y luego montamos el archivo de imagen image.iso en ese punto de montaje. Una vez montada la imagen, se puede tratar como si fuera un CD-ROM o DVD real.</span>

Remember to unmount the image when it is no longer needed.<br /><span style="color:brown">Recuerde desmontar la imagen cuando ya no la necesite.</span>

# Blanking a Rewritable CD-ROM<br /><span style="color:yellow">Borrar un CD-ROM regrabable</span>

Rewritable CD-RW media needs to be erased or blanked before it can be reused. To do this, we can use wodim , specifying the device name for the CD writer and the type of blanking to be performed. The wodim program offers several types. The most minimal (and fastest) is the “fast” type.<br /><span style="color:brown">Los soportes CD-RW regrabables deben borrarse o borrarse antes de poder reutilizarlos. Para ello, podemos utilizar wodim, especificando el nombre del dispositivo de la grabadora de CD y el tipo de supresión a realizar. El programa wodim ofrece varios tipos. El más mínimo (y más rápido) es el tipo "rápido"</span>

`wodim dev=/dev/cdrw blank=fast`

# Writing an Image<br /><span style="color:orange">Escribir una imagen</span>

To write an image, we again use wodim , specifying the name of the optical media writer device and the name of the image file.<br /><span style="color:brown">Para escribir una imagen, usamos nuevamente wodim, especificando el nombre del dispositivo de grabación de medios ópticos y el nombre del archivo de imagen.</span>

`wodim dev=/dev/cdrw image.iso`

In addition to the device name and image file, wodim supports a large set of options. Two common ones are -v for verbose output, and -dao , which writes the disc in disc-at-once mode. This mode should be used if you are preparing a disc for commercial reproduction. The default mode for wodim is track-at-once, which is useful for recording music tracks.<br /><span style="color:brown">Además del nombre del dispositivo y el archivo de imagen, wodim admite un gran conjunto de opciones. Dos comunes son -v para salida detallada y -dao, que escribe el disco en modo disc-at-once. Este modo debe utilizarse si está preparando un disco para reproducción comercial. El modo predeterminado para wodim es track-at-once, que es útil para grabar pistas de música.</span>

# Summing Up<br /><span style="color:red">Resumen</span>

> In this chapter, we looked at the basic storage management tasks. There are, of course, many more. Linux supports a vast array of storage devices and file system schemes. It also offers many features for interoperability with other systems.<br /><span style="color:brown">En este capítulo, analizamos las tareas básicas de administración de almacenamiento. Por supuesto, hay muchos más. Linux admite una amplia gama de dispositivos de almacenamiento y esquemas de sistemas de archivos. También ofrece muchas funciones para la interoperabilidad con otros sistemas.</span>
