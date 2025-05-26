#! /usr/bin/bash

hello_world () {
   echo 'hello, world'
}

hello_world2 () { echo 'hello, world'; } # in one line

# with arguments
hello_name () {
    echo "number of args $#" # Number of arguments
    echo "hello $1" 
    echo "All args $*" # All positional arguments (as a single word)
    # $@ All positional arguments (as separate strings)
    for i in $@; do
        echo "test: $i" 
    done
}

my_function () {
  echo "some result"
  return 55
}

function my_function2 {
  echo "$(( $1 + $2 ))"
}


hello_world
hello_world2
hello_name "Jim" "John"
my_function
echo $?
my_function2 10 15