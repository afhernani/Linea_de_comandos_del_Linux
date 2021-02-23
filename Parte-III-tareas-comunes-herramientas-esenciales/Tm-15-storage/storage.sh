echo """commands:

mount | monta un fichero de sistema (dispositivo)
unmount | desmonta un fichero de sistema
fsck | comprueba y repara un fichero de sistema
fdisk | manipula la tabla de particion del disco
mkfs | crea un fichero de sistema
dd | convertir y copiar un fichero
genisoimage (mkisofs) | create un fichero imagen iso 96660
wodim (cdrecord) | escribe datos al medio optico de almacenamiento DVD-optical
md5sum | calcula un comprobacionsumada MD5 """
echo """
MONTANDO Y DESMONTANDO DISPOSITIVOS DE ALMACENAMIENTO:
    
    /etc/fstab -> 'file system table' lista los dispositivos
    cat /etc/fstab

VER UNA LISTA DE SISTEMA DE FICHEROS MONTADOS:

    mount
    mount | grep sda
    
PASANDO A SUPER USUARIO:

    # montando cd-rom drive 
    sudo -i
    Password:
    umount /dev/sdc
    
    # crear un punto de montaje para el disco
    mkdir /mnt/cdrom
    # montamos el cd-rom, opcion -t especifica el tipo de sistema
    mount -t iso9660 /dev/sdc  /mnt/cdrom
    
    # comprobamos
    cd /mnt/cdrom
    ls
    
    # desmontando el cd-rom
    unmount /dev/sdc
    'unmount: /mnt/cdrom: device is busy'
    # está ocupado ya que estamos situados en el dispositivo
    cd ..
    unmount /dev/sdc
    'ahora se desmonta sin problemas'
"""
echo """ DETERMINAR NOMBRES DE DISPOSITIVOS:
    Hacemos un listado del contenido del directorio /dev

    [~]$ ls /dev
    
    el contenido del listaod sigue los siguientes patrones para los
    nombes de dispositivos:
    
    Patron.      Dispositivo.
    
    /dev/fd*    Unidades de disquete.

    /dev/hd*    Discos IDE (PATA) en sistemas más antiguos. Las placas base típicas contienen dos conectores o canales IDE, cada uno con un cable con dos puntos de conexión para unidades. La primera unidad del cable se llama dispositivo maestro y la segunda, dispositivo esclavo. Los nombres de los dispositivos están ordenados de manera que /dev/hda se refiere al dispositivo maestro en el primer canal, /dev/hdb es el dispositivo esclavo en el primer canal; /dev/hdc es el dispositivo maestro en el segundo canal, y así sucesivamente. Un dígito final indica el número de partición en el dispositivo. Por ejemplo, /dev/hda1 se refiere a la primera partición del primer disco duro del sistema, mientras que /dev/hda se refiere a todo el disco.

    /dev/lp*    Impresoras.

    /dev/sd*    Discos SCSI. En los sistemas Linux modernos, el kernel trata todos los dispositivos similares a discos (incluidos los discos duros PATA/SATA, unidades flash y dispositivos de almacenamiento masivo USB como reproductores de música portátiles y cámaras digitales) como discos SCSI. El resto del sistema de nombres es similar al anterior esquema de nombres /dev/hd* descrito anteriormente.

    /dev/sr*    Unidades ópticas (lectores y grabadoras de CD/DVD). """
    
