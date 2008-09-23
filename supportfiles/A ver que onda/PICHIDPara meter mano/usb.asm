;--------------------------------------------------------
; File Created by SDCC : FreeWare ANSI-C Compiler
; Version 2.6.0 #4309 (Nov 10 2006)
; This file generated Mon Feb 25 20:19:46 2008
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------
	list	p=18f4550

	radix dec

;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global _deviceAddress
	global _HIDTxReport
	global _HIDRxReport
	global _EnableUSBModule
	global _ProcessUSBTransactions
	global _deviceState
	global _remoteWakeup
	global _selfPowered
	global _currentConfiguration
	global _ctrlTransferStage
	global _HIDPostProcess
	global _requestHandled
	global _outPtr
	global _inPtr
	global _wCount
	global _hidIdleRate
	global _hidProtocol
	global _hidRxLen
	global _ep0Bo
	global _ep0Bi
	global _ep1Bo
	global _ep1Bi
	global _SetupPacket
	global _controlTransferBuffer
	global _HIDRxBuffer
	global _HIDTxBuffer
	global _HIDInitEndpoint
	global _HIDGetReport
	global _HIDSetReport
	global _ProcessHIDRequest
	global _ProcessStandardRequest
	global _InDataStage
	global _OutDataStage
	global _SetupStage
	global _WaitForSetupStage
	global _ProcessControlTransfer
	global _UnSuspend
	global _StartOfFrame
	global _Stall
	global _Suspend
	global _BusReset
	global _deviceDescriptor
	global _configDescriptor
	global _HIDReport
	global _stringDescriptor0
	global _stringDescriptor1
	global _stringDescriptor2
	global _dataEEPROM

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern __gptrget1
	extern __gptrput1
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
	extern _GetInputReport
	extern _SetupOutputReport
	extern _SetOutputReport
	extern _GetFeatureReport
	extern _SetupFeatureReport
	extern _SetFeatureReport
;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
WREG	equ	0xfe8
TBLPTRL	equ	0xff6
TBLPTRH	equ	0xff7
TBLPTRU	equ	0xff8
TABLAT	equ	0xff5
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
r0x05	res	1
r0x06	res	1
r0x07	res	1
r0x08	res	1
r0x09	res	1


usbram5	udata
_HIDTxBuffer	res	32
_HIDRxBuffer	res	32
_SetupPacket	res	64
_controlTransferBuffer	res	32

udata_usb_0	udata
_deviceAddress	res	1

udata_usb_1	udata
_hidRxLen	res	1

udata_usb_2	udata
_requestHandled	res	1

udata_usb_3	udata
_outPtr	res	3

udata_usb_4	udata
_wCount	res	2

udata_usb_5	udata
_HIDPostProcess	res	1

udata_usb_6	udata
_hidIdleRate	res	1

udata_usb_7	udata
_hidProtocol	res	1

udata_usb_8	udata
_inPtr	res	3

udata_usb_9	udata
_selfPowered	res	1

udata_usb_10	udata
_remoteWakeup	res	1

udata_usb_11	udata
_deviceState	res	1

udata_usb_12	udata
_currentConfiguration	res	1

udata_usb_13	udata
_ctrlTransferStage	res	1


ustat_usb_00	udata	0X0400
_ep0Bo	res	4
_ep0Bi	res	4
_ep1Bo	res	4
_ep1Bi	res	4

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; ; Starting pCode block for absolute Ival
S_usb__dataEEPROM	code	0XF00000
_dataEEPROM:
	DB	0x00, 0x00, 0x01, 0x00, 0x02, 0x00, 0x03, 0x00, 0x04, 0x00, 0x05, 0x00
	DB	0x06, 0x00, 0x07, 0x00, 0x30, 0x00, 0x31, 0x00, 0x32, 0x00, 0x33, 0x00
	DB	0x34, 0x00, 0x35, 0x00, 0x36, 0x00, 0x37, 0x00, 0x38, 0x00, 0x39, 0x00
	DB	0x61, 0x00, 0x62, 0x00, 0x63, 0x00, 0x64, 0x00, 0x65, 0x00, 0x66, 0x00

; I code from now on!
; ; Starting pCode block
S_usb__ProcessUSBTransactions	code
_ProcessUSBTransactions:
;	.line	1106; usb.c	void ProcessUSBTransactions(void)
	MOVFF	r0x00, POSTDEC1
; #	MOVF	_deviceState, W, B
; #	BTFSS	STATUS, 2
; #	GOTO	_00629_DS_
; #	GOTO	_00655_DS_
; #	BTFSS	_UIRbits, 2
; ;     peep 1 - test/jump to test/skip
	BANKSEL	_deviceState
;	.line	1109; usb.c	if(deviceState == DETACHED)
	MOVF	_deviceState, W, B
;	.line	1110; usb.c	return;
	BZ	_00655_DS_
;	.line	1113; usb.c	if(UIRbits.ACTIVIF && UIEbits.ACTIVIE)
	BTFSS	_UIRbits, 2
; #	GOTO	_00631_DS_
; #	BTFSS	_UIEbits, 2
; #	GOTO	_00631_DS_
; #	CALL	_UnSuspend
; #	CLRF	r0x00
; ;     peep 1 - test/jump to test/skip
;	.line	1114; usb.c	UnSuspend();
	BRA	_00631_DS_
;	.line	1118; usb.c	if(UCONbits.SUSPND == 1)
	BTFSC	_UIEbits, 2
	CALL	_UnSuspend
_00631_DS_:
	CLRF	r0x00
	BTFSC	_UCONbits, 1
	INCF	r0x00, F
	MOVF	r0x00, W
	XORLW	0x01
;	.line	1119; usb.c	return;
	BZ	_00655_DS_
;	.line	1122; usb.c	if (UIRbits.URSTIF && UIEbits.URSTIE)
	BTFSS	_UIRbits, 0
; #	GOTO	_00636_DS_
; #	BTFSS	_UIEbits, 0
; #	GOTO	_00636_DS_
; #	CALL	_BusReset
; #	BTFSS	_UIRbits, 4
; ;     peep 1 - test/jump to test/skip
;	.line	1124; usb.c	BusReset();
	BRA	_00636_DS_
;	.line	1127; usb.c	if (UIRbits.IDLEIF && UIEbits.IDLEIE)
	BTFSC	_UIEbits, 0
	CALL	_BusReset
_00636_DS_:
	BTFSS	_UIRbits, 4
; #	GOTO	_00639_DS_
; #	BTFSS	_UIEbits, 4
; #	GOTO	_00639_DS_
; #	CALL	_Suspend
; #	BTFSS	_UIRbits, 6
; ;     peep 1 - test/jump to test/skip
;	.line	1130; usb.c	Suspend();
	BRA	_00639_DS_
;	.line	1132; usb.c	if (UIRbits.SOFIF && UIEbits.SOFIE)
	BTFSC	_UIEbits, 4
	CALL	_Suspend
_00639_DS_:
	BTFSS	_UIRbits, 6
; #	GOTO	_00642_DS_
; #	BTFSS	_UIEbits, 6
; #	GOTO	_00642_DS_
; #	CALL	_StartOfFrame
; #	BTFSS	_UIRbits, 5
; ;     peep 1 - test/jump to test/skip
;	.line	1134; usb.c	StartOfFrame();
	BRA	_00642_DS_
;	.line	1136; usb.c	if (UIRbits.STALLIF && UIEbits.STALLIE)
	BTFSC	_UIEbits, 6
	CALL	_StartOfFrame
_00642_DS_:
	BTFSS	_UIRbits, 5
; #	GOTO	_00645_DS_
; #	BTFSS	_UIEbits, 5
; #	GOTO	_00645_DS_
; #	CALL	_Stall
; #	BTFSS	_UIRbits, 1
; ;     peep 1 - test/jump to test/skip
;	.line	1138; usb.c	Stall();
	BRA	_00645_DS_
;	.line	1141; usb.c	if (UIRbits.UERRIF && UIEbits.UERRIE)
	BTFSC	_UIEbits, 5
	CALL	_Stall
_00645_DS_:
	BTFSS	_UIRbits, 1
; #	GOTO	_00648_DS_
; #	BTFSS	_UIEbits, 1
; #	GOTO	_00648_DS_
; #	BCF	_UIRbits, 1
; #	MOVLW	0x03
; ;     peep 1 - test/jump to test/skip
;	.line	1146; usb.c	UIRbits.UERRIF = 0;
	BRA	_00648_DS_
;	.line	1150; usb.c	if (deviceState < DEFAULT)
	BTFSC	_UIEbits, 1
	BCF	_UIRbits, 1
_00648_DS_:
	MOVLW	0x03
; #	SUBWF	_deviceState, W, B
; #	BTFSC	STATUS, 0
; #	GOTO	_00651_DS_
; #	GOTO	_00655_DS_
; #	BTFSS	_UIRbits, 3
; ;     peep 1 - test/jump to test/skip
	BANKSEL	_deviceState
;	.line	1151; usb.c	return;
	SUBWF	_deviceState, W, B
;	.line	1154; usb.c	if(UIRbits.TRNIF && UIEbits.TRNIE)
	BNC	_00655_DS_
	BTFSS	_UIRbits, 3
	BRA	_00655_DS_
	BTFSS	_UIEbits, 3
	BRA	_00655_DS_
;	.line	1156; usb.c	ProcessControlTransfer();
	CALL	_ProcessControlTransfer
;	.line	1159; usb.c	UIRbits.TRNIF = 0;
	BCF	_UIRbits, 3
_00655_DS_:
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_usb__BusReset	code
_BusReset:
;	.line	1078; usb.c	void BusReset()
	MOVFF	r0x00, POSTDEC1
;	.line	1080; usb.c	UEIR  = 0x00;
	CLRF	_UEIR
;	.line	1081; usb.c	UIR   = 0x00;
	CLRF	_UIR
;	.line	1082; usb.c	UEIE  = 0x9f;
	MOVLW	0x9f
	MOVWF	_UEIE
;	.line	1083; usb.c	UIE   = 0x7b;
	MOVLW	0x7b
	MOVWF	_UIE
;	.line	1084; usb.c	UADDR = 0x00;
	CLRF	_UADDR
;	.line	1087; usb.c	UEP0 = 0x16;
	MOVLW	0x16
	MOVWF	_UEP0
_00615_DS_:
;	.line	1090; usb.c	while (UIRbits.TRNIF == 1)
	CLRF	r0x00
	BTFSC	_UIRbits, 3
	INCF	r0x00, F
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00617_DS_
;	.line	1091; usb.c	UIRbits.TRNIF = 0;
	BCF	_UIRbits, 3
	BRA	_00615_DS_
