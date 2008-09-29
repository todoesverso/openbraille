#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define PALABRA 81 /** Cantidad de caracteres en una palabra **/
#define COLUMNAS 29 /** Cantidad de caractres en una hoja braille **/

/** Definicion de simbolos **/
#define MAYUSCULA '|'
#define NUMERAL '#'


int convertir(char palabra_entrada[PALABRA], char palabra_salida[PALABRA]){ 
int i,j = 0;
char buff_palabra[PALABRA] = "";
/* Las siguientes son las reglas braille a implementar. Tener en cuenta que 
 * esta funcion recibe y devuelve palabras, por lo que las reglas deben
 * aplicarse indistintamente a las palabras, numeros o signos.*/

/* REGLA 1 - La palabra tiene la primera letra en mayuscula por lo cual se ha
 * de agregar el simbolo MAYUSCULA previo al primer caracter de la palabra. Si
 * en cambio las dos primeras letras son mayusculas, se anteponen dos simbolos
 * MAYUSCULA. La segunda opcion no es la ideal, ya que esto en braille
 * significa que toda la palabra esta en mayusculas.*/


if (isupper(palabra_entrada[0]) && isupper(palabra_entrada[1])){
 buff_palabra[0] = MAYUSCULA;
 buff_palabra[1] = MAYUSCULA;
 j = 2;
 for (i = 0; i < strlen(palabra_entrada); i++ ){
  buff_palabra[j] = palabra_entrada[i];   
  j++;
 }
}      
else if (isupper(palabra_entrada[0]) && ! isupper(palabra_entrada[1])){
 buff_palabra[0] = MAYUSCULA;
 j = 1; 
 for (i = 0; i < strlen(palabra_entrada); i++ ){
  buff_palabra[j] = palabra_entrada[i];   
  j++;
 }
}
else if (islower(palabra_entrada[0])){
 for (i = 0; i < strlen(palabra_entrada); i++ ){
  buff_palabra[i] = palabra_entrada[i];     
 }
}



/* REGLA 2 - La palabra es un numero por lo que debe anteponerse el simbolo
 * NUMERAL y luego hacer el cambio de numeros a letras.*/
if (isdigit(palabra_entrada[0])){
 buff_palabra[0] = NUMERAL;
 for (j = 1 ; j < strlen(palabra_entrada) + 1; j++){
  switch (palabra_entrada[j-1]){
   case '1': 
    buff_palabra[j] = 'a';
    break;
   case '2':
    buff_palabra[j] = 'b';
    break;
   case '3':
    buff_palabra[j] = 'c';
    break;
   case '4':
    buff_palabra[j] = 'd';
    break;
   case '5':
    buff_palabra[j] = 'e';
    break;
   case '6':
    buff_palabra[j] = 'f';
    break;
   case '7':
    buff_palabra[j] = 'g';
    break;
   case '8':
    buff_palabra[j] = 'h';
    break;
   case '9':
    buff_palabra[j] = 'i';
    break;
   case '0':
    buff_palabra[j] = 'j';
    break;
   default:
    buff_palabra[j] = palabra_entrada[j-1];
    break;
  }
 }
}

/* REGLA 3 - Falta agregar una regla que maneje las "palabras que comienzan con
 * signos como puede ser ( o [ o ".
 */



strcpy(palabra_salida, buff_palabra);
return 0;
}

int col_adapt(FILE *archivo_entrada, FILE * archivo_salida){
/* Esta funcion se encarga de convertir y "tabular" en un ancho de COLUMNAS el
 * archivo de entrada. 
 * Se debe inplementar algun tipo de solucion si la plabra de entrada es mas
 * ancha que COLUMNAS, como puede ser una direccion web o algo por el estilo
 */


char palabra[PALABRA] = "" , palabra_salida[PALABRA] = "" , buffer_linea[PALABRA] = "";

while( !feof(archivo_entrada) ){
 fscanf(archivo_entrada, "%s", palabra);
 convertir(palabra, palabra_salida);
 strcat(palabra_salida, " ");
 if ((strlen(buffer_linea) + strlen(palabra_salida)) < COLUMNAS){
   strcat(buffer_linea, palabra_salida);
   printf ("%d\n", (strlen(buffer_linea) + strlen(palabra_salida)));
 }
 else
 { 
   fprintf(archivo_salida, "\n");
   fprintf(archivo_salida, buffer_linea);
   strcpy(buffer_linea, palabra_salida);
//   strcat(buffer_linea, " "); //Evaluar esta linea
  }
}
return 0;
}



int main(int argc, char** argv){
FILE *archivo_entrada, *archivo_salida;

archivo_entrada = fopen(argv[1], "r" );
archivo_salida = fopen ("salida.txt", "w");

if (archivo_entrada == NULL){
        printf("Wrong file\n");
        return 1;
}

col_adapt(archivo_entrada, archivo_salida);


fclose(archivo_salida);
fclose(archivo_entrada);
printf("\n");
return 0;
}
