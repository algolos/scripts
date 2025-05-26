#! /usr/bin/bash

declare -A sounds

sounds[dog]="bark"
sounds[cow]="moo"
sounds[bird]="tweet"
sounds[wolf]="howl"

for val in "${sounds[@]}"; do
  echo "$val"
done
echo ""
for key in "${!sounds[@]}"; do
  echo "$key"
done
echo ""

echo "${sounds[dog]}" # Dog's sound
echo "${sounds[@]}"   # All values
echo "${!sounds[@]}"  # All keys
echo "${#sounds[@]}"  # Number of elements
unset sounds[dog]     # Delete dog

