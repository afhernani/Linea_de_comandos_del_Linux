# para ver processos:
echo "ver procesos con ps "
ps
# para ver processos del sistema:
echo "Procesos del sistema:"
ps x
echo "Estado significado \n R, S, D, T, Z, <, N"
# Estado Significado
<< 'Comment'
echo "R  Corriendo. Esto significa que el proceso se está ejecutando o está listo para ejecutarse."
echo "S  durmiendo. El proceso no se está ejecutando; más bien, está esperando un evento, como una pulsación de tecla o un paquete de red."
echo "D  Sueño ininterrumpido. El proceso está esperando E / S, como una unidad de disco."
echo "T  detenido. Se ha ordenado que el proceso se detenga. Aprenderá más sobre esto más adelante en el capítulo."
echo "Z  Un proceso difunto o \"zombi\". Este es un proceso hijo que ha terminado, pero su padre no lo ha limpiado."
echo "<  Un proceso de alta prioridad. Es posible otorgar más importancia a un proceso, dándole más tiempo en la CPU. Esta propiedad de un proceso se llama bondad. Se dice que un proceso con alta prioridad es menos agradable porque está ocupando más tiempo de la CPU, lo que deja menos para los demás."
echo "N  Un proceso de baja prioridad. Un proceso con baja prioridad (un buen proceso) obtendrá tiempo de procesador solo después de que se hayan atendido otros procesos con mayor prioridad."

Comment

echo "Visualización de procesos dinámicamente con: top"
# Si bien el comando ps puede revelar mucho sobre lo que está haciendo la máquina, solo proporciona una instantánea del estado de la máquina en el momento en que se ejecuta el comando ps. Para ver una vista más dinámica de la actividad de la máquina, usamos el comando superior.
top
echo "controlando processos:"
xlogo
echo "poner un proceso en segundo plano: xlog &"
xlogo &
echo "para ver nuestro proceso en segundo plano ps"
ps
echo "unque tambien: jobs"
jobs
echo "nos devuelve la tareas en segundo plano"
echo "retornamos el proceso al primer plano con: fg %1, siendo 1 el número del proceso"
fg %1
echo "para terminar el proceso xlogo, precionar Ctrl-C"
echo "para parar el proceso sin terminar, xlogo, Ctrl+Z"
xlogo
echo "detiene el proceso y lo pasa a segundo plano"
echo "para ver el proceso: jobs"
jobs 
echo "como está detenido, las acciones sobre la ventana del programa no responden"
echo "con bg %1, lo pasamos a segundo plano en ejecución"
echo "KILL de proces: kill ; xlogo &"
xlogo &
echo "kill nº-process"
echo "con ps obtenemos el PID -> nº-process del proceso si no lo conosemos"
echo "procedemos como en la linea anterior"
echo "Mandar una señal con kill al nº-proceso:"
echo "kill -signal PID..."
echo "default signal -> TERM (terminar)"

<< 'Comment'
Tabla 10-4: Señales comunes
Número   Nombre        Significado

1     HUP Cuelgue.     Este es un vestigio de los buenos tiempos en que los terminales se conectaban a computadoras remotas con líneas telefónicas y módems. La señal se utiliza para indicar a los programas que el terminal de control ha "colgado". El efecto de esta señal se puede demostrar cerrando una sesión de terminal. El programa en primer plano que se ejecuta en el terminal recibirá la señal y finalizará. Esta señal también es utilizada por muchos programas demonio para provocar una reinicialización. Esto significa que cuando un demonio recibe esta señal, se reiniciará y volverá a leer su archivo de configuración. El servidor web Apache es un ejemplo de un demonio que usa la señal HUP de esta manera.

2   INT Interrupción.  Esto realiza la misma función que ctrl-C enviado desde el terminal. Por lo general, terminará un programa.

9    Kill Mata.       Esta señal es especial. Mientras que los programas pueden optar por transmitir las señales que se les envían de diferentes maneras, incluso ignorarlas todas juntas, la señal KILL nunca se envía realmente al programa de destino. Más bien, el kernel termina inmediatamente el proceso. Cuando un proceso se termina de esta manera, no se le da la oportunidad de "limpiar" después de sí mismo o guardar su trabajo. Por esta razón, la señal KILL debe usarse solo como último recurso cuando fallan otras señales de terminación.

