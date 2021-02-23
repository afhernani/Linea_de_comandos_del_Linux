# <p style="text-align:center; color:red">34</p>
# <p style="text-align:center; color:red">string and Numbers<br/>Cadenas y Números</span></p>

Computer programs are all about working with data. In past chapters, we have focused on processing data at the file level. However, many programming problems need to be solved using smaller units of data such as strings and numbers.<br /><span style="color:green">Los programas de computadora tienen que ver con trabajar con datos. En capítulos anteriores, nos hemos centrado en procesar datos a nivel de archivo. Sin embargo, muchos problemas de programación deben resolverse utilizando unidades de datos más pequeñas, como cadenas y números.</span>

In this chapter, we will look at several shell features that are used to manipulate strings and numbers. The shell provides a variety of parameter expansions that perform string operations. In addition to arithmetic expansion (which we touched upon in Chapter 7), there is a well-known command line program called bc , which performs higher-level math.<br /><span style="color:green">En este capítulo, veremos varias características del shell que se utilizan para manipular cadenas y números. El shell proporciona una variedad de expansiones de parámetros que realizan operaciones de cadena. Además de la expansión aritmética (que mencionamos en el Capítulo 7), existe un programa de línea de comandos muy conocido llamado bc, que realiza operaciones matemáticas de alto nivel.</span>

# Parameter Expansion<br /><span style="color:yellow">Expansión de parámetros</span>

Though parameter expansion came up in Chapter 7, we did not cover it in detail because most parameter expansions are used in scripts rather than on the command line. We have already worked with some forms of parameter expansion, for example, shell variables. The shell provides many more.<br /><span style="color:green">Aunque la expansión de parámetros surgió en el Capítulo 7, no la cubrimos en detalle porque la mayoría de las expansiones de parámetros se utilizan en scripts en lugar de en la línea de comandos. Ya hemos trabajado con algunas formas de expansión de parámetros, por ejemplo, variables de shell. La cáscara proporciona muchos más.</span>

> # Note<br /><span style="color:pink">Nota</span>

> It’s always good practice to enclose parameter expansions in double quotes to prevent unwanted word splitting, unless there is a specific reason not to. This is especially true when dealing with filenames since they can often include embedded spaces and other assorted nastiness.<br /><span style="color:green">Siempre es una buena práctica incluir las expansiones de parámetros entre comillas dobles para evitar la división de palabras no deseadas, a menos que haya una razón específica para no hacerlo. Esto es especialmente cierto cuando se trata de nombres de archivos, ya que a menudo pueden incluir espacios incrustados y otras cosas desagradables.</span>

# Basic Parameters<br /><span style="color:yellow">Parametros basicos</span>

The simplest form of parameter expansion is reflected in the ordinary use of variables. Here’s an example:<br /><span style="color:green">La forma más simple de expansión de parámetros se refleja en el uso ordinario de variables. Aquí tienes un ejemplo:</span>
____

` $a `
____
When expanded, this becomes whatever the variable a contains. Simple parameters may also be surrounded by braces.<br /><span style="color:green">Cuando se expande, se convierte en lo que contenga la variable a. Los parámetros simples también pueden estar rodeados de llaves.</span>
____

` ${a}`

____

This has no effect on the expansion but is required if the variable is adjacent to other text, which may confuse the shell. In this example, we attempt to create a filename by appending the string _file to the contents of the variable a :<br /><span style="color:green">Esto no tiene ningún efecto en la expansión, pero es necesario si la variable es adyacente a otro texto, lo que puede confundir al shell. En este ejemplo, intentamos crear un nombre de archivo agregando la cadena _file al contenido de la variable a:</span>

______
```
[me@linuxbox ~]$ a="foo"
[me@linuxbox ~]$ echo "$a_file"
```
____

If we perform this sequence of commands, the result will be nothing because the shell will try to expand a variable named a_file rather than a. This problem can be solved by adding braces around the “real” variable name.<br /><span style="color:green">Si realizamos esta secuencia de comandos, el resultado no será nada porque el shell intentará expandir una variable llamada a_file en lugar de a. Este problema se puede resolver agregando llaves alrededor del nombre de la variable "real".</span>
___
```
[me@linuxbox ~]$ echo "${a}_file"
foo_file
```
___

We have also seen that positional parameters greater than nine can be accessed by surrounding the number in braces. For example, to access the eleventh positional parameter, we can do this:<br /><span style="color:green">También hemos visto que se puede acceder a parámetros posicionales mayores de nueve rodeando el número entre llaves. Por ejemplo, para acceder al undécimo parámetro posicional, podemos hacer esto:</span>
___

` ${11} `
___

# Expansions to Manage Empty Variables<br /><span style="color:yellow">Expansiones para administrar variables vacías</span>

Several parameter expansions are intended to deal with nonexistent and empty variables. These expansions are handy for handling missing positional parameters and assigning default values to parameters. Here is one such expansion:<br /><span style="color:green">Varias expansiones de parámetros están pensadas para tratar con variables vacías e inexistentes. Estas expansiones son útiles para manejar los parámetros posicionales que faltan y asignar valores predeterminados a los parámetros. Aquí hay una de esas expansiones:</span>
___

` ${parameter:-word} `
___

If parameter is unset (i.e., does not exist) or is empty, this expansion results in the value of word . If parameter is not empty, the expansion results in the value of parameter.<br /><span style="color:green">Si el parámetro no está configurado (es decir, no existe) o está vacío, esta expansión da como resultado el valor de palabra. Si el parámetro no está vacío, la expansión da como resultado el valor del parámetro.</span>
____
```
[me@linuxbox ~]$ foo=
[me@linuxbox ~]$ echo ${foo:-"substitute value if unset"}
substitute value if unset
[me@linuxbox ~]$ echo $foo

[me@linuxbox ~]$ foo=bar
[me@linuxbox ~]$ echo ${foo:-"substitute value if unset"}
bar
[me@linuxbox ~]$ echo $foo
bar
```
____

Here is another expansion, in which we use the equal sign instead of a dash:<br /><span style="color:green">Aquí hay otra expansión, en la que usamos el signo igual en lugar de un guión:</span>
___

` ${parameter:=word} `
____

If parameter is unset or empty, this expansion results in the value of word.<br /><span style="color:green">Si el parámetro no está configurado o está vacío, esta expansión da como resultado el valor de palabra.</span>

In addition, the value of word is assigned to parameter . If parameter is not empty, the expansion results in the value of parameter.<br /><span style="color:green">Además, el valor de la palabra se asigna al parámetro. Si el parámetro no está vacío, la expansión da como resultado el valor del parámetro.</span>

____
```
[me@linuxbox ~]$ foo=
[me@linuxbox ~]$ echo ${foo:="default value if unset"}
default value if unset 
[me@linuxbox ~]$ echo $foo
default value if unset
[me@linuxbox ~]$ foo=bar
[me@linuxbox ~]$ echo ${foo:="default value if unset"}
bar
[me@linuxbox ~]$ echo $foo
bar
```
___

