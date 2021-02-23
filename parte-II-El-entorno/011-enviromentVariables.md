# <p style="text-align:center;color:red"> Part II<br /><span style="color:brown">Parte II</span></p>
# <p style="text-align:center;color:red">Configuration and the environment<br /><span style="color:brown">Configuracion y el Entorno</span></p>

# <p style="text-align:center;color:red">11</p>
# <p style="text-align:center;color:red">The Environment<br /><span style="color:brown">El Entorno</span></p>

As we discussed earlier, the shell maintains a body of information during our shell session called the environment. Programs use the data stored in the environment to determine facts about the system’s configuration.<br /><span style="color:brown"></span>

While most programs use configuration files to store program settings, some programs also look for values stored in the environment to adjust their behavior. Knowing this, we can use the environment to customize our shell experience.<br /><span style="color:brown"></span>

In this chapter, we will work with the following commands:<br /><span style="color:brown"></span>

* printenv -- Print part or all of the environment<br /><span style="color:brown"></span>

* set -- Set shell options<br /><span style="color:brown"></span>

* export -- Export environment to subsequently executed programs<br /><span style="color:brown"></span>

* alias -- Create an alias for a command<br /><span style="color:brown"></span>

# What Is Stored in the Environment?<br /><span style="color:yellow"></span>

The shell stores two basic types of data in the environment; though, with bash, the types are largely indistinguishable. They are environment variables and shell variables. Shell variables are bits of data placed there by bash , and environment variables are everything else. In addition to variables, the shell stores some programmatic data, namely, aliases and shell functions. We covered aliases in Chapter 5 and we will cover shell functions (which are related to shell scripting) in Part IV of this book.<br /><span style="color:brown"></span>

# Examining the Environment<br /><span style="color:yellow"></span>

To see what is stored in the environment, we can use either the set builtin in bash or the printenv program. The set command will show both the shell and environment variables, while printenv will display only the latter. Because the list of environment contents will be fairly long, it is best to pipe the output of either command into less.<br /><span style="color:brown"></span>

`[me@linuxbox ~]$ printenv | less`

Doing so, we should get something that looks like this:<br /><span style="color:brown"></span>

```
SHELL=/bin/bash
SESSION_MANAGER=local/EliteDesk:@/tmp/.ICE-unix/3496,unix/EliteDesk:/tmp/.ICE-unix/3496
QT_ACCESSIBILITY=1
COLORTERM=truecolor
XDG_CONFIG_DIRS=/etc/xdg/xdg-ubuntu:/etc/xdg
HISTCONTROL=ignoredups
XDG_MENU_PREFIX=gnome-
GNOME_DESKTOP_SESSION_ID=this-is-deprecated
HISTSIZE=1000
MANDATORY_PATH=/usr/share/gconf/ubuntu.mandatory.path
JAVA_HOME=/usr/lib/jvm/java-1.14.0-openjdk-amd64
GNOME_SHELL_SESSION_MODE=ubuntu
SSH_AUTH_SOCK=/run/user/1000/keyring/ssh
XMODIFIERS=@im=ibus
DESKTOP_SESSION=ubuntu
SSH_AGENT_PID=3454
GTK_MODULES=gail:atk-bridge
PWD=/home/hernani
LOGNAME=hernani
XDG_SESSION_DESKTOP=ubuntu
XDG_SESSION_TYPE=x11
GPG_AGENT_INFO=/run/user/1000/gnupg/S.gpg-agent:0:1
XAUTHORITY=/run/user/1000/gdm/Xauthority
WINDOWPATH=2
HOME=/home/hernani
USERNAME=hernani
IM_CONFIG_PHASE=1
LANG=es_ES.UTF-8
```

What we see is a list of environment variables and their values. For example, we see a variable called USER , which contains the value me . The printenv command can also list the value of a specific variable.<br /><span style="color:brown"></span>

```
[me@linuxbox ~]$ printenv USER
me
```

The set command, when used without options or arguments, will display both the shell and environment variables, as well as any defined shell functions. Unlike printenv , its output is courteously sorted in alphabetical order.<br /><span style="color:brown"></span>

`[me@linuxbox ~]$ set | less`

