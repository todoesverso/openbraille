/// Código de demostración de Entrada/Salida de USB en PIC 18F4550
/// enciende/apada LED y se identifica como impresora (si todo anda bien!! :] )
///
/// Sin copyright, (C) 2008 todoesverso & rajazz
///
/// Esta biblioteca es software libre. Puede ser redistribuido y/o modificado
/// bajo los términos de la Licencia Pública General de GNU publicada por
/// Free Software Foundation, bien de la versión 2.1 de dicha Licencia o
/// (según su elección) de cualquier versión posterior.
///
/// Esta biblioteca se distribuye con la esperanza de que sea útil, pero 
/// SIN NINGUNA GARANTÍA, incluso sin la garantía MERCANTIL implícita o sin
/// garantizar la CONVENIENCIA PARA UN PROPÓSITO PARTICULAR.
/// Ver la Licencia Pública General de GNU para más detalles.
/// Debería haber recibido una copia de la Licencia Pública General junto
/// con este programa. Si no ha sido así, escriba a la Free Software
/// Foundation, Inc., en 675 Mass Ave, Cambridge, MA 02139, EEUU.
///

#include <pic18fregs.h>
#include <stdio.h>
#include <usart.h>
#include "usb.h"

// Constantes definidas por el tamaño de la pagina Braille
#define BYTESXLIN 3
#define NUMLINES 7

// Nombres de lo que esta conectado al puerto del PIC, mirar esquemático del circuito y el pinout
// En el puerto D están conectados dos entradas y la salida del percutor
#define SENS_PAPEL PORTDbits.RD3
#define SENS_CARRO PORTDbits.RD2
#define PERCUTOR PORTDbits.RD1

#define CARRO 1
#define RODILLO 0
// visto desde el frente de la impresora
#define IZQ 1
#define DER 0
// a como sale la hoja impresa
#define ARR 1
#define ABAJ 0
// Extensión máxima de pasos que puede recorrer el carro
#define RECORR_CARRO 136

// NOTA: Hay problemas relacionados al tiempo asociados con GET_FEAUTURE
// cuando corre a menos de 48 MHz

// Corriente:
//   23 mA @ 16 MHz
//   26 mA @ 24 MHz
//   35 mA @ 48 MHz
//
// Definición de los registros de configuración de fusibles (fuses)
#if defined(pic18f2550) || defined(pic18f2455) || defined(pic18f4550) || defined(pic18f4455)
code char at 0x300000 CONFIG1L = 0x20; // CPU system clock 96MHz PLL div 2, Oscillator No div (4MHz input)
code char at 0x300001 CONFIG1H = 0x0e; // HS oscillator, PLL enabled, HS used by USB
code char at 0x300002 CONFIG2L = 0x20; // Brown out off, PWRT On 
code char at 0x300003 CONFIG2H = 0x00; // WDT off
code char at 0x300004 CONFIG3L = 0xff; // Unused configuration bits
code char at 0x300005 CONFIG3H = 0x81; // MCLR, PORTB digital, CCP2 - RC1
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
void UserInit(void){
    ADCON0 = 0xFF;		// Establece RA4 como salida
    ADCON1 = 0x0F;		// Establecer todos los pines de I/O a digital
    
    TRISB = 0x00;
    TRISD = 0xc;
    INTCON = 0;
    INTCON2 = 0;

    PORTB=0x00;	
    PERCUTOR = 0;
}

// Rutina que genera un delay aproximado hecho sin presicion (para ver los LEDs encendidos)

void delay(int ms){
int i;
	while(ms--)
		for(i=0;i<50;i++); // Estos números son ciclos sucifientes para generar retardo
}
// Bucle central de proceso. En cuanto el firmware no esta ocupado atendiendo
// el USB, se toma control acá para hacer otro procesamiento.


// Funciones para el comando de las partes móviles de la impresora

// Función q se usa exlcusivamente para calibrar los motores


void apagar_motores(void){
	PORTB = 0x00;
}

void mover(byte loops, byte direccion, byte motor){
byte pasosI[8] = {0x77, 0x33, 0xbb, 0x99, 0xdd, 0xcc, 0xee, 0x66};
byte pasosD[8] = {0x66, 0xee, 0xcc, 0xdd, 0x99, 0xbb, 0x33, 0x77}; // <--- CAMBIAR!!!!
byte valor,i;
byte loops_aux ;

if(direccion)
	for(loops_aux=0; loops_aux < loops; loops_aux++){
		for(i = 0; i < 8; i++){		
		valor = pasosI[i];
		if(motor){
			PORTB = (PORTB & 0xf0) | (valor & 0x0f);
			delay(50);
		        }
		else	{
			PORTB = (PORTB & 0x0f) | (valor & 0xf0);
			delay(50);
		        }       	
		}
	}
else
	for(loops_aux=0; loops_aux < loops; loops_aux++){
		for(i = 0; i < 8; i++){		
		valor = pasosD[i];
		if(motor){
			PORTB = (PORTB & 0xf0) | (valor & 0x0f);
			delay(50);
		         }
		else    {
			PORTB = (PORTB & 0x0f) | (valor & 0xf0);
		        delay(50);
		        }
		}
	}
}

void reset_carro(void){
	while(SENS_CARRO)
		mover(1, IZQ, CARRO);
	return;
}

