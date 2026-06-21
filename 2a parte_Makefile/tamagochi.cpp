/* Clase: tamagochi   10/09/2025 - 11/09/2025 - 12/09/2025
    Grado y grupo:  3A
    Integrantes:
        Vazquez Delgado Cristian de Jesus  
        Duron Mendoza Antonio   
*/
#include <iostream>
#include <cstdlib> // para que funcione "exit()" al morir
#include <string>  // para el uso de objetos string

using namespace std;

//----------------------------------DATOS--------------------------------
struct Comida
{
    string nombre;
    int saciedad;
    bool curar; // algunas comidas curan, otras no
};

class Mascota
{
private:
    string nombre;
    int vida;
    int hambre;
    int sueno;
    int felicidad;
    int suciedad;

public:
    Mascota();
    void mostrarMenu();
    void mostrarMascota();
    void morir(); 
    void resetear();        // verifica valores máximos y mínimos

    void comer();            // disminuirá el hambre según la comida
    void dormir();           // disminuir sueño y aumentar hambre
    void jugar();            // aumentar felicidad, sueño, hambre y suciedad
    void limpiar();          // disminuir suciedad, aumentar sueño

    void acariciar();        // aumentar felicidad
    void mascotaFeliz();     

    void enfermar();         // se enferma con 80% de hambre, sueño o suciedad
    void curar(Comida tipo); // aumenta 5% de vida si es medicina
};

//------------------------PROTOTIPO DE FUNCIONES--------------------------
Comida crearComida(string nom, int sac, bool curar);
void mostrarCama();
void mostrarBano();

//------------------------PROGRAMA PRINCIPAL------------------------------
int main()
{
    // Creando mascota
    Mascota mascota1;
    mascota1.mostrarMenu();

    return 0;
}

//----------IMPLEMENTACION PROTOTIPOS DE FUNCIONES BÁSICAS-----------------
void mostrarCama(){
    cout << "          ___" << endl;
    cout << "        /     \\" << endl;
    cout << "       /     z \\" << endl;
    cout << "      /     z   \\" << endl;
    cout << "     |     z     |" << endl;
    cout << "     |  /\\___/\\  |" << endl;
    cout << "     | (  o o  ) |" << endl;
    cout << "      \\   \\_/   /" << endl;
    cout << "       \\_______/" << endl;
}

void mostrarBano(){
    cout << "      ____" << endl;
    cout << "     /    /\\" << endl;
    cout << "    /     /\\\\" << endl;
    cout << "    |     /|\\" << endl;
    cout << "    |  /\\_/\\" << endl;
    cout << "    | ( o.o )" << endl;
    cout << "    |  > ^ <" << endl;
    cout << "    | .O.0.O.  |" << endl;
    cout << "    |..0.O.0.. |" << endl;
    cout << "    \\_________/" << endl;
}

Comida crearComida(string nom, int sac, bool curar)
{
    Comida tipo;
    tipo.nombre = nom;
    tipo.saciedad = sac;
    tipo.curar = curar;
    return tipo;
}

//------------------------CLASE MASCOTA----------------------------------
Mascota::Mascota()
{
    system("cls");
    cout << endl << "\t  MI TAMAGOCHI" << endl;
    cout << endl << "\tTipo de mascota: Perro";
    cout << endl << "\tCual es su nombre: ";
    cin >> nombre;

    vida = 100;
    hambre = felicidad = 50;
    suciedad = sueno = 0;
}

