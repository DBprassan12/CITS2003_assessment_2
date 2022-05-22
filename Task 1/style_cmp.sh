#!/bin/bash

File="./sample/sample2.txt"



WordCount=$(  wc -w  "$File" |  cut -d ' ' -f1  )
echo Words "$WordCount"

echo  "++++++++++++++++++++++++++++++++++++++++"


## works

commas=$(grep -o "," "$File" | wc -l)
echo comma "$commas"

semi_colon=$(grep -o ";" "$File" | wc -l)
echo semi_colon "$semi_colon"

fullStop=$(grep -o "\." "$File" | wc -l  )
questionMark=$(grep -oc "\?" "$File" )
exclamationMark=$(grep -oc "\!" "$File" )


sentences=$(($fullStop + $questionMark + $exclamationMark ))
echo sentences "$sentences"


echo  "++++++++++++++++++++++++++++++++++++++++"


declare -a StringArray=( "also" "although" "and" "as" "because" "before" "but" "for" "if" "nor" "of" "or" "since" "that" "though"  "until"  "when" "whenever" "whereas" "which"  "while"  "yet" )

for val in ${StringArray[@]};

do
    foundInfiles=$( grep -wo "$val" $File | wc -l )
    echo $val $foundInfiles
done



















