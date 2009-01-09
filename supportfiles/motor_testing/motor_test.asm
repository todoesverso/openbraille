;############################################################
;
;        Stepper Motor controller
;        Autor: German Sanguinetti
;############################################################
        list            p=pic16f877a
        include         <p16f877a.inc>
        __config _HS_OSC & _WDT_OFF & _PWRTE_ON & _CP_OFF
        errorlevel      -302    ;para el msg de bank warning

;###############  Definicion de etiquetas  ############### 

        cblock  h'0c'
mode                            ;modo de operacion
                                ;0=PARAR 1=DER 2=IZQ
cuenta1                         ;contador de delay
cuenta2                         ;contador delay (mseg)
        endc

;Definicion PORTB 
rb0     equ     0               ;B0
rb1     equ     1               ;B1 
rb2     equ     2               ;B2
rb5     equ     5               ;B5 
rb7     equ     7               ;B7

;###############    Inicio de programa     ############### 
        org     0               ;restablecer vector
        goto    init
        org     4               ;vector interrupcion
        clrf    INTCON          ;reestablecer reg interruption

;###############      Proceso inicial      ############### 
init
        bsf     STATUS,RP0      ;cambiar a bank1
        clrf    TRISA           ;establecer portA en OUT
        movlw   b'00100111'     ;b0,1,2,5=IN b7=OUT
        movwf   TRISB           ;establecer portB
        movlw   b'10000000'     ;bpu=1 pullup no usado
        movwf   OPTION_REG      ;establecer OPTION_REG
        bcf     STATUS,RP0      ;cambiar a bank0
        clrf    mode            ;establecer modo=PARAR 
        clrf    cuenta1         ;limpiar contador
        clrf    cuenta2         ;limpiar contador
        movlw   b'00000101'     ;establecer portA a valor inicial
        movwf   PORTA           ;escribir portA
        bsf     PORTB,rb7       ;establecer b7=1
        btfsc   PORTB,rb5       ;b5=0 ?
        goto    $-1             ;no.  esperar

start

;###############    Verificar condicion    ############### 
        btfsc   PORTB,rb1       ;B1(PARAR) = ON ?
        goto    verificar1      ;no.  siguiente
        clrf    mode            ;si. establecer PARAR modo
        goto    drive           ;no.  saltar a motor drive
verificar1
        btfsc   PORTB,rb2       ;B2(DER) = ON ?
        goto    verificar2      ;no.  siguiente
        movlw   d'1'            ;si. establecer modo derecha 
        movwf   mode            ;grabar modo
        goto    drive           ;no.  saltar a motor drive
verificar2
        btfsc   PORTB,rb0       ;B0(IZQ) = ON ?
        goto    drive           ;no.  saltar a motor drive
        movlw   d'2'            ;si. establecer modo izquierda 
        movwf   mode            ;grabar modo

;####################  Motor drive  #####################
drive
        movf    mode,w          ;leer modo
        bz      start           ;modo = PARAR
        bsf     PORTB,rb7       ;establecer B7 = 1
        btfsc   PORTB,rb5       ;B5 = 0 ?
        goto    $-1             ;no.  esperar
        movlw   d'5'            ;establecer loop cuenta(5msec)
        movwf   cuenta1         ;grabar loop cuenta
loop    call    timer           ;esperar 1msec
        decfsz  cuenta1,f       ;cuenta - 1 = 0 ?
        goto    loop            ;no.  continuar
        bcf     PORTB,rb7       ;establecer B7 = 0
        btfss   PORTB,rb5       ;B5 = 1 ?
        goto    $-1             ;no.  esperar
        movf    PORTA,w         ;leer portA
        sublw   b'000000101'    ;verificar motor  
        bnz     drive2          ;proximo
        movf    mode,w          ;leer modo
        sublw   d'1'            ;esta bien ?
        bz      drive1          ;si. esta bien
        movlw   b'00001001'     ;no.  establecer izquierda  
        goto    drive_end       ;saltar a portA  
drive1
        movlw   b'00000110'     ;establecer derecha  
        goto    drive_end       ;saltar a portA  
;-------------------------------------------------
drive2
        movf    PORTA,w         ;leer portA
        sublw   b'000000110'    ;verificar motor  
        bnz     drive4          ;proximo
        movf    mode,w          ;leer modo
        sublw   d'1'            ;esta bien ?
        bz      drive3          ;si. esta bien
        movlw   b'00000101'     ;no.  establecer izquierda  
        goto    drive_end       ;saltar a portA  
drive3
        movlw   b'00001010'     ;establecer derecha  
        goto    drive_end       ;saltar a portA  
;-------------------------------------------------
drive4
        movf    PORTA,w         ;leer portA
        sublw   b'000001010'    ;verificar motor  
        bnz     drive6          ;proximo
        movf    mode,w          ;leer modo
        sublw   d'1'            ;esta bien ?
        bz      drive5          ;si. esta bien
        movlw   b'00000110'     ;no.  establecer izquierda  
        goto    drive_end       ;saltar a portA  
drive5
        movlw   b'00001001'     ;establecer derecha  
        goto    drive_end       ;saltar a portA  
;-------------------------------------------------
drive6
        movf    PORTA,w         ;leer portA
        sublw   b'000001001'    ;verificar motor  
        bnz     drive8          ;proximo
        movf    mode,w          ;leer modo
        sublw   d'1'            ;esta bien ?
        bz      drive7          ;si. esta bien
        movlw   b'00001010'     ;no.  establecer izquierda  
        goto    drive_end       ;saltar a portA  
drive7
        movlw   b'00000101'     ;establecer derecha  
        goto    drive_end       ;saltar a portA  
;-------------------------------------------------
drive8
        movlw   b'00000101'     ;establecer est inicial

drive_end
        movwf   PORTA           ;escribir portA
        goto    start           ;saltar a inicio
;###############   ############### 
;#############  1msec Timer Subroutine  #################
timer
        movlw   d'200'          ;establecer loop cuenta
        movwf   cuenta2          ;grabar loop cuenta
tmlp    nop                     ;Time adjust
        nop                     ;Time adjust
        decfsz  cuenta2,f        ;cuenta - 1 = 0 ?
        goto    tmlp            ;no.  continuar
        return                  ;si. cuenta end

;########################################################
;            FIN!!!!!!! 
;########################################################

        end


