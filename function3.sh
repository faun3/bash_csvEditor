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