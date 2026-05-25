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
	5) modificar;;
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
        registroPokemon=$(awk -F: -v clave="$1" '$1==clave{print $0}' pokemones.datos)
}

alta(){
	clear
	echo -e "\tGenerando alta de pokemon\n"
	echo -n " Id: "; read ID
	#preguntamos ID del pokemon que se desea dar de alta para ver si existe
	existe "$ID"
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
		echo -n " HP :" read HP		
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

modificar(){
	echo -n "ID: "; read Id
	existe "$Id"
	if test "$registroPokemon" != ""
	then #modificar
		echo -n " Nombre del pokemon: "; read nombre
                echo -n " Especie: "; read especie
                echo -n " Altura: "; read altura
                echo -n " Peso: "; read peso
                echo -n " Generacion: "; read generacion
                echo -n " Habitat: "; read habitat
                echo -n " Habilidad: "; read habilidad
                echo -n " Ratio de captura: "; read ratioCaptura
                echo -n " HP :"; read HP         
                echo -n " Ataque: "; read ataque
                echo -n " Defensa: "; read defensa
                echo -n " Velocidad: "; read velocidad

	awk -F: -v llave="$Id" -v nom=$"$nombre" -v esp="$especie"\
	        -v alt="$altura" -v pes="$peso" -v gen="$generacion"\
                -v  habit="$habitat" -v habil="$habilidad"\
                -v ratio="$ratioCaptura" -v vida="$HP" -v ataq="$ataque"\
                -v def="$defensa" -v vel="$velocidad" '
	 ($1==llave){
	  if(nom==""){nom=$2}
	  if(esp==""){esp=$3}
          if(alt==""){alt=$4}
          if(pes==""){pes=$5}
          if(gen==""){gen=$6}
          if(habit==""){habit=$7}
          if(habil==""){habil=$8}
          if(ratio==""){ratio=$9}
          if(vida==""){vida=$10}
          if(ataq==""){ataq=$11}
          if(def==""){def=$12}
          if(vel==""){vel=$13}
          print llave " : " nom " : " esp " : " alt " : " pes " : " gen " : " habit " : " habil " : " ratio " : " vida " : " ataq " : " def " : " vel 
	}
	($1!=llave){print}
	' pokemones.datos > temporal.datos
	mv temporal.datos pokemones.datos
	echo -e "Pokemon modificado con exito!"
	else
	echo -e "El registro pokemon no existe!"
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
	echo -n " Id: "; read Id
	#preguntamos si existe
	existe "$Id"
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
