#! /usr/bin/bash

set -x

name="John"
echo "Hi $name"  #=> Hi John
set +x
echo 'Hi $name'  #=> Hi $name

echo "${name}"
echo "${name/J/j}"    #=> "john" (substitution)
echo "${name:0:2}"    #=> "Jo" (slicing)
echo "${name::2}"     #=> "Jo" (slicing)
echo "${name::-1}"    #=> "Joh" (slicing)
echo "${name:(-1)}"   #=> "n" (slicing from right)
echo "${name:(-2):1}" #=> "h" (slicing from right)
echo "${food:-Cake}"  #=> $food or "Cake"
echo "${#name}"       #=> 4 length 

length=2
echo "${name:0:length}"  #=> "Jo"

str="/path/to/foo.cpp"
echo "${str%.cpp}"    # /path/to/foo
echo "${str%.cpp}.o"  # /path/to/foo.o
echo "${str%/*}"      # /path/to

echo "${str##*.}"     # cpp (extension)
echo "${str##*/}"     # foo.cpp (basepath)
echo "${str#*/}"      # path/to/foo.cpp
echo "${str##*/}"     # foo.cpp

echo "${str/foo/bar}" # /path/to/bar.cpp

url="https://devhints.io/bash"
echo "${url#*https://}" # devhints.io/bash

str="Hello world"
echo "${str:6:5}"    # "world"
echo "${str: -5:5}"  # "world"

echo "I'm in $(pwd)"
echo "I'm in `pwd`"  # obsolescent same



str="HELLO WORLD!"
echo "${str,}"   #=> "hELLO WORLD!" (lowercase 1st letter)
echo "${str,,}"  #=> "hello world!" (all lowercase)

str="hello world!"
echo "${str^}"   #=> "Hello world!" (uppercase 1st letter)
echo "${str^^}"  #=> "HELLO WORLD!" (all uppercase)

# Объединение строк
str1="Hello"
str2="World"
result="$str1 $str2"  # Простое объединение с пробелом
echo "$result"        # Выведет: Hello World

echo ${0%/*}           # Вывод рабочей папки

echo "Welcome To Devhints" | tr '[:lower:]' '[:upper:]'

