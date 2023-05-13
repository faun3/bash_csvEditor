#!/bin/bash

#PS3 variable is the select prompt variable
PS3="Alegeti optiunea: "

#array of options -- exit is included in the select loop
optiuni=("Creati fisier .csv" "Adauga inregistrare" "Sterge o inregistrare" "Actualizeaza o inregistrare" "Afiseaza n elevi cu cele mai mari note")

#loop forever
while true; do
    echo
    #selects from the array of options and an extra quit option
    select optiune in "${optiuni[@]}" Iesire
    do
        #select auto updates the variable REPLY into what the user inputs
        case $REPLY in
            1)
            /bin/bash ./function1.sh 
            echo;
            break;;
            2) echo "Adaugam inregistrarea!";
            /bin/bash ./function2.sh
            echo;
            break;;
            3) echo "Inregistrarea se va sterge permanent!";
            /bin/bash ./function3.sh
            echo;
            break;;
            4) echo "Vom actualiza inregistrarea!"; 
            echo;
            break;;
            5)
            echo;
            /bin/bash ./function5.sh
            break;;
            #exit option is always last so its number is the length of our array + 1
            $((${#optiuni[@]}+1))) echo "Gata"; 
            #break twice so we exit both the select loop and the while true loop
            break 2;;
            *) echo "Alegere invalida!"; 
            echo;
            break;;
        esac
    done
done