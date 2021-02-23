# <p style="text-align:center;color:red">10</p>
# <p style="text-align:center;color:red">Processes.</p>

Modern operating systems are usually multitasking, meaning they create the illusion of doing more than one thing at once by rapidly switching from one executing program to another. The kernel manages this through the use of processes. Processes are how Linux organizes the different programs waiting for their turn at the CPU.<br /><span style="color:brown"></span>

Sometimes a computer will become sluggish or an application will stop responding. In this chapter, we will look at some of the tools available at the command line that let us examine what programs are doing and how to terminate processes that are misbehaving.<br /><span style="color:brown"></span>

This chapter will introduce the following commands:<br /><span style="color:brown"></span>

* ps -- Report a snapshot of current processes<br /><span style="color:brown"></span>

* top -- Display tasks<br /><span style="color:brown"></span>

* jobs -- List active jobs<br /><span style="color:brown"></span>

* bg -- Place a job in the background<br /><span style="color:brown"></span>

* fg -- Place a job in the foreground<br /><span style="color:brown"></span>

* kill -- Send a signal to a process<br /><span style="color:brown"></span>

* killall -- Kill processes by name<br /><span style="color:brown"></span>

* shutdown -- Shut down or reboot the system<br /><span style="color:brown"></span>

# How a Process Works<br /><span style="color:brown"></span>

When a system starts up, the kernel initiates a few of its own activities as processes and launches a program called init . init , in turn, runs a series of shell scripts (located in /etc) called init scripts, which start all the system services. Many of these services are implemented as daemon programs, programs that just sit in the background and do their thing without having any user interface. So, even if we are not logged in, the system is at least a little busy performing routine stuff.<br /><span style="color:brown"></span>

The fact that a program can launch other programs is expressed in the process scheme as a parent process producing a child process.<br /><span style="color:brown"></span>

The kernel maintains information about each process to help keep things organized. For example, each process is assigned a number called a process ID (PID). PIDs are assigned in ascending order, with init always getting PID 1. The kernel also keeps track of the memory assigned to each process, as well as the processes’ readiness to resume execution. Like files, processes also have owners and user IDs, effective user IDs, and so on.<br /><span style="color:brown"></span>

# Viewing Processes<br /><span style="color:brown"></span>

The most commonly used command to view processes (there are several) is ps . The ps program has a lot of options, but in its simplest form it is used like this:<br /><span style="color:brown"></span>

```
[me@linuxbox ~]$ ps
PID TTY     TIME CMD
5198 pts/1  00:00:00 bash
10129 pts/1 00:00:00 ps
```

The result in this example lists two processes, process 5198 and process 10129, which are bash and ps , respectively. As we can see, by default, ps doesn’t show us very much, just the processes associated with the current terminal session. To see more, we need to add some options; however, before we do that, let’s look at the other fields produced by ps . TTY is short for “teletype” and refers to the controlling terminal for the process. Unix is showing its age here.<br /><span style="color:brown"></span> 

The TIME field is the amount of CPU time consumed by the process. As we can see, neither process makes the computer work very hard.<br /><span style="color:brown"></span>

If we add an option, we can get a bigger picture of what the system is doing.<br /><span style="color:brown"></span>

`[me@linuxbox ~]$ ps x`

Adding the x option (note that there is no leading dash) tells ps to show all of our processes regardless of what terminal (if any) they are controlled by. The presence of a ? in the TTY column indicates no controlling terminal.<br /><span style="color:brown"></span>

Using this option, we see a list of every process that we own.<br /><span style="color:brown"></span>

Because the system is running a lot of processes, ps produces a long list. It is often helpful to pipe the output from ps into less for easier viewing.<br /><span style="color:brown"></span>

Some option combinations also produce long lines of output, so maximizing the terminal emulator window might be a good idea, too.<br /><span style="color:brown"></span>

A new column titled STAT has been added to the output. STAT is short for state and reveals the current status of the process, as shown in Table 10-1.<br /><span style="color:brown"></span>

> Table 10-1: Process States<br /><span style="color:brown"></span>

