#!/bin/bash

File="./sample/sample1.txt"


declare -a StringArray=( "also" "although" "and" "as" "because" "before" "but" "for" "if" "nor" "of" "or" "since" "that" "though"  "until"  "when" "whenever" "whereas" "which"  "while"  "yet" )

# Iterate the string array using for loop


for val in ${StringArray[@]};

do
    foundInfiles=$(grep -ow "$val" "$File" | wc -l)
    echo $val $foundInfiles
    
    
done