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
//PortB como entrada
LDI R16, 0x00
OUT DDRB, R16
LDI R16, 0xFF
OUT PORTB, R16 // Port B como pull up
OUT DDRD, R16 //
LDI R16, 0x00
LDI R17, 0xff

LOOP:
IN R16, PINB //Lectura del pinb
CP R17, R16
BREQ LOOP
CALL DELAY
IN R16, PINB
CP R17, R16
BREQ LOOP
MOV R17, R16
;Aqui comienza la logica para sumar o restar
SBIS PINB, 0
CALL INCRE1
SBIS PINB, 1
CALL DECRE1
JMP LOOP

// Funcion para incrementar
INCRE1:
OUT PIND, R18
INC R18
MOV R20, R18
ANDI R20, 0xF0
BREQ end1
CBR R18, 0XF0
end1:
OUT PIND, R18
RET

DECRE1:
OUT PIND, R18
DEC R18
MOV R20, R18
ANDI R20, 0xF0
BREQ end2
CBR R18, 0XF0
end2:
OUT PIND, R18
RET

INCRE2:


DECRE2:


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