| State |  Meaning |
|--------|---------|
| R | Running. This means the process is running or ready to run.<br /><span style="color:brown"></span>|
| S | Sleeping. The process is not running; rather, it is waiting for an event, suchas a keystroke or network packet. <br /><span style="color:brown"></span>|
| D  | Uninterruptible sleep. The process is waiting for I/O such as a disk drive.<br /><span style="color:brown"></span>|
| T | Stopped. The process has been instructed to stop. You’ll learn more about this later in the chapter.<br /><span style="color:brown"></span>|
| Z | A defunct or “zombie” process. This is a child process that has terminated but has not been cleaned up by its parent. <br /><span style="color:brown"></span>|
| < | A high-priority process. It’s possible to grant more importance to a process, giving it more time on the CPU. This property of a process is called niceness. A process with high priority is said to be less nice because it’s taking more of the CPU’s time, which leaves less for everybody else.<br /><span style="color:brown"></span> |
| N | A low-priority process. A process with low priority (a nice process) will get processor time only after other processes with higher priority have been serviced.<br /><span style="color:brown"></span>|

______

The process state may be followed by other characters. These indicate various exotic process characteristics. See the ps man page for more details.<br /><span style="color:brown"></span>

Another popular set of options is aux (without a leading dash). This gives us even more information.<br /><span style="color:brown"></span>

`[me@linuxbox ~]$ ps aux`

This set of options displays the processes belonging to every user. Using the options without the leading dash invokes the command with “BSD-style” behavior. The Linux version of ps can emulate the behavior of the ps program found in several different Unix implementations. With these options, we get the additional columns shown in Table 10-2.<br /><span style="color:brown"></span>

> Table 10-2: BSD Style ps Column Headers<br /><span style="color:brown"></span>

| Header | Meaning |
|--------|---------|
| USER | User ID. This is the owner of the process.<br /><span style="color:brown"></span>|
| %CPU | CPU usage in percent.<br /><span style="color:brown"></span>|
| %MEM | Memory usage in percent.<br /><span style="color:brown"></span>|
| VSZ | Virtual memory size.<br /><span style="color:brown"></span>| 
| RSS | Resident set size. This is the amount of physical memory (RAM) the process is using in kilobytes.<br /><span style="color:brown"></span>|
| START | Time when the process started. For values over 24 hours, a date is used.<br /><span style="color:brown"></span>|

_____

# Viewing Processes Dynamically with top<br /><span style="color:yellow"></span>

While the ps command can reveal a lot about what the machine is doing, it provides only a snapshot of the machine’s state at the moment the ps command is executed. To see a more dynamic view of the machine’s activity, we use the top command.<br /><span style="color:brown"></span>

`[me@linuxbox ~]$ top`

The top program displays a continuously updating (by default, every three seconds) display of the system processes listed in order of process activity. The name top comes from the fact that the top program is used to see the “top” processes on the system. The top display consists of two parts: a system summary at the top of the display, followed by a table of processes sorted by CPU activity.<br /><span style="color:brown"></span>

The system summary contains a lot of good stuff. Table 10-3 provides a rundown.<br /><span style="color:brown"></span>

> Table 10-3: top Information Fields<br /><span style="color:brown"></span>

| Row | Field | Meaning |
|-----|-------|---------|
| 1 | top | This is the name of the program.<br /><span style="color:brown"></span> |
|   | 14:59:20 | This is the current time of day.<br /><span style="color:brown"></span> |
|   | up 6:30 | This is called uptime. It is the amount of time since the machine was last booted. In this example, the system has been up for six and a half hours.<br /><span style="color:brown"></span> |
|   | 2 users | There are two users logged in. <br /><span style="color:brown"></span>|
|   | load average: | Load average refers to the number of processes that are waiting to run; that is, the number of processes that are in a runnable state and are sharing the CPU. Three values are shown, each for a different period of time. The first is the average for the last 60 seconds, the next the previous 5 minutes, and finally the previous 15 minutes. Values less than 1.0 indicate that the machine is not busy. <br /><span style="color:brown"></span>|
| 2 | Tasks: | This summarizes the number of processes and their various process states.<br /><span style="color:brown"></span> |
| 3  | Cpu(s): | This row describes the character of the activities that the CPU is performing.<br /><span style="color:brown"></span>|
|    | 0.7%us  | 0.7 percent of the CPU is being used for user processes. This means processes outside the kernel.<br /><span style="color:brown"></span>|
|    | 1.0%sy | 1.0 percent of the CPU is being used for system (kernel) processes.<br /><span style="color:brown"></span>|
|    | 0.0%ni | 0.0 percent of the CPU is being used by “nice” (low-priority) processes. <br /><span style="color:brown"></span>|
|    | 98.3%id | 98.3 percent of the CPU is idle.<br /><span style="color:brown"></span>|
|    | 0.0%wa  | 0.0 percent of the CPU is waiting for I/O. <br /><span style="color:brown"></span>|
| 4  | Mem: This shows how physical RAM is being used.<br /><span style="color:brown"></span> |
| 5  | Swap: This shows how swap space (virtual memory) is being used.<br /><span style="color:brown"></span>|

