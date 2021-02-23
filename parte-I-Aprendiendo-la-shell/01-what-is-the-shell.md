# <p style="text-align:center;color:red">Parte I</p>
# <p style="text-align:center;color:red">Aprendiendo la consola</p>

_____

# <p style="text-align:center;color:red">1</p>
# <p style="text-align:center;color:red">¿Qué es la consola ó la shell?</p>

When we speak of the command line, we are really referring to the shell. The shell is a program that takes keyboard commands and passes them to the operating system to carry out. Almost all Linux distributions supply a shell program from the GNU Project called bash. The name is an acronym for bourne-again shell, a reference to the fact that bash is an enhanced replacement for sh , the original Unix shell program written by Steve Bourne.<br /><span style="color:green">Cuando hablamos de la línea de comandos, en realidad nos referimos al shell. El shell es un programa que toma los comandos del teclado y los pasa al sistema operativo para que los lleve a cabo. Casi todas las distribuciones de Linux proporcionan un programa de shell del Proyecto GNU llamado bash. El nombre es un acrónimo de bourne-again shell, una referencia al hecho de que bash es un reemplazo mejorado de sh, el programa de shell de Unix original escrito por Steve Bourne.</span>

# Terminal Emulators<br /><span style="color:yellow">Emuladores de terminal</span>

When using a graphical user interface (GUI), we need another program called a terminal emulator to interact with the shell. If we look through our desktop menus, we will probably find one. KDE uses konsole, and GNOME uses gnome-terminal, though it’s likely called simply Terminal on your menu.<br /><span style="color:green">Cuando usamos una interfaz gráfica de usuario (GUI), necesitamos otro programa llamado emulador de terminal para interactuar con el shell. Si miramos los menús de nuestro escritorio, probablemente encontremos uno. KDE usa konsole y GNOME usa gnome-terminal, aunque probablemente se llame simplemente Terminal en su menú.</span>

A number of other terminal emulators are available for Linux, but they all basically do the same thing: give us access to the shell. You will probably develop a preference for one or another terminal emulator based on the number of bells and whistles it has.<br /><span style="color:green">Hay otros emuladores de terminal disponibles para Linux, pero básicamente todos hacen lo mismo: darnos acceso al shell. Probablemente desarrollará una preferencia por uno u otro emulador de terminal en función de la cantidad de campanas y silbidos que tiene.</span>

# Making Your First Keystrokes<br /><span style="color:yellow">Haciendo sus primeras pulsaciones de teclas</span>

So let’s get started. Launch the terminal emulator. Once it comes up, we should see something like this:<br /><span style="color:green">Entonces empecemos. Inicie el emulador de terminal. Una vez que aparezca, deberíamos ver algo como esto:</span>

`[me@linuxbox ~]$`

This is called a shell prompt, and it will appear whenever the shell is ready to accept input. While it might vary in appearance somewhat depending on the distribution, it will typically include your username@machinename, followed by the current working directory (more about that in a little bit) and a dollar sign.<br /><span style="color:green">Esto se llama indicador de shell y aparecerá siempre que el shell esté listo para aceptar entradas. Si bien puede variar un poco en apariencia dependiendo de la distribución, normalmente incluirá su nombre de usuario @ machinename, seguido del directorio de trabajo actual (más sobre eso en un momento) y un signo de dólar.</span>

