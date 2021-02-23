#! /bin/bash
FILE_NAME="SomeRandomFile"

touch $FILE_NAME

echo """I wrote all
the  
stuff
here.
And to access a variable we can use
$FILE_NAME  

""" >> $FILE_NAME

cat $FILE_NAME
