#! /usr/bin/bash

set -eux

read a
read b
read operator
case "$operator" in
  "+")
  output=$((a + b))
  ;;
  "-")
  output=$((a - b))
  ;;
  "*")
  output=$((a * b))
  ;;
  "/")
  output=$((a / b))
  ;;
  *)
   echo "Usage: $operator {+|-|*|/}"
  ;;
esac
echo "Output: ${output}"