#!/bin/bash


read -p "Indexul la care vreti sa efectuati stergerea este: " deleteIndex

if [ -f copy.csv ]
then
    echo -n "" > copy.csv
do

echo -n "id,name,email,grade" > copy.csv

while IFS="," read -r id remainingData
do
    if [[ $id -ne $deleteIndex ]]
    then
        echo
        echo -n "$id,$remainingData" >> copy.csv
    done

    newIndex=$deleteIndex

    echo
    echo -n "$newIndex,$remainingData" >> copy.csv
done

exit