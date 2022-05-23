#!/bin/bash

#!/bin/sh

File="./sample/sample1.txt"

sed 's/--//g' "$File"  > RemovedDoubleHyphenText.txt
sed 's/ - //g' "RemovedDoubleHyphenText.txt"  > Findcompound_word.txt


compound=$( cat "Findcompound_word.txt" | sed 's/[?!".,]//g'  | tr ' ' '\n' | sort | grep - | wc -l)

echo compound_word "$compound"


rm  RemovedDoubleHyphenText.txt | rm Findcompound_word.txt
