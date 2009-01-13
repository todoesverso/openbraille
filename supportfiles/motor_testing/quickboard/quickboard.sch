EESchema Schematic File Version 2
LIBS:power,D:/Profiles/DGKR78/My Documents/openbraille/supportfiles/motor_testing/kicadlib_contrib/lib/microchip,D:/Profiles/DGKR78/My Documents/openbraille/supportfiles/motor_testing/kicadlib_contrib/lib/pl_symbole,D:/Profiles/DGKR78/My Documents/openbraille/supportfiles/motor_testing/kicadlib_contrib/lib/microchip1,device,transistors,conn,linear,regul,74xx,cmos4000,adc-dac,memory,xilinx,special,microcontrollers,dsp,microchip,analog_switches,motorola,texas,intel,audio,interface,digital-audio,philips,display,cypress,siliconi,contrib,valves,.\quickboard.cache
EELAYER 23  0
EELAYER END
$Descr A4 11700 8267
Sheet 1 1
Title ""
Date "13 jan 2009"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Wire Line
	1550 2150 1550 2200
$Comp
L CAPAPOL C7
U 1 1 496D0160
P 1550 1950
F 0 "C7" H 1600 2050 50  0000 L C
F 1 "100u" H 1600 1850 50  0000 L C
	1    1550 1950
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR3
U 1 1 496D015F
P 1550 2200
F 0 "#PWR3" H 1550 2200 30  0001 C C
F 1 "GND" H 1550 2130 30  0001 C C
	1    1550 2200
	1    0    0    -1  
$EndComp
Kmarq B 3200 1750 "Warning: Pin power_out connected to Pin BiDi (net 2)" F=1
Wire Wire Line
	2050 2150 2050 2200
$Comp
L 7805 U1
U 1 1 4969D648
P 2800 1800
F 0 "U1" H 2950 1604 60  0000 C C
F 1 "7805" H 2800 2000 60  0000 C C
	1    2800 1800
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR5
U 1 1 4969D5E7
P 2050 2200
F 0 "#PWR5" H 2050 2200 30  0001 C C
F 1 "GND" H 2050 2130 30  0001 C C
	1    2050 2200
	1    0    0    -1  
$EndComp
$Comp
L C C1
U 1 1 4969D5E6
P 2050 1950
F 0 "C1" H 2100 2050 50  0000 L C
F 1 "0.1u" H 2100 1850 50  0000 L C
	1    2050 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	3400 2150 3400 2200
$Comp
L GND #PWR9
U 1 1 4969D642
P 3400 2200
F 0 "#PWR9" H 3400 2200 30  0001 C C
F 1 "GND" H 3400 2130 30  0001 C C
	1    3400 2200
	1    0    0    -1  
$EndComp
$Comp
L C C2
U 1 1 4969D641
P 3400 1950
F 0 "C2" H 3450 2050 50  0000 L C
F 1 "0.1u" H 3450 1850 50  0000 L C
	1    3400 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	7000 4650 7000 4700
Wire Wire Line
	7950 4700 7950 4750
Wire Wire Line
	5150 4650 5150 4700
Wire Wire Line
	3200 1750 3400 1750
Connection ~ 4550 4550
Wire Wire Line
	4550 4500 4550 4550
Wire Wire Line
	1950 1350 1950 1400
Wire Wire Line
	8250 5550 8250 5600
Wire Wire Line
	4550 4000 4550 3950
Wire Wire Line
	8250 4600 8250 4550
Connection ~ 8850 4550
Wire Wire Line
	6950 4400 8850 4400
Wire Wire Line
	8850 4400 8850 4600
Wire Wire Line
	9150 5150 8800 5150
Wire Wire Line
	9550 4900 9550 4950
Wire Wire Line
	3900 4550 3900 4600
Wire Wire Line
	5150 4250 5150 2950
Wire Wire Line
	10500 1650 10300 1650
Wire Wire Line
	10300 1650 10300 3800
Wire Wire Line
	10300 3800 10000 3800
Wire Wire Line
	10500 1450 10000 1450
Wire Wire Line
	10000 1450 10000 1800
Wire Wire Line
	1200 1750 1200 1800
Connection ~ 3400 1750
Connection ~ 2050 1750
Wire Wire Line
	1300 1750 2400 1750
Wire Wire Line
	950  1650 950  1750