15  TERM Terminar.   Esta es la señal predeterminada enviada por el comando kill. Si un programa todavía está lo suficientemente "vivo" para recibir señales, Terminara.

18  CONT Continuar.   Esto restaurará un proceso después de una señal de PARADA o TSTP. Esta señal es enviada por los comandos bg y fg.

19  STOP Detener.      Esta señal hace que un proceso se detenga sin terminar. Como la señal KILL, no se envía al proceso de destino, y por tanto no se puede ignorar.

20  TSTP, terminal STOP.     Esta es la señal enviada por el terminal cuando Se presiona ctrl-Z. A diferencia de la señal STOP, el programa recibe la señal TSTP, pero el programa puede optar por ignorarla.


OTRAS SEÑALES DE COMANDO KILL

3  QUIT        Salir.

11 SEGV        Violación de segmentación. Esta señal se envía si un programa hace un uso ilegal de la memoria; es decir, si intentara escribir en alguna parte no se le permitió escribir.

28 WINCH   Cambio de ventana.    Esta es la señal que envía el sistema cuando una ventana cambia de tamaño. Algunos programas, como top y less, responderán a esta señal redibujándose para ajustarse
las nuevas dimensiones de la ventana.

Comment

echo "ejecutamos en segundo plano: xlogo &"
echo "[1] 13546"
echo "lo colgamos: kill -1 13546"
echo "Hangup        xlogo"
echo "Intro otra vez .."

echo "xlogo &"
echo "[1] 13601"
echo "kill -INT 13601"
echo "[1]+ Interrupt    xlogo"
echo "xlogo &"
echo "[1] 13608"
echo "kill -SIGINT 13608"
echo "[1]+ Interrupt    xlogo"

echo "kill -l"
echo "lista las señales de kill"
<< 'comment'
1) SIGHUP	 2) SIGINT	 3) SIGQUIT	 4) SIGILL	 5) SIGTRAP
 6) SIGABRT	 7) SIGBUS	 8) SIGFPE	 9) SIGKILL	10) SIGUSR1
11) SIGSEGV	12) SIGUSR2	13) SIGPIPE	14) SIGALRM	15) SIGTERM
16) SIGSTKFLT	17) SIGCHLD	18) SIGCONT	19) SIGSTOP	20) SIGTSTP
21) SIGTTIN	22) SIGTTOU	23) SIGURG	24) SIGXCPU	25) SIGXFSZ
26) SIGVTALRM	27) SIGPROF	28) SIGWINCH	29) SIGIO	30) SIGPWR
31) SIGSYS	34) SIGRTMIN	35) SIGRTMIN+1	36) SIGRTMIN+2	37) SIGRTMIN+3
38) SIGRTMIN+4	39) SIGRTMIN+5	40) SIGRTMIN+6	41) SIGRTMIN+7	42) SIGRTMIN+8
43) SIGRTMIN+9	44) SIGRTMIN+10	45) SIGRTMIN+11	46) SIGRTMIN+12	47) SIGRTMIN+13
48) SIGRTMIN+14	49) SIGRTMIN+15	50) SIGRTMAX-14	51) SIGRTMAX-13	52) SIGRTMAX-12
53) SIGRTMAX-11	54) SIGRTMAX-10	55) SIGRTMAX-9	56) SIGRTMAX-8	57) SIGRTMAX-7
58) SIGRTMAX-6	59) SIGRTMAX-5	60) SIGRTMAX-4	61) SIGRTMAX-3	62) SIGRTMAX-2
63) SIGRTMAX-1	64) SIGRTMAX
comment
echo "Enviar señales a multiples procesos con killall"
echo "killall [-u user] [-signal] name..."
echo "xlogo &"
echo "[1] 18801"
echo "xlogo &"
echo "[2] 18802"
echo "killall xlogo"
echo "[1]- Terminated   xlogo"
echo "[2]- Terminated   xlogo"

