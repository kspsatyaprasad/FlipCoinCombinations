#!/bin/bash
read -p "Enter no of coin flips:" n
#no of singlet combinations = 2^1=2
#they are heads and tails
declare -A occurence_of_singlet=( [heads]=0 [tails]=0 )
for(( flip = 1; flip <= n; flip++ ))
do
    echo -n "Flip-$flip is "
    (( coin_flip_value = RANDOM % 2 ))
    if(( coin_flip_value == 0 ))
    then
        echo "Heads"
        (( occurence_of_singlet[heads]++  ))
    else
        echo "Tails"
        (( occurence_of_singlet[tails]++  ))
    fi
done

for combination in ${!occurence_of_singlet[@]}
do
    count=${occurence_of_singlet[$combination]}
    percentage_of_combination=$( echo "$count $n" | awk '{printf "%.2f", $1 * 100 / $2}')
    echo "percentage of $combination combination  is $percentage_of_combination"   
done