#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define PALABRA 81 /** Cantidad de caracteres en una palabra **/

int convertir(char palabra_entrada[PALABRA], char palabra_salida[PALABRA]){ 
int i,j = 0;
char buff_palabra[PALABRA] = "";

if (isupper(palabra_entrada[0]) && isupper(palabra_entrada[1])){
    buff_palabra[0] = '|';
    buff_palabra[1] = '|';
    j = 2;
}      
else if (isupper(palabra_entrada[0]))
{
    buff_palabra[0] = '|';
    j = 1; 
}

for (i = 0; i < strlen(palabra_entrada); i++ ){
 buff_palabra[j] = palabra_entrada[i];   
 j++;
}
strcpy(palabra_salida, buff_palabra);
return 0;
}

int main(int argc, char** argv){
char palabra[PALABRA] = "" , palabra_salida[PALABRA] = "" ;
FILE *archivo_entrada, *archivo_salida;

archivo_entrada = fopen(argv[1], "r" );

if (archivo_entrada == NULL){
        printf("Wrong file\n");
        return 1;
}

while( !feof(archivo_entrada))
{
 fscanf(archivo_entrada, "%s", palabra);
 convertir(palabra, palabra_salida);
 printf("%s ",palabra_salida);
}

return 0;
}