void Mascota::mostrarMenu()
{
    int opc = 0;

    do
    {
        system("cls");

        // Verificaciones de estado
        enfermar();
        morir();
        resetear();

        // Parámetros en pantalla
        cout << "Mascota: Perro" << "\t\t" << "Nombre: " << nombre << endl;
        cout << "Vida: ";
        for (int i = 0; i < (vida / 10); i++)
        {
            cout << "<3 ";
        }
        cout << vida << "%" << endl;
        cout << "Hambre: " << hambre << "%\t\tCansancio: " << sueno << "%" << endl;
        cout << "Felicidad: " << felicidad << "%\t\tSuciedad: " << suciedad << "%" << endl;

        // Mostrar gráfico de la mascota
        mostrarMascota();

        // Menú de opciones
        cout << endl << endl;
        cout << "1. Comer \t 2. Dormir \t 3. Jugar" << endl;
        cout << "4. Limpiar \t 5. Acariciar \t 0. Salir" << endl;
        cout << "Seleccion: ";
        cin >> opc;

        switch (opc)
        {
        case 1:
            comer();
            break;
        case 2:
            dormir();
            break;
        case 3:
            jugar(); // <- Añadido al menú
            break;
        case 4:
            limpiar();
            break;
        case 5:
            acariciar();
            break;
        default:
            break;
        }
    } while (opc != 0);

    system("cls");
    cout << endl << endl << "\t\t saliendo..." << endl << endl;
}

void Mascota::mostrarMascota()
{
    cout << "\t          /^-^\\\n";
    cout << "\t         / o o \\\n";
    cout << "\t        /   Y   \\\n";
    cout << "\t        V \\ - / V\n";
    cout << "\t          / - \\\n";
    cout << "\t         /    |\n";
    cout << "\t   (    /     |\n";
    cout << "\t    ===/_) ||\n";
}

void Mascota::morir(){
    if(vida <= 0 || hambre >= 100 || sueno >= 100){
        system("cls");
        cout << endl << "   Murio el tamagochi" << endl;
        cout << "       _________\n";
        cout << "      /         \\\n";
        cout << "     /  R.I.P.   \\\n";
        cout << "    /___________ \\\n";
        cout << "    |           |\n";
        cout << "    |           |\n";
        cout << "    |           |\n";
        cout << "    |_|\n";
        cout << "     |         |\n";
        cout << "     |         |\n";
        cout << "     |_|\n";
        exit(0);
    }
}

void Mascota::resetear(){
    if(hambre < 0)    hambre = 0;
    if(hambre > 100)  hambre = 100;
    
    if(felicidad < 0)   felicidad = 0;
    if(felicidad > 100) felicidad = 100;

    if(sueno < 0)    sueno = 0;
    if(sueno > 100)  sueno = 100;

    if(suciedad < 0)   suciedad = 0;
    if(suciedad > 100) suciedad = 100;
}

void Mascota::comer()
{
    int opc = 0;
    Comida pastel = crearComida("Pastel", 5, false);
    Comida salchicha = crearComida("Salchicha", 10, false);
    Comida agua = crearComida("Agua", 2, false);
    Comida coca = crearComida("Coca", -5, false);
    Comida medicina = crearComida("Paracetamol", 0, true);

    system("cls");
    cout << "Mascota: Perro" << "\t\t" << "Nombre: " << nombre << endl;
    cout << "Vida: ";
    for (int i = 0; i < (vida / 10); i++) cout << "<3 ";
    cout << vida << "%" << endl;
    cout << "Hambre: " << hambre << "%\t\tCansancio: " << sueno << "%" << endl;
    cout << "Felicidad: " << felicidad << "%\t\tSuciedad: " << suciedad << "%" << endl;

    mostrarMascota();

    cout << endl << endl;
    cout << "1. Pastel | saciedad: " << pastel.saciedad << "% | curar: " << (pastel.curar ? "Si" : "No") << endl;
    cout << "2. Salchicha | saciedad: " << salchicha.saciedad << "% | curar: " << (salchicha.curar ? "Si" : "No") << endl;
    cout << "3. Agua | saciedad: " << agua.saciedad << "% | curar: " << (agua.curar ? "Si" : "No") << endl;
    cout << "4. Coca | saciedad: " << coca.saciedad << "% | curar: " << (coca.curar ? "Si" : "No") << endl;
    cout << "5. Medicina | saciedad: " << medicina.saciedad << "% | curar: " << (medicina.curar ? "Si" : "No") << endl;

    cout << "Seleccion: ";
    cin >> opc;

    switch (opc)
    {
    case 1: hambre -= pastel.saciedad; curar(pastel); break;
    case 2: hambre -= salchicha.saciedad; curar(salchicha); break;
    case 3: hambre -= agua.saciedad; curar(agua); break;
    case 4: hambre -= coca.saciedad; curar(coca); break;
    case 5: hambre -= medicina.saciedad; curar(medicina); break;
    default: break;
    }
}

