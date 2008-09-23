// Código de demostración de Entrada/Salida de USB en PIC 18F4550
// enciende/apada LED y se identifica como impresora (si todo anda bien!! :] )
//
// Sin copyright, (C) 2008 todoesverso & rajazz
//
// Esta biblioteca es software libre. Puede ser redistribuido y/o modificado
// bajo los términos de la Licencia Pública General de GNU publicada por
// Free Software Foundation, bien de la versión 2.1 de dicha Licencia o
// (según su elección) de cualquier versión posterior.
//
// Esta biblioteca se distribuye con la esperanza de que sea útil, pero 
// SIN NINGUNA GARANTÍA, incluso sin la garantía MERCANTIL implícita o sin
// garantizar la CONVENIENCIA PARA UN PROPÓSITO PARTICULAR.
// Ver la Licencia Pública General de GNU para más detalles.
// Debería haber recibido una copia de la Licencia Pública General junto
// con este programa. Si no ha sido así, escriba a la Free Software
// Foundation, Inc., en 675 Mass Ave, Cambridge, MA 02139, EEUU.
//

#include <pic18fregs.h>
#include <stdio.h>
#include <usart.h>
#include "usb.h"

// Constantes definidas por el tamaño de la pagina Braille
#define BYTESXLINEA 3
#define NUMLINES 3

// Nombres de lo que esta conectado al puerto del PIC, mirar esquemático del circuito y el pinout
// En el puerto D están conectados dos entradas y la salida del percutor
#define SENSOR_CARRO PORTDbits.RD2
#define SENSOR_PAPEL PORTDbits.RD3
#define PERCUTOR PORTDbits.RD1

#define CARRO 1
#define RODILLO 0
#define IZQ 0
#define DER 1
#define ARR 0
#define ABAJ 1

// Tabla para paso de motor tipo HALF STEP
/* 
#define STEP1 0xf7;
#define STEP2 0xf3;
#define STEP3 0xfd;
#define STEP4 0xfa;
#define STEP5 0xfe;
#define STEP6 0xfc;
#define STEP7 0xfd;
#define STEP8 0xf5;
#define STEP9 0xf7;
*/

// NOTA: Hay problemas relacionados al tiempo asociados con GET_FEAUTURE
// cuando corre a menos de 48 MHz


// Corriente:
//   23 mA @ 16 MHz
//   26 mA @ 24 MHz
//   35 mA @ 48 MHz
//
// Definición de los registros de configuración de fusibles (fuses)
#if defined(pic18f2550) || defined(pic18f2455) || defined(pic18f4550) || defined(pic18f4455)

code char at 0x300000 CONFIG1L = 0x20; // USB, sin dividir por 2 (48MHz), /5 pre (20 MHz)

code char at 0x300001 CONFIG1H = 0x03; // Otra configuración diferente de: IESO=0, FCMEN=0, HS-PLL (40MHz)
// sigue configurando fusibles...
code char at 0x300002 CONFIG2L = 0x20; // Brown out off, PWRT On 
code char at 0x300003 CONFIG2H = 0x00; // WDT off
code char at 0x300004 CONFIG3L = 0xff; // Unused configuration bits
code char at 0x300005 CONFIG3H = 0x01; // No MCLR, PORTB digital, CCP2 - RC1
code char at 0x300006 CONFIG4L = 0x80; // ICD off, ext off, LVP off, stk ovr off
code char at 0x300007 CONFIG4H = 0xff; // Unused configuration bits
code char at 0x300008 CONFIG5L = 0xff; // No code read protection
code char at 0x300009 CONFIG5H = 0xff; // No data/boot read protection
code char at 0x30000A CONFIG6L = 0xff; // No code write protection
code char at 0x30000B CONFIG6H = 0xff; // No data/boot/table protection
code char at 0x30000C CONFIG7L = 0xff; // No table read protection
code char at 0x30000D CONFIG7H = 0xff; // No boot table protection
#endif

volatile byte txBuffer[INPUT_BYTES];

volatile byte rxBuffer[OUTPUT_BYTES];

volatile byte pagina[OUTPUT_BYTES];

// Punto de entrada de inicialización de usuario

