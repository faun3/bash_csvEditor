#!/bin/bash

#code to set the index number of the new entry
    #we use "wc -l" to count the newlines in our file, adding 1 to the number 
    #   returned gives us our index

if [ -f data.csv ]
then
    echo "Vom adauga o noua inregistrare in fisierul date.csv"
    #only get the integer from the "wc -l" command
    lineCount=$(wc -l < data.csv)
    #compute new index
    newEntryIndex=$((lineCount+1))

    while true
    do
        read -p "Introduceti numele: " newEntryName

        # matches 3 or more letters (capital or lowercase)
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

        # copy pasted email regex from stackoverflow
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

    while true
    do
        read -p "Introduceti nota: " newEntryGrade

        #match digits 1-9 OR the string "10"
            #at the start of the string
            #we use () to surround a group so we can use "|" to OR the choices

            # digits 1-9 get matched fully, so does "10"
            # 11 does not get matched even partially
            # -1 does not get matched even partially

            #$ matches no other characters after so something like "1 0" won't trigger a match

        regex="^([1-9]|10)$"

        if [[ $newEntryGrade =~ $regex ]]
        then
            break;
        else
            read -p "Nota introdusa nu este corecta! Apasati 1 pentru a o introduce iar sau orice alta tasta pentru a anula aceasta operatie de adaugare " choice
            if [[ $choice -ne 1 ]]
            then
                exit
            fi
        fi
    done


    #echo endl into file
    echo >> data.csv
    echo -n "$newEntryIndex,$newEntryName,$newEntryEmail,$newEntryGrade" >> data.csv
else
    echo "Fisierul cu date nu exista!"
fi

exit