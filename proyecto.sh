#!/bin/bash
#Modulo:
#Objetivo:
#Version: 1
#Autor:
#	Duron Mendoza Antonio
#	Lopez Acevedo Tania Jaquelin
#	Raygoza Castaleda Ulises
#	Vazquez Delgado Cristian de Jesus
#Modo de uso:

menu(){
	clear
	echo -e "\tMenu principal\n"
	echo " 1) Altas"
	echo " 2) Bajas"
	echo " 3) Consultas"
	echo " 4) Modificaciones"
	echo " 5) Reportes"
	echo " 0) Salir"
	echo -n  " Opcion: "; read opcion
	case $opcion in
	1) alta;;
	esac
}

alta(){
	clear
	echo -e "\tGenerando alta de pokemon\n"
	echo -n " Nombre del pokemon: "; read nombre
	echo -n " Especie: "; read especie
	echo -n " Altura: "; read altura
	echo -n " Peso: "; read peso
	echo -n " Generacion: "; read generacion
	echo -n " Habitat: "; read habitat
	echo -n " Habilidad: "; read habilidad
	echo -n " Ratio de captura: "; read ratioCaptura
	echo -n " HP: "; read HP
	echo -n " Ataque: "; read ataque
	echo -n " Defensa: "; read defensa
	echo -n " Velocidad: "; read velocidad
}

#codigo main
	opcion
	while [ "$opcion" != "0" ]
	do
		menu
	done
	clear