_00617_DS_:
;	.line	1094; usb.c	UCONbits.PKTDIS = 0;
	BCF	_UCONbits, 4
;	.line	1097; usb.c	WaitForSetupStage();
	CALL	_WaitForSetupStage
	BANKSEL	_remoteWakeup
;	.line	1099; usb.c	remoteWakeup = 0;         // Remote wakeup is off by default
	CLRF	_remoteWakeup, B
	BANKSEL	_selfPowered
;	.line	1100; usb.c	selfPowered = 0;          // Self powered is off by default
	CLRF	_selfPowered, B
	BANKSEL	_currentConfiguration
;	.line	1101; usb.c	currentConfiguration = 0; // Clear active configuration
	CLRF	_currentConfiguration, B
;	.line	1102; usb.c	deviceState = DEFAULT;
	MOVLW	0x03
	BANKSEL	_deviceState
	MOVWF	_deviceState, B
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_usb__Suspend	code
_Suspend:
;	.line	1076; usb.c	}
	RETURN	

; ; Starting pCode block
S_usb__Stall	code
_Stall:
;	.line	1033; usb.c	void Stall(void)
	MOVFF	r0x00, POSTDEC1
;	.line	1038; usb.c	if(UEP0bits.EPSTALL == 1)
	CLRF	r0x00
	BTFSC	_UEP0bits, 0
	INCF	r0x00, F
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00601_DS_
;	.line	1041; usb.c	WaitForSetupStage();
	CALL	_WaitForSetupStage
;	.line	1042; usb.c	UEP0bits.EPSTALL = 0;
	BCF	_UEP0bits, 0
_00601_DS_:
;	.line	1044; usb.c	UIRbits.STALLIF = 0;
	BCF	_UIRbits, 5
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_usb__StartOfFrame	code
_StartOfFrame:
;	.line	1029; usb.c	UIRbits.SOFIF = 0;
	BCF	_UIRbits, 6
	RETURN	

; ; Starting pCode block
S_usb__UnSuspend	code
_UnSuspend:
;	.line	1019; usb.c	UCONbits.SUSPND = 0;
	BCF	_UCONbits, 1
;	.line	1020; usb.c	UIEbits.ACTIVIE = 0;
	BCF	_UIEbits, 2
;	.line	1021; usb.c	UIRbits.ACTIVIF = 0;
	BCF	_UIRbits, 2
	RETURN	

; ; Starting pCode block
S_usb__EnableUSBModule	code
_EnableUSBModule:
;	.line	986; usb.c	if(UCONbits.USBEN == 0)
	BTFSC	_UCONbits, 3
	BRA	_00577_DS_
;	.line	991; usb.c	UCON = 0;
	CLRF	_UCON
;	.line	992; usb.c	UIE = 0;
	CLRF	_UIE
;	.line	993; usb.c	UCONbits.USBEN = 1;
	BSF	_UCONbits, 3
;	.line	994; usb.c	deviceState = ATTACHED;
	MOVLW	0x01
	BANKSEL	_deviceState
	MOVWF	_deviceState, B
_00577_DS_:
	BANKSEL	_deviceState
;	.line	999; usb.c	if ((deviceState == ATTACHED) && !UCONbits.SE0)
	MOVF	_deviceState, W, B
	XORLW	0x01
	BNZ	_00581_DS_
	BTFSC	_UCONbits, 5
	BRA	_00581_DS_
;	.line	1001; usb.c	UIR = 0;
	CLRF	_UIR
;	.line	1002; usb.c	UIE = 0;
	CLRF	_UIE
;	.line	1003; usb.c	UIEbits.URSTIE = 1;
	BSF	_UIEbits, 0
;	.line	1004; usb.c	UIEbits.IDLEIE = 1;
	BSF	_UIEbits, 4
;	.line	1005; usb.c	deviceState = POWERED;
	MOVLW	0x02
	BANKSEL	_deviceState
	MOVWF	_deviceState, B
_00581_DS_:
	RETURN	

; ; Starting pCode block
S_usb__ProcessControlTransfer	code
_ProcessControlTransfer:
;	.line	884; usb.c	void ProcessControlTransfer(void)
	MOVFF	r0x00, POSTDEC1
;	.line	889; usb.c	if (USTAT == 0)
	MOVF	_USTAT, W
	BTFSS	STATUS, 2
	BRA	_00540_DS_
;	.line	892; usb.c	byte PID = (ep0Bo.Stat & 0x3C) >> 2; // Pull PID from middle of BD0STAT
	MOVLW	0x3c
	BANKSEL	_ep0Bo
	ANDWF	_ep0Bo, W, B
	MOVWF	r0x00
	BCF	STATUS, 0
	RRCF	r0x00, W
	MOVWF	r0x00
	BCF	STATUS, 0
	RRCF	r0x00, F
;	.line	893; usb.c	if (PID == 0x0D)
	MOVF	r0x00, W
	XORLW	0x0d
	BNZ	_00524_DS_
;	.line	895; usb.c	SetupStage();
	CALL	_SetupStage
	BRA	_00542_DS_
_00524_DS_:
	BANKSEL	_ctrlTransferStage
;	.line	896; usb.c	else if (ctrlTransferStage == DATA_OUT_STAGE)
	MOVF	_ctrlTransferStage, W, B
	XORLW	0x01
	BNZ	_00521_DS_
;	.line	900; usb.c	OutDataStage();
	CALL	_OutDataStage
	BANKSEL	_HIDPostProcess
;	.line	904; usb.c	if (HIDPostProcess)
	MOVF	_HIDPostProcess, W, B
	BZ	_00516_DS_
;	.line	907; usb.c	byte reportID = SetupPacket.wValue0;
	MOVFF	(_SetupPacket + 2), r0x00
	BANKSEL	(_SetupPacket + 3)
;	.line	911; usb.c	if (SetupPacket.wValue1 == 0x02)
	MOVF	(_SetupPacket + 3), W, B
	XORLW	0x02
	BNZ	_00513_DS_
;	.line	914; usb.c	SetOutputReport(reportID);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_SetOutputReport
	INCF	FSR1L, F
	BRA	_00516_DS_
_00513_DS_:
	BANKSEL	(_SetupPacket + 3)
;	.line	916; usb.c	else if (SetupPacket.wValue1 == 0x03)
	MOVF	(_SetupPacket + 3), W, B
	XORLW	0x03
	BNZ	_00516_DS_
;	.line	919; usb.c	SetFeatureReport(reportID);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_SetFeatureReport
	INCF	FSR1L, F
_00516_DS_:
	BANKSEL	_ep0Bo
;	.line	928; usb.c	if(ep0Bo.Stat & DTS)
	BTFSS	_ep0Bo, 6, B
	BRA	_00518_DS_
;	.line	929; usb.c	ep0Bo.Stat = UOWN | DTSEN;
	MOVLW	0x88
; removed redundant BANKSEL
	MOVWF	_ep0Bo, B
	BRA	_00542_DS_
_00518_DS_:
;	.line	931; usb.c	ep0Bo.Stat = UOWN | DTS | DTSEN;
	MOVLW	0xc8
	BANKSEL	_ep0Bo
	MOVWF	_ep0Bo, B
	BRA	_00542_DS_
_00521_DS_:
;	.line	936; usb.c	WaitForSetupStage();
	CALL	_WaitForSetupStage
	BRA	_00542_DS_
_00540_DS_:
;	.line	939; usb.c	else if(USTAT == 0x04)
	MOVF	_USTAT, W
	XORLW	0x04
	BNZ	_00542_DS_
;	.line	942; usb.c	if ((UADDR == 0) && (deviceState == ADDRESS))
	MOVF	_UADDR, W
	BNZ	_00529_DS_
	BANKSEL	_deviceState
	MOVF	_deviceState, W, B
	XORLW	0x04
	BNZ	_00529_DS_
;	.line	946; usb.c	UADDR = SetupPacket.wValue0;
	MOVFF	(_SetupPacket + 2), _UADDR
;	.line	950; usb.c	if(UADDR == 0)
	MOVF	_UADDR, W
	BNZ	_00529_DS_
;	.line	953; usb.c	deviceState = DEFAULT;
	MOVLW	0x03
	BANKSEL	_deviceState
	MOVWF	_deviceState, B
_00529_DS_:
	BANKSEL	_ctrlTransferStage
;	.line	956; usb.c	if (ctrlTransferStage == DATA_IN_STAGE)
	MOVF	_ctrlTransferStage, W, B
	XORLW	0x02
	BNZ	_00535_DS_
;	.line	959; usb.c	InDataStage();
	CALL	_InDataStage
	BANKSEL	_ep0Bi
;	.line	962; usb.c	if(ep0Bi.Stat & DTS)
	BTFSS	_ep0Bi, 6, B
	BRA	_00532_DS_
;	.line	963; usb.c	ep0Bi.Stat = UOWN | DTSEN;
	MOVLW	0x88
; removed redundant BANKSEL
	MOVWF	_ep0Bi, B
	BRA	_00542_DS_
_00532_DS_:
;	.line	965; usb.c	ep0Bi.Stat = UOWN | DTS | DTSEN;
	MOVLW	0xc8
	BANKSEL	_ep0Bi
	MOVWF	_ep0Bi, B
	BRA	_00542_DS_
_00535_DS_:
;	.line	970; usb.c	WaitForSetupStage();
	CALL	_WaitForSetupStage
_00542_DS_:
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_usb__WaitForSetupStage	code
_WaitForSetupStage:
;	.line	871; usb.c	void WaitForSetupStage(void)
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	BANKSEL	_ctrlTransferStage
;	.line	873; usb.c	ctrlTransferStage = SETUP_STAGE;
	CLRF	_ctrlTransferStage, B
;	.line	874; usb.c	ep0Bo.Cnt = E0SZ;
	MOVLW	0x20
	BANKSEL	(_ep0Bo + 1)
	MOVWF	(_ep0Bo + 1), B
;	.line	875; usb.c	ep0Bo.ADDR = PTR16(&SetupPacket);
	MOVLW	LOW(_SetupPacket)
	MOVWF	r0x00
	MOVLW	HIGH(_SetupPacket)
	MOVWF	r0x01
	MOVF	r0x00, W
; removed redundant BANKSEL
	MOVWF	(_ep0Bo + 2), B
	MOVF	r0x01, W
; removed redundant BANKSEL
	MOVWF	(_ep0Bo + 3), B
