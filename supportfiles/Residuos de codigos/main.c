int main(void)
{
/*		int i;
	byte paginaIn[SIZE];//= {0x2d, 0x25, 0x1e, 0x18, 0x21, 0x12, 0x13, 0x14, 0x1e, 0x18, 0x21, 0x12};
	byte paginaOut[640] = {0};
	//byte *ptrOut, *ptrIn, mascara[3] = {0x30, 0x0c, 0x03}; 
	int j;
	
	for (i=0; i < SIZE; i++)
		paginaIn[i] = random();
*/	
	iniciar_usb();
	
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
cnt = 0;
for(j=0; j<30; j++)
	{
	llenarrenglon(paginaOut, paginaIn, ANCHO);
	cnt++;
	}
// Llena un renglon de caracteres Brailles impresos
//ptrOut = paginaOut;	
//	ptrIn = paginaIn;
	
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


	
printf("Pagina Braille de salida\n");
	

	for(i=0; i<640; i+=4)
	{
	printf("%d) ", i/4);
	bprint(paginaOut[i]); bprint(paginaOut[i+1]); bprint(paginaOut[i+2]); bprint(paginaOut[i+3]);
	printf("\n");
	}
	
	

finalizar_usb();
return 0;
}

