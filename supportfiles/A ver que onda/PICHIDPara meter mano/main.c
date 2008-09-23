// Demonstration code of USB I/O on PIC 18F2455 (and siblings) -
// turn LED on/off and echo a buffer back to host.
//
// Copyright (C) 2005 Alexander Enzmann
//
// This library is free software; you can redistribute it and/or
// modify it under the terms of the GNU Lesser General Public
// License as published by the Free Software Foundation; either
// version 2.1 of the License, or (at your option) any later version.
//
// This library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public
// License along with this library; if not, write to the Free Software
// Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
//

#include <pic18fregs.h>
#include <stdio.h>
#include <usart.h>
#include "usb.h"

// Note: there are timing related problems associated with GET_FEATURE
// when run at less than 48 MHz
#define CLK_48MHZ 1

// Current:
//   23 mA @ 16 MHz
//   26 mA @ 24 MHz
//   35 mA @ 48 MHz
//
// Define configuration registers (fuses)
#if defined(pic18f2550) || defined(pic18f2455) || defined(pic18f4550) || defined(pic18f4455)
#if CLK_48MHZ
code char at 0x300000 CONFIG1L = 0x24; // USB, /2 post (48MHz), /5 pre (20 MHz)
#else
code char at 0x300000 CONFIG1L = 0x3c; // USB, /6 post (16MHz), /5 pre (20 MHz)
// code char at 0x300000 CONFIG1L = 0x34; // USB, /4 post (24MHz), /5 pre (20 MHz)
#endif
code char at 0x300001 CONFIG1H = 0x0e; // IESO=0, FCMEN=0, HS-PLL (40MHz)
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

// HID feature buffer
volatile unsigned char HIDFeatureBuffer[HID_FEATURE_REPORT_BYTES];

void high_isr(void) shadowregs interrupt 1
{
	;
}

void low_isr(void) shadowregs interrupt 2
{
	;
}

// Allocate buffers in RAM for storage of bytes that have either just
// come in from the SIE or are waiting to go out to the SIE.
char txBuffer[HID_INPUT_REPORT_BYTES];
char rxBuffer[HID_OUTPUT_REPORT_BYTES];

#if DEBUG_PRINT
// SDCC wants a user-defined function for putchar(c) that it can reuse for
// all the printf() style functions.  The macro PUTCHAR is defined in stdio.h.
PUTCHAR(c)
{
    __stream_putchar(stdout, c);
}

static unsigned char RxRS232()
{
    unsigned char rxByte;
 
    _asm clrwdt _endasm;

    // Check for Overrun Error
    if (RCSTA & 0x02)
    {
        // OERR - Overrun Error, should be able to clear by clearing CREN
        RCSTA &= 0xef;
        RCSTA |= 0x10;
    }


    // Wait until RCIF (bit 5) is clear in PIR
    while (!usart_drdy())
        ;

    // Valid data is now in RCREG
    rxByte = usart_getc();

    return rxByte;
}

static void TxRS232(unsigned char txData)
{
    _asm clrwdt _endasm;

    putchar(txData);
}

static void InitializeUSART()
{
    TRISC &= 0xBF; // Set RC6 as an output
    TRISC |= 0x80; // Set RC7 as an input
    RCSTA   = 0x90; // Enable serial port, enable receiver
    TXSTA   = 0x24; // Asynch, TSR empty, BRGH=1

    // Baud rate formula for BRG16=1, BRGH=1: Baud Rate = Fosc/(4 (n + 1)),
    // or n = (Fosc / (4 * BaudRate)) - 1
    // At 48 MHz, for 115.2K Baud:
    //     SPBRGH:SPBRG = n = Fosc / (4 * 115200) - 1 = 103.17
    BAUDCON = 0x08; // BRG16=1
    SPBRGH  = 0x00; // At 48MHz, SPBRGH=0, SPBRG=103 gives 115.2K Baud
#if CLK_48MHZ
    SPBRG   = 103;  // For 48 MHz clock
#else
    SPBRG   = 52;   // For 24 MHz clock
#endif

    // Assign standard input and output to the USART
    stdin = STREAM_USART;
    stdout = STREAM_USART;


    printf("USB Test Startup\r\n");
}
#endif