;	.line	876; usb.c	ep0Bo.Stat = UOWN | DTSEN; // Give to SIE, enable data toggle checks
	MOVLW	0x88
	BANKSEL	_ep0Bo
	MOVWF	_ep0Bo, B
; removed redundant BANKSEL
;	.line	877; usb.c	ep0Bi.Stat = 0x00;         // Give control to CPU
	CLRF	_ep0Bi, B
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_usb__SetupStage	code
_SetupStage:
;	.line	803; usb.c	void SetupStage(void)
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
;	.line	807; usb.c	ep0Bi.Stat &= ~UOWN;
	MOVLW	0x7f
	BANKSEL	_ep0Bi
	ANDWF	_ep0Bi, W, B
; #	MOVWF	r0x00
; #	MOVF	r0x00, W
; ;     peep 2 - Removed redundant move
	MOVWF	_ep0Bi, B
;	.line	808; usb.c	ep0Bo.Stat &= ~UOWN;
	MOVLW	0x7f
; removed redundant BANKSEL
	ANDWF	_ep0Bo, W, B
; #	MOVWF	r0x00
; #	MOVF	r0x00, W
; ;     peep 2 - Removed redundant move
	MOVWF	_ep0Bo, B
	BANKSEL	_ctrlTransferStage
;	.line	811; usb.c	ctrlTransferStage = SETUP_STAGE;
	CLRF	_ctrlTransferStage, B
	BANKSEL	_requestHandled
;	.line	812; usb.c	requestHandled = 0; // Default is that request hasn't been handled
	CLRF	_requestHandled, B
	BANKSEL	_HIDPostProcess
;	.line	813; usb.c	HIDPostProcess = 0; // Assume standard request until know otherwise
	CLRF	_HIDPostProcess, B
	BANKSEL	_wCount
;	.line	814; usb.c	wCount = 0;         // No bytes transferred
	CLRF	_wCount, B
; removed redundant BANKSEL
	CLRF	(_wCount + 1), B
;	.line	817; usb.c	ProcessStandardRequest();
	CALL	_ProcessStandardRequest
;	.line	820; usb.c	ProcessHIDRequest();
	CALL	_ProcessHIDRequest
	BANKSEL	_requestHandled
;	.line	824; usb.c	if (!requestHandled)
	MOVF	_requestHandled, W, B
	BNZ	_00491_DS_
;	.line	827; usb.c	ep0Bo.Cnt = E0SZ;
	MOVLW	0x20
	BANKSEL	(_ep0Bo + 1)
	MOVWF	(_ep0Bo + 1), B
;	.line	828; usb.c	ep0Bo.ADDR = PTR16(&SetupPacket);
	MOVLW	LOW(_SetupPacket)
	MOVWF	r0x00
	MOVLW	HIGH(_SetupPacket)
	MOVWF	r0x01
	MOVF	r0x00, W
; removed redundant BANKSEL
	MOVWF	(_ep0Bo + 2), B
	MOVF	r0x01, W
; removed redundant BANKSEL
	MOVWF	(_ep0Bo + 3), B
; #	MOVLW	0x84
; #	MOVWF	_ep0Bo, B
; #	MOVLW	0x84
; ;     peep 5 - Removed redundant move
;	.line	829; usb.c	ep0Bo.Stat = UOWN | BSTALL;
	MOVLW	0x84
	BANKSEL	_ep0Bo
;	.line	830; usb.c	ep0Bi.Stat = UOWN | BSTALL;
	MOVWF	_ep0Bo, B
; removed redundant BANKSEL
	MOVWF	_ep0Bi, B
	BRA	_00492_DS_
_00491_DS_:
	BANKSEL	_SetupPacket
;	.line	832; usb.c	else if (SetupPacket.bmRequestType & 0x80)
	BTFSS	_SetupPacket, 7, B
	BRA	_00488_DS_
	BANKSEL	(_wCount + 1)
;	.line	835; usb.c	if(SetupPacket.wLength < wCount)
	MOVF	(_wCount + 1), W, B
	BANKSEL	(_SetupPacket + 7)
	SUBWF	(_SetupPacket + 7), W, B
	BNZ	_00501_DS_
	BANKSEL	_wCount
	MOVF	_wCount, W, B
	BANKSEL	(_SetupPacket + 6)
	SUBWF	(_SetupPacket + 6), W, B
_00501_DS_:
	BC	_00486_DS_
;	.line	836; usb.c	wCount = SetupPacket.wLength;
	MOVFF	(_SetupPacket + 6), _wCount
	MOVFF	(_SetupPacket + 7), (_wCount + 1)
_00486_DS_:
;	.line	837; usb.c	InDataStage();
	CALL	_InDataStage
;	.line	838; usb.c	ctrlTransferStage = DATA_IN_STAGE;
	MOVLW	0x02
	BANKSEL	_ctrlTransferStage
	MOVWF	_ctrlTransferStage, B
;	.line	840; usb.c	ep0Bo.Cnt = E0SZ;
	MOVLW	0x20
	BANKSEL	(_ep0Bo + 1)
	MOVWF	(_ep0Bo + 1), B
;	.line	841; usb.c	ep0Bo.ADDR = PTR16(&SetupPacket);
	MOVLW	LOW(_SetupPacket)
	MOVWF	r0x00
	MOVLW	HIGH(_SetupPacket)
	MOVWF	r0x01
	MOVF	r0x00, W
; removed redundant BANKSEL
	MOVWF	(_ep0Bo + 2), B
	MOVF	r0x01, W
; removed redundant BANKSEL
	MOVWF	(_ep0Bo + 3), B
;	.line	842; usb.c	ep0Bo.Stat = UOWN;
	MOVLW	0x80
	BANKSEL	_ep0Bo
	MOVWF	_ep0Bo, B
;	.line	845; usb.c	ep0Bi.ADDR = PTR16(&controlTransferBuffer);
	MOVLW	LOW(_controlTransferBuffer)
	MOVWF	r0x00
	MOVLW	HIGH(_controlTransferBuffer)
	MOVWF	r0x01
	MOVF	r0x00, W
	BANKSEL	(_ep0Bi + 2)
	MOVWF	(_ep0Bi + 2), B
	MOVF	r0x01, W
; removed redundant BANKSEL
	MOVWF	(_ep0Bi + 3), B
;	.line	847; usb.c	ep0Bi.Stat = UOWN | DTS | DTSEN; 
	MOVLW	0xc8
	BANKSEL	_ep0Bi
	MOVWF	_ep0Bi, B
	BRA	_00492_DS_
_00488_DS_:
;	.line	852; usb.c	ctrlTransferStage = DATA_OUT_STAGE;
	MOVLW	0x01
	BANKSEL	_ctrlTransferStage
	MOVWF	_ctrlTransferStage, B
	BANKSEL	(_ep0Bi + 1)
;	.line	855; usb.c	ep0Bi.Cnt = 0;
	CLRF	(_ep0Bi + 1), B
;	.line	856; usb.c	ep0Bi.Stat = UOWN | DTS | DTSEN;
	MOVLW	0xc8
	BANKSEL	_ep0Bi
	MOVWF	_ep0Bi, B
;	.line	859; usb.c	ep0Bo.Cnt = E0SZ;
	MOVLW	0x20
	BANKSEL	(_ep0Bo + 1)
	MOVWF	(_ep0Bo + 1), B
;	.line	860; usb.c	ep0Bo.ADDR = PTR16(&controlTransferBuffer);
	MOVLW	LOW(_controlTransferBuffer)
	MOVWF	r0x00
	MOVLW	HIGH(_controlTransferBuffer)
	MOVWF	r0x01
	MOVF	r0x00, W
; removed redundant BANKSEL
	MOVWF	(_ep0Bo + 2), B
	MOVF	r0x01, W
; removed redundant BANKSEL
	MOVWF	(_ep0Bo + 3), B
;	.line	862; usb.c	ep0Bo.Stat = UOWN | DTS | DTSEN;
	MOVLW	0xc8
	BANKSEL	_ep0Bo
	MOVWF	_ep0Bo, B
_00492_DS_:
;	.line	866; usb.c	UCONbits.PKTDIS = 0;
	BCF	_UCONbits, 4
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_usb__OutDataStage	code
_OutDataStage:
;	.line	770; usb.c	void OutDataStage(void)
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, POSTDEC1
	MOVFF	r0x08, POSTDEC1
	MOVFF	r0x09, POSTDEC1
;	.line	774; usb.c	bufferSize = ((0x03 & ep0Bo.Stat) << 8) | ep0Bo.Cnt;
	MOVLW	0x03
	BANKSEL	_ep0Bo
	ANDWF	_ep0Bo, W, B
	CLRF	r0x01
	MOVWF	r0x03
	CLRF	r0x02
	MOVFF	(_ep0Bo + 1), r0x00
	MOVF	r0x02, W
	IORWF	r0x00, F
	MOVF	r0x03, W
	IORWF	r0x01, F
;	.line	781; usb.c	wCount = wCount + bufferSize;
	MOVF	r0x00, W
	BANKSEL	_wCount
	ADDWF	_wCount, F, B
	MOVF	r0x01, W
; removed redundant BANKSEL
	ADDWFC	(_wCount + 1), F, B
;	.line	783; usb.c	outPtr = (byte*)&controlTransferBuffer;
	MOVLW	HIGH(_controlTransferBuffer)
	BANKSEL	(_outPtr + 1)
	MOVWF	(_outPtr + 1), B
	MOVLW	LOW(_controlTransferBuffer)
; removed redundant BANKSEL
	MOVWF	_outPtr, B
	MOVLW	0x80
; removed redundant BANKSEL
	MOVWF	(_outPtr + 2), B
;	.line	787; usb.c	for (i=0;i<bufferSize;i++)
	CLRF	r0x03
_00470_DS_:
	MOVF	r0x01, W
	SUBWF	r0x03, W
	BNZ	_00480_DS_
	MOVF	r0x00, W
	SUBWF	r0x02, W
_00480_DS_:
	BC	_00474_DS_
;	.line	792; usb.c	*inPtr++ = *outPtr++;
	MOVFF	_inPtr, r0x04
	MOVFF	(_inPtr + 1), r0x05
	MOVFF	(_inPtr + 2), r0x06
	MOVFF	_outPtr, r0x07
	MOVFF	(_outPtr + 1), r0x08
	MOVFF	(_outPtr + 2), r0x09
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, PRODL
	MOVF	r0x09, W
	CALL	__gptrget1
	MOVWF	r0x07
	BANKSEL	_outPtr
	INCF	_outPtr, F, B
	BNC	_10628_DS_