It is also possible to view the contents of a variable using the echo command, like this:<br /><span style="color:brown"></span>

```
[me@linuxbox ~]$ echo $HOME
/home/me
```

One element of the environment that neither set nor printenv displays is aliases. To see them, enter the alias command without arguments.<br /><span style="color:brown"></span>

```
[me@linuxbox ~]$ alias
alias l.='ls -d .* --color=tty'
alias ll='ls -l --color=tty'
alias ls='ls --color=tty'
alias vi='vim'
alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'
```

# Some Interesting Variables<br /><span style="color:brown"></span>

The environment contains quite a few variables, and though the environment will differ from the one presented here, we will likely see the variables listed in Table 11-1 in our environment.<br /><span style="color:brown"></span>

Table 11-1: Environment Variables<br /><span style="color:brown"></span>

| Variable |  Contenido |
|-----------|-----------|
| DISPLAY |     El nombre de su pantalla si está ejecutando un entorno gráfico. Por lo general, esto es: 0, lo que significa la primera pantalla generada por el servidor X.|
| EDITOR | El nombre del programa que se utilizará para la edición de texto.|
| SHELL  | El nombre de su programa de shell.|
| HOME  |  El nombre de ruta de su directorio personal. |
| LANG | Define el juego de caracteres y el orden de clasificación de su idioma.|
| OLDPWD |  El directorio de trabajo anterior. |
| PAGER |  El nombre del programa que se utilizará para la salida de paginación. Suele estar configurado en /usr/bin/less.|
| PATH | RUTA, una lista de directorios separados por dos puntos que se buscan cuando ingresa nombre de un programa ejecutable.|
| PS1  | Significa cadena de solicitud 1. Esto define el contenido del indicador de shell. Como veremos más adelante, esto se puede personalizar ampliamente.|
| PWD | El directorio de trabajo actual. |
| TERM | El nombre de su tipo de terminal. Los sistemas similares a Unix admiten muchos protocolos de terminal; esta variable establece el protocolo que se utilizará con su emulador de terminal.| 
| TZ | Especifica su zona horaria. La mayoría de los sistemas similares a Unix mantienen el reloj interno de la computadora en la hora universal coordinada (UTC) y luego muestran la hora local aplicando un desplazamiento especificado por esta variable. |
| USER | USUARIO, Su nombre de usuario. | 

_______

Don’t worry if some of these values are missing. They vary by distribution.<br /><span style="color:brown"></span>


# How Is the Environment Established?<br /><span style="color:yellow"></span>

When we log on to the system, the bash program starts and reads a series of configuration scripts called startup files, which define the default environment shared by all users. This is followed by more startup files in our home directory that define our personal environment. The exact sequence depends on the type of shell session being started. There are two kinds.<br /><span style="color:brown"></span>

* **A login shell session** This is one in which we are prompted for our username and password. This happens when we start a virtual console session, for example.<br /><span style="color:brown"></span>

* **A non-login shell session** This typically occurs when we launch a ter-
minal session in the GUI.<br /><span style="color:brown"></span>

Login shells read one or more startup files, as shown in Table 11-2.<br /><span style="color:brown"></span>

> Table 11-2: Startup Files for Login Shell Sessions<br /><span style="color:brown"></span>

| File | Contents |
|-------|----------|
| /etc/profile | A global configuration script that applies to all users.<br /><span style="color:brown"></span>|
| ~/.bash_profile | A user’s personal startup file. It can be used to extend or override settings in the global configuration script.<br /><span style="color:brown"></span>|
| ~/.bash_login | If ~/.bash_profile is not found, bash attempts to read this script.<br /><span style="color:brown"></span>|
| ~/.profile | If neither ~/.bash_profile nor ~/.bash_login is found, bash attempts to read this file. This is the default in Debian-based distributions,
such as Ubuntu.<br /><span style="color:brown"></span>|

____

Non-login shell sessions read the startup files listed in Table 11-3.<br /><span style="color:brown"></span>