The top program accepts a number of keyboard commands. The two most interesting are h , which displays the program’s help screen, and q, which quits top.<br /><span style="color:brown"></span>

Both major desktop environments provide graphical applications that display information similar to top (in much the same way that Task Manager in Windows works), but top is better than the graphical versions because it is faster and it consumes far fewer system resources. After all, our system monitor program shouldn’t be the source of the system slowdown that we are trying to track.<br /><span style="color:brown"></span>

# Controlling Processes<br /><span style="color:yellow"></span>

Now that we can see and monitor processes, let’s gain some control over them. For our experiments, we’re going to use a little program called xlogo as our guinea pig. The xlogo program is a sample program supplied with the X Window System (the underlying engine that makes the graphics on our display go), which simply displays a resizable window containing the X logo. First, we’ll get to know our test subject.<br /><span style="color:brown"></span>

`[me@linuxbox ~]$ xlogo`

After entering the command, a small window containing the logo should appear somewhere on the screen. On some systems, xlogo might print a warning message, but it can be safely ignored.<br /><span style="color:brown"></span>

> # NOTE<br /><span style="color:yellow"></span>

> If your system does not include the xlogo program, try using gedit or kwrite instead.<br /><span style="color:brown"></span>

> We can verify that xlogo is running by resizing its window. If the logo is redrawn in the new size, the program is running.<br /><span style="color:brown"></span>

> Notice how our shell prompt has not returned? This is because the shell is waiting for the program to finish, just like all the other programs we have used so far. If we close the xlogo window (see Figure 10-1), the prompt returns.<br /><span style="color:brown"></span>

![Figure 10-1: The xlogo](logo.png)

# Interrupting a Process<br /><span style="color:yellow"></span>

Let’s observe what happens when we run xlogo again. First, enter the xlogo command and verify that the program is running. Next, return to the terminal window and press ctrl-C.<br /><span style="color:brown"></span>

```
[me@linuxbox ~]$ xlogo
[me@linuxbox ~]$
```

In a terminal, pressing ctrl -C interrupts a program. This means we are politely asking the program to terminate. After we pressed ctrl-C, the xlogo window closed, and the shell prompt returned.<br /><span style="color:brown"></span>

Many (but not all) command line programs can be interrupted by using this technique.<br /><span style="color:brown"></span>

# Putting a Process in the Background<br /><span style="color:yellow"></span>

Let’s say we wanted to get the shell prompt back without terminating the xlogo program. We can do this by placing the program in the background. Think of the terminal as having a foreground (with stuff visible on the surface like the shell prompt) and a background (with stuff hidden behind the surface). To launch a program so that it is immediately placed in the background, we follow the command with an ampersand ( & ) character.<br /><span style="color:brown"></span>

```
[me@linuxbox ~]$ xlogo &
[1] 28236
[me@linuxbox ~]$
```

After entering the command, the xlogo window appeared, and the shell prompt returned, but some funny numbers were printed too. This message is part of a shell feature called job control. With this message, the shell is telling us that we have started job number 1 ( [1] ) and that it has PID 28236. If we run ps , we can see our process.<br /><span style="color:brown"></span>

```
[me@EliteDesk:~]$ ps
    PID TTY          TIME CMD
  29015 pts/3    00:00:00 bash
  29024 pts/3    00:00:00 xlogo
  29026 pts/3    00:00:00 ps
```

