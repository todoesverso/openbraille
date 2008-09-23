#include <stdio.h>

int main(void)
{
	typedef unsigned char byte;
	int i, j, k;

	int byteXrenglon = 7;
	int numReng = 30;
	byte pageBc[630];
	
	byte mascara, byteAux;
	byte *bytePtr;
	byte mascaras[3] = {0x30, 0x0c, 0x03};
	
	bytePtr = &pag[0];
			
	for (i=0; i < 630; i++)
		pageBc[i] = 0;
		
	for (k=0; k < numReng; k++)
	{
		for (j=0; j<3; j++)
		{
			mascara = mascaras[j];
	
			for (i=0; i < byteXrenglon; i++)
			{
// Aca empieza	
				byteAux = *bytePtr & mascara;
				
				*bytePtr = *bytePtr << 2;

				pageBc[i] |= byteAux;

				bytePtr++;

				byteAux = *bytePtr & mascara;

				pageBc[i] |= byteAux;

				bytePtr++;

				byteAux = *bytePtr & mascara;

				*bytePtr = *bytePtr >> 2;

				pageBc[i] |= byteAux;
 
				bytePtr++;

				byteAux = *bytePtr& mascara;
						
				*bytePtr = *bytePtr >> 4;

				pageBc[i] |= byteAux;
			}
		}
	}
return 0;
 // Para compilar...
 // gcc -Wall -W -L/usr/lib/ -lusb paginas.c -o paginas
}
