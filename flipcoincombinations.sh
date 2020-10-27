#!/bin/bash
read -p "Enter no of times to flip single coin:" n
echo
#no of singlet combinatins = 2^1=2
#they are heads and tails
declare -A occurence_of_singlet=(  [H]=0 [T]=0 )
echo "SINGLET COMBINATIONS"
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
echo "DOUBLET COMBINATIONS"
declare -A occurence_of_doublet=(     [HH]=0 [HT]=0 [TH]=0 [TT]=0 )
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


echo 
echo "TRIPLET COMBINATIONS"

declare -A occurence_of_triplet=(  [HHH]=0 [HHT]=0 [HTH]=0 [THH]=0 [HTT]=0 [THT]=0 [TTH]=0 [TTT]=0 )
for(( flip = 1; flip <= n; flip++ ))
do
    echo -n "Flip-$flip is "
    (( coin_flip_value = RANDOM % 8 ))
    case $coin_flip_value in
        0)
            echo "Heads Heads Heads"
            (( occurence_of_triplet[HHH]++ )) 
            ;;
        1)
            echo "Heads Heads Tails"
            (( occurence_of_triplet[HHT]++ ))
            ;;
        2)
            echo "Heads Tails Heads"
            (( occurence_of_triplet[HTH]++ ))
            ;;
        3)
            echo "Tails Heads Heads"
            (( occurence_of_triplet[THH]++ ))
            ;;
        4)
            echo "Heads Tails Tails"
            (( occurence_of_triplet[HTT]++ )) 
            ;;
        5)
            echo "Tails Heads Tails"
            (( occurence_of_triplet[THT]++ ))
            ;;
        6)
            echo "Tails Tails Heads"
            (( occurence_of_triplet[TTH]++ ))
            ;;
        7)
            echo "Tails Tails Tails"
            (( occurence_of_triplet[TTT]++ ))
            ;;
    esac
done

for combination in ${!occurence_of_triplet[@]}
do
    count=${occurence_of_triplet[$combination]}
    percentage_of_combination=$( echo "$count $n" | awk '{printf "%.2f", $1 * 100 / $2}')
    echo "percentage of $combination combination is $percentage_of_combination"   
done