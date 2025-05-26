#! /usr/bin/bash
#set -x

Fruits=('Apple' 'Banana' 'Orange')


echo "${Fruits[0]}"           # Element #0
echo "${Fruits[-1]}"          # Last element
echo "${Fruits[@]}"           # All elements, space-separated
echo "${#Fruits[@]}"          # Number of elements
echo "${#Fruits}"             # String length of the 1st element
echo "${#Fruits[2]}"          # String length of the Nth element
echo "${Fruits[@]:1:2}"       # Range (from position 3, length 2)
echo "${!Fruits[@]}"          # Keys of all elements, space-separated


Veggies=('Tomato' 'Potato' 'Onion')
Fruits=("${Fruits[@]}" "Watermelon")    # Push
echo "${Fruits[@]}"
Fruits+=('Watermelon')                  # Also Push
echo "${Fruits[@]}"
Fruits=( "${Fruits[@]/Ap*/}" )          # Remove by regex match
echo "${Fruits[@]}"
unset Fruits[2]                         # Remove one item
echo "${Fruits[@]}"
Fruits=("${Fruits[@]}")                 # Duplicate
echo "${Fruits[@]}"
Fruits=("${Fruits[@]}" "${Veggies[@]}") # Concatenate
echo "${Fruits[@]}"
#lines=(`cat "logfile"`)                 # Read from file

for i in "${Fruits[@]}"; do
  echo "$i"
done