void Mascota::dormir(){
    system("cls");
    cout << "Mascota: Perro" << "\t\t" << "Nombre: " << nombre << endl;
    cout << "Vida: ";
    for (int i = 0; i < (vida / 10); i++) cout << "<3 ";
    cout << vida << "%" << endl;
    cout << "Hambre: " << hambre << "%\t\tCansancio: " << sueno << "%" << endl;
    cout << "Felicidad: " << felicidad << "%\t\tSuciedad: " << suciedad << "%" << endl;

    mostrarCama();

    sueno -= 20;
    hambre += 15;
    
    cout << endl << endl;
    system("pause");
}

// <- NUEVA IMPLEMENTACIÓN DE JUGAR
void Mascota::jugar(){
    system("cls");
    cout << "Mascota: Perro" << "\t\t" << "Nombre: " << nombre << endl;
    cout << "Vida: ";
    for (int i = 0; i < (vida / 10); i++) cout << "<3 ";
    cout << vida << "%" << endl;
    cout << "Hambre: " << hambre << "%\t\tCansancio: " << sueno << "%" << endl;
    cout << "Felicidad: " << felicidad << "%\t\tSuciedad: " << suciedad << "%" << endl;

    // Animación feliz al jugar
    mascotaFeliz();

    // Lógica pedida en los comentarios: aumenta felicidad, sueno, hambre y suciedad
    felicidad += 20;
    sueno += 15;
    hambre += 10;
    suciedad += 15;
    
    cout << endl << "\t¡Te divertiste jugando con " << nombre << "!" << endl;
    system("pause");
}

void Mascota::limpiar(){
    system("cls");
    cout << "Mascota: Perro" << "\t\t" << "Nombre: " << nombre << endl;
    cout << "Vida: ";
    for (int i = 0; i < (vida / 10); i++) cout << "<3 ";
    cout << vida << "%" << endl;
    cout << "Hambre: " << hambre << "%\t\tCansancio: " << sueno << "%" << endl;
    cout << "Felicidad: " << felicidad << "%\t\tSuciedad: " << suciedad << "%" << endl;

    mostrarBano();

    suciedad = 0;
    sueno += 15;
    
    cout << endl << endl;
    system("pause");
}

void Mascota::acariciar(){
    system("cls");
    cout << "Mascota: Perro" << "\t\t" << "Nombre: " << nombre << endl;
    cout << "Vida: ";
    for (int i = 0; i < (vida / 10); i++) cout << "<3 ";
    cout << vida << "%" << endl;
    cout << "Hambre: " << hambre << "%\t\tCansancio: " << sueno << "%" << endl;
    cout << "Felicidad: " << felicidad << "%\t\tSuciedad: " << suciedad << "%" << endl;

    mascotaFeliz();

    felicidad += 15;
    
    cout << endl << endl;
    system("pause");
}

void Mascota::mascotaFeliz(){
    cout << "\t          /^-^\\\n";
    cout << "\t         / o o \\\n";
    cout << "\t        /   Y   \\\n";
    cout << "\t        V \\ v / V\n";
    cout << "\t          / - \\\n";
    cout << "\t         /    |\n";
    cout << "\t   (    /     |\n";
    cout << "\t    ===/_) ||\n";
}

void Mascota::enfermar(){
    if(hambre >= 80 || sueno >= 80 || suciedad >= 80){
        cout << "\n [!] La mascota esta enferma... bajo 10% de vida." << endl;
        cout << " (Hambre, sueno o suciedad arriba de 80%) ¡CUIDA SUS NIVELES!" << endl << endl;
        vida -= 10; 
    }
}     

void Mascota::curar(Comida tipo)
{
    if (tipo.curar)
    {
        if (vida >= 100)
        {
            vida = 100;
            return;
        }
        vida = vida + 5; 
    }
}