> Table 11-3: Startup Files for Non-Login Shell Sessions<br /><span style="color:brown"></span>
| File | Contents |
|--------|---------|
| /etc/bash.bashrc | A global configuration script that applies to all users.<br /><span style="color:brown"></span>|
| ~/.bashrc | A user’s personal startup file. It can be used to extend or override settings in the global configuration script.<br /><span style="color:brown"></span>| 

______

In addition to reading the startup files listed in Table 11-3, non-login shells inherit the environment from their parent process, usually a login shell.<br /><span style="color:brown"></span>

Take a look and see which of these startup files are installed. Remember, because most of the filenames listed start with a period (meaning that they are hidden), we will need to use the -a option when using ls.<br /><span style="color:brown"></span>

The ~/.bashrc file is probably the most important startup file from the ordinary user’s point of view, because it is almost always read. Non-login shells read it by default, and most startup files for login shells are written in such a way as to read the ~/.bashrc file as well.<br /><span style="color:brown"></span>

# What’s in a Startup File?<br /><span style="color:yellow"></span>

If we take a look inside a typical .bash_profile (taken from a CentOS 6 system), it looks something like this:<br /><span style="color:brown"></span>

```
# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi
# User specific environment and startup programs

PATH=$PATH:$HOME/bin
export PATH
```

Lines that begin with a # are comments and are not read by the shell. These are there for human readability. The first interesting thing occurs on the fourth line, with the following code:<br /><span style="color:brown"></span>

```
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi
```

This is called an if compound command, which we will cover fully when we get to shell scripting in Part IV, but for now, here is a translation:<br /><span style="color:brown"></span>

```
If the file "~/.bashrc" exists, then
        read the "~/.bashrc" file.
```

We can see that this bit of code is how a login shell gets the contents of .bashrc. The next thing in our startup file has to do with the PATH variable.<br /><span style="color:brown"></span>

Ever wonder how the shell knows where to find commands when we enter them on the command line? For example, when we enter ls , the shell does not search the entire computer to find /bin/ls (the full pathname of the ls command); rather, it searches a list of directories that are contained in the PATH variable.<br /><span style="color:brown"></span>

The PATH variable is often (but not always, depending on the distribution) set by the /etc/profile startup file with this code:<br /><span style="color:brown"></span>

`PATH=$PATH:$HOME/bin`

PATH is modified to add the directory $HOME/bin to the end of the list.<br /><span style="color:brown"></span>

This is an example of parameter expansion, which we touched on in Chapter 7. To demonstrate how this works, try the following:<br /><span style="color:brown"></span>

```
[me@linuxbox~]$ foo="This is some "
[me@linuxbox~]$ echo $foo
This is some
[me@linuxbox~]$ foo=$foo"text."
[me@linuxbox~]$ echo $foo
This is some text.

```

Using this technique, we can append text to the end of a variable’s contents.<br /><span style="color:brown"></span>

By adding the string $HOME/bin to the end of the PATH variable’s contents, the directory $HOME/bin is added to the list of directories searched when a command is entered. This means that when we want to create a directory within our home directory for storing our own private programs, the shell is ready to accommodate us. All we have to do is call it bin , and we’re ready to go.<br /><span style="color:brown"></span>


> # Note<br /><span style="color:brown"></span>

> Many distributions provide this PATH setting by default. Debian-based distributions, such as Ubuntu, test for the existence of the ~/bin directory at login and dynamically add it to the PATH variable if the directory is found.<br /><span style="color:brown"></span>

Lastly, we have this:<br /><span style="color:brown"></span>

`export PATH`

The export command tells the shell to make the contents of PATH available to child processes of this shell.<br /><span style="color:brown"></span>

# Modifying the Environment<br /><span style="color:brown"></span>

Because we know where the startup files are and what they contain, we can modify them to customize our environment.<br /><span style="color:brown"></span>

# Which Files Should We Modify?<br /><span style="color:brown"></span>

As a general rule, to add directories to your PATH or define additional environment variables, place those changes in .bash_profile (or the equivalent,according to your distribution; for example, Ubuntu uses .profile). For everything else, place the changes in .bashrc.<br /><span style="color:brown"></span>

> # Note<br /><span style="color:brown"></span>

