#include <stdio.h>

typedef unsigned char byte;
int byteXrenglon = 7;
int numReng = 30;

byte llenarbyte(byte *bytePtr, byte mascara)
{
	byte byteAux, bytePkt = 0;

	byteAux = (*bytePtr & mascara) << 2;

	bytePkt |= byteAux;

	bytePtr++;

	byteAux = *bytePtr & mascara;

	bytePkt |= byteAux;

	bytePtr++;

	byteAux = (*bytePtr & mascara) >> 2;

	bytePkt |= byteAux;

	bytePtr++;

	byteAux = (*bytePtr & mascara) >> 4;

	bytePkt |= byteAux;

	return bytePkt;
}

void llenarlinea(byte *bytePtr, byte mascara)
{
	int i;
	for (i=0; i < byteXrenglon; i++)
		llenarbyte(bytePtr, mascara, i);
}

void llenarrenglon(byte *bytePtr)
{
	int i;
	byte mascaras[3] = {0x30, 0x0c, 0x03};
	
	for (i=0; i<3; i++)	
		llenarlinea(bytePtr, mascaras[i]);
}	
	
	
	
void llenarpagina (byte *bytePtr)
{
	int i;

	for (i=0; i < numReng; i++)
		llenarrenglon(bytePtr);
}

int main(void)
{	
	int i;
	byte pagina[630] = {0x18, 0x27, 0x3c, 0x19, 0x19, 0x05, 0x2a, 0x37, 0x17};
	
	printf("Valores originales\n");
	for (i=0; i < 20; i++)
		printf("%.2X ", pagina[i]);
	printf("\n");
	
	//for (i=0; i < 630; i++)
	//	pageBc[i] = 0;
	
	llenarpagina(pagina);
	for (i=0; i < 20; i++)
		printf("%.2X ", pageBc[i]);
	printf("\n");
	return 0;
}
