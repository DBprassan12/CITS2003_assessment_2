profile_Files="./tempFolder/*.txt"


FindFileName=$(
    for file in $profile_Files;
    do echo  $file  | rev | cut -d '.' -f3 | cut -d '/' -f1 | cut -d '_' -f2-3 |rev ;
    done
)

echo "$FindFileName"




