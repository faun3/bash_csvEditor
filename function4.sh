#!/bin/bash

maxLines=$(wc -l < data.csv)
regex='^[0-9]+$'

read -p "Introduceti indexul unde vreti sa efectuati modifcarea: " lineNumber

while true; do
    if ! [[ $lineNumber =~ $regex ]]; then
        read -p "Valoarea introdusa nu pare sa fie un numar intreg. Apasati 1 pentru a introduce alta valoare sau orice alta tasta pentru a anula aceasta operatie de extragere: " choice
        if [[ $choice == 1 ]]; then
            read -p "Introduceti indexul inregistratii pe care doriti sa o modificati: " lineNumber
        else
            break 2;
            exit
        fi
    else
        if [[ $lineNumber -gt $maxLines ]]; then
            read -p "Numarul introdus este mai mare decat numarul de inregistrari din fisier (${maxLines}). Apasati 1 pentru a introduce alta valoare sau orice alta tasta pentru a anula aceasta operatie de modificare: " choice
            if [[ $choice == 1 ]]; then
                read -p "Introduceti indexul unde vreti sa efectuati modificarea: " lineNumber
            else
                break 2;
                exit
            fi
        else
            linePos=$((lineNumber+1))
            linie=$(sed "${linePos}q;d" data.csv)
            echo "Linia pe care urmeaza sa o modificati este: $linie"
            read -p "Apasati 1 pentru a incepe modifcarea sau orice alta tasta pentru a anula aceasta operatie de modificare: " choice
            if [[ $choice == 1 ]]; then
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

                        while true
                            do
                                read -p "Introduceti nota: " newEntryGrade

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
                            
                            index=$((linePos-1))
                            {
                                # -F for setting field separator to comma
                                # -v sets variables for use inside of our awk command
                                awk -F ',' -v OFS=',' -v ind=$index -v name=$newEntryName -v email=$newEntryEmail -v grade=$newEntryGrade '
                                {
                                    
                                    if (ind == $1) 
                                    {
                                        $2 = name; 
                                        $3 = email; 
                                        $4 = grade; 
                                        print $1,name,email,grade
                                    } 
                                    else 
                                    {
                                        print $1,$2,$3,$4
                                    }
                                }
                                ' data.csv > copy.csv
                                mv copy.csv data.csv
                                # -c prints the leading number of bytes in the file;
                                #   passing -1 means we print the whole file except the last one byte (a newline added by awk)
                                head -c -1 data.csv > copy.csv
                                mv copy.csv data.csv
                            }
            else
                exit
            fi
            break 2;
        fi
    fi  
done

exit