> # Note<br /><span style="color:blue">Nota</span>

> Positional and other special parameters cannot be assigned this way.<br /><span style="color:blue">Los parámetros posicionales y otros parámetros especiales no se pueden asignar de esta manera.</span>

Here we use a question mark:<br /><span style="color:green">Aquí usamos un signo de interrogación:</span>

` ${parameter:?word} `

If parameter is unset or empty, this expansion causes the script to exit with an error, and the contents of word are sent to standard error. If parameter is not empty, the expansion results in the value of parameter.<br /><span style="color:green">Si el parámetro no está configurado o está vacío, esta expansión hace que el script se cierre con un error y el contenido de la palabra se envía al error estándar. Si el parámetro no está vacío, la expansión da como resultado el valor del parámetro.</span>

_____
```
[me@linuxbox ~]$ foo=
[me@linuxbox ~]$ echo ${foo:?"parameter is empty"}
bash: foo: parameter is empty
[me@linuxbox ~]$ echo $?
1
[me@linuxbox ~]$ foo=bar
[me@linuxbox ~]$ echo ${foo:?"parameter is empty"}
bar
[me@linuxbox ~]$ echo $?
0
```
___

Here we use a plus sign:<br /><span style="color:green">Aquí usamos un signo más:</span>

` ${parameter:+word} `

If parameter is unset or empty, the expansion results in nothing. If parameter is not empty, the value of word is substituted for parameter ; however, the value of parameter is not changed.<br /><span style="color:green">Si el parámetro no está configurado o está vacío, la expansión no da como resultado nada. Si el parámetro no está vacío, el valor de la palabra se sustituye por el parámetro; sin embargo, el valor del parámetro no cambia.</span>
____
```
[me@linuxbox ~]$ foo=
[me@linuxbox ~]$ echo ${foo:+"substitute value if set"}

[me@linuxbox ~]$ foo=bar
[me@linuxbox ~]$ echo ${foo:+"substitute value if set"}
substitute value if set
```
___

# Expansions That Return Variable Names<br /><span style="color:yellow">Expansiones que devuelven nombres de variables</span>

The shell has the ability to return the names of variables. This is used in some rather exotic situations.<br /><span style="color:green">El shell tiene la capacidad de devolver los nombres de las variables. Esto se usa en algunas situaciones bastante exóticas.</span>
____
```
${!prefix*}
${!prefix@}
```
____

This expansion returns the names of existing variables with names beginning with prefix . According to the bash documentation, both forms of the expansion perform identically. Here, we list all the variables in the environment with names that begin with BASH:<br /><span style="color:green">Esta expansión devuelve los nombres de las variables existentes con nombres que comienzan con prefijo. De acuerdo con la documentación de bash, ambas formas de expansión funcionan de manera idéntica. Aquí, enumeramos todas las variables en el entorno con nombres que comienzan con BASH:</span>

___
```
[me@linuxbox ~]$ echo ${!BASH*}
BASH BASH_ARGC BASH_ARGV BASH_COMMAND BASH_COMPLETION BASH_COMPLETION_DIR
BASH_LINENO BASH_SOURCE BASH_SUBSHELL BASH_VERSINFO BASH_VERSION
```
____

# String Operations<br /><span style="color:yellow">Operaciones de cadena</span>

There is a large set of expansions that can be used to operate on strings. Many of these expansions are particularly well suited for operations on pathnames. The following expansion:<br /><span style="color:green">Existe un gran conjunto de expansiones que se pueden utilizar para operar con cuerdas. Muchas de estas expansiones son especialmente adecuadas para operaciones en nombres de ruta. La siguiente expansión:</span>

` ${#parameter} `

expands into the length of the string contained by parameter . Normally, parameter is a string; however, if parameter is either @ or * , then the expansion results in the number of positional parameters.<br /><span style="color:green">se expande a la longitud de la cadena contenida por parámetro. Normalmente, el parámetro es una cadena; sin embargo, si el parámetro es @ o *, entonces la expansión da como resultado el número de parámetros posicionales.</span>

____
```
[me@linuxbox ~]$ foo="This string is long."
[me@linuxbox ~]$ echo "'$foo' is ${#foo} characters long."
'This string is long.' is 20 characters long.
```
____

The following expansions are used to extract a portion of the string contained in **parameter** :<br /><span style="color:green">Las siguientes expansiones se utilizan para extraer una parte de la cadena contenida en **parámetro**:</span>
____
```
${parameter:offset}
${parameter:offset:length}
```
____

The extraction begins at offset characters from the beginning of the string and continues until the end of the string, unless length is specified.<br /><span style="color:green">La extracción comienza en los caracteres de desplazamiento desde el principio de la cadena y continúa hasta el final de la cadena, a menos que se especifique la longitud.</span>
____
```
[me@linuxbox ~]$ foo="This string is long."
[me@linuxbox ~]$ echo ${foo:5}
string is long.
[me@linuxbox ~]$ echo ${foo:5:6}
string
```
___

If the value of offset is negative, it is taken to mean it starts from the end of the string rather than the beginning. Note that negative values must be preceded by a space to prevent confusion with the ${parameter:-word} expansion. length , if present, must not be less than zero.<br /><span style="color:green">Si el valor de desplazamiento es negativo, se considera que comienza desde el final de la cadena en lugar del principio. Tenga en cuenta que los valores negativos deben ir precedidos de un espacio para evitar confusiones con la expansión $ {parámetro: -word}. la longitud, si está presente, no debe ser menor que cero.</span>

If **parameter** is @ , the result of the expansion is length positional parameters, starting at offset .<br /><span style="color:green">Si **parámetro** es @, el resultado de la expansión son los parámetros posicionales de longitud, comenzando en el desplazamiento.</span>

____
```
[me@linuxbox ~]$ foo="This string is long."
[me@linuxbox ~]$ echo ${foo: -5}
long.
[me@linuxbox ~]$ echo ${foo: -5:2}
lo
```
____

The following expansions remove a leading portion of the string contained in parameter defined by pattern.<br /><span style="color:green">Las siguientes expansiones eliminan una parte inicial de la cadena contenida en el parámetro definido por patrón.</span>
___
```
${parameter#pattern}
${parameter##pattern}
```
___

pattern is a wildcard pattern like those used in pathname expansion. The difference in the two forms is that the # form removes the shortest match, while the ## form removes the longest match.<br /><span style="color:green">patrón es un patrón comodín como los que se utilizan en la expansión de nombre de ruta. La diferencia entre las dos formas es que la forma # elimina la coincidencia más corta, mientras que la forma ## elimina la coincidencia más larga.</span>
____
```
[me@linuxbox ~]$ foo=file.txt.zip
[me@linuxbox ~]$ echo ${foo#*.}
txt.zip
[me@linuxbox ~]$ echo ${foo##*.}
zip
```
___