// Regardless of what the USB is up to, we check the USART to see
// if there's something we should be doing.
static void checkEcho()
{
#if DEBUG_PRINT
    if (usart_drdy())
    {
        // Have a character to echo
		unsigned char rxByte;
		PORTAbits.RA4 ^= 1;
		rxByte = usart_getc();
		putchar(rxByte);
		if (rxByte == 'X')
		{
			if(deviceState == DETACHED)
				printf("Detached\r\n");
			else if(deviceState == ATTACHED)
				printf("Attached\r\n");
			else if(deviceState == POWERED)
				printf("Powered\r\n");
			else if(deviceState == DEFAULT)
				printf("Default\r\n");
			else if(deviceState == ADDRESS)
				printf("Address\r\n");
			else if(deviceState == CONFIGURED)
				printf("Configured\r\n");
			else
				printf("Unknown state\r\n");

			printf("UCON: %x, UCFG: %x\r\n", UCON, UCFG);
        }
    }
#endif
}

// Entry point for user initialization
void UserInit(void)
{
#if DEBUG_PRINT
	InitializeUSART();
#endif

    // Set RA4 as an output
    TRISA &= 0xEF;
}

// If we got some bytes from the host, then echo them back.
static void USBEcho(void)
{
    byte rxCnt, i;

    // Find out if an Output report has been received from the host.
    rxCnt = HIDRxReport(rxBuffer, HID_OUTPUT_REPORT_BYTES);

	// If no bytes in, then nothing to do
	if (rxCnt == 0)
		return;

    // Copy input bytes to the output buffer
	for (i=0;i<HID_OUTPUT_REPORT_BYTES;i++)
        txBuffer[i] = rxBuffer[i];            

    // As long as the SIE is owned by the processor, we let USB tasks continue.
	while (ep1Bi.Stat & UOWN)
        ProcessUSBTransactions(); 

    // The report will be sent in the next interrupt IN transfer.
    HIDTxReport(txBuffer, HID_INPUT_REPORT_BYTES);
}

// Central processing loop.  Whenever the firmware isn't busy servicing
// the USB, we will get control here to do other processing.
void ProcessIO(void)
{
	// Process USART
    checkEcho();

    // User Application USB tasks
    if ((deviceState < CONFIGURED) || (UCONbits.SUSPND==1))
		return;

	// Process USB: Echo back any bytes that have come in.
    USBEcho();
}

// Initialization for a SET_FEATURE request.  This routine will be
// invoked during the setup stage and is used to set up the buffer
// for receiving data from the host
void SetupFeatureReport(byte reportID)
{
    if (reportID == 0)
    {
        // When the report arrives in the data stage, the data will be  
        // stored in HIDFeatureBuffer.
        inPtr = (byte*)&HIDFeatureBuffer;
    }
}

// Post processing for a SET_FEATURE request.  After all the data has
// been delivered from host to device, this will be invoked to perform
// application specific processing.
void SetFeatureReport(byte reportID)
{
#if DEBUG_PRINT
	//printf("SetFeatureReport(0x%hx)\r\n", reportID);
#endif
    // Currently only handling report 0, ignore any others.
   if (reportID == 0)
    {
        // Set the state of the LED based on bit 0 of the first byte
        // of the feature report.
	PORTEbits.RE0 = (HIDFeatureBuffer[0] & 0x01);


    }
   /* if (reportID == 1)
    {
        // Set the state of the LED based on bit 0 of the first byte
        // of the feature report.
	PORTEbits.RE1 = (HIDFeatureBuffer[0] & 0xFF);

    }
    if (reportID == 2)
    {
        // Set the state of the LED based on bit 0 of the first byte
        // of the feature report.
	PORTEbits.RE2 = (HIDFeatureBuffer[0] & 0xFF);

    }*/

}