Wire Wire Line
	9150 4550 9150 4650
Connection ~ 8250 5150
Wire Wire Line
	8300 5150 8000 5150
Wire Wire Line
	7450 5350 7700 5350
Wire Wire Line
	9050 4000 6950 4000
Wire Wire Line
	6950 4000 6950 4200
Wire Wire Line
	5150 2950 9050 2950
Wire Wire Line
	9550 4000 9600 4000
Wire Wire Line
	9550 2000 9600 2000
Connection ~ 2800 4900
Connection ~ 4750 5000
Wire Wire Line
	5150 5000 3300 5000
Connection ~ 3750 4800
Wire Wire Line
	5150 4800 3300 4800
Wire Wire Line
	4250 5100 4250 4900
Wire Wire Line
	3550 5300 3550 5350
Wire Wire Line
	4050 5300 4050 5350
Wire Wire Line
	4550 5300 4550 5350
Wire Wire Line
	2800 2050 2800 2100
Wire Wire Line
	10500 1850 10500 1900
Wire Wire Line
	4750 5100 4750 5000
Wire Wire Line
	3750 5100 3750 4800
Wire Wire Line
	5150 4900 3300 4900
Connection ~ 4250 4900
Wire Wire Line
	2800 4650 2800 5000
Connection ~ 2800 4800
Wire Wire Line
	9550 2950 9600 2950
Wire Wire Line
	9550 4950 9600 4950
Wire Wire Line
	5150 4350 5050 4350
Wire Wire Line
	5050 4350 5050 2000
Wire Wire Line
	5050 2000 9050 2000
Wire Wire Line
	10100 5150 10100 5200
Wire Wire Line
	10100 4200 10100 4250
Wire Wire Line
	10100 3150 10100 3200
Wire Wire Line
	10100 2200 10100 2250
Wire Wire Line
	8000 5550 8000 5600
Wire Wire Line
	6950 4950 8000 4950
Wire Wire Line
	8000 4950 8000 5150
Wire Wire Line
	7450 4850 6950 4850
Wire Wire Line
	8850 5050 8850 5000
Connection ~ 1550 1750
Wire Wire Line
	10500 1350 2400 1350
Wire Wire Line
	2400 1350 2400 1750
Wire Wire Line
	10000 4750 10400 4750
Wire Wire Line
	10400 4750 10400 1750
Wire Wire Line
	10400 1750 10500 1750
Wire Wire Line
	10500 1550 10200 1550
Wire Wire Line
	10200 1550 10200 2750
Wire Wire Line
	10200 2750 10000 2750
Wire Wire Line
	5150 4550 4500 4550
Wire Wire Line
	6950 4300 9550 4300
Wire Wire Line
	9550 4300 9550 4400
Wire Wire Line
	9150 4600 9300 4600
Wire Wire Line
	9300 4600 9300 4900
Connection ~ 9150 4600
Wire Wire Line
	8250 4550 6950 4550
Wire Wire Line
	8250 5050 8250 5000
Wire Wire Line
	8250 5000 8850 5000
Wire Wire Line
	950  1750 1100 1750
Wire Wire Line
	3400 1750 3400 1650
Wire Wire Line
	7000 4700 6950 4700
Wire Wire Line
	7550 4700 7500 4700
$Comp
L GND #PWR17
U 1 1 496CFF3C
P 7950 4750
F 0 "#PWR17" H 7950 4750 30  0001 C C
F 1 "GND" H 7950 4680 30  0001 C C
	1    7950 4750
	1    0    0    -1  
$EndComp
$Comp
L R R6
U 1 1 496CFEFA
P 7250 4700
F 0 "R6" V 7330 4700 50  0000 C C
F 1 "3k3" V 7250 4700 50  0000 C C
	1    7250 4700
	0    1    1    0   
$EndComp
$Comp
L LED D1
U 1 1 496CFED8
P 7750 4700
F 0 "D1" H 7750 4800 50  0000 C C
F 1 "LED" H 7750 4600 50  0000 C C
	1    7750 4700
	1    0    0    -1  
$EndComp
$Comp
L CAPAPOL C4
U 1 1 496CFE00
P 8250 5350
F 0 "C4" H 8300 5450 50  0000 L C
F 1 "10u" H 8300 5250 50  0000 L C
	1    8250 5350
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR15
U 1 1 496CFD5B
P 5150 4700
F 0 "#PWR15" H 5150 4700 30  0001 C C
F 1 "GND" H 5150 4630 30  0001 C C
	1    5150 4700
	1    0    0    -1  