echo """ Además, a menudo vemos enlaces simbólicos como /dev/cdrom, /dev/dvd y /dev/floppy, que apuntan a los archivos reales del dispositivo, proporcionados para su comodidad.
Si está trabajando en un sistema que no se monta automáticamente dispositivos extraíbles, puede utilizar la siguiente técnica para determinar cómo se nombra el dispositivo extraíble cuando está conectado. Primero, inicie una vista en tiempo real del archivo /var/log/messages o /var/log/syslog (es posible que necesite privilegios de superusuario para esto).

    [~]$ sudo tail -f /var/log/messages

Después de que la pantalla se detenga nuevamente, presione ctrl-C para recuperar el mensaje.
Las partes interesantes de la salida son las referencias repetidas a [sdb], que coincide con nuestra expectativa de un nombre de dispositivo de disco SCSI.

    Usar la técnica tail -f /var/log/messages o /var/log/syslog es una excelente manera de observar lo que hace el sistema casi en tiempo real.
    
    [~]$ df  #lista los dispositivos de forma rápida
"""
echo """# CREANDO UN NUEVO SISTEMA DE ARCHIVOS:

Supongamos que queremos reformatear la unidad flash con un sistema de archivos nativo de Linux, en lugar del sistema FAT32 que tiene ahora. Esto implica dos pasos.

1. (opcional) Cree un nuevo diseño de partición si el existente no es de nuestro agrado.
2. Cree un nuevo sistema de archivos vacío en la unidad

Nota:
En el siguiente ejercicio vamos a formatear una unidad flash. Utilice una unidad que no contenga nada que le importe porque se borrará. Nuevamente, asegúrese de especificar el nombre de dispositivo correcto para su sistema, no el que se muestra en el texto. Si no hace caso de esta advertencia, podría formatear (es decir, borrar) la unidad incorrecta.

# Manipular particiones con fdisk

fdisk es uno de una gran cantidad de programas disponibles (tanto de línea de comandos como gráficos) que nos permite interactuar directamente con dispositivos similares a discos (como unidades de disco duro y unidades flash) a un nivel muy bajo. Con esta herramienta podemos editar, eliminar y crear particiones en el dispositivo. Para trabajar con nuestra unidad flash, primero debemos desmontarla (si es necesario) y luego invocar el programa fdisk de la siguiente manera:

    [~]$ sudo umount /dev/sdb1
    [~]$ sudo fdisk /dev/sdb

Tenga en cuenta que debemos especificar el dispositivo en términos de todo el dispositivo, no por número de partición. Después de que se inicie el programa, veremos el siguiente mensaje:

    Command (m for help):
    # m 
    Command action
        a toggle a bootable flag
        b edit bsd disklabel
        c toggle the dos compatibility flag
        d delete a partition
        l list known partition types
        m print this menu
        n add a new partition
        o create a new empty DOS partition table
        p print the partition table
        q quit without saving changes
        s create a new empty Sun disklabel
        t change a partition's system id
        u change display/entry units
        v verify the partition table
        w write table to disk and exit
        x extra functionality (experts only)

    Lo primero es examinar las particiones con la opción p
    mostrando la tabla para el dispositivo seleccionado.
    
    para ver la lista de tipo de pariciones disponibles select
    opcion l.
    
    una vez elegida la volvemos atras al menu y elegimos cambiar particion id:
    opcion t
    
    completamos todos los cambios que necesitamos hacer. para almacenar los cambios y salimos
    opcion w
    
    si no queremos modificar nada optin q quit.
    
# CREANDO UN NUEVO ARCHIVO DE SISTMA CON mkfs:
    
    cuando la particion esté hecha. es hora de crear un nuevo archivo de sistema.
    hacemos esto con mkfs 'make file system' que admite variedad de formatos de 
    de sistema: -t ext4 y para FAT32, -t vfat como sigue:
    
    [~]$ sudo mkf -t ext4 /dev/sdb1
    
    o
    
    [~]$ sudo mkf -t vfat /dev/sdb1
    
    Este proceso de particion y formato puede ser usado para cualquier dispositivo
    de almacenamiento que se añada al sistema. puede ser aplicado a unidades usb o
    discos duros y otros dispositivos de almacenamiento removibles como discos duros
    USB.
    
# COMPROBANDO Y REPARANDO ARCHIVOS DE SISTEMA:

    en el archivo 'cat /etc/fstab' vemos datos, cada vez que el sitema arranca, comprueba
    rutinariamente la integridad del sistema antes de montarlos. esto se hace con la aplicación
    'fsck' abreviatura de 'file system check'.
    El ultimo número en cada entrada del archivo anterior especifica el orden en que los dispositivos
    son comprobados:
    primero comprueba el archivo de sistema raiz, seguidamente por los archivos home y boot de sistema.
    los dispositivos con cero en el ultimo digito no son comprobados.
    
    De forma de comprobar la integridad de los sistemas de archivos 'fsck' solo repara archivos de sistema
    en root corruptos dependiendo de su gravedad. para comprobar la integridad del archivo de sistema
    (deberia estar desmontado primero) lo ariamos de la forma siguiente.
    
        [~]$ sudo umount /dev/sdb1
        [~]$ sudo fsck /dev/sdb
       
"""

