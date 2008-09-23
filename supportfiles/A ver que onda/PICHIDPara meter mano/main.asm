;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.6.0 #4309 (Nov 10 2006)
; This file generated Mon Feb 25 20:19:55 2008
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------
	list	p=18f4550
	__config 0x300000, 0x24
	__config 0x300001, 0xe
	__config 0x300002, 0x20
	__config 0x300003, 0x0
	__config 0x300005, 0x1
	__config 0x300006, 0x80
	__config 0x300008, 0xff
	__config 0x300009, 0xff
	__config 0x30000a, 0xff
	__config 0x30000b, 0xff
	__config 0x30000c, 0xff
	__config 0x30000d, 0xff

	radix dec

;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global _HIDFeatureBuffer
	global _txBuffer
	global _rxBuffer
	global _high_isr
	global _low_isr
	global _UserInit
	global _ProcessIO
	global _SetupFeatureReport
	global _SetFeatureReport
	global _GetFeatureReport
	global _SetupOutputReport
	global _SetOutputReport
	global _GetInputReport
	global _main

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern _SPPDATAbits
	extern _SPPCFGbits
	extern _SPPEPSbits
	extern _SPPCONbits
	extern _UFRMLbits
	extern _UFRMHbits
	extern _UIRbits
	extern _UIEbits
	extern _UEIRbits
	extern _UEIEbits
	extern _USTATbits
	extern _UCONbits
	extern _UADDRbits
	extern _UCFGbits
	extern _UEP0bits
	extern _UEP1bits
	extern _UEP2bits
	extern _UEP3bits
	extern _UEP4bits
	extern _UEP5bits
	extern _UEP6bits
	extern _UEP7bits
	extern _UEP8bits
	extern _UEP9bits
	extern _UEP10bits
	extern _UEP11bits
	extern _UEP12bits
	extern _UEP13bits
	extern _UEP14bits
	extern _UEP15bits
	extern _PORTAbits
	extern _PORTBbits
	extern _PORTCbits
	extern _PORTEbits
	extern _LATAbits
	extern _LATBbits
	extern _LATCbits
	extern _TRISAbits
	extern _TRISBbits
	extern _TRISCbits
	extern _OSCTUNEbits
	extern _PIE1bits
	extern _PIR1bits
	extern _IPR1bits
	extern _PIE2bits
	extern _PIR2bits
	extern _IPR2bits
	extern _EECON1bits
	extern _RCSTAbits
	extern _TXSTAbits
	extern _T3CONbits
	extern _CMCONbits
	extern _CVRCONbits
	extern _ECCP1ASbits
	extern _ECCP1DELbits
	extern _BAUDCONbits
	extern _CCP2CONbits
	extern _CCP1CONbits
	extern _ADCON2bits
	extern _ADCON1bits
	extern _ADCON0bits
	extern _SSPCON2bits
	extern _SSPCON1bits
	extern _SSPSTATbits
	extern _T2CONbits
	extern _T1CONbits
	extern _RCONbits
	extern _WDTCONbits
	extern _HLVDCONbits
	extern _OSCCONbits
	extern _T0CONbits
	extern _STATUSbits
	extern _FSR2Hbits
	extern _BSRbits
	extern _FSR1Hbits
	extern _FSR0Hbits
	extern _INTCON3bits
	extern _INTCON2bits
	extern _INTCONbits
	extern _TBLPTRUbits
	extern _PCLATHbits
	extern _PCLATUbits
	extern _STKPTRbits
	extern _TOSUbits
	extern _stdin
	extern _stdout
	extern _deviceState
	extern _selfPowered
	extern _remoteWakeup
	extern _currentConfiguration
	extern _ep0Bo
	extern _ep0Bi
	extern _ep1Bo
	extern _ep1Bi
	extern _SetupPacket
	extern _HIDRxBuffer
	extern _HIDTxBuffer
	extern _outPtr
	extern _inPtr
	extern _wCount
	extern _hidRxLen
	extern _SPPDATA
	extern _SPPCFG
	extern _SPPEPS
	extern _SPPCON
	extern _UFRML
	extern _UFRMH
	extern _UIR
	extern _UIE
	extern _UEIR
	extern _UEIE
	extern _USTAT
	extern _UCON
	extern _UADDR
	extern _UCFG
	extern _UEP0
	extern _UEP1
	extern _UEP2
	extern _UEP3
	extern _UEP4
	extern _UEP5
	extern _UEP6
	extern _UEP7
	extern _UEP8
	extern _UEP9
	extern _UEP10
	extern _UEP11
	extern _UEP12
	extern _UEP13
	extern _UEP14
	extern _UEP15
	extern _PORTA
	extern _PORTB
	extern _PORTC
	extern _PORTE
	extern _LATA
	extern _LATB
	extern _LATC
	extern _TRISA
	extern _TRISB
	extern _TRISC
	extern _OSCTUNE
	extern _PIE1
	extern _PIR1
	extern _IPR1
	extern _PIE2
	extern _PIR2
	extern _IPR2
	extern _EECON1
	extern _EECON2
	extern _EEDATA
	extern _EEADR
	extern _RCSTA
	extern _TXSTA
	extern _TXREG
	extern _RCREG
	extern _SPBRG
	extern _SPBRGH
	extern _T3CON
	extern _TMR3L
	extern _TMR3H
	extern _CMCON
	extern _CVRCON
	extern _ECCP1AS
	extern _ECCP1DEL
	extern _BAUDCON
	extern _CCP2CON
	extern _CCPR2L
	extern _CCPR2H
	extern _CCP1CON
	extern _CCPR1L
	extern _CCPR1H
	extern _ADCON2
	extern _ADCON1
	extern _ADCON0
	extern _ADRESL
	extern _ADRESH
	extern _SSPCON2
	extern _SSPCON1
	extern _SSPSTAT
	extern _SSPADD
	extern _SSPBUF
	extern _T2CON
	extern _PR2
	extern _TMR2
	extern _T1CON
	extern _TMR1L
	extern _TMR1H
	extern _RCON
	extern _WDTCON
	extern _HLVDCON
	extern _OSCCON
	extern _T0CON
	extern _TMR0L
	extern _TMR0H
	extern _STATUS
	extern _FSR2L
	extern _FSR2H
	extern _PLUSW2
	extern _PREINC2
	extern _POSTDEC2
	extern _POSTINC2
	extern _INDF2
	extern _BSR
	extern _FSR1L
	extern _FSR1H
	extern _PLUSW1
	extern _PREINC1
	extern _POSTDEC1
	extern _POSTINC1
	extern _INDF1
	extern _WREG
	extern _FSR0L
	extern _FSR0H
	extern _PLUSW0
	extern _PREINC0
	extern _POSTDEC0
	extern _POSTINC0
	extern _INDF0
	extern _INTCON3
	extern _INTCON2
	extern _INTCON
	extern _PRODL
	extern _PRODH
	extern _TABLAT
	extern _TBLPTRL
	extern _TBLPTRH
	extern _TBLPTRU
	extern _PCL
	extern _PCLATH
	extern _PCLATU
	extern _STKPTR
	extern _TOSL
	extern _TOSH
	extern _TOSU
	extern _EnableUSBModule
	extern _ProcessUSBTransactions
	extern _HIDTxReport
	extern _HIDRxReport
