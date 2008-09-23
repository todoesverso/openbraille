#include <stdio.h>
//Cantidad de bytes en la pagina de salida
#define ANCHO 7

// La cantidad de caracteres que contien la pagina de entrada (1 byte por ASCII )
#define LONG 4*ANCHO
#define SIZE 840

//Tamaño de una pagina Braille impresa (630 bytes)
#define TAM 3*ANCHO


typedef unsigned char byte;

// Variables globales




void bprint(byte x)
{
	int n;
	for(n=0; n<8; n++)
	{
		if((x & 0x80) !=0)
		{
			printf("1");
		}
		else
		{
			printf("0");
		}
		if (n==3)
		{
			printf(" "); /* Un espacio cada 4 bits */
		}
		x = x<<1;
	}
	printf("  ");
}

byte llenarbyte(byte *ptr, byte mask)
{
byte pkt = 0;
switch(mask)
{
case 0x30:
   pkt = ((*ptr & mask) << 2)|(*(ptr+1) & mask)|((*(ptr+2) & mask) >> 2)|((*(ptr+3) & mask) >> 4);
   break;
case 0x0c:
   pkt = ((*ptr & mask) << 4)|((*(ptr+1) & mask) << 2)|(*(ptr+2) & mask)|((*(ptr+3) & mask) >> 2);
   break;
case 0x03:
   pkt = ((*ptr & mask) << 6)|((*(ptr+1) & mask) << 4)|((*(ptr+2) & mask) << 2)|(*(ptr+3) & mask);
   break;
default: printf("Error de mascara");
}
//ptr +=4;
	return pkt;
}

void llenarrenglon (byte *ptrOut, byte *ptrIn, int ancho)
{
int i,j;
byte *ptrInA, *ptrOutA;
 ptrInA = ptrIn;
 ptrOutA = ptrOut;
byte mascara[3] = {0x30, 0x0c, 0x03};

	for(i=0; i<3; i++)
	{
		ptrInA = ptrIn;
	// LLena la linea hasta el ancho correspondiente de pagina
		for(j = 0; j < ancho; j++)
		{
			*ptrOut = llenarbyte (ptrInA, mascara[i]);
			ptrOut++;
			ptrInA +=4;
		}
	}
}

int main(void)
{
		int i;
	byte paginaIn[SIZE];//= {0x2d, 0x25, 0x1e, 0x18, 0x21, 0x12, 0x13, 0x14, 0x1e, 0x18, 0x21, 0x12};
	byte paginaOut[640] = {0};
	byte *ptrOut, *ptrIn, mascara[3] = {0x30, 0x0c, 0x03}; int j;
	
	for (i=0; i < SIZE; i++)
		paginaIn[i] = i;
	
printf("Pagina Braille de entrada\n");
for (i=0; i < SIZE; i+=4) //agrupa de a 4, 2 bit de cada uno forman 1 byte a la salida
	if (0) // !(paginaIn[i]<0x40))
		printf("Revisar el valor del byte %d porque excede el tamaño de 6 bits\n", i);
	else
	{
	printf(" %.2X %.2X %.2X %.2X  ", paginaIn[i],paginaIn[i+1],paginaIn[i+2], paginaIn[i+3]);
	bprint(paginaIn[i]); bprint(paginaIn[i+1]); bprint(paginaIn[i+2]); bprint(paginaIn[i+3]);
	printf("\n");
	}
printf("\n");

// Empieza la conversion
for(j=0; j<30; j++)
llenarrenglon(paginaOut, paginaIn, ANCHO);
// Llena un renglon de caracteres Brailles impresos
//ptrOut = paginaOut;	
//	ptrIn = paginaIn;
/*	
for(i=0; i<3; i++)
	{
	// LLena la linea hasta el ancho correspondiente de pagina

	for(j = 0; j < ANCHO; j++) // Cambiar ese 3 por la ultima posicion de la pagina de salida
		{
		*ptrOut = llenarbyte (ptrIn, mascara[i]);
		ptrOut++;
		ptrIn +=4;
		}
	}

*/
printf("Pagina Braille de salida\n");
	

	for(i=0; i<640; i+=4)
	{
	printf("%d) ", i/4);
	bprint(paginaOut[i]); bprint(paginaOut[i+1]); bprint(paginaOut[i+2]); bprint(paginaOut[i+3]);
	printf("\n");
	}
	

return 0;
}

