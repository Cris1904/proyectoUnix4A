#!/bin/bash
#Modulo: scrip principal que contiene la logica para el control de altas, bajas, cambios, consultas y reportes.
#Objetivo:
#Version: 1.6 (beta)
#Autor:
#	Duron Mendoza Antonio
#	Lopez Acevedo Tania Jaquelin
#	Raygoza Castaleda Ulises
#	Vazquez Delgado Cristian de Jesus
#Modo de uso:

#Crea un archivo bandera para bloquear el acceso y evitar que otros modifiquen los datos al mismo tiempo.
bloqueo(){
    while [ -f bloquear.pokemones ]
    do
        sleep 5
    done
    touch bloquear.pokemones
}

#Elimina el archivo bandera para liberar el acceso a la base de datos a los demas.
desbloqueo(){
    rm bloquear.pokemones
}

#Muestra las opciones principales del sistema y ejecuta la funcion que el usuario seleccione.
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
	6) reporte;;
	esac
}

#Lee linea por linea el archivo de datos y lo imprime directamente en la terminal.
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

#Busca un ID especifico en el archivo para comprobar si ese pokemon ya existe en la base.
existe(){
        registroPokemon=$(awk -F: -v clave="$1" '$1==clave{print $0}' pokemones.datos)
}

#Solicita todos los datos de un pokemon nuevo, valida que el ID no exista y lo agrega al archivo protegido.
alta(){
	clear
	echo -e "\tGenerando alta de pokemon\n"
	bloqueo
	echo -n " ID: "; read ID
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
		echo -n " HP :"; read HP
		echo -n " Ataque: "; read ataque
		echo -n " Defensa: "; read defensa
		echo -n " Velocidad: "; read velocidad
		echo "$ID:$nombre:$especie:$altura:$peso:$generacion:$habitat:$habilidad:$ratioCaptura:$HP:$ataque:$defensa:$velocidad" >> pokemones.datos
	else
		echo -e "\n Un pokemon ya fue registrado con ese ID"
	fi
	desbloqueo
	echo ""
	read -p " Presione ENTER para continuar"
}

#Despliega un submenu para elegir que campo especifico se desea cambiar.
menuModificar(){
	clear
        echo -e "\tSelecciona campo a modificar\n"
        echo " 1) Nombre del pokemon"
        echo " 2) Especie"
        echo " 3) Altura"
        echo " 4) Peso"
        echo " 5) Generacion"
        echo " 6) Habitat"
        echo " 7) Habilidad"
        echo " 8) Ratio de captura"
        echo " 9) HP"
        echo " 10) Ataque"
        echo " 11) Defensa"
        echo " 12) Velocidad"
        echo " 13) Cancelar"
	echo -n " Opcion: "; read opcion
        case $opcion in
        1) echo -en "\n Nuevo nombre del pokemon: "; read nombre; vacioModificar "$nombre";;
       	2) echo -en "\n Nueva especie: "; read especie; vacioModificar "$especie";;
        3) echo -en "\n Nueva altura: "; read altura; vacioModificar "$altura";;
	4) echo -en "\n Nuevo peso: "; read peso; vacioModificar "$peso";;
	5) echo -en "\n Nueva generacion: "; read generacion; vacioModificar "$generacion";;
	6) echo -en "\n Nueva habitat: "; read habitat; vacioModificar "$habitat";;
	7) echo -en "\n Nueva habilidad: "; read habilidad; vacioModificar "$habilidad";;
        8) echo -en "\n Nuevo ratio de captura: "; read ratioCaptura; vacioModificar "$ratioCaptura";;
        9) echo -en "\n Nuevo HP :"; read HP; vacioModificar "$HP";;
        10) echo -en "\n Nuevo ataque: "; read ataque; vacioModificar "$ataque";;
        11) echo -en "\n Nueva defensa: "; read defensa; vacioModificar "$defensa";;
        12) echo -en "\n Nueva velocidad: "; read velocidad; vacioModificar "$velocidad";;
        13|*) echo "" #no ejecuta ninguna accion;;
        esac
}

