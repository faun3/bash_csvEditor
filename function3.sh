#!/bin/bash


read -p "Indexul la care vreti sa efectuati stergerea este: " deleteIndex

if [ -f copy.csv ]
then
    echo -n "" > copy.csv
fi

newID=1

echo -n "id,name,email,grade" > copy.csv

{
    read
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