$EndComp
$Comp
L PIC16F84A U***1
U 1 1 496CFD23
P 6050 4650
F 0 "U***1" H 6050 5300 60  0000 C C
F 1 "PIC16F84A" H 6050 4000 60  0000 C C
	1    6050 4650
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR8
U 1 1 496A1E6D
P 3400 1650
F 0 "#PWR8" H 3400 1750 30  0001 C C
F 1 "VCC" H 3400 1750 30  0000 C C
	1    3400 1650
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR4
U 1 1 496A1CE6
P 1950 1400
F 0 "#PWR4" H 1950 1400 30  0001 C C
F 1 "GND" H 1950 1330 30  0001 C C
	1    1950 1400
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG1
U 1 1 496A1CCD
P 1950 1350
F 0 "#FLG1" H 1950 1620 30  0001 C C
F 1 "PWR_FLAG" H 1950 1580 30  0000 C C
	1    1950 1350
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR20
U 1 1 496A1C5E
P 8250 5600
F 0 "#PWR20" H 8250 5600 30  0001 C C
F 1 "GND" H 8250 5530 30  0001 C C
	1    8250 5600
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR19
U 1 1 496A1B9B
P 8250 5050
F 0 "#PWR19" H 8250 5050 30  0001 C C
F 1 "GND" H 8250 4980 30  0001 C C
	1    8250 5050
	1    0    0    -1  
$EndComp
$Comp
L CRYSTAL X1
U 1 1 496A1A89
P 8550 4550
F 0 "X1" H 8550 4700 60  0000 C C
F 1 "4MHz" H 8550 4400 60  0000 C C
	1    8550 4550
	-1   0    0    1   
$EndComp
$Comp
L POT RV1
U 1 1 496A1A45
P 9150 4900
F 0 "RV1" H 9150 4800 50  0000 C C
F 1 "POT10k" H 9150 4900 50  0000 C C
	1    9150 4900
	0    1    -1   0   
$EndComp
$Comp
L PWR_FLAG #FLG2
U 1 1 496A19A8
P 2400 1350
F 0 "#FLG2" H 2400 1620 30  0001 C C
F 1 "PWR_FLAG" H 2400 1580 30  0000 C C
	1    2400 1350
	1    0    0    -1  
$EndComp
$Comp
L C C5
U 1 1 496A1866
P 8250 4800
F 0 "C5" H 8300 4900 50  0000 L C
F 1 "33p" H 8300 4700 50  0000 L C
	1    8250 4800
	-1   0    0    1   
$EndComp
$Comp
L C C6
U 1 1 496A185D
P 8850 4800
F 0 "C6" H 8900 4900 50  0000 L C
F 1 "33p" H 8900 4700 50  0000 L C
	1    8850 4800
	1    0    0    -1  
$EndComp
NoConn ~ 5150 4450
NoConn ~ 5150 5100
NoConn ~ 6950 5050
NoConn ~ 6950 5150
$Comp
L VCC #PWR13
U 1 1 496A13DD
P 4550 3950
F 0 "#PWR13" H 4550 4050 30  0001 C C
F 1 "VCC" H 4550 4050 30  0000 C C
	1    4550 3950
	1    0    0    -1  
$EndComp
$Comp
L R R4
U 1 1 496A13CE
P 4550 4250
F 0 "R4" V 4630 4250 50  0000 C C
F 1 "10k" V 4550 4250 50  0000 C C
	1    4550 4250
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR11
U 1 1 496A1349
P 3900 4600
F 0 "#PWR11" H 3900 4600 30  0001 C C
F 1 "GND" H 3900 4530 30  0001 C C
	1    3900 4600
	1    0    0    -1  
$EndComp
$Comp
L SW_PUSH SW2
U 1 1 496A1338
P 4200 4550
F 0 "SW2" H 4350 4660 50  0000 C C
F 1 "RESET" H 4200 4470 50  0000 C C
	1    4200 4550
	1    0    0    -1  
