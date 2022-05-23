#!/bin/bash

for var in "$@"

do
    
    if [[ -f $var ]] 
    then
        FindFileName=$( echo $1 | rev | cut -d '.' -f2 | cut -d '/' -f1 | rev)
        NewprofileName=$(echo "$FindFileName"_profile.txt)
        File="$1"


MakeProfile=$(
    
sed 's/[-?!".,]//g' "$File"  > tempText.txt
sed 's/--//g' "$File"  > RemovedDoubleHyphenText.txt
sed 's/ - //g' "RemovedDoubleHyphenText.txt"  > Findcompound_word.txt


declare -a StringArray=( "also" "although" "and" "as" "because" "before" "but" "for" "if" "nor" "of" "or" "since" "that" "though"  "until"  "when" "whenever" "whereas" "which"  "while"  "yet" )
for val in ${StringArray[@]};
do
    foundInfiles=$( grep -wo "$val" "tempText.txt" | wc -l )
    echo $val $foundInfiles
done

fullStop=$(grep -o "\." "$File" | wc -l )
questionMark=$(grep -oc "?" "$File" )
exclamationMark=$(grep -oc "!" "$File" )

sentences=$(($fullStop + $questionMark + $exclamationMark ))
echo sentences "$sentences"


commas=$(grep -o "," "$File" | wc -l)
echo comma "$commas"

semi_colon=$(grep -o ";" "$File" | wc -l)
echo semi_colon "$semi_colon"

contraction=$(grep -E -i -o  "[a-z]'[a-z]+" "$File" | grep -Ev 's' | wc -l)
echo contraction "$contraction"

WordCount=$(  wc -w  tempText.txt |  cut -d ' ' -f1  )
echo Words "$WordCount"

compound=$( cat "Findcompound_word.txt" | sed 's/[?!".,]//g'  | tr ' ' '\n' | sort | grep - | wc -l)
echo compound_word "$compound"


rm RemovedDoubleHyphenText.txt | rm Findcompound_word.txt | rm tempText.txt
)




if (( $# < 2 )); then

      echo "$MakeProfile" |sort > "$NewprofileName"

fi



  

fi





done











































