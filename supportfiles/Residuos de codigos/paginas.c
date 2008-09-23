#include <stdio.h>
#include <stdlib.h>

typedef unsigned char byte;

byte brAsciiTabla[] = 
{				//b7 b6 b5 b4 b3 b2 b1 b0  "Simbolo"		//b7 b6 b5 b4 b3 b2 b1 b0   "Simbolo"
	0x00,0x1b,		//(Espacio)	 			        //0  0  0  1  1  0  1  1       ! 
 	0x04,0x17,		//0  0  0  0  0  1  0  0      "			//0  0  0  1  0  1  1  1       #
	0x49,0x41,		//0  0  1  1  1  0  0  1      $                 //0  0  1  1  0  0  0  1       %	
	0x4b,0x02,		//0  0  1  1  1  0  1  1      &			//0  0  0  0  0  0  1  0       '
	0x2f,0x1f,		//0  0  1  0  1  1  1  1      ( 		//0  0  0  1  1  1  1  1       )  
	0x21,0x00,		//0  0  1  0  0  0  0  1      *			//0  0  0  1  0  0  1  1       +
	0x01,0x00,		//0  0  0  0  0  0  0  1      ,			//0  0  0  0  0  0  1  1       -
	0x11,0x12,		//0  0  0  1  0  0  0  1      .  		//0  0  0  1  0  0  1  0       /
	0x07,0x08,		//0  0  0  0  0  1  1  1      0			//0  0  0  0  1  0  0  0       1
	0x0a,0x0c,		//0  0  0  0  1  0  1  0      2			//0  0  0  0  1  1  0  0       3
	0x0d,0x09,		//0  0  0  0  1  1  0  1      4			//0  0  0  0  1  0  0  1       5  			
	0x0e,0x0f,		//0  0  0  0  1  1  1  0      6			//0  0  0  0  1  1  1  1       7
	0x0b,0x06,		//0  0  0  0  1  0  1  1      8			//0  0  0  0  0  1  1  0       9	  		
	0x25,0x05,		//0  0  1  0  0  1  0  1      :			//0  0  0  0  0  1  0  1       ; 			
	0x29,0x4f,		//0  0  1  0  1  0  0  1      <			//0  0  1  1  1  1  1  1       =	 
	0x16,0x45,		//0  0  0  1  0  1  1  0      >			//0  0  1  1  0  1  0  1       ? 	
	0x10,0x20,		//0  0  0  1  0  0  0  0      @			//0  0  1  0  0  0  0  0       A
	0x28,0x30,		//0  0  1  0  1  0  0  0      B			//0  0  1  1  0  0  0  0       C			
	0x34,0x24,		//0  0  1  1  0  1  0  0      D			//0  0  1  0  0  1  0  0       E		
	0x38,0x3c,		//0  0  1  1  1  0  0  0      F			//0  0  1  1  1  1  0  0       G		
	0x2c,0x18,		//0  0  1  0  1  1  0  0      H			//0  0  0  1  1  0  0  0       I
	0x1c,0x22,		//0  0  0  1  1  1  0  0      J			//0  0  1  0  0  0  1  0       K 		
	0x2a,0x32,		//0  0  1  0  1  0  1  0      L			//0  0  1  1  0  0  1  0       M  
	0x36,0x26,		//0  0  1  1  0  1  1  0      N			//0  0  1  0  0  1  1  0       O
	0x3a,0x3e,		//0  0  1  1  1  0  1  0      P			//0  0  1  1  1  1  1  0       Q
	0x2e,0x1a,		//0  0  1  0  1  1  1  0      R			//0  0  0  1  1  0  1  0       S 
	0x1e,0x23,		//0  0  0  1  1  1  1  0      T			//0  0  1  0  0  0  1  1       U	
	0x2b,0x1d,		//0  0  1  0  1  0  1  1      V			//0  0  0  1  1  1  0  1       W 	
	0x33,0x37,		//0  0  1  1  0  0  1  1      X			//0  0  1  1  0  1  1  1       Y
	0x27,0x19,		//0  0  1  0  0  1  1  1      Z			//0  0  0  1  1  0  0  1       [
	0x2d,0x3d,		//0  0  1  0  1  1  0  1      \			//0  0  1  1  1  1  0  1       ]
	0x14,0x15		//0  0  0  1  0  1  0  0      ^		 	//0  0  0  1  0  1  0  1       _
};




byte reemplazar(byte caract){
	byte charCod;
	byte retorna;
	
	charCod = caract - 0x20;
	retorna =  brAsciiTabla[charCod];

return retorna;
}




int main(void)
{
FILE *ascii, *braille;
byte caract;

	ascii = fopen("/home/rajazz/ascii.txt","r");


	braille = fopen("/home/rajazz/braille.txt","w");


	while(!feof(ascii))
	{
		caract = getc(ascii);

	if(!feof(ascii))
		putc(reemplazar(caract), braille);
	}

fclose(ascii);
fclose(braille);

return 0;
 // gcc -Wall -W -L/usr/lib/ -lusb paginas.c -o paginas
}






	

