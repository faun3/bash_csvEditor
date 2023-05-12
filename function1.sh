#!/bin/bash
if [ -f data.csv ]
then
    echo
    echo "Fisierul .csv va fi recreat daca apasati 1!"
    read -p 'Vreti sa rescrieti continutul fisierului? Apasati 1 pentru confirmare sau orice alta tasta pentru a refuza. ' choice
    while true
    do
        case $choice in
            1)
                #we echo without the trailing endl ("-n") to maintain csv line integrity
                echo -n 'id,name,email,grade' > data.csv;
                echo
                echo 'Fisierul a fost recreat (contine doar capul de tabel) '
                break 2;;
            *)
                break 2;;
        esac
    done
else
    echo
    echo -n 'id,name,email,grade' > data.csv;
    echo "Am creat fisierul .csv; ";

fi

exit