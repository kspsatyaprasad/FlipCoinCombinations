#!/bin/bash
#This function gives the winner of the combinations
get_winner_of_combinations ()
{
    
    local -n keys_of_combinations=$1
    local -n values_of_combinations=$2

    maximum_value=0
    index_of_maximum_value=0
    for(( i = 0; i < ${#values_of_combinations[@]}; i++ ))
    do
        if(( values_of_combinations[i] >= maximum_value ))
        then    
                maximum_value=${values_of_combinations[i]}
                index_of_maximum_value=$i
        fi
    done
    echo " ${keys_of_combinations[$index_of_maximum_value]} combination is winning combination with ${maximum_value}%" 
}

read -p "Enter number of times to flip a combination:" no_of_flips

echo 
echo "SINGLET-COMBINATION"
declare -A occurence_of_singlet=( [H]=0 [T]=0  )
for(( flip = 1; flip <= no_of_flips; flip++ ))
do
    echo -n "Flip-$flip is "
    (( coin = RANDOM % 2 ))
    case $coin in 
        0)
            echo "Heads"
            (( occurence_of_singlet[H]++ ))
            ;;
        1)
            echo "Tails"
            (( occurence_of_singlet[T]++ ))
    esac
done

for combination in ${!occurence_of_singlet[@]}
do
    #update count values_of_combinations  with corresponding percentage_of_combination
    percentage_of_combination=$(( ${occurence_of_singlet[$combination]}  * 100 / no_of_flips ))
    occurence_of_singlet[$combination]=$percentage_of_combination
    echo "percentage of $combination combination is ${occurence_of_singlet[$combination]}%"   
done

echo "DOUBLET-COMBINATION"
declare -A occurence_of_doublet=( [HH]=0 [HT]=0 [TH]=0  [TT]=0  )

for(( flip = 1; flip <= no_of_flips; flip++ ))
do
    echo -n "Flip-$flip is "
    (( coin_1 = RANDOM % 2 ))
    (( coin_2 = RANDOM % 2 ))

    #0 is mapped as heads
    #1 is mappes as tails
    case $coin_1$coin_2 in 
        00)
            echo "Heads Heads"
            (( occurence_of_doublet[HH]++ )) 
            ;;
        01)
            echo "Heads Tails"
            (( occurence_of_doublet[HT]++ ))
            ;;
        10)
            echo "Tails Heads"
            (( occurence_of_doublet[TH]++ ))
            ;;
        11)
            echo "Tails Tails"
            (( occurence_of_doublet[TT]++ ))
            ;;
    esac
done

for combination in ${!occurence_of_doublet[@]}
do
    #update count values_of_combinations  with corresponding percentage_of_combination
    percentage_of_combination=$(( ${occurence_of_doublet[$combination]}  * 100 / no_of_flips ))
    occurence_of_doublet[$combination]=$percentage_of_combination
    echo "percentage of $combination combination is ${occurence_of_doublet[$combination]}%"   
done

echo "TRIPLET-COMBINATION"
declare -A occurence_of_triplet=(   [HHH]=0  [HHT]=0 [HTH]=0 [HTT]=0 [THH]=0 [THT]=0  [TTH]=0  [TTT]=0  )
for(( flip = 1; flip <= no_of_flips; flip++ ))
do
    echo -n "Flip-$flip is "
    (( coin_1 = RANDOM % 2 ))
    (( coin_2 = RANDOM % 2 ))
    (( coin_3 = RANDOM % 2 ))

      case $coin_1$coin_2$coin_3 in 
        000)
            echo "Heads Heads Heads"
            (( occurence_of_triplet[HHH]++ )) 
            ;;
        001)
            echo "Heads Heads Tails"
            (( occurence_of_triplet[HHT]++ ))
            ;;
        010)
            echo "Heads Tails Heads"
            (( occurence_of_triplet[HTH]++ ))
            ;;
        011)
            echo "Heads Tails Tails"
            (( occurence_of_triplet[HTT]++ ))
            ;;
        100)
            echo "Tails Heads Heads"
            (( occurence_of_triplet[THH]++ )) 
            ;;
        101)
            echo "Tails Heads Tails"
            (( occurence_of_triplet[THT]++ ))
            ;;
        110)
            echo "Tails Tails Heads"
            (( occurence_of_triplet[TTH]++ ))
            ;;
        111)
           echo "Tails Tails Tails"
            (( occurence_of_triplet[TTT]++ ))
            ;;
    esac
done
for combination in ${!occurence_of_triplet[@]}
do
    #update count values_of_combinations  with corresponding percentage_of_combination
    percentage_of_combination=$(( ${occurence_of_triplet[$combination]}  * 100 / no_of_flips ))
    occurence_of_triplet[$combination]=$percentage_of_combination
    echo "percentage of $combination combination is ${occurence_of_triplet[$combination]}%"   
done

#extracting keys_of_combinations and values_of_combinations
singlet_combinations=( ${!occurence_of_singlet[@]} )
singlet_combination_percentages=( ${occurence_of_singlet[@]} )

doublet_combinations=( ${!occurence_of_doublet[@]} )
doublet_combination_percentages=( ${occurence_of_doublet[@]} )

triplet_combinations=( ${!occurence_of_triplet[@]} )
triplet_combination_percentages=( ${occurence_of_triplet[@]} )


#appending all 3 arrays and assigning into other array
total_combinations+=( ${singlet_combinations[@]} ${doublet_combinations[@]} ${triplet_combinations[@]} )
total_combination_percentages+=( ${singlet_combination_percentages[@]} ${doublet_combination_percentages[@]} ${triplet_combination_percentages[@]} )




echo  "sorted singlet percentages:"
echo "$( printf "%s\n" "${singlet_combination_percentages[@]}" | sort -n ) "

echo  "sorted doublet percentages:"
echo "$( printf "%s\n" "${doublet_combination_percentages[@]}" | sort -n ) "

echo  "sorted triplet percentages:"
echo "$( printf "%s\n" "${triplet_combination_percentages[@]}" | sort -n ) "

echo "Winner For Singlet Combination"
get_winner_of_combinations singlet_combinations singlet_combination_percentages
echo 
echo "Winner For Doublet Combination"
get_winner_of_combinations doublet_combinations doublet_combination_percentages
echo

echo "Winner For Triplet Combination"
get_winner_of_combinations triplet_combinations triplet_combination_percentages
echo

echo "Winner For All Combinations"
get_winner_of_combinations total_combinations total_combination_percentages