// Handle a feature report request on the control pipe
void GetFeatureReport(byte reportID)
{
#if DEBUG_PRINT
	//printf("GetFeatureReport(0x%uhx): 0x%hx, 0x%hx\r\n",
	//	(byte)reportID, (byte)HIDFeatureBuffer[0],
	//	(byte)HIDFeatureBuffer[1]);
#endif
	if (reportID == 0)
	{
		// Handle report #0
		outPtr = (byte *)&HIDFeatureBuffer;
		HIDFeatureBuffer[0] = PORTA;
		// HIDFeatureBuffer[HID_FEATURE_REPORT_BYTES-1] = 0x2C;
		wCount = HID_FEATURE_REPORT_BYTES;
	}
}

// Handle control out.  This might be an alternate way of processing
// an output report, so all that's needed is to point the output
// pointer to the output buffer
// Initialization for a SET_REPORT request.  This routine will be
// invoked during the setup stage and is used to set up the buffer
// for receiving data from the host
void SetupOutputReport(byte reportID)
{
	if (reportID == 0)
	{
		// When the report arrives in the data stage, the data will be  
		// stored in HIDFeatureBuffer
		inPtr = (byte*)&HIDRxBuffer;
	}
}

// Post processing for a SET_REPORT request.  After all the data has
// been delivered from host to device, this will be invoked to perform
// application specific processing.
void SetOutputReport(byte reportID)
{
#if DEBUG_PRINT
	//printf("SetOutputReport(0x%hx)\r\n", reportID);
#endif
	// Currently only handling report 0, ignore any others.
	if (reportID != 0)
		return;

	// TBD: do something.  Not currently implemented because the output
	// report is being handled by an interrupt endpoint.
}

// Handle a control input report
void GetInputReport(byte reportID)
{
#if DEBUG_PRINT
	printf("GetInputReport: 0x%uhx\r\n", reportID);
#endif
	if (reportID == 0)
	{
		// Send back the contents of the HID report
		// TBD: provide useful information...
		outPtr = (byte *)&HIDTxBuffer;

		// The number of bytes in the report (from usb.h).
		wCount = HID_INPUT_REPORT_BYTES;
	}
}

// Entry point of the firmware
void main(void)
{
	// Set all I/O pins to digital
    ADCON1 |= 0x0F;
    
	// Initialize USB
    UCFG = 0x14; // Enable pullup resistors; full speed mode

	ADCON0=0xFF;
	INTCON=0;
	INTCON2=0;
	_asm
	clrf 0xF96
	_endasm;
	PORTE=0;


    deviceState = DETACHED;
    remoteWakeup = 0x00;
    currentConfiguration = 0x00;

	// Call user initialization function
    UserInit();


	while(1)
    {
        // Ensure USB module is available
		EnableUSBModule();

		// As long as we aren't in test mode (UTEYE), process
		// USB transactions.
		if(UCFGbits.UTEYE != 1)
			ProcessUSBTransactions();

        // Application specific tasks
        ProcessIO();
    }
}


//sdcc --vc --fstack --denable-peeps --optimize-goto --optimize-cmp --optimize-df --obanksel=9 --opt-code-size --fommit-/frame-pointer -mpic16 -p18f4550 -I /usr/share/sdcc/include/pic16/ -c usb.c

//sdcc --vc --fstack --denable-peeps --optimize-goto --optimize-cmp --optimize-df --obanksel=9 --opt-code-size --fommit-frame-pointer -mpic16 -p18f4550 -I /home/rajazz/Final/PICHID\ -Para\ meter\ mano/ -L /usr/share/sdcc/lib/pic16/ -Wl,"-w -s 18f4550.lkr" main.c usb.o