;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
PCLATH	equ	0xffa
PCLATU	equ	0xffb
FSR0L	equ	0xfe9
FSR0H	equ	0xfea
FSR1L	equ	0xfe1
FSR2L	equ	0xfd9
INDF0	equ	0xfef
POSTDEC1	equ	0xfe5
PREINC1	equ	0xfe4
PLUSW2	equ	0xfdb
PRODL	equ	0xff3
PRODH	equ	0xff4


; Internal registers
.registers	udata_ovr	0x0000
r0x00	res	1
r0x01	res	1
r0x02	res	1
r0x03	res	1
r0x04	res	1

udata_main_0	udata
_rxBuffer	res	32

udata_main_1	udata
_txBuffer	res	32

udata_main_2	udata
_HIDFeatureBuffer	res	32

;--------------------------------------------------------
; interrupt vector 
;--------------------------------------------------------

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; ; Starting pCode block for absolute section
; ;-----------------------------------------
S_main_ivec_0x1_high_isr	code	0X000008
ivec_0x1_high_isr:
	GOTO	_high_isr

; ; Starting pCode block for absolute section
; ;-----------------------------------------
S_main_ivec_0x2_low_isr	code	0X000018
ivec_0x2_low_isr:
	GOTO	_low_isr

; I code from now on!
; ; Starting pCode block
S_main__main	code
_main:
;	.line	347; main.c	ADCON1 |= 0x0F;
	MOVLW	0x0f
	IORWF	_ADCON1, F
