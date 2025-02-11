;
; AssemblerApplication1.asm
;
; Created: 2/4/2025 8:11:10 AM
; Author : laloj
;

// Encabezado
.include "M328PDEF.inc"
.cseg
.org 0x0000
// Configuracion de la pila
LDI R16, LOW(RAMEND)
OUT SPL, R16 // Cargar 0xff a SPL
LDI R16, HIGH(RAMEND)
OUT SPH, R16 // Cargar 0x08 a SPH

; Que hace cada registro aqui voy a anotar
; R16 (dentro del loop) almaxenara la lectura del pin b
; R17 va a almacenar 0xFF para comparar la lectura del pin D
; R18 Va a tener la cuenta 

//Setup
//PortC como entrada
LDI R16, 0x00
OUT DDRC, R16
LDI R16, 0xFF
OUT PORTC, R16 // Port C como pull up
OUT DDRD, R16 //D como salida
OUT DDRB, R16 //PortB como salida
LDI R16, 0x00
LDI R17, 0xff
LDI R22, 0x00
ldi R23, 0x00

LOOP:
IN R16, PINC //Lectura del pinb
CP R17, R16
BREQ LOOP
CALL DELAY
IN R16, PINC
CP R17, R16
BREQ LOOP
MOV R17, R16
;Aqui comienza la logica para sumar o restar
SBIS PINC, 0
CALL INCRE1
SBIS PINC, 1
CALL DECRE1
SBIS PINC, 2
CALL INCRE2
SBIS PINC, 3
CALL DECRE2
SBIS PINC, 4
CALL SUMAMUMA
JMP LOOP

// Funcion para incrementar
INCRE1:
OUT PIND, R20
INC R18
ANDI R18, 0x0F
MOV R20, R18
ADD R20, R22
OUT PIND, R20
RET

DECRE1:
OUT PIND, R20
DEC R18
ANDI R18, 0x0F
MOV R20, R18
ADD R20, R22
OUT PIND, R20
RET

INCRE2:
OUT PIND, R20
INC R21
ANDI R21, 0x0F
MOV R22, R21
ROL R22
ROL R22
ROL R22
ROL R22
MOV R20, R22
ADD R20, R18
OUT PIND, R20
RET


DECRE2:
OUT PIND, R20
DEC R21
ANDI R21, 0x0F
MOV R22, R21
ROL R22
ROL R22
ROL R22
ROL R22
MOV R20, R22
ADD R20, R18
OUT PIND, R20
RET

SUMAMUMA:
OUT PINB, R23
MOV R23, R21
ADD R23, R18
OUT PINB, R23
RET

//El delay lol
DELAY:
    LDI     R19, 0
SUBDELAY1:
    INC     R19
    CPI     R19, 0
    BRNE    SUBDELAY1
    LDI     R19, 0
SUBDELAY2:
    INC     R19
    CPI     R19, 0
    BRNE    SUBDELAY2
    LDI     R19, 0
SUBDELAY3:
    INC     R19
    CPI     R19, 0
    BRNE    SUBDELAY3
	    LDI     R19, 0
	SUBDELAY4:
    INC     R19
    CPI     R19, 0
    BRNE    SUBDELAY4
    RET