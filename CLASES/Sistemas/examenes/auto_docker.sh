#!/bin/bash
echo "-------------------------------------------------"
echo "-----------------AUTODOCKER----------------------"
echo "-------------------------------------------------"
echo "-------------QUE QUIERES HACER?------------------"
echo "---1-LANZAR CONTENEDORES 2-CERRAR CONTENEDORES---"
read menu1
case $menu1 in
1)
    echo "-------------------------------------------------"
    echo "-----CUANTOS CONTENEDORES DESEA LANZAR?----------"
    echo "-------------------------------------------------"
    read many

    for i in $many
    echo $i