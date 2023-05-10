#!/bin/bash
PS3="Alegeti optiunea: "

optiuni=("Creati fisier .csv" "Adauga inregistrare" "Sterge o inregistrare" "Actualizeaza o inregistrare")

select optiune in "${optiuni[@]}" Iesire
do
    case $REPLY in
        1) echo "Vom crea fisierul csv!";;
        2) echo "Adaugam inregistrarea!";;
        3) echo "Inregistrarea se va sterge permanent!";;
        4) echo "Vom actualiza inregistrarea!";;
        $((${#optiuni[@]}+1))) echo "Ok"; break;;
        *) echo "Alegere invalida!";;
    esac
done