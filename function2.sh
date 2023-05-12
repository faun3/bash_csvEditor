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

    while true
    do
        read -p "Introduceti numele: " newEntryName

        regex="[a-zA-Z]{3,}"

        if [[  $newEntryName =~ $regex ]]
        then
            break;
        else
            read -p "Numele introdus nu pare corect! Apasati 1 pentru a-l introduce iar sau orice alta tasta pentru a anula aceasta operatie de adaugare. (Numele pot contine doar litere mici si mari): " choice
            if [[ $choice -ne 1 ]]
            then
                exit
            fi
        fi
    done

    while true
    do
        read -p "Introduceti email-ul: " newEntryEmail

        regex="^[a-z0-9!#\$%&'*+/=?^_\`{|}~-]+(\.[a-z0-9!#$%&'*+/=?^_\`{|}~-]+)*@([a-z0-9]([a-z0-9-]*[a-z0-9])?\.)+[a-z0-9]([a-z0-9-]*[a-z0-9])?\$"

        if [[ $newEntryEmail =~ $regex ]]
        then
            break;
        else
            read -p "Adresa de email introdusa nu pare a fi corecta! Apasati 1 pentru a o introduce iar sau orice alta tasta pentru a anula aceasta operatie de adaugare " choice
            if [[ $choice -ne 1 ]]
            then
                exit
            fi
        fi
    done

    read -p "Introduceti nota: " newEntryGrade

    #echo endl into file
    echo >> data.csv
    echo -n "$newEntryIndex,$newEntryName,$newEntryEmail,$newEntryGrade" >> data.csv
else
    echo "Fisierul cu date nu exista!"
fi

exit