#!/bin/bash

mkdir tempFolder


for var in "$@"

do

    if [[ -f $var ]]

    then
        FindFileName=$( echo $var | rev | cut -d '.' -f2 | cut -d '/' -f1 | rev)
        NewprofileName=$(echo "$FindFileName"_profile.txt)
        File="$var"

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


if (( $# == 1 )); then
      echo "$MakeProfile" |sort > "$NewprofileName"
      rm -rf tempFolder


elif (( $# == 2 )); then
      echo "$MakeProfile" |sort > ./tempFolder/"$NewprofileName"
else echo incorrect input

fi

fi

done

if (( $# == 2 ));

then

    profile_Files="./tempFolder/*.txt"

    for file in $profile_Files

    do
        WordCount=$(awk ' NR==27 {print $2}' $file)

        RemoveSentenceandWord=$( awk 'NR!=17 && NR!=27 {print}' $file)
        echo "$RemoveSentenceandWord" > "$file"-n.txt

        Norm=$( awk -v c="$WordCount" '{print $1 , $2/c*100}' "$file"-n.txt )
        echo "$Norm" > "$file"-n.txt

        SentenceNorm=$(awk -v c="$WordCount" ' NR==17 {print $1 , c/$2}' $file)
        echo "$SentenceNorm" >> "$file"-n.txt

        sort $file-n.txt > "$file"N.txt
        rm "$file" | rm $file-n.txt

    done









    TextFile=$(for file in $profile_Files;do echo $file ;done)
        
    FindFileName=$(for file in $profile_Files; do echo  $file | rev | cut -d '.' -f1-10 | cut -d '/' -f1-10 | rev  ; done)
        
    echo "$NewFileName"






    merge=$( awk 'FNR==NR{a[$1]=$2 FS $3;next}{ print $0, a[$1]}' $TextFile )

    echo "$merge" > "final.txt"

    ff=$(awk '{ print $1 , $4=($3*$3)-($2-$2)}' final.txt )
    echo "$ff" > "final.txt"
    
    ff=$(awk '{ print $1 , $2=sqrt($2)}' final.txt )
    echo "$ff" > "final.txt"


    ss=$(awk '{ sum+=$2} END {print sum/27}' final.txt)
    echo The Euclidian Distance between the two texts is: "$ss" >> "final.txt"



rm -rf tempFolder

fi