The shell’s job control facility also gives us a way to list the jobs that have been launched from our terminal. Using the jobs command, we can see this list:<br /><span style="color:brown"></span>

```
hernani@EliteDesk:~$ jobs
[1]+  Ejecutando              xlogo &
```

The results show that we have one job, numbered 1; that it is running; and that the command was xlogo &.<br /><span style="color:brown"></span>

# Returning a Process to the Foreground<br /><span style="color:yellow"></span>

A process in the background is immune from terminal keyboard input, including any attempt to interrupt it with ctrl-C. To return a process to the foreground, use the fg command in this way:<br /><span style="color:brown"></span>

```
me@EliteDesk:~$ jobs
[1]+  Ejecutando              xlogo &
me@EliteDesk:~$ fg %1
xlogo
```
# Stopping (Pausing) a Process<br /><span style="color:yellow"></span>

Sometimes we’ll want to stop a process without terminating it. This is often done to allow a foreground process to be moved to the background. To stop a foreground process and place it in the background, press ctrl -Z. Let’s try it. At the command prompt, type xlogo , press enter , and then press ctrl-Z.<br /><span style="color:brown"></span>

```
me@EliteDesk:~$ fg %1
xlogo
^Z
[1]+  Detenido                xlogo
me@EliteDesk:~$
```

After stopping xlogo , we can verify that the program has stopped by attempting to resize the xlogo window. We will see that it appears quite dead. We can either continue the program’s execution in the foreground, using the fg command, or resume the program’s execution in the background with the bg command.<br /><span style="color:brown"></span>

```
hernani@EliteDesk:~$ bg %1
[1]+ xlogo &
hernani@EliteDesk:~$ 
```

As with the fg command, the jobspec is optional if there is only one job. Moving a process from the foreground to the background is handy if we launch a graphical program from the command line but forget to place it in the background by appending the trailing &.<br /><span style="color:brown"></span>

Why would we want to launch a graphical program from the command line? There are two reasons.<br /><span style="color:brown"></span>

* The program you want to run might not be listed on the window manager’s menus (such as xlogo ).<br /><span style="color:brown"></span>

* By launching a program from the command line, you might be able to see error messages that would otherwise be invisible if the program were launched graphically. Sometimes, a program will fail to start up when launched from the graphical menu. By launching it from the command line instead, we may see an error message that will reveal the problem. Also, some graphical programs have interesting and useful command line options.<br /><span style="color:brown"></span>

# Signals<br /><span style="color:yellow"></span>

The kill command is used to “kill” processes. This allows us to terminate programs that need killing (that is, some kind of pausing or termination).<br /><span style="color:brown"></span>

Here’s an example:<br /><span style="color:brown"></span>

```
[me@EliteDesk:~]$ xlogo &
[2] 29651
[me@EliteDesk:~]$ kill 29651
[me@EliteDesk:~]$ 
[2]+  Terminado               xlogo
[me@EliteDesk:~]$ 
```

We first launch xlogo in the background. The shell prints the jobspec and the PID of the background process. Next, we use the kill command and specify the PID of the process we want to terminate. We could have also specified the process using a jobspec (for example, %1 ) instead of a PID.<br /><span style="color:brown"></span>

While this is all very straightforward, there is more to it than that. The kill command doesn’t exactly “kill” processes; rather, it sends them signals. Signals are one of several ways that the operating system communicates with programs. We have already seen signals in action with the use of ctrl-C and ctrl-Z. When the terminal receives one of these keystrokes, it sends a signal to the program in the foreground. In the case of ctrl-C, a signal called INT (interrupt) is sent; with ctrl-Z, a signal called TSTP (terminal stop) is sent. Programs, in turn, “listen” for signals and may act upon them as they are received. The fact that a program can listen and act upon signals allows a program to do things such as save work in progress when it is sent a termination signal.<br /><span style="color:brown"></span>

# Sending Signals to Processes with kill<br /><span style="color:yellow"></span>

The kill command is used to send signals to programs. Its most common syntax looks like this:<br /><span style="color:brown"></span>

`kill -signal PID...`

If no signal is specified on the command line, then the TERM (terminate) signal is sent by default. The kill command is most often used to send the signals listed in Table 10-4.<br /><span style="color:brown"></span>

