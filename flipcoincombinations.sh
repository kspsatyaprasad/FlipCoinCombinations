#!/bin/bash
read -p "Enter no of times to flip single coin:" n
echo
#no of singlet combinatins = 2^1=2
#they are heads and tails
declare -A occurence_of_singlet=(  [H]=0 [T]=0 )
echo "SINGLET COMBINATION"
for(( flip = 1; flip <= n; flip++ ))
do
    echo -n "Flip-$flip is "
    (( coin_flip_value = RANDOM % 2 ))
    if(( coin_flip_value == 0 ))
    then
        echo "Heads"
        (( occurence_of_singlet[H]++  ))
    else
        echo "Tails"
        (( occurence_of_singlet[T]++  ))
    fi
done


for combination in ${!occurence_of_singlet[@]}
do
    count=${occurence_of_singlet[$combination]}
    percentage_of_combination=$( echo "$count $n" | awk '{printf "%.2f", $1 * 100 / $2}')
    echo "percentage of $combination combination is $percentage_of_combination"   
done

echo 
echo "DOUBLET COMBINATION"
declare -A occurence_of_doublet=( [HH]=0 [HT]=0 [TH]=0 [TT]=0 )
for(( flip = 1; flip <= n; flip++ ))
do
    echo -n "Flip-$flip is "
    (( coin_flip_value = RANDOM % 4 ))
    case $coin_flip_value in
        0)
            echo "Heads Heads"
            (( occurence_of_doublet[HH]++ )) 
            ;;
        1)
            echo "Heads Tails"
            (( occurence_of_doublet[HT]++ ))
            ;;
        2)
            echo "Tails Heads"
            (( occurence_of_doublet[TH]++ ))
            ;;
        3)
            echo "Tails Tails"
            (( occurence_of_doublet[TT]++ ))
            ;;
    esac
done

for combination in ${!occurence_of_doublet[@]}
do
    count=${occurence_of_doublet[$combination]}
    percentage_of_combination=$( echo "$count $n" | awk '{printf "%.2f", $1 * 100 / $2}')
    echo "percentage of $combination combination is $percentage_of_combination"   
done