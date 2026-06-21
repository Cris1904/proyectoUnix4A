# Proyecto Final de UNIX: Gestión de Datos y Automatización

Este repositorio contiene el proyecto final para la materia de UNIX (Ingeniería en Sistemas Computacionales). El proyecto se divide en dos fases principales orientadas a demostrar el dominio sobre la administración del sistema a bajo nivel, la manipulación de flujos de texto y la automatización de procesos de compilación.

# Estructura del Proyecto

El proyecto aborda dos implementaciones técnicas distintas:
1. Gestor de Archivos Planos (Bash): Un sistema CRUD para administrar un inventario de Pokemones utilizando herramientas nativas de la shell.
2. Simulador Tamagochi (C++ & Make): Un programa de alto nivel gestionado íntegramente a través de reglas de construcción automatizadas.

# Parte 1: Sistema de Gestión de Pokemones (Shell Script)

Aplicación interactiva de línea de comandos desarrollada en Bash para administrar una base de datos plana (`pokemones.datos`). 

# Características Principales
* Operaciones CRUD: Altas seguras, bajas lógicas/físicas, consultas directas y modificaciones granulares de 13 campos de metadatos.
* Control de Concurrencia (Mutex): Implementación de exclusión mutua mediante un archivo bandera (`bloquear.pokemones`) para prevenir condiciones de carrera durante la escritura.
* Procesamiento de Flujos: Uso de `awk` para filtrado, búsqueda de llaves primarias (ID) y formateo de reportes por generación.

# Requisitos y Ejecución
1. Asegurarse de tener un entorno compatible con Bash.
2. Otorgar permisos de ejecución al script principal:
   chmod +x proyecto.sh
3. Ejecutar el gestor:
   ./proyecto.sh

# Parte 2: Simulador Tamagochi (C++ y Makefile)

Simulador de mascota virtual desarrollado en C++ para demostrar las buenas prácticas de ingeniería de software en entornos UNIX mediante la automatización del compilador GNU (`g++`).

### Gestión de Compilación (Make)
El ciclo de vida del software se administra mediante un archivo `Makefile` con reglas estandarizadas. Es necesario primero posicionarse en el directorio raíz del proyecto y utilizar los siguientes comandos:

* `make all` : Compila el código fuente (`tamagochi.cpp`) y genera el binario ejecutable.
* `make debug` : Compila el binario integrando símbolos de depuración (`-g`) para herramientas como `gdb`.
* `make clean` : Elimina los archivos binarios residuales generados, limpiando el entorno de trabajo.
* `sudo make install` : Despliega el ejecutable en `/usr/local/bin` para que esté disponible globalmente en el sistema.
* `sudo make uninstall` : Elimina de forma segura el ejecutable del directorio del sistema.

*Para ejecutar el programa localmente (tras usar `make all`):*
./tamagochi


# Equipo de Desarrollo

* Durón Mendoza Antonio
* López Acevedo Tania Jaquelin
* Raygoza Castañeda Ulises
* Vázquez Delgado Cristian de Jesús
