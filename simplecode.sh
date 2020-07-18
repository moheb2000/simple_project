#!/bin/bash

numberOfLines=`wc -l $1 | tr -dc '0-9'`
# this loop create two arrays for numbers and characters
for (( i=0; i<$numberOfLines; i=i+1 )); do
    declare -a numberList
    numberList+=(`head -n $(( i+1 )) $1 | tail -1 | tr -dc '0-9'`)
    declare -a characterList
    characterList+=(`head -n $(( i+1 )) $1 | tail -1 | tr -dc 'a-z'`)
done
uniqueNumberList=($(echo "${numberList[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' ')) # this create an array from unique numbers in lines
create_line(){
# this loop create a list from index of a unique number in numberList
    for i in "${!numberList[@]}"; do
        if [[ "${numberList[$i]}" -eq $1 ]]; then
            declare -a myList
            myList+=(${i});
        fi
    done
# this loop create a line contain characters
    generatedLine=""
    for j in "${myList[@]}"; do
        generatedLine+="${characterList[$j]} "
    done
}
# this loop create output value
for k in "${uniqueNumberList[@]}"; do
create_line $k
echo "$generatedLine$k"
done