void UserInit(void)
{
    // Establece RA4 como salida
    TRISA &= 0xEF;
    // Configuracion adicional, Victor's work
    // No tengo idea que hace, pregutar despues a victor asi queda comentado
    ADCON0 = 0xFF;
    TRISB &= 0x00;
    INTCON = 0;
    INTCON2 = 0;
    TRISE = 0;
    TRISB = 0;
    TRISD = 0xc;
// Sacar lo que está comentado a continuacion si lo anterior funciona...
/*
    _asm
    clrf 0xF96 // No hay TRISE, configurado a mano...
    // tampoco hay TRISD
    // Inicializar puerto D (b2 -> percutor, b1-b0 -> entradas)
    movlw 0x03
    movwf 0xf95
		    
    _endasm */
    PORTE = 0;
    PORTB = 0xff; 
    PORTD = 0;

}

// Rutina que genera un delay aproximado hecho sin presicion (para ver los LEDs encendidos)

void delay(int ms)
{
	int i;
	
	while(ms--)
		for(i=0;i<100;i++); // Estos números son ciclos sucifientes para generar retardo

}
// Bucle central de proceso. En cuanto el firmware no esta ocupado atendiendo
// el USB, se toma control acá para hacer otro procesamiento.

void golpear(void)
{
	
	PERCUTOR = 0;
	delay(500);
	PERCUTOR = 1;
	delay(5000);
	PERCUTOR = 0;
}

void check_driver(void)
{
PORTB = 0xff;
}

void desplazar(int cant)
{

	PORTB=0;

	if (cant==1)
		PORTBbits.RB1 = 1;
	else
		PORTBbits.RB2 = 1;
	delay(50);
}

void rotar(int cant)
{
	PORTB=0;

	if (cant==1)
		PORTBbits.RB3 = 1;
	else
		PORTBbits.RB4 = 1;
	delay(50);
}

void volvercarro(void)
{
	PORTB=0;	
	PORTBbits.RB5 = 1;
	delay(50);	
}

void check_bit(int ind, int pos)  // posicion del bit del 0 al 7
{
byte mascara, aux;
	
	mascara = 0x01; // Para la lectura del primer bit
	mascara = mascara << pos;
	aux = pagina[ind] & mascara;
	if (aux)
		golpear();
}

void print_byte(int ind)
{
	int i=0;
	byte a;
	for (i = 8; i > 0; i--)
	{
		PORTBbits.RB6=1;
		delay(50);
		check_bit(ind, i-1);
		a =(byte)i;
		if (a&1) // Chequea la paridad
			desplazar(2);
		else
			desplazar(1);
		delay(50);
		PORTBbits.RB6=0;
	}
}

void print_line(int linea)
{
	int i, j;
	j = linea*BYTESXLINEA;
	for (i = j; i < j + BYTESXLINEA; i++)
		print_byte(i);
	volvercarro();
}

void print_page(void)
{
	int i;
	for(i = 0; i < NUMLINES; i++)
	{
		print_line(i);
		rotar(1);
		i++;
		print_line(i);
		rotar(1);
		i++;
		print_line(i);
		rotar(2);
	}
}
	
// Funciones encargadas del comando sobre la impresora

void apagar_motores(void)
{
PORTB = 0x00;
}

// Funciones encargadas del comando sobre la impresora

int mover(int paso, int loops, int direccion, int motor)
{
byte pasos[8]={0x77, 0x33, 0xbb, 0x99, 0xdd, 0xcc, 0xee, 0x66}, valor;
int paso_aux, loops_aux, i;

paso_aux = paso;

if(direccion)

	for(loops_aux=0; loops_aux < loops; loops_aux++)
	{
		for(i = paso_aux; i < 8; i++)
		{		
		valor = pasos[i];
		if(motor)	
		{
		PORTB = (PORTB & 0xf0) | (valor & 0x0f);
		delay(50);
		}
		else
		{
		PORTB = (PORTB & 0x0f) | (valor & 0xf0);
		delay(50);
		}	
		}
	paso_aux=0;
	}
else

	for(loops_aux=0; loops_aux < loops; loops_aux++){
	for(i = paso+1; i > 0; i--)
		{
		valor = pasos[i];
		if(motor)		
		{
		PORTB = (PORTB & 0xf0) | (valor & 0x0f);
		delay(50);
		}
		else
		{
		PORTB = (PORTB & 0x0f) | (valor & 0xf0);
		PORTB |= valor;;
		delay(50);
		}
		}
		paso_aux = 7;
	}
	
return paso_aux;
}

int reset_carro(void)
{

int contador = 0;

while(SENSOR_CARRO) {

	mover(0, 1, DER, CARRO);
	mover(0, 1, DER, RODILLO);
	contador++;
	}

apagar_motores();

return contador;

}