;	.line	350; main.c	UCFG = 0x14; // Enable pullup resistors; full speed mode
	MOVLW	0x14
	MOVWF	_UCFG
;	.line	352; main.c	ADCON0=0xFF;
	MOVLW	0xff
	MOVWF	_ADCON0
;	.line	353; main.c	INTCON=0;
	CLRF	_INTCON
;	.line	354; main.c	INTCON2=0;
	CLRF	_INTCON2
	clrf 0xF96
	
;	.line	358; main.c	PORTE=0;
	CLRF	_PORTE
	BANKSEL	_deviceState
;	.line	361; main.c	deviceState = DETACHED;
	CLRF	_deviceState, B
	BANKSEL	_remoteWakeup
;	.line	362; main.c	remoteWakeup = 0x00;
	CLRF	_remoteWakeup, B
	BANKSEL	_currentConfiguration
;	.line	363; main.c	currentConfiguration = 0x00;
	CLRF	_currentConfiguration, B
;	.line	366; main.c	UserInit();
	CALL	_UserInit
_00200_DS_:
;	.line	372; main.c	EnableUSBModule();
	CALL	_EnableUSBModule
;	.line	376; main.c	if(UCFGbits.UTEYE != 1)
	CLRF	r0x00
	BTFSC	_UCFGbits, 7
	INCF	r0x00, F
	MOVF	r0x00, W
	XORLW	0x01
	BZ	_00198_DS_
;	.line	377; main.c	ProcessUSBTransactions();
	CALL	_ProcessUSBTransactions
_00198_DS_:
;	.line	380; main.c	ProcessIO();
	CALL	_ProcessIO
	BRA	_00200_DS_
	RETURN	

; ; Starting pCode block
S_main__GetInputReport	code
_GetInputReport:
;	.line	327; main.c	void GetInputReport(byte reportID)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	332; main.c	if (reportID == 0)
	MOVF	r0x00, W
	BNZ	_00192_DS_
;	.line	336; main.c	outPtr = (byte *)&HIDTxBuffer;
	MOVLW	HIGH(_HIDTxBuffer)
	BANKSEL	(_outPtr + 1)
	MOVWF	(_outPtr + 1), B
	MOVLW	LOW(_HIDTxBuffer)
; removed redundant BANKSEL
	MOVWF	_outPtr, B
	MOVLW	0x80
; removed redundant BANKSEL
	MOVWF	(_outPtr + 2), B
;	.line	339; main.c	wCount = HID_INPUT_REPORT_BYTES;
	MOVLW	0x20
	BANKSEL	_wCount
	MOVWF	_wCount, B
; removed redundant BANKSEL
	CLRF	(_wCount + 1), B
_00192_DS_:
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__SetOutputReport	code
_SetOutputReport:
;	.line	313; main.c	void SetOutputReport(byte reportID)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	319; main.c	if (reportID != 0)
	MOVF	r0x00, W
	BNZ	_00182_DS_
_00182_DS_:
;	.line	320; main.c	return;
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__SetupOutputReport	code
_SetupOutputReport:
;	.line	300; main.c	void SetupOutputReport(byte reportID)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	302; main.c	if (reportID == 0)
	MOVF	r0x00, W
	BNZ	_00175_DS_
;	.line	306; main.c	inPtr = (byte*)&HIDRxBuffer;
	MOVLW	HIGH(_HIDRxBuffer)
	BANKSEL	(_inPtr + 1)
	MOVWF	(_inPtr + 1), B
	MOVLW	LOW(_HIDRxBuffer)
; removed redundant BANKSEL
	MOVWF	_inPtr, B
	MOVLW	0x80
; removed redundant BANKSEL
	MOVWF	(_inPtr + 2), B
_00175_DS_:
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__GetFeatureReport	code
_GetFeatureReport:
;	.line	277; main.c	void GetFeatureReport(byte reportID)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	284; main.c	if (reportID == 0)
	MOVF	r0x00, W
	BNZ	_00168_DS_
