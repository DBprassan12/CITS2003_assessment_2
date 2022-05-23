#!/bin/bash

#!/bin/sh

File="./sample/sample2.txt"


compound_word=$(grep -E -i -o  "[a-z]'[a-z]+" "$File" | grep -Ev 's' | wc -l)





echo contraction "$compound_word"