; removed redundant BANKSEL
	INCF	(_outPtr + 1), F, B
_10628_DS_:
	BNC	_20629_DS_
	BANKSEL	(_outPtr + 2)
	INCF	(_outPtr + 2), F, B
_20629_DS_:
	MOVFF	r0x07, POSTDEC1
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, PRODL
	MOVF	r0x06, W
	CALL	__gptrput1
	BANKSEL	_inPtr
	INCF	_inPtr, F, B
	BNC	_30630_DS_
; removed redundant BANKSEL
	INCF	(_inPtr + 1), F, B
_30630_DS_:
	BNC	_40631_DS_
	BANKSEL	(_inPtr + 2)
	INCF	(_inPtr + 2), F, B
_40631_DS_:
;	.line	787; usb.c	for (i=0;i<bufferSize;i++)
	INCF	r0x02, F
	BTFSC	STATUS, 0
	INCF	r0x03, F
	BRA	_00470_DS_
_00474_DS_:
	MOVFF	PREINC1, r0x09
	MOVFF	PREINC1, r0x08
	MOVFF	PREINC1, r0x07
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_usb__InDataStage	code
_InDataStage:
;	.line	725; usb.c	void InDataStage(void)
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, POSTDEC1
	MOVFF	r0x08, POSTDEC1
;	.line	733; usb.c	if(wCount < E0SZ)
	MOVLW	0x00
	BANKSEL	(_wCount + 1)
	SUBWF	(_wCount + 1), W, B
	BNZ	_00460_DS_
	MOVLW	0x20
; removed redundant BANKSEL
	SUBWF	_wCount, W, B
_00460_DS_:
	BC	_00448_DS_
;	.line	734; usb.c	bufferSize = wCount;
	MOVFF	_wCount, r0x00
	MOVFF	(_wCount + 1), r0x01
	BRA	_00449_DS_
_00448_DS_:
;	.line	736; usb.c	bufferSize = E0SZ;
	MOVLW	0x20
	MOVWF	r0x00
	CLRF	r0x01
_00449_DS_:
;	.line	743; usb.c	ep0Bi.Stat &= ~(BC8 | BC9); // Clear BC8 and BC9
	MOVLW	0xfc
	BANKSEL	_ep0Bi
	ANDWF	_ep0Bi, W, B
; #	MOVWF	r0x02
; #	MOVF	r0x02, W
; ;     peep 2 - Removed redundant move
	MOVWF	_ep0Bi, B
;	.line	744; usb.c	ep0Bi.Stat |= (byte)((bufferSize & 0x0300) >> 8);
	MOVLW	0x03
	ANDWF	r0x01, W
; #	MOVWF	r0x03
; #	MOVF	r0x03, W
; ;     peep 2 - Removed redundant move
	MOVWF	r0x02
; removed redundant BANKSEL
	MOVF	_ep0Bi, W, B
	IORWF	r0x02, F
	MOVF	r0x02, W
; removed redundant BANKSEL
	MOVWF	_ep0Bi, B
; #	MOVF	r0x00, W
; #	MOVWF	r0x02
; #	MOVF	r0x02, W
; ;     peep 9c - Removed redundant move
;	.line	745; usb.c	ep0Bi.Cnt = (byte)(bufferSize & 0xFF);
	MOVF	r0x00, W
	MOVWF	r0x02
	BANKSEL	(_ep0Bi + 1)
	MOVWF	(_ep0Bi + 1), B
;	.line	746; usb.c	ep0Bi.ADDR = PTR16(&controlTransferBuffer);
	MOVLW	LOW(_controlTransferBuffer)
	MOVWF	r0x02
	MOVLW	HIGH(_controlTransferBuffer)
	MOVWF	r0x03
	MOVF	r0x02, W
; removed redundant BANKSEL
	MOVWF	(_ep0Bi + 2), B
	MOVF	r0x03, W
; removed redundant BANKSEL
	MOVWF	(_ep0Bi + 3), B
;	.line	751; usb.c	wCount = wCount - bufferSize;
	MOVF	r0x00, W
	BANKSEL	_wCount
	SUBWF	_wCount, F, B
	MOVF	r0x01, W
; removed redundant BANKSEL
	SUBWFB	(_wCount + 1), F, B
;	.line	754; usb.c	inPtr = (byte *)&controlTransferBuffer;
	MOVLW	HIGH(_controlTransferBuffer)
	BANKSEL	(_inPtr + 1)
	MOVWF	(_inPtr + 1), B
	MOVLW	LOW(_controlTransferBuffer)
; removed redundant BANKSEL
	MOVWF	_inPtr, B
	MOVLW	0x80
; removed redundant BANKSEL
	MOVWF	(_inPtr + 2), B
;	.line	759; usb.c	for (i=0;i<bufferSize;i++)
	CLRF	r0x02
_00450_DS_:
	MOVFF	r0x02, r0x03
	CLRF	r0x04
	MOVF	r0x01, W
	SUBWF	r0x04, W
	BNZ	_00465_DS_
	MOVF	r0x00, W
	SUBWF	r0x03, W
_00465_DS_:
	BC	_00454_DS_
;	.line	764; usb.c	*inPtr++ = *outPtr++;
	MOVFF	_inPtr, r0x03
	MOVFF	(_inPtr + 1), r0x04
	MOVFF	(_inPtr + 2), r0x05
	MOVFF	_outPtr, r0x06
	MOVFF	(_outPtr + 1), r0x07
	MOVFF	(_outPtr + 2), r0x08
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, PRODL
	MOVF	r0x08, W
	CALL	__gptrget1
	MOVWF	r0x06
	BANKSEL	_outPtr
	INCF	_outPtr, F, B
	BNC	_50632_DS_
; removed redundant BANKSEL
	INCF	(_outPtr + 1), F, B
_50632_DS_:
	BNC	_60633_DS_
	BANKSEL	(_outPtr + 2)
	INCF	(_outPtr + 2), F, B
_60633_DS_:
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, PRODL
	MOVF	r0x05, W
	CALL	__gptrput1
	BANKSEL	_inPtr
	INCF	_inPtr, F, B
	BNC	_70634_DS_
; removed redundant BANKSEL
	INCF	(_inPtr + 1), F, B
_70634_DS_:
	BNC	_80635_DS_
	BANKSEL	(_inPtr + 2)
	INCF	(_inPtr + 2), F, B
_80635_DS_:
;	.line	759; usb.c	for (i=0;i<bufferSize;i++)
	INCF	r0x02, F
	BRA	_00450_DS_
_00454_DS_:
	MOVFF	PREINC1, r0x08
	MOVFF	PREINC1, r0x07
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_usb__ProcessStandardRequest	code
_ProcessStandardRequest:
;	.line	616; usb.c	void ProcessStandardRequest(void)
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
;	.line	618; usb.c	byte request = SetupPacket.bRequest;
	MOVFF	(_SetupPacket + 1), r0x00
;	.line	620; usb.c	if((SetupPacket.bmRequestType & 0x60) != 0x00)
	MOVLW	0x60
	BANKSEL	_SetupPacket
	ANDWF	_SetupPacket, W, B
	MOVWF	r0x01
	MOVF	r0x01, W
	BZ	_00379_DS_
;	.line	623; usb.c	return;
	BRA	_00411_DS_
_00379_DS_:
;	.line	625; usb.c	if (request == SET_ADDRESS)
	MOVF	r0x00, W
	XORLW	0x05
	BNZ	_00409_DS_
;	.line	634; usb.c	requestHandled = 1;
	MOVLW	0x01
	BANKSEL	_requestHandled
	MOVWF	_requestHandled, B
;	.line	635; usb.c	deviceState = ADDRESS;
	MOVLW	0x04
	BANKSEL	_deviceState
	MOVWF	_deviceState, B
;	.line	636; usb.c	deviceAddress = SetupPacket.wValue0;
	MOVFF	(_SetupPacket + 2), _deviceAddress
	BRA	_00411_DS_
_00409_DS_:
;	.line	638; usb.c	else if (request == GET_DESCRIPTOR)
	MOVF	r0x00, W
	XORLW	0x06
	BNZ	_00406_DS_
;	.line	640; usb.c	GetDescriptor();
	CALL	_GetDescriptor
	BRA	_00411_DS_
_00406_DS_:
;	.line	642; usb.c	else if (request == SET_CONFIGURATION)
	MOVF	r0x00, W
	XORLW	0x09
	BNZ	_00403_DS_
;	.line	647; usb.c	requestHandled = 1;
	MOVLW	0x01
	BANKSEL	_requestHandled
	MOVWF	_requestHandled, B
;	.line	648; usb.c	currentConfiguration = SetupPacket.wValue0;
	MOVFF	(_SetupPacket + 2), _currentConfiguration
	BANKSEL	_currentConfiguration
;	.line	651; usb.c	if (currentConfiguration == 0)
	MOVF	_currentConfiguration, W, B
	BNZ	_00381_DS_
;	.line	654; usb.c	deviceState = ADDRESS;
	MOVLW	0x04
	BANKSEL	_deviceState
	MOVWF	_deviceState, B
	BRA	_00411_DS_
_00381_DS_:
;	.line	658; usb.c	deviceState = CONFIGURED;
	MOVLW	0x05
	BANKSEL	_deviceState
	MOVWF	_deviceState, B
;	.line	661; usb.c	HIDInitEndpoint();
	CALL	_HIDInitEndpoint
	BRA	_00411_DS_
_00403_DS_:
;	.line	667; usb.c	else if (request == GET_CONFIGURATION)
	MOVF	r0x00, W
	XORLW	0x08
	BNZ	_00400_DS_
;	.line	672; usb.c	requestHandled = 1;
	MOVLW	0x01
	BANKSEL	_requestHandled
	MOVWF	_requestHandled, B
;	.line	673; usb.c	outPtr = (byte*)&currentConfiguration;
	MOVLW	HIGH(_currentConfiguration)
	BANKSEL	(_outPtr + 1)
	MOVWF	(_outPtr + 1), B
	MOVLW	LOW(_currentConfiguration)
; removed redundant BANKSEL
	MOVWF	_outPtr, B
	MOVLW	0x80
; removed redundant BANKSEL
	MOVWF	(_outPtr + 2), B
;	.line	674; usb.c	wCount = 1;
	MOVLW	0x01
	BANKSEL	_wCount
	MOVWF	_wCount, B
; removed redundant BANKSEL
	CLRF	(_wCount + 1), B
	BRA	_00411_DS_