The following are the same as the previous # and ## expansions, except they remove text from the end of the string contained in parameter rather than from the beginning.<br /><span style="color:green">Las siguientes son las mismas que las expansiones # y ## anteriores, excepto que eliminan el texto del final de la cadena contenida en el parámetro en lugar de hacerlo desde el principio.</span>

____
```
${parameter%pattern}
${parameter%%pattern}
```
____

Here is an example:<br /><span style="color:green">aquí está un ejemplo:</sapn>

____
```
[me@linuxbox ~]$ foo=file.txt.zip
[me@linuxbox ~]$ echo ${foo%.*}
file.txt
[me@linuxbox ~]$ echo ${foo%%.*}
file
```
____

The following expansions perform a search-and-replace operation upon the contents of parameter:<br /><span style="color:green">Las siguientes expansiones realizan una operación de búsqueda y reemplazo sobre el contenido del parámetro:</span>
____
```
${parameter/pattern/string}
${parameter//pattern/string}
${parameter/#pattern/string}
${parameter/%pattern/string}
```
____

If text is found matching wildcard pattern , it is replaced with the contents of string . In the normal form, only the first occurrence of pattern is replaced. In the // form, all occurrences are replaced. The /# form requires that the match occur at the beginning of the string, and the /% form requires the match to occur at the end of the string. In every form, /string may be omitted, causing the text matched by pattern to be deleted.<br /><span style="color:green">Si se encuentra texto que coincide con el patrón de comodín, se reemplaza con el contenido de la cadena. En la forma normal, solo se reemplaza la primera aparición de patrón. En el formulario //, se reemplazan todas las apariciones. La forma /# requiere que la coincidencia ocurra al principio de la cadena, y la forma /% requiere que la coincidencia ocurra al final de la cadena. En todas las formas, se puede omitir /sting, lo que provoca que se elimine el texto que coincide con el patrón.</span>
____
```
[me@linuxbox~]$ foo=JPG.JPG
[me@linuxbox~]$ echo ${foo/JPG/jpg}
jpg.JPG
[me@linuxbox~]$ echo ${foo//JPG/jpg}
jpg.jpg
[me@linuxbox~]$ echo ${foo/#JPG/jpg}
jpg.JPG
[me@linuxbox~]$ echo ${foo/%JPG/jpg}
JPG.jpg
```
____

