#!/bin/bash




declare -a StringArray=( "also" "although" "and" "as" "because" "before" "but" "for" "if" "nor" "of" "or" "since" "that" "though"  "until"  "when" "whenever" "whereas" "which"  "while"  "yet" )

# Iterate the string array using for loop
for val in ${StringArray[@]};

do
    
    
    echo $val
    
    
done