#Revisa que el nuevo dato ingresado no este vacio antes de proceder a guardarlo.
vacioModificar(){
	if [ "$1" != "" ]
        then
        	guardarModif
        	echo -e "\n Se modifico el campo del pokemon\n"
        else
       		echo -e "\n Dejaste vacio, no se modifico\n"
        fi
}

#Sobrescribe el archivo de datos actualizando solo el campo que el usuario eligio modificar.
guardarModif(){
	bloqueo
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
          print llave ":" nom ":" esp ":" alt ":" pes ":" gen ":" habit ":" habil ":" ratio ":" vida ":" ataq ":" def ":" vel 
        }
        ($1!=llave){print}
        ' pokemones.datos > temporal.datos
        mv temporal.datos pokemones.datos
	desbloqueo
}

#Solicita el ID a editar, valida su existencia y arranca el proceso de modificacion.
modificar(){
	clear
	echo -e "\tGenerar modificacion a un Pokemon\n"
	echo -n " ID: "; read Id
	existe "$Id"
	if test "$registroPokemon" != ""
	then #modificamos con un menu de opciones para editar solo un campo a la vez
		menuModificar
      	else
	echo -en "\n El registro pokemon no existe\n\n"
	fi
	read -p " Presiona ENTER para continuar"
}

#Elimina el registro de un pokemon creando un nuevo archivo que omite el ID proporcionado.
baja(){
	clear
	echo -e "\tGenerando baja de pokemon\n"
	bloqueo
	echo -n " ID del pokemon que deseas borrar: "; read ID
	#mandamos a un archivo temporal todos aquellos pokemones que no
	#coincidan con el ID del pokemon que se desea borrar
	awk -F: -v clave="$ID" '($1!=clave){print}' pokemones.datos > temporal.datos
	#renombramos el rchivo temporal a nuestro archivo principal
	mv temporal.datos pokemones.datos
	desbloqueo
	echo ""
	read -p " Presione ENTER para continuar"
}

#Solicita un ID y muestra toda la informacion completa de ese pokemon si lo encuentra.
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

#Comprueba si existe al menos un pokemon en la base de datos que pertenezca a la generacion buscada.
existeGen(){
	hayGeneracion=$(awk -F: -v llave="$numGeneracion" '($6==llave){print}' pokemones.datos)
}

#Genera un archivo de texto nuevo con una lista formateada de todos los pokemones de cierta generacion.
reporte(){
	clear
	echo -e "\tGenerando reporte\n"
	echo -n " Generacion:"; read numGeneracion
	existeGen "$numGeneracion"
	if test "$hayGeneracion" != "" #si identificamos que hay tan siquiera un pokemon
	then
	awk -F: -v llave="$numGeneracion" '($6==llave){
							printf "--------------------------------------\n";
							printf "ID: %s\n",$1;
							printf "Nombre del pokemon: %s\n",$2;
							printf "Especie: %s\n",$3;
							printf "Altura: %s\n",$4;
							printf "Peso: %s\n",$5;
							printf "Generacion: %s\n",$6;
							printf "Habitat: %s\n",$7;
							printf "Habilidad: %s\n",$8;
							printf "Ratio de captura: %s\n",$9;
							printf "HP: %s\n",$10;
							printf "Ataque: %s\n",$11;
							printf "Defensa: %s\n",$12;
							printf "Velocidad: %s\n",$13;
						      }' pokemones.datos > generacion"$numGeneracion".txt
	echo -e " Se genero el archivo generacion$numGeneracion.txt\n"
	else
	echo -e " NO se genero el archivo (no hay pokemones de esa generacion)\n"
	fi
	read -p  " Presiona ENTER para continuar"
}
#codigo main
	opcion
	while [ "$opcion" != "0" ]
	do
		menu
	done
	clear
