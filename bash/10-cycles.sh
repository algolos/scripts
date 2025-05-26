#! /usr/bin/bash


for i in /etc/cron.*; do
  echo "$i"
done

for ((i = 0 ; i < 5 ; i++)); do
  echo "$i"
done

for i in {1..5}; do
    echo "Welcome $i"
done

for i in {5..50..5}; do
    echo "Welcome $i"
done

# чтение файла построчно
i=0
while read -r line; do
  echo "$line: $i"
  i=$((i + 1))
done <file

for Variable in file file2
do
    cat "$Variable"
done

# while loop:
while [ true ]
do
    echo "loop body here..."
    break
done