;	.line	287; main.c	outPtr = (byte *)&HIDFeatureBuffer;
	MOVLW	HIGH(_HIDFeatureBuffer)
	BANKSEL	(_outPtr + 1)
	MOVWF	(_outPtr + 1), B
	MOVLW	LOW(_HIDFeatureBuffer)
; removed redundant BANKSEL
	MOVWF	_outPtr, B
	MOVLW	0x80
; removed redundant BANKSEL
	MOVWF	(_outPtr + 2), B
;	.line	288; main.c	HIDFeatureBuffer[0] = PORTA;
	MOVF	_PORTA, W
	BANKSEL	_HIDFeatureBuffer
	MOVWF	_HIDFeatureBuffer, B
;	.line	290; main.c	wCount = HID_FEATURE_REPORT_BYTES;
	MOVLW	0x20
	BANKSEL	_wCount
	MOVWF	_wCount, B
; removed redundant BANKSEL
	CLRF	(_wCount + 1), B
_00168_DS_:
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__SetFeatureReport	code
_SetFeatureReport:
;	.line	245; main.c	void SetFeatureReport(byte reportID)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	251; main.c	if (reportID == 0)
	MOVF	r0x00, W
	BNZ	_00161_DS_
;	.line	255; main.c	PORTEbits.RE0 = (HIDFeatureBuffer[0] & 0x01);
	MOVLW	0x01
	BANKSEL	_HIDFeatureBuffer
	ANDWF	_HIDFeatureBuffer, W, B
; #	MOVWF	r0x00
; #	MOVF	r0x00, W
; ;     peep 2 - Removed redundant move
	ANDLW	0x01
	MOVWF	PRODH
	MOVF	_PORTEbits, W
	ANDLW	0xfe
	IORWF	PRODH, W
	MOVWF	_PORTEbits
_00161_DS_:
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__SetupFeatureReport	code
_SetupFeatureReport:
;	.line	232; main.c	void SetupFeatureReport(byte reportID)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
;	.line	234; main.c	if (reportID == 0)
	MOVF	r0x00, W
	BNZ	_00154_DS_
;	.line	238; main.c	inPtr = (byte*)&HIDFeatureBuffer;
	MOVLW	HIGH(_HIDFeatureBuffer)
	BANKSEL	(_inPtr + 1)
	MOVWF	(_inPtr + 1), B
	MOVLW	LOW(_HIDFeatureBuffer)
; removed redundant BANKSEL
	MOVWF	_inPtr, B
	MOVLW	0x80
; removed redundant BANKSEL
	MOVWF	(_inPtr + 2), B
_00154_DS_:
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__ProcessIO	code
_ProcessIO:
;	.line	216; main.c	void ProcessIO(void)
	MOVFF	r0x00, POSTDEC1
;	.line	219; main.c	checkEcho();
	CALL	_checkEcho
;	.line	222; main.c	if ((deviceState < CONFIGURED) || (UCONbits.SUSPND==1))
	MOVLW	0x05
	BANKSEL	_deviceState
	SUBWF	_deviceState, W, B
	BNC	_00139_DS_
	CLRF	r0x00
	BTFSC	_UCONbits, 1
	INCF	r0x00, F
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00140_DS_
_00139_DS_:
;	.line	223; main.c	return;
	BRA	_00142_DS_
_00140_DS_:
;	.line	226; main.c	USBEcho();
	CALL	_USBEcho
_00142_DS_:
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_main__USBEcho	code
_USBEcho:
;	.line	191; main.c	static void USBEcho(void)
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
;	.line	196; main.c	rxCnt = HIDRxReport(rxBuffer, HID_OUTPUT_REPORT_BYTES);
	MOVLW	HIGH(_rxBuffer)
	MOVWF	r0x01
	MOVLW	LOW(_rxBuffer)
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x02
	MOVLW	0x20
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_HIDRxReport
	MOVWF	r0x00
	MOVLW	0x04
	ADDWF	FSR1L, F
; #	MOVF	r0x00, W
; #	BTFSS	STATUS, 2
; #	GOTO	_00134_DS_
; #	GOTO	_00130_DS_
; #	CLRF	r0x00
; ;     peep 1 - test/jump to test/skip
;	.line	199; main.c	if (rxCnt == 0)
	MOVF	r0x00, W
