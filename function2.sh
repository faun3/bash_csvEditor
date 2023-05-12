#!/bin/bash

#code to set the index number of the new entry
    #we use "wc -l" to count the newlines in our file, adding 1 to the number 
    #   returned gives us our index

if [ -f data.csv ]
then
    echo "Vom adauga o noua inregistrare in fisierul date.csv"
    echo
    #only get the integer from the "wc -l" command
    lineCount=$(wc -l < data.csv)
    #compute new index
    newEntryIndex=$((lineCount+1))

    read -p "Introduceti numele: " newEntryName

    read -p "Introduceti email-ul: " newEntryEmail

    read -p "Introduceti nota: " newEntryGrade

    #echo endl into file
    echo >> data.csv
    echo -n "$newEntryIndex,$newEntryName,$newEntryEmail,$newEntryGrade" >> data.csv
else
    echo "Fisierul cu date nu exista!"
fi

exit