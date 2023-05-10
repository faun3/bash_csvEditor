#!/bin/bash
PS3="Alegeti optiunea: "

optiuni=("Creati fisier .csv" "Adauga inregistrare" "Sterge o inregistrare" "Actualizeaza o inregistrare")

while true; do
    select optiune in "${optiuni[@]}" Iesire
    do
        case $REPLY in
            1) echo "Vom crea fisierul csv!"; break;;
            2) echo "Adaugam inregistrarea!"; break;;
            3) echo "Inregistrarea se va sterge permanent!"; break;;
            4) echo "Vom actualiza inregistrarea!"; break;;
            $((${#optiuni[@]}+1))) echo "Ok"; break 2;;
            *) echo "Alegere invalida!"; break;;
        esac
    done
done