static void imprimir(void)
{
int j, k, l;
byte aux,i;
byte mascara;
i=0;
while (i < 3)
{	
	for(l = 0; l < 3; l++)
	{
		for (j = 0; j < 7; j++)  // Para imprimir una linea
			
		{
		mascara = 0x80; // Para la lectura del primer bit
		aux = pagina[i] & mascara;

		for (k = 0; k < 4; k++)
		{
		if (aux)
			golpear();
		desplazar(1); // Desplazamiento corto
		mascara = mascara >> 1; // Para lectura del siguiente bit
	
		if (aux)
			golpear();
		desplazar(2); // Deplazamiento largo
		mascara = mascara >> 1;
		}
		i++;
		}
		rotar(1);
		volvercarro();
	}
	rotar(2);
	volvercarro();
}
}

static void USBEcho(void)
{
	byte rxCnt, i;

        // Find out if an Output report has been received from the host
	rxCnt = BulkOut(rxBuffer, OUTPUT_BYTES);

	if (rxCnt == 0) return;

	for(i=0;i<OUTPUT_BYTES;i++)
		pagina[i]=rxBuffer[i];
	// Estas dos lineas modifican el original
	

print_page();
txBuffer[0]= 0x12;
txBuffer[1]= 0xab;

	while (ep1Bi.Stat & UOWN)
		ProcessUSBTransactions(); 
	
	BulkIn(txBuffer, 2);
	// ACA EMPEZAMOS A MODIFICAR


}

void ProcessIO(void)
{
	
	// Tareas de aplicación de Usuario USB
  //  if ((deviceState < CONFIGURED) || (UCONbits.SUSPND==1))
		//return;

	// Proceso USB: Agregar acá la función que realiza el dispositivo
	// ACA!!

	//USBEcho();

	
/*	rxCnt=   BulkOut(rxBuffer, 7);
	
   
   if (rxCnt == 0) return;
	for(i=0;i<7;i++)
		delay(100);
	PORTE=rxBuffer[i];
*/
// Las siguientes lineas hacen que el dispositivo haga un eco de lo que recibe por el bus USB
}

// Punto de entrada del Firmware
void main(void)
{
int a, b;

	// Establecer todos los pines de I/O a digital
    ADCON1 |= 0x0F;

	// Inicializar USB
    UCFG = 0x14; // Habilita las resistencias de pullup; modo full speed

// Condiciones iniciales del dispositivo
    deviceState = DETACHED;
    remoteWakeup = 0x00;
    currentConfiguration = 0x00;
	

	// LLamada a la función de inicialización de usuario
	UserInit();
	
	golpear();
//	reset_carro();
	a = mover(0, 134, IZQ, CARRO);
	golpear();
	golpear();
	b = mover (0, 134, ABAJ, RODILLO);
	golpear();
	golpear();
	golpear();
	a = mover(0, 134, DER, CARRO);

	golpear();
	a = mover(0, 134, DER, CARRO);
	golpear();
	golpear();
	b = mover (0, 134, ARR, RODILLO);
	golpear();
	golpear();
	golpear();
	apagar_motores();
	/*for (i=0; i<aux; i++)
	{
	delay(1000);
	delay(1000);
	mover(0, 1, DER, CARRO);
	PORTEbits.RE0 = 1;
	delay(1000);
	delay(1000);
	PORTEbits.RE0 = 0;
	delay(1000);
	delay(1000);
	}
	PORTEbits.RE0 = 0;*/
	apagar_motores();




	while(1)
	{
	// Asegurar que el modulo USB está disponible
	//	EnableUSBModule();

	// En cuanto sale del modo de prueba (UTEYE), procesa
	// las transactiones USB
	//	if(UCFGbits.UTEYE != 1)
//			ProcessUSBTransactions();

        // Tareas de apliacación específica
		//ProcessIO();
	
	}
}
//sdcc --vc --fstack --denable-peeps --optimize-goto --optimize-cmp --optimize-df --obanksel=9 --opt-code-size --fommit-/frame-pointer -mpic16 -p18f45100 -I /usr/share/sdcc/include/pic16/ -c usb.c

//sdcc --vc --fstack --denable-peeps --optimize-goto --optimize-cmp --optimize-df --obanksel=9 --opt-code-size --fommit-frame-pointer -mpic16 -p18f45100 -I /home/rajazz/Final/PICHID\ -Para\ meter\ mano/ -L /usr/share/sdcc/lib/pic16/ -Wl,"-w -s 18f45100.lkr" main.c usb.o

