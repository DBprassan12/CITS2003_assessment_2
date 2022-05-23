#!/bin/bash

File="./sample/sample2.txt"

sed 's/[-?!".,]//g' "$File"  > tempText.txt
WordCount=$(  wc -w  tempText.txt |  cut -d ' ' -f1  )
echo Words "$WordCount"


declare -a StringArray=( "also" "although" "and" "as" "because" "before" "but" "for" "if" "nor" "of" "or" "since" "that" "though"  "until"  "when" "whenever" "whereas" "which"  "while"  "yet" )
for val in ${StringArray[@]};
do
    foundInfiles=$( grep -wo "$val" "tempText.txt" | wc -l )
    echo $val $foundInfiles
done

rm tempText.txt


commas=$(grep -o "," "$File" | wc -l)
echo comma "$commas"

semi_colon=$(grep -o ";" "$File" | wc -l)
echo semi_colon "$semi_colon"


fullStop=$(grep -o "\." "$File" | wc -l )
questionMark=$(grep -oc "?" "$File" )
exclamationMark=$(grep -oc "!" "$File" )

sentences=$(($fullStop + $questionMark + $exclamationMark ))
echo sentences "$sentences"


compound_word=$(grep -E -i -o  "[a-z]'[a-z]+" "$File" | grep -Ev 's' | wc -l)
echo contraction "$compound_word"