> Table 10-4: Common Signals<br /><span style="color:brown"></span>

| Number | Name | Meaning |
|--------|------|---------|
| 1 | HUP | Hang up. This is a vestige of the good old days when terminals were attached to remote computers with phone lines and modems. The signal is used to indicate to programs that the controlling terminal has “hung up.” The effect of this signal can be demonstrated by closing a terminal session. The foreground program running on the terminal will be sent the signal
and will terminate.<br />
This signal is also used by many daemon programs to cause a reinitialization. This means that when a daemon is sent this signal, it will restart and reread its configuration file. The Apache web server is an example of a daemon that uses the HUP signal in this way. <br /><span style="color:brown"></span>|
| 2  | INT | Interrupt. This performs the same function as ctrl-C sent from the terminal. It will usually terminate a program.<br /><span style="color:brown"></span>|
| 9 | KILL | Kill. This signal is special. Whereas programs may choose to handle signals sent to them in different ways, including ignoring them all together, the KILL signal is never actually sent to the target program. Rather, the kernel immediately terminates the process. When a process is terminated in this manner, it is given no opportunity to “clean up” after itself or save its work. For this reason, the KILL signal should be used only as a last resort when other termination signals fail.<br /><span style="color:brown"></span>| 
| 15 | TERM | Terminate. This is the default signal sent by the kill command. If a program is still “alive” enough to receive signals, it will terminate. <br /><span style="color:brown"></span>|
| 18 | CONT | Continue. This will restore a process after a STOP or TSTP signal. This signal is sent by the bg and fg commands.<br /><span style="color:brown"></span> | 
| 19 | STOP | Stop. This signal causes a process to pause without terminating. Like the KILL signal, it is not sent to the target process, and thus it cannot be ignored.<br /><span style="color:brown"></span> |
| 20 | TSTP | Terminal stop. This is the signal sent by the terminal when ctrl-Z is pressed. Unlike the STOP signal, the TSTP signal is received by the program, but the program may choose to
ignore it. <br /><span style="color:brown"></span>|

_________

Let’s try the kill command.<br /><span style="color:brown"></span>

```
[me@EliteDesk:~]$ xlogo &
[1] 30035
[me@EliteDesk:~]$ ps
    PID TTY          TIME CMD
  29015 pts/3    00:00:00 bash
  30035 pts/3    00:00:00 xlogo
  30039 pts/3    00:00:00 ps
[me@EliteDesk:~]$ kill -1 30035
[me@EliteDesk:~]$ 
[1]+  Colgar (hangup)         xlogo
[me@EliteDesk:~]$
```

In this example, we start the xlogo program in the background and then send it a HUP signal with kill . The xlogo program terminates, and the shell indicates that the background process has received a hang-up signal. We may need to press enter a couple of times before the message appears. Note that signals may be specified either by number or by name, including the name prefixed with the letters SIG.<br /><span style="color:brown"></span>

```
[me@EliteDesk:~]$ xlogo &
[1] 30301
[me@EliteDesk:~]$ kill -INT 30301
[me@EliteDesk:~]$ 
[1]+  Interrupción           xlogo
[me@EliteDesk:~]$ xlogo &
[1] 30315
[me@EliteDesk:~]$ kill -SIGINT 30315
[me@EliteDesk:~]$ 
[1]+  Interrupción           xlogo
[me@EliteDesk:~]$ 
```

Repeat the preceding example and try the other signals. Remember, we can also use jobspecs in place of PIDs.<br /><span style="color:brown"></span>

Processes, like files, have owners, and you must be the owner of a process (or the superuser) to send it signals with kill.<br /><span style="color:brown"></span>

In addition to the list of signals covered so far, which are most often used with kill , there are other signals frequently used by the system, as listed in Table 10-5.<br /><span style="color:brown"></span>

> Table 10-5: Other Common Signals<br /><span style="color:brown"></span>

