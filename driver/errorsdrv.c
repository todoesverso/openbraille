#include "options.h"

int
errors(int number) {
 FILE *filePtr;  
 char file_name;
 char line[512];
 int line_number = 0;
 char command[899] = "";

 getOpt("errors-msg", &file_name);
 
 filePtr = fopen (&file_name, "rt");

 if (filePtr == NULL) {
 printf("Error al abrir el archivo \n");
 return 1;
 }

 for (line_number = 0; line_number < number; line_number++) 
       fgets (line, sizeof(line), filePtr); 
 
 fclose (filePtr);
 
 line_number =  strlen(line); // Re use line_number
 printf ("%d\n",line_number);

 line[line_number -1 ] = ' '; // Remove \n

 printf("%s\n",line);

 strcat (command, "espeak -v es -s 135 -p 35 '");
 strcat (command, line);
 strcat (command, "'");
 
 printf("%s\n", command);
 system(command);
 return 0;
}
