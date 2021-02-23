#!/bin/bash
# Arithmetic expansion 
# uses the following form: $((expression))
echo $((2 + 2))
echo Exponente $(((5**2)*3))
echo Five divided by two equals $((5/2))
echo With $((5%2)) left over
# crear multiples cadenas de texto con un patron
# contenido en parentesis. Nota: sin espacios entre ,
echo Font-{A,B,C}-Back 
# Los patrones que se van a expandir con llaves pueden contener una parte inicial llamada preámbulo y una parte final llamada posdata. La expresión de llaves en sí puede contener una lista de cadenas separadas por comas o un rango de números enteros o caracteres individuales. El patrón no puede contener espacios en blanco sin comillas.
# Aquí hay un ejemplo que usa un rango de números enteros:
echo Number_{1..5}
echo {01..15}
echo {001..15}
# un rango de letras
echo {A..Z}
# rango de letras inversas
echo a{A{1,2},B{3,4}}b
# utiliza para crear directorios automaticamente.
mkdir Photos
cd Photos
mkdir {2007..2009}-{01..12}
ls
#

