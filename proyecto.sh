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
	echo " 1) Mostrar archivo pokemones.datos"
	echo " 2) Altas"
	echo " 3) Bajas"
	echo " 4) Consultas"
	echo " 5) Modificaciones"
	echo " 6) Reportes"
	echo " 0) Salir"
	echo -n  " Opcion: "; read opcion
	case $opcion in
	1) mostrar;;
	2) alta;;
	3) baja;;
	4) consulta;;
	esac
}

mostrar(){
	clear
	echo -e "\tMostrando contenido de pokemones.datos\n"
	while IFS= read -r linea
	do
		echo " $linea"
	done < "pokemones.datos"
	echo ""
	read -p " Presiona ENTER para continuar"
}

existe(){
	echo -n " ID pokemon: "; read ID
        registroPokemon=$(awk -F: -v clave="$ID" '($1==clave){print}' pokemones.datos)
}

alta(){
	clear
	echo -e "\tGenerando alta de pokemon\n"
	#preguntamos ID del pokemon que se desea dar de alta para ver si existe
	existe
	#si la funcion existe no guarda nada (vacio) quiere decir que no hay
	#pokemon registrado que coincida con esa clave o ID
	if [ "$registroPokemon" == "" ]
	then
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
		echo "$ID:$nombre:$especie:$altura:$peso:$generacion:$habitat:$habilidad:$ratioCaptura:$HP:$ataque:$defensa:$velocidad" >> pokemones.datos
	else
		echo -e "\n Un pokemon ya fue registrado con ese ID"
	fi
	echo ""
	read -p " Presione ENTER para continuar"
}

baja(){
	clear
	echo -e " \tGenerando baja de pokemon\n"
	echo -n " ID del pokemon que deseas borrar: "; read ID
	#mandamos a un archivo temporal todos aquellos pokemones que no
	#coincidan con el ID del pokemon que se desea borrar
	awk -F: -v clave="$ID" '($1!=clave){print}' pokemones.datos > temporal.datos
	#renombramos el rchivo temporal a nuestro archivo principal
	mv temporal.datos pokemones.datos
	echo ""
	read -p " Presione ENTER para continuar"
}

consulta(){
	clear
	echo -e "\tConsultado datos de pokemon\n"
	#preguntamos si existe
	existe
	#si se guardo algo en registroPokemon quiere decir que hubo
	#una coincidencia entonces mostramos los datos del pokemon
	if [ "$registroPokemon" != "" ]
	then
		echo -e "\n $registroPokemon"
	fi
	echo ""
	read -p " Presiona ENTER para continuar"
}

#codigo main
	opcion
	while [ "$opcion" != "0" ]
	do
		menu
	done
	clear
