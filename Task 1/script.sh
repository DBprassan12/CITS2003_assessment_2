#!/bin/bash

File="./sample/sample2.txt"


declare -a StringArray=( "also" "although" "and" "as" "because" "before" "but" "for" "if" "nor" "of" "or" "since" "that" "though"  "until"  "when" "whenever" "whereas" "which"  "while"  "yet" )

# Iterate the string array using for loop


for val in ${StringArray[@]};

do
    foundInfiles=$(grep -ow "$val" "$File" | wc -l)
    echo $val $foundInfiles
    
done



WordCount=$( wc -w $File |  cut -d ' ' -f1   )
echo Words "$WordCount"

commas=$(grep -o "," "$File" | wc -l)
echo comma "$commas"

Semicolon=$(grep -o ";" "$File" | wc -l)
echo Semi_colon "$Semicolon"

sentence=$(grep -ow "." "$File" | wc -l)
echo sentence "$sentence"