_00400_DS_:
;	.line	676; usb.c	else if (request == GET_STATUS)
	MOVF	r0x00, W
	BNZ	_00397_DS_
;	.line	678; usb.c	GetStatus();
	CALL	_GetStatus
	BRA	_00411_DS_
_00397_DS_:
;	.line	680; usb.c	else if ((request == CLEAR_FEATURE) ||
	MOVF	r0x00, W
	XORLW	0x01
	BZ	_00392_DS_
;	.line	681; usb.c	(request == SET_FEATURE))
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00393_DS_
_00392_DS_:
;	.line	683; usb.c	SetFeature();
	CALL	_SetFeature
	BRA	_00411_DS_
_00393_DS_:
;	.line	685; usb.c	else if (request == GET_INTERFACE)
	MOVF	r0x00, W
	XORLW	0x0a
	BNZ	_00390_DS_
;	.line	692; usb.c	requestHandled = 1;
	MOVLW	0x01
	BANKSEL	_requestHandled
	MOVWF	_requestHandled, B
	BANKSEL	_controlTransferBuffer
;	.line	693; usb.c	controlTransferBuffer[0] = 0;
	CLRF	_controlTransferBuffer, B
;	.line	694; usb.c	outPtr = &controlTransferBuffer;
	MOVLW	HIGH(_controlTransferBuffer)
	BANKSEL	(_outPtr + 1)
	MOVWF	(_outPtr + 1), B
	MOVLW	LOW(_controlTransferBuffer)
; removed redundant BANKSEL
	MOVWF	_outPtr, B
	MOVLW	0x80
; removed redundant BANKSEL
	MOVWF	(_outPtr + 2), B
;	.line	695; usb.c	wCount = 1;
	MOVLW	0x01
	BANKSEL	_wCount
	MOVWF	_wCount, B
; removed redundant BANKSEL
	CLRF	(_wCount + 1), B
	BRA	_00411_DS_
_00390_DS_:
;	.line	697; usb.c	else if (request == SET_INTERFACE)
	MOVF	r0x00, W
	XORLW	0x0b
	BNZ	_00411_DS_
;	.line	703; usb.c	requestHandled = 1;
	MOVLW	0x01
	BANKSEL	_requestHandled
	MOVWF	_requestHandled, B
_00411_DS_:
;	.line	711; usb.c	else if (request == SYNCH_FRAME)
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_usb__SetFeature	code
_SetFeature:
;	.line	567; usb.c	static void SetFeature(void)
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
;	.line	569; usb.c	byte recipient = SetupPacket.bmRequestType & 0x1F;
	MOVLW	0x1f
	BANKSEL	_SetupPacket
	ANDWF	_SetupPacket, W, B
	MOVWF	r0x00
;	.line	570; usb.c	byte feature = SetupPacket.wValue0;
	MOVFF	(_SetupPacket + 2), r0x01
;	.line	575; usb.c	if (recipient == 0x00)
	MOVF	r0x00, W
	BNZ	_00346_DS_
;	.line	578; usb.c	if (feature == DEVICE_REMOTE_WAKEUP)
	MOVF	r0x01, W
	XORLW	0x01
	BZ	_00361_DS_
	BRA	_00348_DS_
_00361_DS_:
;	.line	580; usb.c	requestHandled = 1;
	MOVLW	0x01
	BANKSEL	_requestHandled
	MOVWF	_requestHandled, B
	BANKSEL	(_SetupPacket + 1)
;	.line	581; usb.c	if (SetupPacket.bRequest == SET_FEATURE)
	MOVF	(_SetupPacket + 1), W, B
	XORLW	0x03
	BNZ	_00328_DS_
;	.line	582; usb.c	remoteWakeup = 1;
	MOVLW	0x01
	BANKSEL	_remoteWakeup
	MOVWF	_remoteWakeup, B
	BRA	_00348_DS_
_00328_DS_:
	BANKSEL	_remoteWakeup
;	.line	584; usb.c	remoteWakeup = 0;
	CLRF	_remoteWakeup, B
	BRA	_00348_DS_
_00346_DS_:
;	.line	588; usb.c	else if (recipient == 0x02)
	MOVF	r0x00, W
	XORLW	0x02
	BZ	_00365_DS_
	BRA	_00348_DS_
_00365_DS_:
;	.line	591; usb.c	byte endpointNum = SetupPacket.wIndex0 & 0x0F;
	MOVLW	0x0f
	BANKSEL	(_SetupPacket + 4)
	ANDWF	(_SetupPacket + 4), W, B
	MOVWF	r0x00
;	.line	592; usb.c	byte endpointDir = SetupPacket.wIndex0 & 0x80;
	MOVLW	0x80
; removed redundant BANKSEL
	ANDWF	(_SetupPacket + 4), W, B
	MOVWF	r0x02
;	.line	593; usb.c	if ((feature == ENDPOINT_HALT) && (endpointNum != 0))
	MOVF	r0x01, W
	BTFSS	STATUS, 2
	BRA	_00348_DS_
	MOVF	r0x00, W
	BNZ	_00369_DS_
	BRA	_00348_DS_
_00369_DS_:
;	.line	596; usb.c	requestHandled = 1;
	MOVLW	0x01
	BANKSEL	_requestHandled
	MOVWF	_requestHandled, B
; ;multiply lit val:0x08 by variable r0x00 and store in r0x00
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
;	.line	599; usb.c	inPtr = (byte *)&ep0Bo + (endpointNum * 8);
	MOVF	r0x00, W
	MULLW	0x08
	MOVFF	PRODL, r0x00
	MOVFF	PRODH, r0x01
	MOVF	r0x00, W
	BANKSEL	_inPtr
	MOVWF	_inPtr, B
	MOVLW	0x04
	ADDWF	r0x01, W
; removed redundant BANKSEL
	MOVWF	(_inPtr + 1), B
	MOVLW	0x80
; removed redundant BANKSEL
	CLRF	(_inPtr + 2), B
	BTFSS	r0x01, 7
	BRA	_90636_DS_
; removed redundant BANKSEL
	SETF	(_inPtr + 2), B
_90636_DS_:
	BANKSEL	(_inPtr + 2)
	ADDWFC	(_inPtr + 2), F, B
;	.line	600; usb.c	if (endpointDir)
	MOVF	r0x02, W
	BZ	_00333_DS_
;	.line	601; usb.c	inPtr += 4;
	MOVLW	0x04
; removed redundant BANKSEL
	ADDWF	_inPtr, F, B
	MOVLW	0x00
; removed redundant BANKSEL
	ADDWFC	(_inPtr + 1), F, B
; removed redundant BANKSEL
	ADDWFC	(_inPtr + 2), F, B
_00333_DS_:
	BANKSEL	(_SetupPacket + 1)
;	.line	603; usb.c	if(SetupPacket.bRequest == SET_FEATURE)
	MOVF	(_SetupPacket + 1), W, B
	XORLW	0x03
	BNZ	_00338_DS_
;	.line	604; usb.c	*inPtr = 0x84;
	MOVFF	_inPtr, r0x00
	MOVFF	(_inPtr + 1), r0x01
	MOVFF	(_inPtr + 2), r0x03
	MOVLW	0x84
	MOVWF	POSTDEC1
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x03, W
	CALL	__gptrput1
	BRA	_00348_DS_
_00338_DS_:
;	.line	607; usb.c	if(endpointDir == 1)
	MOVF	r0x02, W
	XORLW	0x01
	BNZ	_00335_DS_
;	.line	608; usb.c	*inPtr = 0x00;
	MOVFF	_inPtr, r0x00
	MOVFF	(_inPtr + 1), r0x01
	MOVFF	(_inPtr + 2), r0x02
	CLRF	POSTDEC1
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrput1
	BRA	_00348_DS_
_00335_DS_:
;	.line	610; usb.c	*inPtr = 0x88;
	MOVFF	_inPtr, r0x00
	MOVFF	(_inPtr + 1), r0x01
	MOVFF	(_inPtr + 2), r0x02
	MOVLW	0x88
	MOVWF	POSTDEC1
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrput1
_00348_DS_:
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_usb__GetStatus	code
_GetStatus:
;	.line	518; usb.c	static void GetStatus(void)
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
;	.line	521; usb.c	byte recipient = SetupPacket.bmRequestType & 0x1F;
	MOVLW	0x1f
	BANKSEL	_SetupPacket
	ANDWF	_SetupPacket, W, B
	MOVWF	r0x00
	BANKSEL	_controlTransferBuffer
;	.line	525; usb.c	controlTransferBuffer[0] = 0;
	CLRF	_controlTransferBuffer, B
; removed redundant BANKSEL
;	.line	526; usb.c	controlTransferBuffer[1] = 0;
	CLRF	(_controlTransferBuffer + 1), B
;	.line	529; usb.c	if (recipient == 0x00)
	MOVF	r0x00, W
	BNZ	_00304_DS_
;	.line	532; usb.c	requestHandled = 1;
	MOVLW	0x01
	BANKSEL	_requestHandled
	MOVWF	_requestHandled, B
	BANKSEL	_selfPowered
;	.line	534; usb.c	if (selfPowered)
	MOVF	_selfPowered, W, B
	BZ	_00291_DS_
;	.line	535; usb.c	controlTransferBuffer[0] |= 0x01;
	MOVLW	0x01
	BANKSEL	_controlTransferBuffer
	IORWF	_controlTransferBuffer, W, B
; #	MOVWF	r0x01
; #	MOVF	r0x01, W
; ;     peep 2 - Removed redundant move
	MOVWF	_controlTransferBuffer, B
_00291_DS_:
	BANKSEL	_remoteWakeup
;	.line	536; usb.c	if (remoteWakeup)
	MOVF	_remoteWakeup, W, B
	BTFSC	STATUS, 2
	BRA	_00305_DS_
;	.line	537; usb.c	controlTransferBuffer[0] |= 0x02;
	MOVLW	0x02
	BANKSEL	_controlTransferBuffer
	IORWF	_controlTransferBuffer, W, B
; #	MOVWF	r0x01
; #	MOVF	r0x01, W
; ;     peep 2 - Removed redundant move
	MOVWF	_controlTransferBuffer, B
	BRA	_00305_DS_
_00304_DS_:
;	.line	539; usb.c	else if (recipient == 0x01)
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00301_DS_
;	.line	542; usb.c	requestHandled = 1;
	MOVLW	0x01
	BANKSEL	_requestHandled
	MOVWF	_requestHandled, B
	BRA	_00305_DS_