void golpear(void){
	PERCUTOR = 1;
	delay(100);
	PERCUTOR = 0;
	delay(100);
}

// Funciones para la realización de la impresión

void check_bit(int ind, byte pos){ // posicion del bit del 0 al 7
byte mascara, aux;
	mascara = 0x01; // Para la lectura del cada bit
	mascara = mascara << pos;
	aux = pagina[ind] & mascara;
	if (aux)
		golpear();
	// para indicar un cero
	/*else
	{	PERCUTOR = 0;
	PERCUTOR = 1;
	delay(800);
	PERCUTOR = 0;
	delay(800);
	PERCUTOR = 1;
	delay(800);
	PERCUTOR = 0;
	}*/
}

void print_byte(int ind){
byte a, i;
	for (i = 8; i > 0; i--){
		check_bit(ind, i-1);
		a =(byte)i;

		if (!(a&1)) // Chequea la paridad
	// Deplazar carro
			mover(3, DER, CARRO); // Separacion horizontal mínima del caracter braille
		else
	// Deplazar carro
			mover(6, DER, CARRO); // Separacion horizontal máxima del caracter braille
	}
}

void print_line(byte linea){
byte i, j;					// CUIDADO, puede requerir tipo @int
	apagar_motores();
	mover(15, DER, CARRO);
	j = linea*BYTESXLIN;
	for (i = j; i < j + BYTESXLIN; i++)
		print_byte(i);
	reset_carro();  // en realidad, cambiar para que no llegue hasta el fondo
	apagar_motores();

}

void print_page(void){
byte i;
	
	for(i = 0; i < NUMLINES; i++){
		print_line(i);
	// Girar rodillo
		mover(40, ARR, RODILLO); // Separacion mínima vertical del caracter braille
		i++;
		print_line(i);
	// Girar rodillo
		mover(40, ARR, RODILLO); // Separacion mínima vertical del caracter braille
		i++;
		print_line(i);
	// Girar rodillo
		mover(70, ARR, RODILLO); // Separacion máxima vertical del caracter braille
	}
}
/*
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
	// Deplazar carro
		mover(1, DER, CARRO); // Separacion mínima horizontal del caracter braille
		mascara = mascara >> 1; // Para lectura del siguiente bit
	
		if (aux)
			golpear();
	// Deplazar carro
		mover(2, DER, CARRO); // Separacion máxima horizontal del caracter braille
		mascara = mascara >> 1;
		}
		i++;
		}
	// Girar rodillo
		mover(3, ARR, RODILLO); // Separacion mínima vertical del caracter braille
		reset_carro();
	}
	// Girar rodillo
	mover(5, ARR, RODILLO); // Separacion máxima vertical del caracter braille
	reset_carro();
}
} */
static void USBEcho(void){
	byte rxCnt, i;

        // Find out if an Output report has been received from the host
//	rxCnt = BulkOut(rxBuffer, OUTPUT_BYTES);

	if (rxCnt == 0) return;
	for(i=0;i<OUTPUT_BYTES;i++)
		pagina[i]=rxBuffer[i];
	// Estas dos lineas modifican el original
	
	print_page();
	apagar_motores();

// se mandan estos datos por el USB al finalizar el proceso de impresión
pagina[0]=rxCnt;

	for(i=0;i<OUTPUT_BYTES;i++)
		txBuffer[i]=pagina[i];
	
//	BulkIn(txBuffer, OUTPUT_BYTES);
	// ACA EMPEZAMOS A MODIFICAR
}

void ProcessIO(void){	
	// Tareas de aplicación de Usuario USB
    if ((deviceState < CONFIGURED) || (UCONbits.SUSPND==1))
		return;

	// Proceso USB: Agregar acá la función que realiza el dispositivo
	// ACA!!

	USBEcho();

// Las siguientes lineas hacen que el dispositivo haga un eco de lo que recibe por el bus USB
}

// Punto de entrada del Firmware
void main(void){
	// LLamada a la función de inicialización de usuario
	UserInit();
	// Inicializar USB
    UCFG = 0x14; // Habilita las resistencias de pullup; modo full speed

// Condiciones iniciales del dispositivo
    deviceState = DETACHED;
    remoteWakeup = 0x00;
    currentConfiguration = 0x00;	


	reset_carro();
	
	while(1){
	// Asegurar que el modulo USB está disponible
		EnableUSBModule();

	// En cuanto sale del modo de prueba (UTEYE), procesa
	// las transactiones USB
		if(UCFGbits.UTEYE != 1)
			ProcessUSBTransactions();

        // Tareas de apliacación específica
		ProcessIO();
	
	}
}
//sdcc --vc --fstack --denable-peeps --optimize-goto --optimize-cmp --optimize-df --obanksel=9 --opt-code-size --fommit-/frame-pointer -mpic16 -p18f45100 -I /usr/share/sdcc/include/pic16/ -c usb.c

//sdcc --vc --fstack --denable-peeps --optimize-goto --optimize-cmp --optimize-df --obanksel=9 --opt-code-size --fommit-frame-pointer -mpic16 -p18f45100 -I /home/rajazz/Final/PICHID\ -Para\ meter\ mano/ -L /usr/share/sdcc/lib/pic16/ -Wl,"-w -s 18f45100.lkr" main.c usb.o

