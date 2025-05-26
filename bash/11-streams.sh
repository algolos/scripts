#! /usr/bin/bash

# Read from stdin until ^EOF$ and overwrite hello.py with the lines
# between "EOF" (which are called a "here document"):
cat > hello.py << EOF
#!/usr/bin/env python3
from __future__ import print_function
import sys
print("#stdout", file=sys.stdout)
print("#stderr", file=sys.stderr)
for line in sys.stdin:
    print(line, file=sys.stdout)
EOF

# Variables will be expanded if the first "EOF" is not quoted

# Run the hello.py python3 script with various stdin, stdout, and
# stderr redirections:
python3 hello.py < "input.in" # pass input.in as input to the script

python3 hello.py > "output.out" # redirect output from the script to output.out

python3 hello.py 2> "error.err" # redirect error output to error.err

python3 hello.py > "output-and-error.log" 2>&1
# redirect both output and errors to output-and-error.log
# &1 means file descriptor 1 (stdout), so 2>&1 redirects stderr (2) to the current
# destination of stdout (1), which has been redirected to output-and-error.log.

python3 hello.py > /dev/null 2>&1
# redirect all output and errors to the black hole, /dev/null, i.e., no output

# The output error will overwrite the file if it exists,
# if you want to append instead, use ">>":
python3 hello.py >> "output.out" 2>> "error.err"

# Overwrite output.out, append to error.err, and count lines:
info bash 'Basic Shell Features' 'Redirections' > output.out 2>> error.err
wc -l output.out error.err