#! /usr/bin/bash

###########################################################
### Сравнение [ ] и [[ ]] в Bash
###########################################################
# | Критерий       | [ ] (test)              | [[ ]]                     | Примеры
# |----------------|-------------------------|---------------------------|-----------------------------------------
# | Совместимость  | POSIX (/bin/sh)         | Только Bash/Zsh           | [ "$var" = "val" ] vs [[ $var == "val" ]]
# | Безопасность   | Требует кавычек         | Автоматическая обработка  | [ -f "$file" ] vs [[ -f $file ]]
# | Логика         | -a (AND), -o (OR)       | &&, ||                    | [ "$a" -lt 10 -a "$b" -gt 20 ] vs [[ $a -lt 10 && $b -gt 20 ]]
# | Сравнение строк| =, !=                   | ==, !=, =~ (регулярки)    | [[ $str =~ ^[0-9]+$ ]]
# | Подстановки    | Литералы (* → как текст)| Работают (*.txt)          | [[ $file == *.log ]]
# | Скорость       | Медленнее (внешняя)     | Быстрее (встроено)        | 
# | Числа          | -eq, -lt, -gt           | Можно использовать >, <   | (( a > 10 )) — но это уже (( ))

a=14
# С [ ] (громоздко):
if [ "$a" -gt 10 -a "$a" -lt 20 ]; then
    echo "a между 10 и 20"
fi
a=25
# С [[ ]] (проще):
if [[ $a -gt 20 && $a -lt 30 ]]; then
    echo "a между 20 и 30"
fi

# Проверка файлов и директорий

file="/path/to/file.txt"
dir="/path/to/dir"

# Существует ли файл?
if [[ -f "$file" ]]; then
    echo "Файл существует"
fi

# Является ли директорией?
if [[ -d "$dir" ]]; then
    echo "Это директория"
fi

# Пустой ли файл?
if [[ ! -s "$file" ]]; then
    echo "Файл пуст"
fi

# Сравнение строк

str1="hello"
str2="world"

# Равны ли строки?
if [[ "$str1" == "$str2" ]]; then
    echo "Строки идентичны"
else
    echo "Строки разные"
fi

# Содержит ли подстроку?
if [[ "$str1" == *"ell"* ]]; then
    echo "Строка содержит 'ell'"
fi

# Регулярные выражения
if [[ "$str1" =~ ^h ]]; then
    echo "Строка начинается с 'h'"
fi

# Сравнение чисел

a=10
b=20

# Классический синтаксис
if [[ "$a" -lt "$b" ]]; then
    echo "$a меньше $b"
fi

# Альтернатива с (( ))
if (( a < b )); then
    echo "$a меньше $b (через арифметику)"
fi

# Логические операторы

age=18
name="Alice"

# И (AND)
if [[ "$age" -ge 18 && "$name" == "Alice" ]]; then
    echo "Алиса совершеннолетняя"
fi

# Или (OR)
if [[ "$age" -lt 18 || "$name" != "Alice" ]]; then
    echo "Или не Алиса, или несовершеннолетний"
fi

# Проверка переменных

unset var
empty_var=""

# Переменная не установлена?
if [[ -z "${var+x}" ]]; then
    echo "var не определена"
fi

# Переменная пуста?
if [[ -z "$empty_var" ]]; then
    echo "empty_var пуста"
fi

# Переменная установлена и не пуста?
if [[ -n "$name" ]]; then
    echo "name содержит значение: $name"
fi

# Комбинированные условия

# Проверка прав на файл
if [[ -r "$file" && -w "$file" ]]; then
    echo "Файл доступен для чтения и записи"
fi

# Сложная логика
if [[ (-f "$file" || -d "$dir") && "$user" == "admin" ]]; then
    echo "Доступ разрешён"
fi

# Работа с массивами

fruits=("apple" "banana" "cherry")

# Есть ли элемент в массиве?
if [[ " ${fruits[*]} " == *" banana "* ]]; then
    echo "Банан есть в списке"
fi

# Специальные условия

# Существует ли команда в системе?
if command -v git &>/dev/null; then
    echo "Git установлен"
fi

# Доступен ли порт?
if nc -z localhost 80 &>/dev/null; then
    echo "Порт 80 открыт"
fi

a=6
b=6
c=10
if (( b >= a )) && (( b < c )); then
    echo "good"
fi 

if [[ b -ge a && b -lt c ]]; then
    echo "good"
fi 

var_test="ttt"
echo "${var_test+z}"

# There is also the `=~` operator, which tests a string against the Regex pattern:
email=me@example.com
if [[ "$email" =~ [a-z]+@[a-z]{2,}\.(com|net|org) ]]
then
    echo "Valid email!"
fi