;	.line	200; main.c	return;
	BZ	_00130_DS_
;	.line	203; main.c	for (i=0;i<HID_OUTPUT_REPORT_BYTES;i++)
	CLRF	r0x00
_00126_DS_:
	MOVLW	0x20
	SUBWF	r0x00, W
	BC	_00123_DS_
;	.line	204; main.c	txBuffer[i] = rxBuffer[i];            
	MOVLW	LOW(_txBuffer)
	ADDWF	r0x00, W
	MOVWF	r0x01
	CLRF	r0x02
	MOVLW	HIGH(_txBuffer)
	ADDWFC	r0x02, F
	MOVLW	LOW(_rxBuffer)
	ADDWF	r0x00, W
	MOVWF	r0x03
	CLRF	r0x04
	MOVLW	HIGH(_rxBuffer)
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVFF	INDF0, r0x03
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	MOVFF	r0x03, INDF0
;	.line	203; main.c	for (i=0;i<HID_OUTPUT_REPORT_BYTES;i++)
	INCF	r0x00, F
	BRA	_00126_DS_
_00123_DS_:
	BANKSEL	_ep1Bi
;	.line	207; main.c	while (ep1Bi.Stat & UOWN)
	BTFSS	_ep1Bi, 7, B
	BRA	_00125_DS_
;	.line	208; main.c	ProcessUSBTransactions(); 
	CALL	_ProcessUSBTransactions
	BRA	_00123_DS_
_00125_DS_:
;	.line	211; main.c	HIDTxReport(txBuffer, HID_INPUT_REPORT_BYTES);
	MOVLW	HIGH(_txBuffer)
	MOVWF	r0x01
	MOVLW	LOW(_txBuffer)
	MOVWF	r0x00
	MOVLW	0x80
	MOVWF	r0x02
	MOVLW	0x20
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_HIDTxReport
	MOVLW	0x04
	ADDWF	FSR1L, F
_00130_DS_:
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_main__UserInit	code
_UserInit:
;	.line	187; main.c	TRISA &= 0xEF;
	BCF	_TRISA, 4
	RETURN	

; ; Starting pCode block
S_main__checkEcho	code
_checkEcho:
;	.line	177; main.c	}
	RETURN	

; ; Starting pCode block
S_main__low_isr	code
_low_isr:
;	.line	66; main.c	void low_isr(void) shadowregs interrupt 2
	MOVFF	PRODL, POSTDEC1
	MOVFF	PRODH, POSTDEC1
	MOVFF	FSR0L, POSTDEC1
	MOVFF	FSR0H, POSTDEC1
	MOVFF	PCLATH, POSTDEC1
	MOVFF	PCLATU, POSTDEC1
;	.line	69; main.c	}
	MOVFF	PREINC1, PCLATU
	MOVFF	PREINC1, PCLATH
	MOVFF	PREINC1, FSR0H
	MOVFF	PREINC1, FSR0L
	MOVFF	PREINC1, PRODH
	MOVFF	PREINC1, PRODL
	RETFIE	0x01

; ; Starting pCode block
S_main__high_isr	code
_high_isr:
;	.line	61; main.c	void high_isr(void) shadowregs interrupt 1
	MOVFF	PRODL, POSTDEC1
	MOVFF	PRODH, POSTDEC1
	MOVFF	FSR0L, POSTDEC1
	MOVFF	FSR0H, POSTDEC1
	MOVFF	PCLATH, POSTDEC1
	MOVFF	PCLATU, POSTDEC1
;	.line	64; main.c	}
	MOVFF	PREINC1, PCLATU
	MOVFF	PREINC1, PCLATH
	MOVFF	PREINC1, FSR0H
	MOVFF	PREINC1, FSR0L
	MOVFF	PREINC1, PRODH
	MOVFF	PREINC1, PRODL
	RETFIE	0x01



; Statistics:
; code size:	  696 (0x02b8) bytes ( 0.53%)
;           	  348 (0x015c) words
; udata size:	   96 (0x0060) bytes ( 5.36%)
; access size:	    5 (0x0005) bytes


	end