_00301_DS_:
;	.line	544; usb.c	else if (recipient == 0x02)
	MOVF	r0x00, W
	XORLW	0x02
	BZ	_00322_DS_
	BRA	_00305_DS_
_00322_DS_:
;	.line	547; usb.c	byte endpointNum = SetupPacket.wIndex0 & 0x0F;
	MOVLW	0x0f
	BANKSEL	(_SetupPacket + 4)
	ANDWF	(_SetupPacket + 4), W, B
	MOVWF	r0x00
;	.line	548; usb.c	byte endpointDir = SetupPacket.wIndex0 & 0x80;
	MOVLW	0x80
; removed redundant BANKSEL
	ANDWF	(_SetupPacket + 4), W, B
	MOVWF	r0x01
;	.line	549; usb.c	requestHandled = 1;
	MOVLW	0x01
	BANKSEL	_requestHandled
	MOVWF	_requestHandled, B
; ;multiply lit val:0x08 by variable r0x00 and store in r0x00
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
;	.line	552; usb.c	inPtr = (byte *)&ep0Bo + (endpointNum * 8);
	MOVF	r0x00, W
	MULLW	0x08
	MOVFF	PRODL, r0x00
	MOVFF	PRODH, r0x02
	MOVF	r0x00, W
	BANKSEL	_inPtr
	MOVWF	_inPtr, B
	MOVLW	0x04
	ADDWF	r0x02, W
; removed redundant BANKSEL
	MOVWF	(_inPtr + 1), B
	MOVLW	0x80
; removed redundant BANKSEL
	CLRF	(_inPtr + 2), B
	BTFSS	r0x02, 7
	BRA	_100637_DS_
; removed redundant BANKSEL
	SETF	(_inPtr + 2), B
_100637_DS_:
	BANKSEL	(_inPtr + 2)
	ADDWFC	(_inPtr + 2), F, B
;	.line	553; usb.c	if (endpointDir)
	MOVF	r0x01, W
	BZ	_00295_DS_
;	.line	554; usb.c	inPtr += 4;
	MOVLW	0x04
; removed redundant BANKSEL
	ADDWF	_inPtr, F, B
	MOVLW	0x00
; removed redundant BANKSEL
	ADDWFC	(_inPtr + 1), F, B
; removed redundant BANKSEL
	ADDWFC	(_inPtr + 2), F, B
_00295_DS_:
;	.line	555; usb.c	if(*inPtr & BSTALL)
	MOVFF	_inPtr, r0x00
	MOVFF	(_inPtr + 1), r0x01
	MOVFF	(_inPtr + 2), r0x02
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	MOVWF	r0x00
	BTFSS	r0x00, 2
	BRA	_00305_DS_
;	.line	556; usb.c	controlTransferBuffer[0] = 0x01;
	MOVLW	0x01
	BANKSEL	_controlTransferBuffer
	MOVWF	_controlTransferBuffer, B
_00305_DS_:
	BANKSEL	_requestHandled
;	.line	559; usb.c	if (requestHandled)
	MOVF	_requestHandled, W, B
	BZ	_00308_DS_
;	.line	561; usb.c	outPtr = (byte *)&controlTransferBuffer;
	MOVLW	HIGH(_controlTransferBuffer)
	BANKSEL	(_outPtr + 1)
	MOVWF	(_outPtr + 1), B
	MOVLW	LOW(_controlTransferBuffer)
; removed redundant BANKSEL
	MOVWF	_outPtr, B
	MOVLW	0x80
; removed redundant BANKSEL
	MOVWF	(_outPtr + 2), B
;	.line	562; usb.c	wCount = 2;
	MOVLW	0x02
	BANKSEL	_wCount
	MOVWF	_wCount, B
; removed redundant BANKSEL
	CLRF	(_wCount + 1), B
_00308_DS_:
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_usb__GetDescriptor	code
_GetDescriptor:
;	.line	452; usb.c	static void GetDescriptor(void)
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	BANKSEL	_SetupPacket
;	.line	457; usb.c	if(SetupPacket.bmRequestType == 0x80)
	MOVF	_SetupPacket, W, B
	XORLW	0x80
	BZ	_00277_DS_
	BRA	_00268_DS_
_00277_DS_:
;	.line	459; usb.c	byte descriptorType  = SetupPacket.wValue1;
	MOVFF	(_SetupPacket + 3), r0x00
;	.line	460; usb.c	byte descriptorIndex = SetupPacket.wValue0;
	MOVFF	(_SetupPacket + 2), r0x01
;	.line	462; usb.c	if (descriptorType == DEVICE_DESCRIPTOR)
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00264_DS_
;	.line	467; usb.c	requestHandled = 1;
	MOVLW	0x01
	BANKSEL	_requestHandled
	MOVWF	_requestHandled, B
;	.line	468; usb.c	outPtr = (byte *)&deviceDescriptor;
	MOVLW	LOW(_deviceDescriptor)
	BANKSEL	_outPtr
	MOVWF	_outPtr, B
	MOVLW	HIGH(_deviceDescriptor)
; removed redundant BANKSEL
	MOVWF	(_outPtr + 1), B
	MOVLW	UPPER(_deviceDescriptor)
; removed redundant BANKSEL
	MOVWF	(_outPtr + 2), B
;	.line	469; usb.c	wCount = DEVICE_DESCRIPTOR_SIZE;
	MOVLW	0x12
	BANKSEL	_wCount
	MOVWF	_wCount, B
; removed redundant BANKSEL
	CLRF	(_wCount + 1), B
	BRA	_00268_DS_
_00264_DS_:
;	.line	471; usb.c	else if (descriptorType == CONFIGURATION_DESCRIPTOR)
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00261_DS_
;	.line	476; usb.c	requestHandled = 1;
	MOVLW	0x01
	BANKSEL	_requestHandled
	MOVWF	_requestHandled, B
;	.line	487; usb.c	outPtr = (byte *)&configDescriptor;
	MOVLW	LOW(_configDescriptor)
	BANKSEL	_outPtr
	MOVWF	_outPtr, B
	MOVLW	HIGH(_configDescriptor)
; removed redundant BANKSEL
	MOVWF	(_outPtr + 1), B
	MOVLW	UPPER(_configDescriptor)
; removed redundant BANKSEL
	MOVWF	(_outPtr + 2), B
;	.line	488; usb.c	wCount = configDescriptor.configHeader[2]; // Note: SDCC makes bad code with this
	MOVLW	LOW(_configDescriptor + 2)
	MOVWF	TBLPTRL
	MOVLW	HIGH(_configDescriptor + 2)
	MOVWF	TBLPTRH
	MOVLW	UPPER(_configDescriptor + 2)
	MOVWF	TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x02
	MOVFF	r0x02, _wCount
	BANKSEL	(_wCount + 1)
	CLRF	(_wCount + 1), B
	BRA	_00268_DS_
_00261_DS_:
;	.line	494; usb.c	else if (descriptorType == STRING_DESCRIPTOR)
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00268_DS_
;	.line	499; usb.c	requestHandled = 1;
	MOVLW	0x01
	BANKSEL	_requestHandled
	MOVWF	_requestHandled, B
;	.line	500; usb.c	if (descriptorIndex == 0)
	MOVF	r0x01, W
	BNZ	_00256_DS_
;	.line	501; usb.c	outPtr = &stringDescriptor0;
	MOVLW	LOW(_stringDescriptor0)
	BANKSEL	_outPtr
	MOVWF	_outPtr, B
	MOVLW	HIGH(_stringDescriptor0)
; removed redundant BANKSEL
	MOVWF	(_outPtr + 1), B
	MOVLW	UPPER(_stringDescriptor0)
; removed redundant BANKSEL
	MOVWF	(_outPtr + 2), B
	BRA	_00257_DS_
_00256_DS_:
;	.line	502; usb.c	else if (descriptorIndex == 1)
	MOVF	r0x01, W
	XORLW	0x01
	BNZ	_00253_DS_
;	.line	503; usb.c	outPtr = &stringDescriptor1;
	MOVLW	LOW(_stringDescriptor1)
	BANKSEL	_outPtr
	MOVWF	_outPtr, B
	MOVLW	HIGH(_stringDescriptor1)
; removed redundant BANKSEL
	MOVWF	(_outPtr + 1), B
	MOVLW	UPPER(_stringDescriptor1)
; removed redundant BANKSEL
	MOVWF	(_outPtr + 2), B
	BRA	_00257_DS_
_00253_DS_:
;	.line	505; usb.c	outPtr = &stringDescriptor2;
	MOVLW	LOW(_stringDescriptor2)
	BANKSEL	_outPtr
	MOVWF	_outPtr, B
	MOVLW	HIGH(_stringDescriptor2)
; removed redundant BANKSEL
	MOVWF	(_outPtr + 1), B
	MOVLW	UPPER(_stringDescriptor2)
; removed redundant BANKSEL
	MOVWF	(_outPtr + 2), B
_00257_DS_:
;	.line	506; usb.c	wCount = *outPtr;
	MOVFF	_outPtr, r0x00
	MOVFF	(_outPtr + 1), r0x01
	MOVFF	(_outPtr + 2), r0x02
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, PRODL
	MOVF	r0x02, W
	CALL	__gptrget1
	MOVWF	r0x00
	MOVFF	r0x00, _wCount
	BANKSEL	(_wCount + 1)
	CLRF	(_wCount + 1), B
_00268_DS_:
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_usb__ProcessHIDRequest	code
_ProcessHIDRequest:
;	.line	332; usb.c	void ProcessHIDRequest(void)
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
;	.line	337; usb.c	if((SetupPacket.bmRequestType & 0x1F) != 0x01 || (SetupPacket.wIndex0 != 0x00))
	MOVLW	0x1f
	BANKSEL	_SetupPacket
	ANDWF	_SetupPacket, W, B
; #	MOVWF	r0x00
; #	MOVF	r0x00, W
; ;     peep 2 - Removed redundant move
	XORLW	0x01
	BNZ	_00179_DS_
_00224_DS_:
	BANKSEL	(_SetupPacket + 4)
	MOVF	(_SetupPacket + 4), W, B
	BZ	_00180_DS_
_00179_DS_:
;	.line	338; usb.c	return;
	BRA	_00209_DS_
_00180_DS_:
;	.line	340; usb.c	bRequest = SetupPacket.bRequest;
	MOVFF	(_SetupPacket + 1), r0x00
;	.line	342; usb.c	if (bRequest == GET_DESCRIPTOR)
	MOVF	r0x00, W
	XORLW	0x06
	BNZ	_00189_DS_