> Unless you are the system administrator and need to change the defaults for all users of the system, restrict your modifications to the files in your home directory. It is certainly possible to change the files in /etc such as profile, and in many cases it would be sensible to do so, but for now, let’s play it safe.<br /><span style="color:brown"></span>

# Text Editors<br /><span style="color:brown"></span>

To edit (that is, modify) the shell’s startup files, as well as most of the other configuration files on the system, we use a program called a text editor. A text editor is a program that is, in some ways, like a word processor in that it allows us to edit the words on the screen with a moving cursor. It differs from a word processor by only supporting pure text and often contains features designed for writing programs. Text editors are the central tool used by software developers to write code and by system administrators to manage the configuration files that control the system.<br /><span style="color:brown"></span>

A lot of different text editors are available for Linux; most systems have several installed. Why so many different ones? Because programmers like writing them and because programmers use them extensively, they write editors to express their own desires as to how they should work.<br /><span style="color:brown"></span>

Text editors fall into two basic categories: graphical and text-based. GNOME and KDE both include some popular graphical editors. GNOME ships with an editor called gedit , which is usually called “Text Editor” in the GNOME menu. KDE usually ships with three, which are (in order of increasing complexity) kedit , kwrite , and kate .<br /><span style="color:brown"></span>

There are many text-based editors. The popular ones we’ll encounter are nano , vi , and emacs . The nano editor is a simple, easy-to-use editor designed as a replacement for the pico editor supplied with the PINE email suite. The vi editor (which on most Linux systems has been replaced by a program named vim , which is short for “vi improved”) is the traditional editor for Unix-like systems. It will be the subject of Chapter 12. The emacs editor was originally written by Richard Stallman. It is a gigantic, all-purpose, does everything programming environment. While readily available, it is seldom installed on most Linux systems by default.<br /><span style="color:brown"></span>

# Using a Text Editor<br /><span style="color:brown"></span>

Text editors can be invoked from the command line by typing the name of the editor followed by the name of the file you want to edit. If the file does not already exist, the editor will assume that we want to create a new file.<br /><span style="color:brown"></span>

Here is an example using gedit:<br /><span style="color:brown"></span>

`[me@linuxbox ~]$ gedit some_file`

This command will start the gedit text editor and load the file named some_file, if it exists.<br /><span style="color:brown"></span>

Graphical text editors are pretty self-explanatory, so we won’t cover them here. Instead, we will concentrate on our first text-based text editor, nano . Let’s fire up nano and edit the .bashrc file. But before we do that, let’s practice some “safe computing.” Whenever we edit an important configuration file, it is always a good idea to create a backup copy of the file first. This protects us in case we mess up the file while editing. To create a backup of the .bashrc file, do this:<br /><span style="color:brown"></span>

`[me@linuxbox ~]$ cp .bashrc .bashrc.bak`

It doesn’t matter what we call the backup file; just pick an understandable name. The extensions .bak, .sav, .old, and .orig are all popular ways of indicating a backup file. Oh, and remember that cp will overwrite existing files silently.<br /><span style="color:brown"></span>

Now that we have a backup file, we’ll start the editor.<br /><span style="color:brown"></span>

`[me@linuxbox ~]$ nano .bashrc`

Once nano starts, we’ll get a screen like this:<br /><span style="color:brown"></span>

``` 
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
                             [ 137 líneas leídas ]
^G Ver ayuda ^O Guardar   ^W Buscar    ^K Cortar Tex^J Justificar^C Posición
^X Salir     ^R Leer fich.^\ Reemplazar^U Pegar     ^T Ortografía^_ Ir a línea
```

> # Note<br /><span style="color:brown"></span>

> If your system does not have nano installed, you may use a graphical editor instead.<br /><span style="color:brown"></span>

The screen consists of a header at the top, the text of the file being edited in the middle, and a menu of commands at the bottom. Because nano was designed to replace the text editor supplied with an email client, it is rather short on editing features.<br /><span style="color:brown"></span>

The first command you should learn in any text editor is how to exit the program. In the case of nano , you press ctrl -X to exit. This is indicated in the menu at the bottom of the screen. The notation ^X means ctrl -X. This is a common notation for control characters used by many programs.<br /><span style="color:brown"></span>