Parameter expansion is a good thing to know. The string manipulation expansions can be used as substitutes for other common commands such as sed and cut . Expansions can improve the efficiency of scripts by eliminating the use of external programs. As an example, we will modify the longest-word program discussed in the previous chapter to use the parameter expansion ${#j} in place of the command substitution $(echo -n $j | wc -c) and its resulting subshell, like so:<br /><span style="color:green">Es bueno saber la expansión de parámetros. Las expansiones de manipulación de cadenas se pueden utilizar como sustitutos de otros comandos comunes como sed y cut. Las expansiones pueden mejorar la eficiencia de los scripts al eliminar el uso de programas externos. Como ejemplo, modificaremos el programa de la palabra más larga discutido en el capítulo anterior para usar el parámetro de expansión ${#j} en lugar de la sustitución del comando $(echo -n $j | wc -c) y su subshell resultante, al igual que:</span>

_____
```bash
#!/bin/bash

# longest-word3: find longest string in a file

for i; do
    if [[ -r "$i" ]]; then
        max_word=
        max_len=0
        for j in $(strings $i); do
            len="${#j}"
            if (( len > max_len )); then
                max_len="$len"
                max_word="$j"
            fi
        done
        echo "$i: '$max_word' ($max_len characters)"
    fi
done
```
____

Next, we will compare the efficiency of the two versions by using the time command.<br /><span style="color:green">A continuación, compararemos la eficiencia de las dos versiones usando el comando time.</span>
____
```
[me@linuxbox ~]$ time longest-word2 dirlist-usr-bin.txt
dirlist-usr-bin.txt: 'scrollkeeper-get-extended-content-list' (38 characters)

real    0m3.618s
user    0m1.544s
sys     0m1.768s
[me@linuxbox ~]$ time longest-word3 dirlist-usr-bin.txt
dirlist-usr-bin.txt: 'scrollkeeper-get-extended-content-list' (38 characters)

real    0m0.060s
user    0m0.056s
sys     0m0.008s
```
____

The original version of the script takes 3.618 seconds to scan the text file, while the new version, using parameter expansion, takes only 0.06 seconds, which is a significant improvement.<br /><span style="color:green">La versión original del script tarda 3.618 segundos en escanear el archivo de texto, mientras que la nueva versión, que usa la expansión de parámetros, toma solo 0.06 segundos, lo cual es una mejora significativa.</span>

# Case Conversion<br /><span style="color:yellow">Conversión de casos</span>

bash has four parameter expansions and two declare command options to support the uppercase/lowercase conversion of strings.<br /><span style="color:green">bash tiene cuatro expansiones de parámetros y dos opciones de comando de declaración para admitir la conversión de cadenas de mayúsculas/minúsculas.</span>

So, what is case conversion good for? Aside from the obvious aesthetic value, it has an important role in programming. Let’s consider the case of a database lookup. Imagine that a user has entered a string into a data input field that we want to look up in a database. It’s possible the user will enter the value in all uppercase letters or lowercase letters or a combination of both. We certainly don’t want to populate our database with every possible permutation of uppercase and lowercase spellings. What to do?<br /><span style="color:green">Entonces, ¿para qué sirve la conversión de casos? Aparte del valor estético obvio, tiene un papel importante en la programación. Consideremos el caso de una búsqueda en una base de datos. Imagine que un usuario ha ingresado una cadena en un campo de entrada de datos que queremos buscar en una base de datos. Es posible que el usuario ingrese el valor en letras mayúsculas o minúsculas o una combinación de ambas. Ciertamente, no queremos poblar nuestra base de datos con todas las posibles permutaciones de ortografía en mayúsculas y minúsculas. ¿Qué hacer?</span>

A common approach to this problem is to normalize the user’s input. That is, convert it into a standardized form before we attempt the database lookup. We can do this by converting all the characters in the user’s input to either lower or uppercase and ensure that the database entries are normalized the same way.<br /><span style="color:green">Un enfoque común para este problema es normalizar la entrada del usuario. Es decir, conviértalo en un formulario estandarizado antes de intentar la búsqueda en la base de datos. Podemos hacer esto convirtiendo todos los caracteres en la entrada del usuario a minúsculas o mayúsculas y asegurarnos de que las entradas de la base de datos estén normalizadas de la misma manera.</span>

The declare command can be used to normalize strings to either uppercase or lowercase. Using declare , we can force a variable to always contain the desired format no matter what is assigned to it.<br /><span style="color:green">El comando declare puede usarse para normalizar cadenas a mayúsculas o minúsculas. Usando declare, podemos forzar que una variable contenga siempre el formato deseado sin importar lo que se le asigne.</span>

____
```bash
#!/bin/bash

# ul-declare: demonstrate case conversion via declare

declare -u upper
declare -l lower
if [[ $1 ]]; then
    upper="$1"
    lower="$1"
    echo "$upper"
    echo "$lower"
fi
```
___

In the preceding script, we use declare to create two variables, upper and lower . We assign the value of the first command line argument (positional parameter 1) to each of the variables and then display them on the screen.<br /><span style="color:green">En el script anterior, usamos declare para crear dos variables, superior e inferior. Asignamos el valor del primer argumento de la línea de comando (parámetro posicional 1) a cada una de las variables y luego las mostramos en la pantalla.</span>
____
```
[me@linuxbox ~]$ ul-declare aBc
ABC
abc
```
____

As we can see, the command line argument ( aBc ) has been normalized. In addition to declare , there are four parameter expansions that perform upper/lowercase conversion, as described in Table 34-1.<br /><span style="color:green">Como podemos ver, el argumento de la línea de comandos (aBc) se ha normalizado. Además de declarar, hay cuatro expansiones de parámetros que realizan la conversión de mayúsculas / minúsculas, como se describe en la Tabla 34-1.</span>

> Table 34-1: Case Conversion Parameter Expansions<br /><span style="color:green">Tabla 34-1: Expansiones de parámetros de conversión de casos</span>

| Format | Result |
|---------|---------|
${ parameter,,pattern } | Expand the value of parameter into all lowercase. pattern is an optional shell pattern that will limit which characters (for example, [A-F]) will be converted. See the bash man page for a full description of patterns.<br /><span style="color:green">Expanda el valor del parámetro en minúsculas. patrón es un patrón de shell opcional que limitará qué caracteres (por ejemplo, [A-F]) se convertirán. Consulte la página del manual de bash para obtener una descripción completa de los patrones.</span>| 
${ parameter,pattern } | Expand the value of parameter , changing only the first character to lowercase.<br /><span style="color:green">Expanda el valor del parámetro, cambiando solo el primer carácter a minúsculas.</span> |
${ parameter^^pattern } | Expand the value of parameter into all uppercase letters. <br /><span style="color:green">Expanda el valor del parámetro en todas las letras mayúsculas.</span>|
${ parameter^pattern } | Expand the value of parameter , changing only the first character to uppercase (capitalization).<br /><span style="color:green">Expanda el valor del parámetro, cambiando solo el primer carácter a mayúsculas (mayúsculas).</span> |
_____

Here is a script that demonstrates these expansions:<br /><span style="color:green">Aquí hay un guión que demuestra estas expansiones:</span>

___
```bash
#!/bin/bash

# ul-param: demonstrate case conversion via parameter expansion

if [[ "$1" ]]; then
    echo "${1,,}"
    echo "${1,}"
    echo "${1^^}"
    echo "${1^}"
fi
```
___

Here is the script in action:<br /><span style="color:green">Aquí está el guión en acción:</span>

___
```
[me@linuxbox ~]$ ul-param aBc
abc
aBc
ABC
ABc
```
____

Again, we process the first command line argument and output the four variations supported by the parameter expansions. While this script uses the first positional parameter, parameter may be any string, variable, or string expression.<br /><span style="color:green">Nuevamente, procesamos el primer argumento de la línea de comando y mostramos las cuatro variaciones admitidas por las expansiones de parámetros. Si bien este script usa el primer parámetro posicional, el parámetro puede ser cualquier cadena, variable o expresión de cadena.</span>

# Arithmetic Evaluation and Expansion<br /><span style="color:yellow">Evaluación y expansión aritmética</span>

We looked at arithmetic expansion in Chapter 7. It is used to perform various arithmetic operations on integers. Its basic form is as follows:<br /><span style="color:green">Examinamos la expansión aritmética en el capítulo 7. Se utiliza para realizar varias operaciones aritméticas con números enteros. Su forma básica es la siguiente:</span>

` $((expression)) `

where expression is a valid arithmetic expression.<br /><span style="color:green">donde expresión es una expresión aritmética válida.</span> 

This is related to the compound command (( )) used for arithmetic evaluation (truth tests) we encountered in Chapter 27.<br /><span style="color:green">Esto está relacionado con el comando compuesto (()) utilizado para la evaluación aritmética (pruebas de verdad) que encontramos en el Capítulo 27.</span>

In previous chapters, we saw some of the common types of expressions and operators. Here, we will look at a more complete list.<br /><span style="color:green">En capítulos anteriores, vimos algunos de los tipos comunes de expresiones y operadores. Aquí, veremos una lista más completa.</span>

# Number Bases<br /><span style="color:yellow">Bases numéricas</span>

In Chapter 9, we got a look at octal (base 8) and hexadecimal (base 16) numbers. In arithmetic expressions, the shell supports integer constants in any base. Table 34-2 shows the notations used to specify the bases.<br /><span style="color:green">En el Capítulo 9, echamos un vistazo a los números octales (base 8) y hexadecimales (base 16). En expresiones aritméticas, el shell admite constantes enteras en cualquier base. La Tabla 34-2 muestra las notaciones utilizadas para especificar las bases.</span>

Table 34-2: Specifying Different Number Bases<br /><span style="color:green">Tabla 34-2: Especificación de bases numéricas diferentes</span>

| Notation | Description |
|---------|--------------|
number | By default, numbers without any notation are treated as decimal (base 10) integers. <br /><span style="color:green">De forma predeterminada, los números sin notación se tratan como enteros decimales (base 10).</span>|
0number | In arithmetic expressions, numbers with a leading zero are considered octal.<br /><span style="color:green">En expresiones aritméticas, los números con un cero a la izquierda se consideran octales.</span> |
0xnumber | Hexadecimal notation.<br /><span style="color:green">Notación hexadecimal.</span> |
base#number | number is in base.<br /><span style="color:green">el número está en la base.</span> |

___

Here are some examples:<br /><span style="color:green">Aquí hay unos ejemplos:</span>

___
```
[me@linuxbox ~]$ echo $((0xff))
255
[me@linuxbox ~]$ echo $((2#11111111))
255
```
___

In the previous examples, we print the value of the hexadecimal number ff (the largest two-digit number) and the largest eight-digit binary (base 2) number.<br /><span style="color:green">En los ejemplos anteriores, imprimimos el valor del número hexadecimal ff (el número más grande de dos dígitos) y el número binario de ocho dígitos más grande (base 2).</span>

# Unary Operators<br /><span style="color:yellow">Operadores unarios</span>

There are two unary operators, + and - , which are used to indicate whether a number is positive or negative, respectively. An example is -5.<br /><span style="color:green">Hay dos operadores unarios, + y -, que se utilizan para indicar si un número es positivo o negativo, respectivamente. Un ejemplo es -5.</span>

# Simple Arithmetic<br /><span style="color:yellow">Aritmética simple</span>

Table 34-3 lists the ordinary arithmetic operators.<br /><span style="color:green">La tabla 34-3 enumera los operadores aritméticos ordinarios.</span>

> Table 34-3: Arithmetic Operators<br /><span style="color:green">Tabla 34-3: Operadores aritméticos</span>

| Operator | Description |
|----------|-------------|
| + | Addition |
| - | Subtraction | 
| * | Multiplication |
| / | Integer division |
| ** | Exponentiation |
| % | Modulo (remainder) |

Most of these are self-explanatory, but integer division and modulo require further discussion.<br /><span style="color:green">La mayoría de ellos se explican por sí mismos, pero la división de enteros y el módulo requieren más discusión.</span>

Since the shell’s arithmetic operates only on integers, the results of division are always whole numbers.<br /><span style="color:green">Dado que la aritmética del shell opera solo con números enteros, los resultados de la división son siempre números enteros.</span>
____
```
[me@linuxbox ~]$ echo $(( 5 / 2 ))
2
```
___

This makes the determination of a remainder in a division operation more important.<br /><span style="color:green">Esto hace que la determinación de un resto en una operación de división sea más importante.</span>
___
```
[me@linuxbox ~]$ echo $(( 5 % 2 ))
1
```
___

By using the division and modulo operators, we can determine that 5 divided by 2 results in 2, with a remainder of 1.<br /><span style="color:green">Al usar los operadores de división y módulo, podemos determinar que 5 dividido por 2 da como resultado 2, con un resto de 1.</span>

Calculating the remainder is useful in loops. It allows an operation to be performed at specified intervals during the loop’s execution. In the following example, we display a line of numbers, highlighting each multiple of 5:<br /><span style="color:green">Calcular el resto es útil en bucles. Permite que se realice una operación a intervalos específicos durante la ejecución del bucle. En el siguiente ejemplo, mostramos una línea de números, resaltando cada múltiplo de 5:</span>

___
```bash
#!/bin/bash

# modulo: demonstrate the modulo operator

for ((i = 0; i <= 20; i = i + 1)); do
    remainder=$((i % 5))
    if (( remainder == 0 )); then
        printf "<%d> " "$i"
    else
        printf "%d " "$i"
    fi
done
printf "\n"
```
____

When executed, the results look like this:<br /><span style="color:green">Cuando se ejecuta, los resultados se ven así:</span>

___
```
[me@linuxbox ~]$ modulo
<0> 1 2 3 4 <5> 6 7 8 9 <10> 11 12 13 14 <15> 16 17 18 19 <20>
```
___

# Assignment<br /><span style="color:yellow">Asignación</span>

Although its uses may not be immediately apparent, arithmetic expressions may perform assignment. We have performed assignment many times, though in a different context. Each time we give a variable a value, we are performing assignment. We can also do it within arithmetic expressions.<br /><span style="color:green">Aunque sus usos pueden no ser evidentes de inmediato, las expresiones aritméticas pueden realizar asignaciones. Hemos realizado asignaciones muchas veces, aunque en un contexto diferente. Cada vez que le damos un valor a una variable, estamos realizando una asignación. También podemos hacerlo dentro de expresiones aritméticas.</span>

___
```
[me@linuxbox ~]$ foo=
[me@linuxbox ~]$ echo $foo
[me@linuxbox ~]$ if (( foo = 5 )); then echo "It is true."; fi
It is true.
[me@linuxbox ~]$ echo $foo
5
```
____

In the preceding example, we first assign an empty value to the variable foo and verify that it is indeed empty. Next, we perform an if with the compound command (( foo = 5 )) . This process does two interesting things: it assigns the value of 5 to the variable foo , and it evaluates to true because foo was assigned a non-zero value.<br /><span style="color:green">En el ejemplo anterior, primero asignamos un valor vacío a la variable foo y verificamos que de hecho esté vacío. A continuación, realizamos un if con el comando compuesto ((foo = 5)). Este proceso hace dos cosas interesantes: asigna el valor de 5 a la variable foo y evalúa como verdadero porque a foo se le asignó un valor distinto de cero.</span>

> # Note<br /><span style="color:red">Nota</span>
> It is important to remember the exact meaning of = in the previous expression. A single = performs assignment. foo = 5 says “make foo equal to 5,” while == evaluates equivalence. foo == 5 says “does foo equal 5?” This is a common feature in many programming languages. In the shell, this can be a little confusing because the test command accepts a single = for string equivalence. This is yet another reason to use the more modern [[ ]] and (( )) compound commands in place of test .<br /><span style="color:green">Es importante recordar el significado exacto de = en la expresión anterior. Un solo = realiza la tarea. foo = 5 dice "hacer foo igual a 5", mientras que == evalúa la equivalencia. foo == 5 dice "¿foo es igual a 5?" Esta es una característica común en muchos lenguajes de programación. En el shell, esto puede ser un poco confuso porque el comando de prueba acepta un solo = para la equivalencia de cadenas. Esta es otra razón más para usar los comandos compuestos [[]] y (()) más modernos en lugar de test.</span>

In addition to the = notation, the shell also provides notations that perform some very useful assignments, as described in Table 34-4.<br /><span style="color:green">Además de la notación =, el shell también proporciona notaciones que realizan algunas asignaciones muy útiles, como se describe en la Tabla 34-4.</span>

> Table 34-4: Assignment Operators<br /><span style="color:green">Tabla 34-4: Operadores de asignación</span>

| Notation | Description |
|------------|------------|
parameter = value | Simple assignment. Assigns value to parameter .<br /><span style="color:green">Asignación sencilla. Asigna valor al parámetro.</span> |
parameter += value | Addition. Equivalent to parameter = parameter + value . <br /><span style="color:green">Adición. Equivalente a parámetro = parámetro + valor.</span>|
parameter -= value | Subtraction. Equivalent to parameter = parameter – value . <br /><span style="color:green">Sustracción. Equivalente a parámetro = parámetro - valor.</span>|
parameter *= value | Multiplication. Equivalent to parameter = parameter * value .<br /><span style="color:green">Multiplicación. Equivalente a parámetro = parámetro * valor.</span> |
parameter /= value | Integer division. Equivalent to parameter = parameter / value .<br /><span style="color:green">División entera. Equivalente a parámetro = parámetro / valor.</span> |
parameter %= value | Modulo. Equivalent to parameter = parameter % value .<br /><span style="color:green">Modulo. Equivalente a parámetro = parámetro% valor.</span> |
parameter++ | Variable post-increment. Equivalent to parameter = parameter + 1 (however, see the following discussion).<br /><span style="color:green">Post-incremento variable. Equivalente a parámetro = parámetro + 1 (sin embargo, consulte la siguiente discusión).</span> |
parameter−− | Variable post-decrement. Equivalent to parameter = parameter − 1. <br /><span style="color:green">Post-decremento variable. Equivalente a parámetro = parámetro - 1.</span>|
++parameter | Variable pre-increment. Equivalent to parameter = parameter + 1. <br /><span style="color:green">Preincremento variable. Equivalente a parámetro = parámetro + 1.</span>|
--parameter | Variable pre-decrement. Equivalent to parameter = parameter − 1.<br /><span style="color:green">Pre-decremento variable. Equivalente a parámetro = parámetro - 1.</span> |
____

These assignment operators provide a convenient shorthand for many common arithmetic tasks. Of special interest are the increment ( ++ ) and decrement ( −− ) operators, which increase or decrease the value of their parameters by one. This style of notation is taken from the C programming language and has been incorporated into a number of other programming languages, including bash.<br /><span style="color:green">Estos operadores de asignación proporcionan un método abreviado conveniente para muchas tareas aritméticas comunes. De especial interés son los operadores de incremento (++) y decremento (−−), que aumentan o disminuyen el valor de sus parámetros en uno. Este estilo de notación se toma del lenguaje de programación C y se ha incorporado a varios otros lenguajes de programación, incluido bash.</span>

The operators may appear either at the front of a parameter or at the end. While they both either increment or decrement the parameter by one, the two placements have a subtle difference. If placed at the front of the parameter, the parameter is incremented (or decremented) before the parameter is returned. If placed after, the operation is performed after the parameter is returned. This is rather strange, but it is the intended behavior. Here is a demonstration:<br /><span style="color:green">Los operadores pueden aparecer al principio de un parámetro o al final. Si bien ambos aumentan o disminuyen el parámetro en uno, las dos ubicaciones tienen una diferencia sutil. Si se coloca al principio del parámetro, el parámetro se incrementa (o decrementa) antes de que se devuelva el parámetro. Si se coloca después, la operación se realiza después de que se devuelva el parámetro. Esto es bastante extraño, pero es el comportamiento previsto. Aquí hay una demostración:</span>

___
```
[me@linuxbox ~]$ foo=1
[me@linuxbox ~]$ echo $((foo++))
1
[me@linuxbox ~]$ echo $foo
2
```
___

If we assign the value of one to the variable foo and then increment it with the ++ operator placed after the parameter name, foo is returned with the value of one. However, if we look at the value of the variable a second time, we see the incremented value. If we place the ++ operator in front of the parameter, we get the more expected behavior.<br /><span style="color:green">Si asignamos el valor de uno a la variable foo y luego lo incrementamos con el operador ++ colocado después del nombre del parámetro, foo se devuelve con el valor de uno. Sin embargo, si miramos el valor de la variable por segunda vez, vemos el valor incrementado. Si colocamos el operador ++ delante del parámetro, obtenemos el comportamiento más esperado.</span>
___
```
[me@linuxbox ~]$ foo=1
[me@linuxbox ~]$ echo $((++foo))
2
[me@linuxbox ~]$ echo $foo
2
```
___

For most shell applications, prefixing the operator will be the most useful.<br /><span style="color:green">Para la mayoría de las aplicaciones de shell, el prefijo del operador será lo más útil.</span>

The ++ and -- operators are often used in conjunction with loops. We will make some improvements to our modulo script to tighten it up a bit.<br /><span style="color:green">Los operadores ++ y - se utilizan a menudo junto con bucles. Haremos algunas mejoras en nuestro script de módulo para ajustarlo un poco.</span>

___
```bash
#!/bin/bash

# modulo2: demonstrate the modulo operator

for ((i = 0; i <= 20; ++i )); do
    if (((i % 5) == 0 )); then
        printf "<%d> " "$i"
    else
        printf "%d " "$i"
    fi
done
printf "\n"
```
___

# Bit Operations<br /><span style="color:yellow">Operaciones de bits</span>

One class of operators manipulates numbers in an unusual way. These operators work at the bit level. They are used for certain kinds of low-level tasks, often involving setting or reading bit flags (see Table 34-5).<br /><span style="color:green">Una clase de operadores manipula los números de una manera inusual. Estos operadores trabajan a nivel de bits. Se utilizan para ciertos tipos de tareas de bajo nivel, que a menudo implican establecer o leer indicadores de bits (consulte la Tabla 34-5).</span>

> Table 34-5: Bit Operators<br /><span style="color:green">Tabla 34-5: Operadores de bits</span>

| Operator | Description |
|------------|------------|
~ | Bitwise negation. Negate all the bits in a number. <br /><span style="color:green">Negación bit a bit. Niega todos los bits de un número.</span>|
| << | Left bitwise shift. Shift all the bits in a number to the left. <br /><span style="color:green">Desplazamiento bit a la izquierda. Mueva todos los bits de un número a la izquierda.</span>|
| >> | Right bitwise shift. Shift all the bits in a number to the right.<br /><span style="color:green">Desplazamiento bit a bit a la derecha. Mueva todos los bits de un número a la derecha.</span> |
| & | Bitwise AND. Perform an AND operation on all the bits in two numbers. <br /><span style="color:green"></span>|
| \| | Bitwise OR. Perform an OR operation on all the bits in two numbers.<br /><span style="color:green">OR bit a bit. Realice una operación OR en todos los bits en dos números.</span> |
| ^ | Bitwise XOR. Perform an exclusive OR operation on all the bits in two numbers.<br /><span style="color:green">XOR bit a bit. Realice una operación OR exclusiva en todos los bits en dos números.</span> |

Note that there are also corresponding assignment operators (for example, <<= ) for all but bitwise negation.<br /><span style="color:green">Tenga en cuenta que también hay operadores de asignación correspondientes (por ejemplo, << =) para todos menos la negación bit a bit.</span>

Here we will demonstrate producing a list of powers of 2, using the left bitwise shift operator:<br /><span style="color:green">Aquí demostraremos cómo producir una lista de potencias de 2, usando el operador de desplazamiento bit a bit a la izquierda:</span>

___
```
[me@linuxbox ~]$ for ((i=0;i<8;++i)); do echo $((1<<i)); done
1
2
4
8
16
32
64
128
```
___

# Logic<br /><span style="color:yellow">Lógica</span>

As we discovered in Chapter 27, the (( )) compound command supports a  variety of comparison operators. There are a few more that can be used to evaluate logic. Table 34-6 provides the complete list.<br /><span style="color:green">Como descubrimos en el Capítulo 27, el comando compuesto (()) admite una variedad de operadores de comparación. Hay algunos más que se pueden usar para evaluar la lógica. La Tabla 34-6 proporciona la lista completa.</span>

> Table 34-6: Comparison Operators<br /><span style="color:green">Tabla 34-6: Operadores de comparación</span>

| Operator | Description |
|---------|----------------|
| <= | Less than or equal to.<br /><span style="color:green">Menos que o igual a.</span> |
| >= | Greater than or equal to.<br /><span style="color:green">Mayor qué o igual a.</span> |
| < | Less than.<br /><span style="color:green">Menos que.</span> |
| > | Greater than.<br /><span style="color:green">Mas grande que.</span> |
| == | Equal to.<br /><span style="color:green">Igual a.</span> |
| != | Not equal to.<br /><span style="color:green">No igual a</span> |
| && | Logical AND.<br /><span style="color:green">AND logico</span> |
| || | Logical OR. <br /><span style="color:green">OR logico</span>| 
| expr1?expr2:expr3 | Comparison (ternary) operator. If expression expr1 evaluates tobe nonzero (arithmetic true), then expr2 ; else expr3. <br /><span style="color:green">Operador de comparación (ternario). Si la expresión expr1 se evalúa como distinta de cero (aritmética verdadera), entonces expr2; más expr3.</span>|

When used for logical operations, expressions follow the rules of arithmetic logic; that is, expressions that evaluate as zero are considered false, while non-zero expressions are considered true. The (( )) compound command maps the results into the shell’s normal exit codes.<br /><span style="color:green">Cuando se utilizan para operaciones lógicas, las expresiones siguen las reglas de la lógica aritmética; es decir, las expresiones que se evalúan como cero se consideran falsas, mientras que las expresiones distintas de cero se consideran verdaderas. El comando compuesto (()) asigna los resultados a los códigos de salida normales del shell.</span>
____
```
[me@linuxbox ~]$ if ((1)); then echo "true"; else echo "false"; fi
true
[me@linuxbox ~]$ if ((0)); then echo "true"; else echo "false"; fi
false
```
____

The strangest of the logical operators is the ternary operator. This operator (which is modeled after the one in the C programming language) performs a stand-alone logical test. It can be used as a kind of if / then / else statement. It acts on three arithmetic expressions (strings won’t work), and if the first expression is true (or non-zero), the second expression is performed. Otherwise, the third expression is performed. We can try this on the command line:<br /><span style="color:green">El más extraño de los operadores lógicos es el operador ternario. Este operador (que sigue el modelo del lenguaje de programación C) realiza una prueba lógica independiente. Se puede utilizar como una especie de declaración if / then / else. Actúa sobre tres expresiones aritméticas (las cadenas no funcionan), y si la primera expresión es verdadera (o distinta de cero), se realiza la segunda expresión. De lo contrario, se realiza la tercera expresión. Podemos probar esto en la línea de comando:</span>

____
```
[me@linuxbox ~]$ a=0
[me@linuxbox ~]$ ((a<1?++a:--a))
[me@linuxbox ~]$ echo $a
1
[me@linuxbox ~]$ ((a<1?++a:--a))
[me@linuxbox ~]$ echo $a
0
```
____

Here we see a ternary operator in action. This example implements a toggle. Each time the operator is performed, the value of the variable a switches from zero to one or vice versa.<br /><span style="color:green">Aquí vemos un operador ternario en acción. Este ejemplo implementa un conmutador. Cada vez que se realiza el operador, el valor de la variable a cambia de cero a uno o viceversa.</span>

Please note that performing assignment within the expressions is not straightforward. When attempted, bash will declare an error.<br /><span style="color:green">Tenga en cuenta que realizar asignaciones dentro de las expresiones no es sencillo. Cuando se intenta, bash declarará un error.</span>

___
```
[me@linuxbox ~]$ a=0
[me@linuxbox ~]$ ((a<1?a+=1:a-=1))
bash: ((: a<1?a+=1:a-=1: attempted assignment to non-variable (error token is "-=1")
```
___

This problem can be mitigated by surrounding the assignment expression with parentheses.<br /><span style="color:green">Este problema se puede mitigar rodeando la expresión de asignación entre paréntesis.</span>
____

` [me@linuxbox ~]$ ((a<1?(a+=1):(a-=1))) `
___

Next is a more complete example of using arithmetic operators in a script that produces a simple table of numbers:<br /><span style="color:green">A continuación, se muestra un ejemplo más completo del uso de operadores aritméticos en un script que produce una tabla simple de números:</span>

___
```bash
#!/bin/bash

# arith-loop: script to demonstrate arithmetic operators

finished=0
a=0
printf "a\ta**2\ta**3\n"
printf "=\t====\t====\n"

until ((finished)); do
    b=$((a**2))
    c=$((a**3))
    printf "%d\t%d\t%d\n" "$a" "$b" "$c"
    ((a<10?++a:(finished=1)))
done
```
____

In this script, we implement an until loop based on the value of the finished variable. Initially, the variable is set to zero (arithmetic false), and we continue the loop until it becomes non-zero. Within the loop, we calculate the square and cube of the counter variable a . At the end of the loop, the value of the counter variable is evaluated. If it is less than 10 (the maximum number of iterations), it is incremented by one, or else the variable finished is given the value of one, making finished arithmetically true, thereby terminating the loop. Running the script gives this result:<br /><span style="color:green">En este script, implementamos un bucle hasta basado en el valor de la variable terminada. Inicialmente, la variable se establece en cero (aritmética falsa) y continuamos el ciclo hasta que se vuelve diferente de cero. Dentro del ciclo, calculamos el cuadrado y el cubo de la variable de contador a. Al final del ciclo, se evalúa el valor de la variable del contador. Si es menor que 10 (el número máximo de iteraciones), se incrementa en uno, o de lo contrario a la variable finalizada se le da el valor de uno, haciendo que finalizado sea aritméticamente verdadero, terminando así el ciclo. Ejecutar el script da este resultado:</span>

___
```
[me@linuxbox ~]$ arith-loop
a   a**2    a**3
=   ====    ====
0   0       0
1   1       1
2   4       8
3   9       27
..  ..      ..
```
____

# bc - An Arbitrary Precision Calculator Language<br /><span style="color:yellow">bc - un lenguaje de calculadora de precisión arbitraria</span>

We have seen how the shell can handle many types of integer arithmetic, but what if we need to perform higher math or even just use floating-point numbers? The answer is, we can’t. At least not directly with the shell. To do this, we need to use an external program. There are several approaches we can take. Embedding Perl or AWK programs is one possible solution, but unfortunately, it’s outside the scope of this book.<br /><span style="color:green">Hemos visto cómo el shell puede manejar muchos tipos de aritmética de enteros, pero ¿qué pasa si necesitamos realizar operaciones matemáticas superiores o incluso usar números de punto flotante? La respuesta es que no podemos. Al menos no directamente con el caparazón. Para hacer esto, necesitamos usar un programa externo. Hay varios enfoques que podemos adoptar. Incrustar programas Perl o AWK es una posible solución, pero desafortunadamente, está fuera del alcance de este libro.</span>

Another approach is to use a specialized calculator program. One such program found on many Linux systems is called bc.<br /><span style="color:green">Otro enfoque es utilizar un programa de calculadora especializado. Uno de estos programas que se encuentra en muchos sistemas Linux se llama bc.</span>

The bc program reads a file written in its own C-like language and executes it. A bc script may be a separate file, or it may be read from standard input. The bc language supports quite a few features including variables, loops, and programmer-defined functions. We won’t cover bc entirely here, just enough to get a taste. bc is well documented by its man page.<br /><span style="color:green">El programa bc lee un archivo escrito en su propio lenguaje similar a C y lo ejecuta. Un script bc puede ser un archivo separado o puede leerse desde una entrada estándar. El lenguaje bc admite bastantes características, incluidas variables, bucles y funciones definidas por el programador. No cubriremos bc por completo aquí, solo lo suficiente para probarlo. bc está bien documentado por su página de manual.</span>

Let’s start with a simple example. We’ll write a bc script to add 2 plus 2.<br /><span style="color:green">Comencemos con un ejemplo simple. Escribiremos un script bc para agregar 2 más 2.</span>

___
```
/* A very simple bc script */
2 + 2
```
___

The first line of the script is a comment. bc uses the same syntax for comments as the C programming language. Comments, which may span multiple lines, begin with /* and end with */.<br /><span style="color:green">La primera línea del guión es un comentario. bc usa la misma sintaxis para los comentarios que el lenguaje de programación C. Los comentarios, que pueden abarcar varias líneas, comienzan con / * y terminan con * /.</span>

# Using bc<br /><span style="color:yellow">Usando bc</span>

If we save the previous bc script as foo.bc , we can run it this way:<br /><span style="color:green">Si guardamos el script bc anterior como foo.bc, podemos ejecutarlo de esta manera:</span>

___
```
[me@linuxbox ~]$ bc foo.bc
bc 1.06.94
Copyright 1991-1994, 1997, 1998, 2000, 2004, 2006 Free Software Foundation, Inc.
This is free software with ABSOLUTELY NO WARRANTY.
For details type `warranty'.
4
```
____

If we look carefully, we can see the result at the very bottom, after the copyright message. This message can be suppressed with the -q (quiet) option.<br /><span style="color:green">Si miramos con atención, podemos ver el resultado en la parte inferior, después del mensaje de derechos de autor. Este mensaje se puede suprimir con la opción -q (silencioso).</span>

bc can also be used interactively.<br /><span style="color:green">bc también se puede utilizar de forma interactiva</span>
____
```
[me@linuxbox ~]$ bc –q
2 + 2
4
quit
```
___

When using bc interactively, we simply type the calculations we want to perform, and the results are immediately displayed. The bc command quit ends the interactive session.<br /><span style="color:green">Cuando usamos bc de forma interactiva, simplemente escribimos los cálculos que queremos realizar y los resultados se muestran inmediatamente. El comando bc quit finaliza la sesión interactiva.</span>

It is also possible to pass a script to bc via standard input.<br /><span style="color:green">También es posible pasar un script a bc a través de una entrada estándar.</span>
___
```
[me@linuxbox ~]$ bc < foo.bc
4
```
____

The ability to take standard input means that we can use here documents, here strings, and pipes to pass scripts. This is a here string example:<br /><span style="color:green">La capacidad de tomar entradas estándar significa que podemos usar aquí documentos, aquí cadenas y canalizaciones para pasar scripts. Este es un ejemplo de cadena aquí:</span>
___
```
[me@linuxbox ~]$ bc <<< "2+2"
4
```
____

# An Example Script<br /><span style="color:yellow">Un guion de ejemplo</span>

As a real-world example, we will construct a script that performs a common calculation, monthly loan payments. In the script that follows, we use a here document to pass a script to bc:<br /><span style="color:green">Como ejemplo del mundo real, construiremos un script que realiza un cálculo común, pagos mensuales del préstamo. En el script que sigue, usamos un documento here para pasar un script a bc:</span>

```bash
#!/bin/bash

# loan-calc: script to calculate monthly loan payments

PROGNAME="${0##*/}" # Use parameter expansion to get basename

usage () {
    cat <<- EOF
    Usage: $PROGNAME PRINCIPAL INTEREST MONTHS

    Where:

    PRINCIPAL is the amount of the loan.
    INTEREST is the APR as a number (7% = 0.07).
    MONTHS is the length of the loan's term.
EOF

}

if (($# != 3)); then
    usage
    exit 1
fi

principal=$1
interest=$2
months=$3

bc <<- EOF
    scale = 10
    i = $interest / 12
    p = $principal
    n = $months
    a = p * ((i * ((1 + i) ^ n)) / (((1 + i) ^ n) - 1))
    print a, "\n"
EOF
```
____

When executed, the results look like this:<br /><span style="color:green">Cuando se ejecuta, los resultados se ven así:</span>

___
```
[me@linuxbox ~]$ loan-calc 135000 0.0775 180
1270.7222490000
```
___

This example calculates the monthly payment for a $135,000 loan at 7.75 percent APR for 180 months (15 years). Notice the precision of the answer. This is determined by the value given to the special scale variable in the bc script. A full description of the bc scripting language is provided by the bc man page. While its mathematical notation is slightly different from that of the shell ( bc more closely resembles C), most of it will be quite familiar, based on what we have learned so far.<br /><span style="color:green">Este ejemplo calcula el pago mensual de un préstamo de $ 135,000 a una APR del 7.75 por ciento durante 180 meses (15 años). Note la precisión de la respuesta. Esto está determinado por el valor dado a la variable de escala especial en el script bc. La página de manual de bc proporciona una descripción completa del lenguaje de secuencias de comandos de bc. Si bien su notación matemática es ligeramente diferente a la del caparazón (bc se parece más a C), la mayor parte será bastante familiar, según lo que hemos aprendido hasta ahora.</span>

# Summing Up<br /><span style="color:yellow">Resumen</span>

In this chapter, we learned about many of the little things that can be used to get the “real work” done in scripts. As our experience with scripting grows, the ability to effectively manipulate strings and numbers will prove extremely valuable. Our loan-calc script demonstrates that even simple scripts can be created to do some really useful things.<br /><span style="color:green">En este capítulo, aprendimos sobre muchas de las pequeñas cosas que se pueden usar para hacer el "trabajo real" en los scripts. A medida que crece nuestra experiencia con la creación de scripts, la capacidad de manipular de forma eficaz cadenas y números resultará extremadamente valiosa. Nuestro script credit-calc demuestra que incluso se pueden crear scripts simples para hacer cosas realmente útiles.</span>

# Extra Credit<br /><span style="color:yellow">Crédito adicional</span>

While the basic functionality of the loan-calc script is in place, the script is far from complete. For extra credit, try improving the loan-calc script with the following features:<br /><span style="color:green">Si bien la funcionalidad básica de la secuencia de comandos de préstamo-calc está en su lugar, la secuencia de comandos está lejos de estar completa. Para obtener crédito adicional, intente mejorar la secuencia de comandos de préstamo-cálculo con las siguientes características:</span>

* Full verification of the command line arguments<br /><span style="color:green">Verificación completa de los argumentos de la línea de comandos</span>
* A command line option to implement an “interactive” mode that will prompt the user to input the principal, interest rate, and term of the loan<br /><span style="color:green">Una opción de línea de comandos para implementar un modo "interactivo" que solicitará al usuario que ingrese el capital, la tasa de interés y el plazo del préstamo.</span>
* A better format for the output<br /><span style="color:green">Un mejor formato para la salida</span>