;	.line	345; usb.c	byte descriptorType  = SetupPacket.wValue1;
	MOVFF	(_SetupPacket + 3), r0x01
;	.line	346; usb.c	if (descriptorType == HID_DESCRIPTOR)
	MOVF	r0x01, W
	XORLW	0x21
	BNZ	_00186_DS_
;	.line	352; usb.c	requestHandled = 1;
	MOVLW	0x01
	BANKSEL	_requestHandled
	MOVWF	_requestHandled, B
;	.line	353; usb.c	outPtr = &configDescriptor.HIDDescriptor;
	MOVLW	0x09
	ADDWF	LOW(_configDescriptor), W
	BANKSEL	_outPtr
	MOVWF	_outPtr, B
	MOVLW	0x00
	ADDWFC	HIGH(_configDescriptor), W
; removed redundant BANKSEL
	MOVWF	(_outPtr + 1), B
	MOVLW	0x00
	ADDWFC	UPPER(_configDescriptor), W
; removed redundant BANKSEL
	MOVWF	(_outPtr + 2), B
;	.line	354; usb.c	wCount = HID_HEADER_SIZE;
	MOVLW	0x09
	BANKSEL	_wCount
	MOVWF	_wCount, B
; removed redundant BANKSEL
	CLRF	(_wCount + 1), B
	BRA	_00189_DS_
_00186_DS_:
;	.line	356; usb.c	else if (descriptorType == REPORT_DESCRIPTOR)
	MOVF	r0x01, W
	XORLW	0x22
	BNZ	_00189_DS_
;	.line	362; usb.c	requestHandled = 1;
	MOVLW	0x01
	BANKSEL	_requestHandled
	MOVWF	_requestHandled, B
;	.line	363; usb.c	outPtr = (code byte *)HIDReport;
	MOVLW	LOW(_HIDReport)
	BANKSEL	_outPtr
	MOVWF	_outPtr, B
	MOVLW	HIGH(_HIDReport)
; removed redundant BANKSEL
	MOVWF	(_outPtr + 1), B
	MOVLW	UPPER(_HIDReport)
; removed redundant BANKSEL
	MOVWF	(_outPtr + 2), B
;	.line	364; usb.c	wCount = HID_REPORT_SIZE;
	MOVLW	0x2f
	BANKSEL	_wCount
	MOVWF	_wCount, B
; removed redundant BANKSEL
	CLRF	(_wCount + 1), B
_00189_DS_:
;	.line	381; usb.c	if ((SetupPacket.bmRequestType & 0x60) != 0x20)
	MOVLW	0x60
	BANKSEL	_SetupPacket
	ANDWF	_SetupPacket, W, B
; #	MOVWF	r0x01
; #	MOVF	r0x01, W
; ;     peep 2 - Removed redundant move
	XORLW	0x20
	BZ	_00191_DS_
;	.line	386; usb.c	return;
	BRA	_00209_DS_
_00191_DS_:
;	.line	390; usb.c	if (bRequest == GET_REPORT)
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00207_DS_
;	.line	395; usb.c	HIDGetReport();
	CALL	_HIDGetReport
	BRA	_00209_DS_
_00207_DS_:
;	.line	397; usb.c	else if (bRequest == SET_REPORT)
	MOVF	r0x00, W
	XORLW	0x09
	BNZ	_00204_DS_
;	.line	402; usb.c	HIDPostProcess = 1;
	MOVLW	0x01
	BANKSEL	_HIDPostProcess
	MOVWF	_HIDPostProcess, B
;	.line	403; usb.c	HIDSetReport();            
	CALL	_HIDSetReport
	BRA	_00209_DS_
_00204_DS_:
;	.line	405; usb.c	else if (bRequest == GET_IDLE)
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00201_DS_
;	.line	410; usb.c	requestHandled = 1;
	MOVLW	0x01
	BANKSEL	_requestHandled
	MOVWF	_requestHandled, B
;	.line	411; usb.c	outPtr = &hidIdleRate;
	MOVLW	HIGH(_hidIdleRate)
	BANKSEL	(_outPtr + 1)
	MOVWF	(_outPtr + 1), B
	MOVLW	LOW(_hidIdleRate)
; removed redundant BANKSEL
	MOVWF	_outPtr, B
	MOVLW	0x80
; removed redundant BANKSEL
	MOVWF	(_outPtr + 2), B
;	.line	412; usb.c	wCount = 1;
	MOVLW	0x01
	BANKSEL	_wCount
	MOVWF	_wCount, B
; removed redundant BANKSEL
	CLRF	(_wCount + 1), B
	BRA	_00209_DS_
_00201_DS_:
;	.line	414; usb.c	else if (bRequest == SET_IDLE)
	MOVF	r0x00, W
	XORLW	0x0a
	BNZ	_00198_DS_
;	.line	419; usb.c	requestHandled = 1;
	MOVLW	0x01
	BANKSEL	_requestHandled
	MOVWF	_requestHandled, B
;	.line	420; usb.c	hidIdleRate = SetupPacket.wValue1;
	MOVFF	(_SetupPacket + 3), _hidIdleRate
	BRA	_00209_DS_
_00198_DS_:
;	.line	422; usb.c	else if (bRequest == GET_PROTOCOL)
	MOVF	r0x00, W
	XORLW	0x03
	BNZ	_00195_DS_
;	.line	427; usb.c	requestHandled = 1;
	MOVLW	0x01
	BANKSEL	_requestHandled
	MOVWF	_requestHandled, B
;	.line	428; usb.c	outPtr = &hidProtocol;
	MOVLW	HIGH(_hidProtocol)
	BANKSEL	(_outPtr + 1)
	MOVWF	(_outPtr + 1), B
	MOVLW	LOW(_hidProtocol)
; removed redundant BANKSEL
	MOVWF	_outPtr, B
	MOVLW	0x80
; removed redundant BANKSEL
	MOVWF	(_outPtr + 2), B
;	.line	429; usb.c	wCount = 1;
	MOVLW	0x01
	BANKSEL	_wCount
	MOVWF	_wCount, B
; removed redundant BANKSEL
	CLRF	(_wCount + 1), B
	BRA	_00209_DS_
_00195_DS_:
;	.line	431; usb.c	else if (bRequest == SET_PROTOCOL)
	MOVF	r0x00, W
	XORLW	0x0b
	BNZ	_00209_DS_
;	.line	436; usb.c	requestHandled = 1;
	MOVLW	0x01
	BANKSEL	_requestHandled
	MOVWF	_requestHandled, B
;	.line	437; usb.c	hidProtocol = SetupPacket.wValue0;
	MOVFF	(_SetupPacket + 2), _hidProtocol
_00209_DS_:
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_usb__HIDSetReport	code
_HIDSetReport:
;	.line	317; usb.c	void HIDSetReport(void)
	MOVFF	r0x00, POSTDEC1
;	.line	319; usb.c	byte reportID = SetupPacket.wValue0;
	MOVFF	(_SetupPacket + 2), r0x00
	BANKSEL	(_SetupPacket + 3)
;	.line	325; usb.c	if (SetupPacket.wValue1 == 0x02)
	MOVF	(_SetupPacket + 3), W, B
	XORLW	0x02
	BNZ	_00165_DS_
;	.line	326; usb.c	requestHandled = SetupOutputReport(reportID);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_SetupOutputReport
	INCF	FSR1L, F
	BANKSEL	_requestHandled
	MOVWF	_requestHandled, B
	BRA	_00167_DS_
_00165_DS_:
	BANKSEL	(_SetupPacket + 3)
;	.line	327; usb.c	else if (SetupPacket.wValue1 == 0x03)
	MOVF	(_SetupPacket + 3), W, B
	XORLW	0x03
	BNZ	_00167_DS_
;	.line	328; usb.c	requestHandled = SetupFeatureReport(reportID);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_SetupFeatureReport
	INCF	FSR1L, F
	BANKSEL	_requestHandled
	MOVWF	_requestHandled, B
_00167_DS_:
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_usb__HIDGetReport	code
_HIDGetReport:
;	.line	302; usb.c	void HIDGetReport(void)
	MOVFF	r0x00, POSTDEC1
;	.line	304; usb.c	byte reportID = SetupPacket.wValue0;
	MOVFF	(_SetupPacket + 2), r0x00
	BANKSEL	(_SetupPacket + 3)
;	.line	310; usb.c	if (SetupPacket.wValue1 == 0x01)
	MOVF	(_SetupPacket + 3), W, B
	XORLW	0x01
	BNZ	_00148_DS_
;	.line	311; usb.c	requestHandled = GetInputReport(reportID);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_GetInputReport
	INCF	FSR1L, F
	BANKSEL	_requestHandled
	MOVWF	_requestHandled, B
	BRA	_00150_DS_
_00148_DS_:
	BANKSEL	(_SetupPacket + 3)
;	.line	312; usb.c	else if (SetupPacket.wValue1 == 0x03)
	MOVF	(_SetupPacket + 3), W, B
	XORLW	0x03
	BNZ	_00150_DS_
;	.line	313; usb.c	requestHandled = GetFeatureReport(reportID);
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	CALL	_GetFeatureReport
	INCF	FSR1L, F
	BANKSEL	_requestHandled
	MOVWF	_requestHandled, B
_00150_DS_:
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_usb__HIDInitEndpoint	code
_HIDInitEndpoint:
;	.line	281; usb.c	void HIDInitEndpoint(void)
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	BANKSEL	_hidRxLen
;	.line	283; usb.c	hidRxLen =0;
	CLRF	_hidRxLen, B
;	.line	289; usb.c	UEP1 = 0x1E;
	MOVLW	0x1e
	MOVWF	_UEP1
;	.line	291; usb.c	ep1Bo.Cnt = sizeof(HIDRxBuffer);
	MOVLW	0x20
	BANKSEL	(_ep1Bo + 1)
	MOVWF	(_ep1Bo + 1), B
;	.line	292; usb.c	ep1Bo.ADDR = PTR16(&HIDRxBuffer);
	MOVLW	LOW(_HIDRxBuffer)
	MOVWF	r0x00
	MOVLW	HIGH(_HIDRxBuffer)
	MOVWF	r0x01
	MOVF	r0x00, W
; removed redundant BANKSEL
	MOVWF	(_ep1Bo + 2), B
	MOVF	r0x01, W
; removed redundant BANKSEL
	MOVWF	(_ep1Bo + 3), B
;	.line	293; usb.c	ep1Bo.Stat = UOWN | DTSEN;
	MOVLW	0x88
	BANKSEL	_ep1Bo
	MOVWF	_ep1Bo, B
