#!/bin/bash
coin_flip_value=$(( RANDOM % 2 ))
if(( coin_flip_value == 0 ))
then
    echo "Heads"
else
    echo "Tails"
fi