| Number | Name | Meaning |
|--------|------|---------|
| 3 | QUIT | Quit.<br /><span style="color:brown"></span> |
| 11 | SEGV | Segmentation violation. This signal is sent if a program makes illegal use of memory; that is, if it tried to write somewhere it was not allowed to write.<br /><span style="color:brown"></span> |
| 28 | WINCH | Window change. This is the signal sent by the system when a window changes size. Some programs, such as top and less , will respond to this signal by redrawing themselves to fit the new window dimensions.<br /><span style="color:brown"></span>|

______

For the curious, you can display a complete list of signals with the following command:<br /><span style="color:brown"></span>

`[me@linuxbox ~]$ kill -l`

# Sending Signals to Multiple Processes with killall<br /><span style="color:yellow"></span>

It’s also possible to send signals to multiple processes matching a specified program or username by using the killall command. Here is the syntax:<br /><span style="color:brown"></span>

`killall [-u user] [-signal] name...`

To demonstrate, we will start a couple of instances of the xlogo program and then terminate them.<br /><span style="color:brown"></span>

```
[me@EliteDesk:~]$ xlogo &
[1] 30487
[me@EliteDesk:~]$ xlogo &
[2] 30496
[me@EliteDesk:~]$ killall xlogo
[me@EliteDesk:~]$ 
[1]-  Terminado               xlogo
[2]+  Terminado               xlogo
[me@EliteDesk:~]$ 
```

Remember, as with kill , you must have superuser privileges to send signals to processes that do not belong to you.<br /><span style="color:brown"></span>

# Shutting Down the System<br /><span style="color:yellow"></span>

The process of shutting down the system involves the orderly termination of all the processes on the system, as well as performing some vital house-keeping chores (such as syncing all of the mounted file systems) before the system powers off. Four commands can perform this function:<br /><span style="color:brown"></span>

* halt<br /><span style="color:brown"></span>

* poweroff<br /><span style="color:brown"></span>

* reboot<br /><span style="color:brown"></span>

* shutdown<br /><span style="color:brown"></span>

The first three are pretty self-explanatory and are generally used without any command line options. Here’s an example:<br /><span style="color:brown"></span>

`[me@linuxbox ~]$ sudo reboot`

The shutdown command is a bit more interesting. With it, we can specify which of the actions to perform (halt, power down, or reboot) and provide a time delay to the shutdown event. Most often it is used like this to halt the system:<br /><span style="color:brown"></span>

`[me@linuxbox ~]$ sudo shutdown -h now`

or like this to reboot the system:<br /><span style="color:brown"></span>

`[me@linuxbox ~]$ sudo shutdown -r now`

The delay can be specified in a variety of ways. See the shutdown man page for details. Once the shutdown command is executed, a message is “broadcast” to all logged-in users warning them of the impending event.<br /><span style="color:brown"></span>

# More Process-Related Commands<br /><span style="color:yellow"></span>

Because monitoring processes is an important system administration task, there are a lot of commands for it. Table 10-6 lists some to play with.<br /><span style="color:brown"></span>

> Table 10-6: Other Process-Related Commands<br /><span style="color:brown"></span>

| Command | Description |
|---------|-------------|
| pstree | Outputs a process list arranged in a tree-like pattern showing the parent-child relationships between processes.<br /><span style="color:brown"></span>|
| vmstat | Outputs a snapshot of system resource usage including memory, swap, and disk I/O. To see a continuous display, follow the command with a time delay (in seconds) for updates. Here’s an example: vmstat 5 . Terminate the output with ctrl-C.<br /><span style="color:brown"></span> |
| xload | A graphical program that draws a graph showing system load over time.<br /><span style="color:brown"></span> |
| tload | Similar to the xload program but draws the graph in the terminal. Terminate the output with ctrl-C.<br /><span style="color:brown"></span> |

_________

# Summing Up<br /><span style="color:yellow"></span>

Most modern systems feature a mechanism for managing multiple processes.<br /><span style="color:brown"></span>

Linux provides a rich set of tools for this purpose. Given that Linux is the world’s most deployed server operating system, this makes a lot of sense.<br /><span style="color:brown"></span>

Unlike some other systems, however, Linux relies primarily on command line tools for process management. Though there are graphical process tools for Linux, the command line tools are greatly preferred because of their speed and light footprint. While the GUI tools may look pretty, they often create a lot of system load themselves, which somewhat defeats the purpose.<br /><span style="color:brown"></span>