$EndComp
$Comp
L DARL_N Q3
U 1 1 4969D8F5
P 9850 3000
F 0 "Q3" H 9850 3250 50  0000 C C
F 1 "TIP122" H 9650 2900 50  0000 C C
	1    9850 3000
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR2
U 1 1 496A11F4
P 1200 1800
F 0 "#PWR2" H 1200 1800 30  0001 C C
F 1 "GND" H 1200 1730 30  0001 C C
	1    1200 1800
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR1
U 1 1 496A11C5
P 950 1650
F 0 "#PWR1" H 950 1750 30  0001 C C
F 1 "VCC" H 950 1750 30  0000 C C
	1    950  1650
	1    0    0    -1  
$EndComp
$Comp
L CONN_3 K1
U 1 1 496A11A0
P 1200 1400
F 0 "K1" V 1150 1400 50  0000 C C
F 1 "CONN_3" V 1250 1400 40  0000 C C
	1    1200 1400
	0    -1   -1   0   
$EndComp
$Comp
L VCC #PWR22
U 1 1 496A1173
P 9150 4550
F 0 "#PWR22" H 9150 4650 30  0001 C C
F 1 "VCC" H 9150 4650 30  0000 C C
	1    9150 4550
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR21
U 1 1 496A1166
P 8850 5050
F 0 "#PWR21" H 8850 5050 30  0001 C C
F 1 "GND" H 8850 4980 30  0001 C C
	1    8850 5050
	1    0    0    -1  
$EndComp
$Comp
L R R5
U 1 1 496A1165
P 8550 5150
F 0 "R5" V 8630 5150 50  0000 C C
F 1 "1k" V 8550 5150 50  0000 C C
	1    8550 5150
	0    1    1    0   
$EndComp
$Comp
L GND #PWR18
U 1 1 496A0F6D
P 8000 5600
F 0 "#PWR18" H 8000 5600 30  0001 C C
F 1 "GND" H 8000 5530 30  0001 C C
	1    8000 5600
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR23
U 1 1 496A0F33
P 10100 2250
F 0 "#PWR23" H 10100 2250 30  0001 C C
F 1 "GND" H 10100 2180 30  0001 C C
	1    10100 2250
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR24
U 1 1 496A0F2E
P 10100 3200
F 0 "#PWR24" H 10100 3200 30  0001 C C
F 1 "GND" H 10100 3130 30  0001 C C
	1    10100 3200
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR25
U 1 1 496A0F28
P 10100 4250
F 0 "#PWR25" H 10100 4250 30  0001 C C
F 1 "GND" H 10100 4180 30  0001 C C
	1    10100 4250
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR26
U 1 1 496A0F24
P 10100 5200
F 0 "#PWR26" H 10100 5200 30  0001 C C
F 1 "GND" H 10100 5130 30  0001 C C
	1    10100 5200
	1    0    0    -1  
$EndComp
$Comp
L R R11
U 1 1 496A0E99
P 9550 4650
F 0 "R11" V 9630 4650 50  0000 C C
F 1 "3k3" V 9550 4650 50  0000 C C
	1    9550 4650
	-1   0    0    1   
$EndComp
$Comp
L R R10
U 1 1 496A0E98
P 9300 4000
F 0 "R10" V 9380 4000 50  0000 C C
F 1 "3k3" V 9300 4000 50  0000 C C
	1    9300 4000
	0    1    1    0   
$EndComp
$Comp
L R R9
U 1 1 496A0E8E
P 9300 2950
F 0 "R9" V 9380 2950 50  0000 C C
F 1 "3k3" V 9300 2950 50  0000 C C
	1    9300 2950
	0    1    1    0   
$EndComp
$Comp
L R R8
U 1 1 496A0E85
P 9300 2000
F 0 "R8" V 9380 2000 50  0000 C C
F 1 "3k3" V 9300 2000 50  0000 C C
	1    9300 2000
	0    1    1    0   
$EndComp
$Comp
L VCC #PWR7
U 1 1 4969DCA5
P 2800 4650
F 0 "#PWR7" H 2800 4750 30  0001 C C
F 1 "VCC" H 2800 4750 30  0000 C C
	1    2800 4650
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR10
U 1 1 4969DC36
P 3550 5350
F 0 "#PWR10" H 3550 5350 30  0001 C C
F 1 "GND" H 3550 5280 30  0001 C C
	1    3550 5350
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR12
U 1 1 4969DC33
P 4050 5350
F 0 "#PWR12" H 4050 5350 30  0001 C C
F 1 "GND" H 4050 5280 30  0001 C C
	1    4050 5350
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR14
U 1 1 4969DC2D
P 4550 5350
F 0 "#PWR14" H 4550 5350 30  0001 C C
F 1 "GND" H 4550 5280 30  0001 C C
	1    4550 5350
	1    0    0    -1  
