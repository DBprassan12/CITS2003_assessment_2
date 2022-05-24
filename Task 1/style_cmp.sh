#!/bin/bash


# Divij Bhaw
# 23183845@student.uwa.edu.au
# Assignment 2 2022 class CITS2003
# TASK ONE


mkdir tempFolder
#Creating A folder to keep Things clean


# ***** START OF SUB-SCRIPTS ONE MAKE PROFILE *************************
for var in "$@"
#Interrailing through the arguments using a For Loop

do

    if [[ -f $var ]]
    #Check if the argument is a File 

    then
        FindFileName=$( echo $var | rev | cut -d '.' -f2 | cut -d '/' -f1 | rev)
        NewprofileName=$(echo "$FindFileName"-profile.txt)
        File="$var"
        #Finding Filename and creating Profile name.

        MakeProfile=$(
        #MakeProfile is a script will be used to Call Finding. Added into a  Variable to make it easier to call it 

            sed 's/[-?!".,]//g' "$File"  > tempText.txt
            sed 's/--//g' "$File"  > RemovedDoubleHyphenText.txt
            sed 's/ - //g' "RemovedDoubleHyphenText.txt"  > Findcompound_word.txt
            #Cleaning up file and removing unnecessary characters

            declare -a StringArray=( "also" "although" "and" "as" "because" "before" "but" "for" "if" "nor" "of" "or" "since" "that" "though"  "until"  "when" "whenever" "whereas" "which"  "while"  "yet" )
            #Word List array to find conjunctions

            #Interrailing through the array to find conjunctions count 
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
            #Finding full-stop, question-mark or exclamation mark that is used to end a sentence

            commas=$(grep -o "," "$File" | wc -l)
            echo comma "$commas"
            #Finding commas

            semi_colon=$(grep -o ";" "$File" | wc -l)
            echo semi_colon "$semi_colon"
            #Finding semi_colon

            contraction=$(grep -E -i -o  "[a-z]'[a-z]+" "$File" | grep -Ev 's' | wc -l)
            echo contraction "$contraction"
            #Finding contraction , Used regex to grep for contraction  and exclude possessive using grep -Ev           

            WordCount=$(  wc -w  tempText.txt |  cut -d ' ' -f1  )
            echo Words "$WordCount"
            #Finding WordCount

            compound=$( cat "Findcompound_word.txt" | sed 's/[?!".,]//g'  | tr ' ' '\n' | sort | grep - | wc -l)
            echo compound_word "$compound"
            #Finding compound_word , Used Sed to Remove unnecessary characters and grep all words with compund words , counted each line 

            rm RemovedDoubleHyphenText.txt | rm Findcompound_word.txt | rm tempText.txt
            #Removing files used for Sorting 
        )

if (($# == 1)) && [[ -f "$1" ]] ;
#Check if argument length is 1 and check if argument is a file 

then
      echo "$MakeProfile" |sort > "$NewprofileName"
      rm -rf tempFolder
      #Output findings from MakeProfile Script int a File Profile text file.
      #Remove tempFolder 

elif (($# == 2)) && [[ -f "$1" ]] && [[ -f "$2" ]]  ;  
#Check if argument length is 2 and check if the arguments are files 

then
      echo "$MakeProfile" |sort > ./tempFolder/"$NewprofileName"
      #Create Temp Folder for storing Normalised Profiles 
      #Output findings from MakeProfile Script int a File Profile text file for both files

else echo Invalid Input 
#Error handling 

fi

fi

done
# ***** END OF SUB-SCRIPTS ONE MAKE PROFILE *************************


# ***** START OF SUB-SCRIPTS TWO NORMALISED PROFILES AND FINAL EUCLIDIAN DISTANCE SCRIPT *************************
if (($# == 2)) && [[ -f "$1" ]] && [[ -f "$2" ]]   ;  
#Check if argument length is 2 and check if the arguments are files 


then

    profile_Files="./tempFolder/*.txt"
    #Specifying tempFolder

    for file in $profile_Files
    #Interrailing through the Files using a For Loop in tempFolder

    do
        WordCount=$(awk ' NR==27 {print $2}' $file)
        #Finding WordCount on Line 27 and Set as Variable 

        RemoveSentenceandWord=$( awk 'NR!=17 && NR!=27 {print}' $file)
        echo "$RemoveSentenceandWord" > "$file"-n.txt
        #Find WordCount on Line 27 and Sentenceand  on Line 17 and Remove from text
        #copy to "$file"-n.txt

        Norm=$( awk -v c="$WordCount" '{print $1 , $2/c*1000}' "$file"-n.txt )
        echo "$Norm" > "$file"-n.txt
        #Print First column print $1
        #Print second column (print $2) times Word Count of File and multiplying by 1,000
        #copy to "$file"-n.txt

        SentenceNorm=$(awk -v c="$WordCount" ' NR==17 {print $1 , c/$2}' $file)
        echo "$SentenceNorm" >> "$file"-n.txt
        #Print First column print $1 from Line 27 from original text file 
        #Print second column (print $2) times Word Count of File and divide by sentence Count
        #Append to "$file"-n.txt (>>)

        rm "$file" 
        sort $file-n.txt > "$file" 
        rm $file-n.txt
        #Clean Up Files used for Sorting 

    done


    TextFile=$(for file in $profile_Files;do echo $file ;done)
    #Interrailing through temp file and Creating 1 string with both file names ( will be used for AWK search )

    FIleName=$(for file in $profile_Files; do echo $file | rev | cut -d '.' -f2 | cut -d '/' -f1 | cut -d '-' -f2| rev; done )
    #Finding Filename and creating Profile name.( will be used for Naming Normalised Profile )

    NewFile=$(echo  $FIleName | tr -d " ")
    #Remove Space

    mergeFiles=$( awk 'FNR==NR{a[$1]=$2 FS $3;next}{ print $0, a[$1]}' $TextFile )
    echo "$mergeFiles" > "$NewFile".txt
    #Keep the First column and Merging column 2 from the two files as a new third collum 
    #copy to ""$NewFile".txt

    SquareFunction=$(awk '{ print $1 , $4=($3*$3)-($2-$2) }' "$NewFile".txt )
    echo "$SquareFunction" > "$NewFile".txt
    #create a 4th collum from squaring values in second and third columns 
    #copy to ""$NewFile".txt as two collum

    SqaureRootFunction=$(awk '{ print $1 , $2=sqrt($2)}' "$NewFile".txt   )
    echo "$SqaureRootFunction" > "$NewFile".txt
    #Square root Second Collum of normalised numbers 
    #copy to ""$NewFile".txt 

    Euclidian=$(awk '{ sum+=$2} END {print sum/27}' "$NewFile".txt  )
    echo The Euclidian Distance between the two texts is: "$Euclidian" >> "$NewFile".txt
    #add all normalized numbers and divide by 27 counts because excluding word count 
    #copy to ""$NewFile".txt 

elif (($# == 1)) && [[ ! -f "$1" ]] ;  then echo Invalid Input  
#Error handling 

elif (($# == 2)) && [[ ! -f "$1" ]] && [[ ! -f "$2" ]]  ;   then echo Invalid Input  
#Error handling 

fi

# ***** END OF SUB-SCRIPTS TWO NORMALISED PROFILES AND FINAL EUCLIDIAN DISTANCE SCRIPT *************************

rm -rf tempFolder

# Remove Temp File 