The second command we need to know is how to save our work. With nano it’s ctrl -O. With this knowledge, we’re ready to do some editing. Using the down arrow key and/or the page down key, move the cursor to the end of the file and then add the following lines to the .bashrc file:<br /><span style="color:brown"></span>

```
umask 0002
export HISTCONTROL=ignoredups
export HISTSIZE=1000
alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'
```

> # Note<br /><span style="color:brown"></span>

> Your distribution may already include some of these, but duplicates won’t hurt anything.<br /><span style="color:brown"></span>

Table 11-4 details the meaning of our additions.<br /><span style="color:brown"></span>

> Table 11-4: Additions to Our .bashrc<br /><span style="color:brown"></span>

| Line | Meaning |
|------|----------|
| umask 0002 | Sets the umask to solve the problem with the shared directories we discussed in Chapter 9.<br /><span style="color:brown"></span>|
| export HISTCONTROL=ignoredups | Causes the shell’s history recording feature to ignore a command if the same command was just recorded.<br /><span style="color:brown"></span> |
| export HISTSIZE=1000 | Increases the size of the command history from the usual default of 500 lines to 1,000 lines. <br /><span style="color:brown"></span>|
| alias l.='ls -d .* --color=auto'  | Creates a new command called l. , which displays all directory entries that begin with a dot. <br /><span style="color:brown"></span>|
| alias ll='ls -l --color=auto' | Creates a new command called ll , which displays a long-format directory listing.<br /><span style="color:brown"></span>| 

______

As we can see, many of our additions are not intuitively obvious, so it would be a good idea to add some comments to our .bashrc file to help explain things to the humans. Using the editor, change our additions to look like this:<br /><span style="color:brown"></span>

```
# Change umask to make directory sharing easier
umask 0002
# Ignore duplicates in command history and increase
# history size to 1000 lines
export HISTCONTROL=ignoredups
export HISTSIZE=1000
# Add some helpful aliases
alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'
```

Ah, much better! With our changes complete, press ctrl -O to save our modified .bashrc file, and press ctrl -X to exit nano.<br /><span style="color:brown"></span>

> # Why Comments Are Important<br /><span style="color:brown"></span>

> Whenever you modify configuration files, it’s a good idea to add some comments to document your changes. Sure, you’ll probably remember what you changed tomorrow, but what about six months from now? Do yourself a favor and add some comments. While you’re at it, it’s not a bad idea to keep a log of what changes you make.<br /><span style="color:brown"></span>

> Shell scripts and bash startup files use a # symbol to begin a comment. Other configuration files may use other symbols. Most configuration files will have comments. Use them as a guide.<br /><span style="color:brown"></span>

> You will often see lines in configuration files that are commented out to prevent them from being used by the affected program. This is done to give the reader suggestions for possible configuration choices or examples of correct configuration syntax. For example, the .bashrc file of Ubuntu 18.04 contains these lines:<br /><span style="color:brown"></span>

```
# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'
```

The last three lines are valid alias definitions that have been commented out. If you remove the leading # symbols from these three lines, a technique called uncommenting, you will activate the aliases. Conversely, if you add a # symbol to the beginning of a line, you can deactivate a configuration line while preserving the information it contains.<br /><span style="color:brown"></span>

# Activating Our Changes<br /><span style="color:brown"></span>

The changes we have made to our .bashrc will not take effect until we close our terminal session and start a new one because the .bashrc file is read only at the beginning of a session. However, we can force bash to reread the modified.<br /><span style="color:brown"></span>

bashrc file with the following command:<br /><span style="color:brown"></span>

`[me@linuxbox ~]$ source ~/.bashrc`

After doing this, we should be able to see the effect of our changes. Try one of the new aliases.<br /><span style="color:brown"></span>

`[me@linuxbox ~]$ ll`

# Summing Up<br /><span style="color:brown"></span>

In this chapter, we learned an essential skill: editing configuration files with a text editor. Moving forward, as we read man pages for commands, take note of the environment variables that commands support. There may be a gem or two. In later chapters, we will learn about shell functions, a powerful feature that you can also include in the bash startup files to add to your arsenal of custom commands.<br /><span style="color:brown"></span>

