#!/bin/bash

if ! [[ -f data.csv ]]; then
    echo "Fisierul cu date nu exista!"
    exit
fi

maxLines=$(wc -l < data.csv)
regex='^[0-9]+$'

read -p "Introduceti numarul de elevi: " lineNumber

while true; do
    if ! [[ $lineNumber =~ $regex ]]; then
        read -p "Valoarea introdusa nu pare sa fie un numar intreg. Apasati 1 pentru a introduce alta valoare sau orice alta tasta pentru a anula aceasta operatie de extragere: " choice
        if [[ $choice == 1 ]]; then
            read -p "Introduceti numarul de elevi: " lineNumber
        else
            break 2;
            exit
        fi
    else
        if [[ $lineNumber -gt $maxLines ]]; then
            read -p "Numarul introdus este mai mare decat numarul de inregistrari din fisier (${maxLines}). Apasati 1 pentru a introduce alta valoare sau orice alta tasta pentru a anula aceasta operatie de extragere: " choice
            if [[ $choice == 1 ]]; then
                read -p "Introduceti numarul de elevi: " lineNumber
            else
                break 2;
                exit
            fi
        else
            #t sets the separator to a comma
            #the k argument specifies the column which we want to sort by
            #the n argument specifies that the sort is numeric
                #bonus: numeric sorting will leave the header row untouched
            #the r argument reverses the sorting order
                #this will move the header to the bottom, but we only want the first n rows anyway
            sort -t"," -k4 -n -r data.csv | head  -n $lineNumber
            break 2;
        fi
    fi  
done

exit