$EndComp
$Comp
L SW_PUSH_SMALL SW1
U 1 1 4969DC03
P 3650 5200
F 0 "SW1" H 3800 5310 30  0000 C C
F 1 "Left" H 3650 5121 30  0000 C C
	1    3650 5200
	-1   0    0    -1  
$EndComp
$Comp
L SW_PUSH_SMALL SW3
U 1 1 4969DBDD
P 4650 5200
F 0 "SW3" H 4800 5310 30  0000 C C
F 1 "Right" H 4650 5121 30  0000 C C
	1    4650 5200
	-1   0    0    -1  
$EndComp
$Comp
L SW_PUSH_SMALL SW4
U 1 1 4969DB23
P 4150 5200
F 0 "SW4" H 4300 5310 30  0000 C C
F 1 "Stop" H 4150 5121 30  0000 C C
	1    4150 5200
	-1   0    0    -1  
$EndComp
$Comp
L R R3
U 1 1 4969DAEA
P 3050 5000
F 0 "R3" V 3130 5000 50  0000 C C
F 1 "10k" V 3050 5000 50  0000 C C
	1    3050 5000
	0    1    1    0   
$EndComp
$Comp
L R R2
U 1 1 4969DAE1
P 3050 4900
F 0 "R2" V 3130 4900 50  0000 C C
F 1 "10k" V 3050 4900 50  0000 C C
	1    3050 4900
	0    1    1    0   
$EndComp
$Comp
L R R1
U 1 1 4969DACB
P 3050 4800
F 0 "R1" V 3130 4800 50  0000 C C
F 1 "10k" V 3050 4800 50  0000 C C
	1    3050 4800
	0    1    1    0   
$EndComp
$Comp
L R R7
U 1 1 4969DA98
P 7450 5100
F 0 "R7" V 7530 5100 50  0000 C C
F 1 "3k3" V 7450 5100 50  0000 C C
	1    7450 5100
	-1   0    0    1   
$EndComp
$Comp
L NPN Q1
U 1 1 4969D9E5
P 7900 5350
F 0 "Q1" H 8050 5350 50  0000 C C
F 1 "BC337" H 7802 5500 50  0000 C C
	1    7900 5350
	1    0    0    -1  
$EndComp
$Comp
L CONN_6 P1
U 1 1 4969D985
P 10850 1600
F 0 "P1" V 10800 1600 60  0000 C C
F 1 "CONN_6" V 10900 1600 60  0000 C C
	1    10850 1600
	1    0    0    -1  
$EndComp
$Comp
L DARL_N Q2
U 1 1 4969D8F6
P 9850 2050
F 0 "Q2" H 9850 2300 50  0000 C C
F 1 "TIP122" H 9650 1950 50  0000 C C
	1    9850 2050
	1    0    0    -1  
$EndComp
$Comp
L DARL_N Q4
U 1 1 4969D8B8
P 9850 4050
F 0 "Q4" H 9850 4300 50  0000 C C
F 1 "TIP122" H 9650 3950 50  0000 C C
	1    9850 4050
	1    0    0    -1  
$EndComp
$Comp
L DARL_N Q5
U 1 1 4969D895
P 9850 5000
F 0 "Q5" H 9850 5250 50  0000 C C
F 1 "TIP122" H 9650 4900 50  0000 C C
	1    9850 5000
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR16
U 1 1 4969D839
P 7000 4650
F 0 "#PWR16" H 7000 4750 30  0001 C C
F 1 "VCC" H 7000 4750 30  0000 C C
	1    7000 4650
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR6
U 1 1 4969D666
P 2800 2100
F 0 "#PWR6" H 2800 2100 30  0001 C C
F 1 "GND" H 2800 2030 30  0001 C C
	1    2800 2100
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR27
U 1 1 4969D4A7
P 10500 1900
F 0 "#PWR27" H 10500 1900 30  0001 C C
F 1 "GND" H 10500 1830 30  0001 C C
	1    10500 1900
	1    0    0    -1  
$EndComp
$EndSCHEMATC