If the last character of the prompt is a hash mark ( # ) rather than a dollar sign, the terminal session has superuser privileges. This means either we are logged in as the root user or we selected a terminal emulator that provides superuser (administrative) privileges.<br /><span style="color:green">Si el último carácter del mensaje es una marca de almohadilla (#) en lugar de un signo de dólar, la sesión de terminal tiene privilegios de superusuario. Esto significa que iniciamos sesión como usuario root o seleccionamos un emulador de terminal que proporciona privilegios de superusuario (administrativo).</span>

Assuming things are good so far, let’s try some typing. Enter some gibberish at the prompt like so:<br /><span style="color:green">Suponiendo que las cosas van bien hasta ahora, intentemos escribir un poco. Ingrese un galimatías en el indicador así:</span>

____

` [me@linuxbox ~]$ kaekfjaeifj`

____

Because this command makes no sense, the shell tells us so and gives us another chance.<br /><span style="color:green">Debido a que este comando no tiene sentido, el shell nos lo dice y nos da otra oportunidad.</span>

_____

```bash
bash: kaekfjaeifj: command not found
[me@linuxbox ~]$
```
____


# Command History<br /><span style="color:yellow">Historial de comandos</span>

If we press the up arrow, we will see that the previous command entered, kaekfjaeifj , reappears after the prompt. This is called command history. Most Linux distributions remember the last 1,000 commands by default. Press the down arrow and the previous command disappears.<br /><span style="color:green">Si presionamos la flecha hacia arriba, veremos que el comando anterior ingresado, kaekfjaeifj, vuelve a aparecer después del indicador. Esto se llama historial de comandos. La mayoría de las distribuciones de Linux recuerdan los últimos 1000 comandos de forma predeterminada. Presione la flecha hacia abajo y el comando anterior desaparecerá.</span>

# Cursor Movement<br /><span style="color:yellow">Movimiento del cursor</span>

Recall the previous command by pressing the up arrow again. If we try the left and right arrows, we’ll see that we can position the cursor anywhere on the command line. This makes editing commands easy.<br /><span style="color:green">Recupere el comando anterior presionando la flecha hacia arriba nuevamente. Si probamos las flechas izquierda y derecha, veremos que podemos colocar el cursor en cualquier lugar de la línea de comando. Esto facilita la edición de comandos.</span>

> # A Few Words A bout Mice and Focus<br /><span style="color:green">Algunas palabras sobre ratones y enfoque</span>

> While the shell is all about the keyboard, you can also use a mouse with your terminal emulator. A mechanism built into the X Window System (the underlying engine that makes the GUI go) supports a quick copy-and-paste technique.<br /><span style="color:green">Si bien el shell tiene que ver con el teclado, también puede usar un mouse con su emulador de terminal. Un mecanismo integrado en el sistema X Window (el motor subyacente que hace funcionar la GUI) admite una técnica rápida de copiar y pegar.</span>

> If you highlight some text by holding down the left mouse button and dragging the mouse over it (or double-clicking a word), it is copied into a buffer maintained by X. Pressing the middle mouse button will cause the text to be pasted at the cursor location. Try it.<br /><span style="color:green">Si resalta algún texto manteniendo presionado el botón izquierdo del mouse y arrastrando el mouse sobre él (o haciendo doble clic en una palabra), se copia en un búfer mantenido por X. Al presionar el botón central del mouse, el texto se pegará en la ubicación del cursor. Intentalo.</span>

> Don’t be tempted to use ctrl -C and ctrl -V to perform copy and paste inside a terminal window. They don’t work. These control codes have different meanings to the shell and were assigned many years before the release of Microsoft Windows.<br /><span style="color:green">No caiga en la tentación de utilizar ctrl -C y ctrl -V para copiar y pegar dentro de una ventana de terminal. No funcionan. Estos códigos de control tienen diferentes significados para el shell y se asignaron muchos años antes del lanzamiento de Microsoft Windows.</span>

Your graphical desktop environment (most likely KDE or GNOME), in an effort to behave like Windows, probably has its focus policy set to “click to focus.” This means for a window to get focus (become active), you need to click on it. This is contrary to the traditional X behavior of “focus follows mouse,” which means that a window gets focus just by passing the mouse over it. The window will not come to the foreground until you click on it, but it will be able to receive input. Setting the focus policy to “focus follows mouse” will make the copy-and-paste technique even more useful. Give it a try if you can (some desktop environments such as Ubuntu’s Unity no longer support it). I think if you give it a chance, you will prefer it. You will find this setting in the configuration program for your window manager.<br /><span style="color:green">Su entorno de escritorio gráfico (probablemente KDE o GNOME), en un esfuerzo por comportarse como Windows, probablemente tenga su política de enfoque establecida en "hacer clic para enfocar". Esto significa que para que una ventana se enfoque (se active), debe hacer clic en ella. Esto es contrario al comportamiento tradicional de X de "el foco sigue al mouse", lo que significa que una ventana se enfoca simplemente pasando el mouse sobre ella. La ventana no pasará al primer plano hasta que haga clic en ella, pero podrá recibir información. Establecer la política de enfoque en "el enfoque sigue al mouse" hará que la técnica de copiar y pegar sea aún más útil. Pruébelo si puede (algunos entornos de escritorio como Unity de Ubuntu ya no lo admiten). Creo que si le das una oportunidad, lo preferirás. Encontrará esta configuración en el programa de configuración de su administrador de ventanas.</span>


# Try Some Simple Commands<br /><span style="color:yellow">Pruebe algunos comandos simples</span>

Now that we have learned to enter text in the terminal emulator, let’s try a few simple commands. Let’s begin with the date command, which displays the current time and date.<br /><span style="color:green">Ahora que hemos aprendido a ingresar texto en el emulador de terminal, intentemos algunos comandos simples. Comencemos con el comando de fecha, que muestra la fecha y la hora actuales.</span>

___

```shell
[me@linuxbox ~]$ date
Fri Feb 2 15:09:41 EST 2018
```

___

A related command is cal , which, by default, displays a calendar of the current month.<br /><span style="color:green">Un comando relacionado es cal, que, de forma predeterminada, muestra un calendario del mes actual.</span>

`[me@linuxbox ~]$ cal`


> # The Console Behind the Curtain<br /><span style="color:yellow">La consola detrás de la cortina</span>

> Even if we have no terminal emulator running, several terminal sessions continue to run behind the graphical desktop. We can access these sessions, called virtual consoles , by pressing ctrl-alt-F1 through ctrl-alt-F6 on most Linux distributions.<br /><span style="color:green">Incluso si no tenemos un emulador de terminal en ejecución, varias sesiones de terminal continúan ejecutándose detrás del escritorio gráfico. Podemos acceder a estas sesiones, llamadas consolas virtuales, presionando ctrl-alt-F1 a través de ctrl-alt-F6 en la mayoría de las distribuciones de Linux.</span>

> When a session is accessed, it presents a login prompt into which we can enter our username and password. To switch from one virtual console to another, press alt-F1 through alt-F6. On most systems, we can return to the graphical desktop by pressing alt-F7.<br /><span style="color:green">Cuando se accede a una sesión, presenta un mensaje de inicio de sesión en el que podemos ingresar nuestro nombre de usuario y contraseña. Para cambiar de una consola virtual a otra, presione alt-F1 a alt-F6. En la mayoría de los sistemas, podemos volver al escritorio gráfico presionando alt-F7.</span>

To see the current amount of free space on our disk drives, enter df.<br /><span style="color:green">Para ver la cantidad actual de espacio libre en nuestras unidades de disco, ingrese df.</span>

`[me@linuxbox ~]$ df`

Likewise, to display the amount of free memory, enter the free command.<br /><span style="color:green">Asimismo, para mostrar la cantidad de memoria libre, ingrese el comando libre.</span>

`[me@linuxbox ~]$ free`

# Ending a Terminal Session<br /><span style="color:yellow">Finalizar una sesión de terminal</span>

We can end a terminal session by closing the terminal emulator window, by entering the exit command at the shell prompt, or by pressing ctrl-D.<br /><span style="color:green">Podemos finalizar una sesión de terminal cerrando la ventana del emulador de terminal, ingresando el comando exit en el indicador de shell o presionando ctrl-D.</span>

`[me@linuxbox ~]$ exit`

# Summing Up<br /><span style="color:yellow">Resumiendo</span>

This chapter marked the beginning of our journey into the Linux command line, with an introduction to the shell, a glimpse of the command line, and a brief lesson on how to start and end a terminal session. We also saw how to issue some simple commands and perform a little light commandline editing. That wasn’t so scary, was it? <br /><span style="color:green">Este capítulo marcó el comienzo de nuestro viaje hacia la línea de comandos de Linux, con una introducción al shell, un vistazo a la línea de comandos y una breve lección sobre cómo iniciar y finalizar una sesión de terminal. También vimos cómo emitir algunos comandos simples y realizar una pequeña edición de línea de comandos. Eso no fue tan aterrador, ¿verdad?</span>

In the next chapter, we’ll learn a few more commands and wander around the Linux file system.<br /><span style="color:green">En el próximo capítulo, aprenderemos algunos comandos más y recorreremos el sistema de archivos de Linux.</span>