;	.line	295; usb.c	ep1Bi.ADDR = PTR16(&HIDTxBuffer);
	MOVLW	LOW(_HIDTxBuffer)
	MOVWF	r0x00
	MOVLW	HIGH(_HIDTxBuffer)
	MOVWF	r0x01
	MOVF	r0x00, W
	BANKSEL	(_ep1Bi + 2)
	MOVWF	(_ep1Bi + 2), B
	MOVF	r0x01, W
; removed redundant BANKSEL
	MOVWF	(_ep1Bi + 3), B
;	.line	296; usb.c	ep1Bi.Stat = DTS;
	MOVLW	0x40
	BANKSEL	_ep1Bi
	MOVWF	_ep1Bi, B
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_usb__HIDRxReport	code
_HIDRxReport:
;	.line	237; usb.c	byte HIDRxReport(byte *buffer, byte len)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, POSTDEC1
	MOVFF	r0x08, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
	MOVLW	0x05
	MOVFF	PLUSW2, r0x03
	BANKSEL	_hidRxLen
;	.line	239; usb.c	hidRxLen = 0;
	CLRF	_hidRxLen, B
	BANKSEL	_ep1Bo
;	.line	246; usb.c	if(!(ep1Bo.Stat & UOWN))
	BTFSC	_ep1Bo, 7, B
	BRA	_00132_DS_
;	.line	249; usb.c	if(len > ep1Bo.Cnt)
	MOVF	r0x03, W
; #	SUBWF	(_ep1Bo + 1), W, B
; #	BTFSC	STATUS, 0
; #	GOTO	_00127_DS_
; #	MOVFF	(_ep1Bo + 1), r0x03
; #	CLRF	_hidRxLen, B
; ;     peep 1 - test/jump to test/skip
	BANKSEL	(_ep1Bo + 1)
;	.line	250; usb.c	len = ep1Bo.Cnt;
	SUBWF	(_ep1Bo + 1), W, B
;	.line	256; usb.c	for(hidRxLen = 0; hidRxLen < len; hidRxLen++)
	BTFSS	STATUS, 0
	MOVFF	(_ep1Bo + 1), r0x03
	BANKSEL	_hidRxLen
	CLRF	_hidRxLen, B
_00133_DS_:
	MOVF	r0x03, W
	BANKSEL	_hidRxLen
	SUBWF	_hidRxLen, W, B
	BC	_00136_DS_
; removed redundant BANKSEL
;	.line	258; usb.c	buffer[hidRxLen] = HIDRxBuffer[hidRxLen];
	MOVF	_hidRxLen, W, B
	ADDWF	r0x00, W
	MOVWF	r0x04
	CLRF	WREG
	ADDWFC	r0x01, W
	MOVWF	r0x05
	CLRF	WREG
	ADDWFC	r0x02, W
	MOVWF	r0x06
	MOVLW	LOW(_HIDRxBuffer)
; removed redundant BANKSEL
	ADDWF	_hidRxLen, W, B
	MOVWF	r0x07
	CLRF	r0x08
	MOVLW	HIGH(_HIDRxBuffer)
	ADDWFC	r0x08, F
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	INDF0, r0x07
	MOVFF	r0x07, POSTDEC1
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, PRODL
	MOVF	r0x06, W
	CALL	__gptrput1
	BANKSEL	_hidRxLen
;	.line	256; usb.c	for(hidRxLen = 0; hidRxLen < len; hidRxLen++)
	INCF	_hidRxLen, F, B
	BRA	_00133_DS_
_00136_DS_:
;	.line	268; usb.c	ep1Bo.Cnt = sizeof(HIDRxBuffer);
	MOVLW	0x20
	BANKSEL	(_ep1Bo + 1)
	MOVWF	(_ep1Bo + 1), B
	BANKSEL	_ep1Bo
;	.line	269; usb.c	if(ep1Bo.Stat & DTS)
	BTFSS	_ep1Bo, 6, B
	BRA	_00129_DS_
;	.line	270; usb.c	ep1Bo.Stat = UOWN | DTSEN;
	MOVLW	0x88
; removed redundant BANKSEL
	MOVWF	_ep1Bo, B
	BRA	_00132_DS_
_00129_DS_:
;	.line	272; usb.c	ep1Bo.Stat = UOWN | DTS | DTSEN;
	MOVLW	0xc8
	BANKSEL	_ep1Bo
	MOVWF	_ep1Bo, B
_00132_DS_:
	BANKSEL	_hidRxLen
;	.line	275; usb.c	return hidRxLen;
	MOVF	_hidRxLen, W, B
	MOVFF	PREINC1, r0x08
	MOVFF	PREINC1, r0x07
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_usb__HIDTxReport	code
_HIDTxReport:
;	.line	200; usb.c	byte HIDTxReport(byte *buffer, byte len)
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, POSTDEC1
	MOVFF	r0x08, POSTDEC1
	MOVLW	0x02
	MOVFF	PLUSW2, r0x00
	MOVLW	0x03
	MOVFF	PLUSW2, r0x01
	MOVLW	0x04
	MOVFF	PLUSW2, r0x02
	MOVLW	0x05
	MOVFF	PLUSW2, r0x03
	BANKSEL	_ep1Bi
;	.line	209; usb.c	if (ep1Bi.Stat & UOWN)
	BTFSS	_ep1Bi, 7, B
	BRA	_00106_DS_
;	.line	210; usb.c	return 0;
	CLRF	WREG
	BRA	_00116_DS_
_00106_DS_:
;	.line	213; usb.c	if(len > HID_INPUT_REPORT_BYTES)
	MOVLW	0x21
	SUBWF	r0x03, W
	BNC	_00121_DS_
;	.line	214; usb.c	len = HID_INPUT_REPORT_BYTES;
	MOVLW	0x20
	MOVWF	r0x03
_00121_DS_:
;	.line	220; usb.c	for (i = 0; i < len; i++)
	CLRF	r0x04
_00112_DS_:
	MOVF	r0x03, W
	SUBWF	r0x04, W
	BC	_00115_DS_
;	.line	221; usb.c	HIDTxBuffer[i] = buffer[i];
	MOVLW	LOW(_HIDTxBuffer)
	ADDWF	r0x04, W
	MOVWF	r0x05
	CLRF	r0x06
	MOVLW	HIGH(_HIDTxBuffer)
	ADDWFC	r0x06, F
	MOVF	r0x04, W
	ADDWF	r0x00, W
	MOVWF	r0x07
	CLRF	WREG
	ADDWFC	r0x01, W
	MOVWF	r0x08
	CLRF	WREG
	ADDWFC	r0x02, W
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, PRODL
	CALL	__gptrget1
	MOVWF	r0x07
	MOVFF	r0x05, FSR0L
	MOVFF	r0x06, FSR0H
	MOVFF	r0x07, INDF0
;	.line	220; usb.c	for (i = 0; i < len; i++)
	INCF	r0x04, F
	BRA	_00112_DS_
_00115_DS_:
;	.line	225; usb.c	ep1Bi.Cnt = len;
	MOVF	r0x03, W
	BANKSEL	(_ep1Bi + 1)
	MOVWF	(_ep1Bi + 1), B
	BANKSEL	_ep1Bi
;	.line	226; usb.c	if(ep1Bi.Stat & DTS)
	BTFSS	_ep1Bi, 6, B
	BRA	_00110_DS_
;	.line	227; usb.c	ep1Bi.Stat = UOWN | DTSEN;
	MOVLW	0x88
; removed redundant BANKSEL
	MOVWF	_ep1Bi, B
	BRA	_00111_DS_
_00110_DS_:
;	.line	229; usb.c	ep1Bi.Stat = UOWN | DTS | DTSEN;
	MOVLW	0xc8
	BANKSEL	_ep1Bi
	MOVWF	_ep1Bi, B
_00111_DS_:
;	.line	231; usb.c	return len;
	MOVF	r0x03, W
_00116_DS_:
	MOVFF	PREINC1, r0x08
	MOVFF	PREINC1, r0x07
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block for Ival
	code
_deviceDescriptor:
	DB	0x12, 0x01, 0x00, 0x02, 0x00, 0x00, 0x00, 0x20, 0x6b, 0x1d, 0x02, 0x00
	DB	0x10, 0x00, 0x01, 0x02, 0x00, 0x01
; ; Starting pCode block for Ival
_configDescriptor:
	DB	0x09, 0x02, 0x20, 0x00, 0x01, 0x01, 0x00, 0xa0, 0x32, 0x09, 0x04, 0x00
	DB	0x00, 0x02, 0x07, 0x01, 0x02, 0x00, 0x07, 0x05, 0x01, 0x02, 0x20, 0x00
	DB	0x00, 0x07, 0x05, 0x82, 0x02, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	DB	0x00, 0x00, 0x00, 0x00, 0x00
; ; Starting pCode block for Ival
_HIDReport:
	DB	0x06, 0xa0, 0xff, 0x09, 0x01, 0xa1, 0x01, 0x09, 0x02, 0x15, 0x00, 0x26
	DB	0x00, 0xff, 0x75, 0x08, 0x95, 0x20, 0x81, 0x02, 0x09, 0x02, 0x15, 0x00
	DB	0x26, 0x00, 0xff, 0x75, 0x08, 0x95, 0x20, 0x91, 0x02, 0x09, 0x01, 0x15
	DB	0x00, 0x26, 0x00, 0xff, 0x75, 0x08, 0x95, 0x20, 0xb1, 0x02, 0xc0
; ; Starting pCode block for Ival
_stringDescriptor0:
	DB	0x04, 0x03, 0x09, 0x04
; ; Starting pCode block for Ival
_stringDescriptor1:
	DB	0x0e, 0x03, 0x48, 0x00, 0x49, 0x00, 0x4a, 0x00, 0x4f, 0x00, 0x64, 0x00
	DB	0x65, 0x00
; ; Starting pCode block for Ival
_stringDescriptor2:
	DB	0x20, 0x03, 0x50, 0x00, 0x55, 0x00, 0x54, 0x00, 0x41, 0x00, 0x20, 0x00
	DB	0x50, 0x00, 0x49, 0x00, 0x43, 0x00, 0x43, 0x00, 0x48, 0x00, 0x4f, 0x00
	DB	0x54, 0x00, 0x4f, 0x00, 0x21, 0x00, 0x21, 0x00


; Statistics:
; code size:	 3246 (0x0cae) bytes ( 2.48%)
;           	 1623 (0x0657) words
; udata size:	  195 (0x00c3) bytes (10.88%)
; access size:	   10 (0x000a) bytes


	end
