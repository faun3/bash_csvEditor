#!/bin/bash

if ! [[ -f data.csv ]]; then
    echo "Fisierul cu date nu exista!"
    exit
fi

read -p "Indexul la care vreti sa efectuati stergerea este: " deleteIndex

linePos=$((deleteIndex+1))
linie=$(sed "${linePos}q;d" data.csv)

while true; do
    if [ -n "$linie" ]; then
        echo "Se va sterge urmatoarea linie: "
        echo $linie
        echo
        break 2;
    else
        echo "Acel index nu exista in fisier!"
        lineCount=$(wc -l < data.csv)
        echo "Fisierul are doar ${lineCount-1} inregistrari" 
        read -p "Indexul la care vreti sa efectuati stergerea este: " deleteIndex
        linePos=$((deleteIndex+1))
        linie=$(sed "${linePos}q;d" data.csv)
    fi
done

read -p "Daca doriti sa stergeti PERMANENT aceasta linie din fisier, apasati tasta \"1\", sau orice alta tasta pentru a anula aceasta operatie de stergere: " choice

if [ $choice == 1 ]
then
    if [ -f copy.csv ]
    then
        echo -n "" > copy.csv
    fi

    newID=1

    echo -n "id,name,email,grade" > copy.csv

    {
        read
        # if we don't add this OR condition to our while loop the last line
        #   is never read; read will fail upon reading the last line which
        #   contains no data, however, data is loaded into the "remainingData" variable
        #   so the OR check for it not being null will pass and the last line is read
        while IFS="," read -r id remainingData || [ -n "$remainingData" ]
        do
            if [[ $id != $deleteIndex ]]
            then
                echo >> copy.csv
                echo -n "$newID,$remainingData" >> copy.csv
                newID=$((newID+1))
            fi
        done
    } < data.csv

    mv copy.csv data.csv

    exit
else
    exit
fi

