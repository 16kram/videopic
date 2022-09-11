;******************************************************************************
;*                                VIDEO PIC 16F877                            *
;*                              (C)2007 ESTEBAN P.A.                          *
;*                                                                            *
;* PROGRAMA PARA REPRESENTAR CAR�CTERES B/N EN UNA PANTALLA DE TELEVISI�N PAL *
;*                        UTILIZANDO UN PIC 16F877 A 20 MHZ                   *
;*                                                                            *
;****************************************************************************** 

;MODO 0 --> MUESTRA UNA PANTALLA DE (X,Y) 20 x 8 CAR�CTERES
;MODO 1 --> MUESTRA UNA PANTALLA DE (X,Y) 7 x 11 CAR�CTERES
;TANTO EL MODO O COMO EL MODO 1 DISPONEN DE 31 CAR�CTERES
;DE 8x8 PIXELS INDEPENDIENTES PARA CADA MODO DE VIDEO.

;PARA CAMBIAR EL MODO DE VIDEO SE DEBE CAMBIAR EL VALOR DE
;LA ETIQUETA MODO_PANT, LOS VALORES QUE ACEPTA SON 0 Y 1
;0=MODO DE VIDEO 0(20x8 CAR�CTERES) Y MODO DE VIDEO=1(7x11 CAR�CTERES)

;EL MODO 0 UTILIZA PARTE DE LOS REGISTROS DE MEMORIA DE LOS BANCOS 0 Y 1 DEL PIC, 
;LA PANTALLA EN MODO 0 EST� DIVIDIDA EN DOS PARTES, LA PARTE 0(PARTE SUPERIOR DE LA PANTALLA)
;QUE CONTIENE 80 REGISTROS DE MEMORIA DEL BANCO 0 Y LA PARTE 1(PARTE INFERIOR DE LA PANTALLA),
;QUE CONTIENE OTROS 80 REGISTROS DE MEMORIA, PERO DEL BANCO1

;EL MODO 1 UTILIZA 77 REGISTROS DE MEMORIA DEL BANCO 0

;LA MAYORIA DE LOS CAR�CTERES GR�FICOS QUE REPRESENTA EL PROGRAMA
;EN LA TV HAN SIDO COPIADOS DEL MICROORDENADOR SINCLAIR ZX81

;------------------------------------------------------------------------------
;CONFIGURACI�N, REGISTROS Y ETIQUETAS DEL PIC

	__CONFIG	_CP_OFF&_WDT_OFF&_PWRTE_ON&_HS_OSC&_BODEN_OFF&_LVP_OFF
	list	 p=16f877A
	#include p16f877A.inc

LONG_X	EQU	.20; NUM. MAX. DE CAR�CTERES DE FILA EN MODO 0
LONG_Y	EQU	.8; NUM. MAX. DE L�NEAS DE UN CAR�CTER EN MODO 0
CHARMAXXY	EQU	.4; NUM. MAX DE CAR�CTERES DE COLUMNA EN MODO 0

LONGX_MODE1	EQU	.7; NUM. MAX. DE CAR�CTERES DE FILA EN MODO 1
LONGY_MODE1	EQU	.8; NUM. MAX DE L�NEAS DE UN CAR�CTER EN MODO 1
CHARMAXY_MODE1	EQU	.11; NUM. MAX. DE CAR�CTERES DE COLUMNA EN MODO 1


;REGISTROS DE USO PARA EL PROGRAMA
	CBLOCK	20H
	CONT,LINE,BYTECHAR,NUMCHAR,NUMCOL
	CONTCHAR,LINECHAR,BUFFER,CONTLINEA,FLAGSTV
	INICPANT; DIRECCI�N DE MEMORIA DONDE COMIENZA LA PARTE 0 DE LA PANTALLA EN MODO 0 Y 1
	ENDC

PANT2	EQU	0A0H;DIRECCI�N DE MEMORIA DONDE COMIENZA LA PARTE 1 DE LA PANTALLA EN MODO 0

MODO_PANT	EQU	.0; 0=PANTALLA EN MODO 0, 1=PANTALLA EN MODO 1



;------------------------------------------------------------------------------

	
	ORG 00H
	GOTO	START
	
	ORG	05H


;---------------------------JUEGO DE CAR�CTERES--------------------------------

;-------------------------SET 0 DE CAR�CTERES MODO 0---------------------------
BYTEPANT
	ADDWF	BYTECHAR,W
	ADDWF	PCL,F
	RETLW	B'00000000'
	RETLW	B'00000000'
	RETLW	B'00000000'
	RETLW	B'00000000'
	RETLW	B'00000000'; SPACE 0
	RETLW	B'00000000'
	RETLW	B'00000000'
	RETLW	B'00000000'
	
    	RETLW	B'00000000'
	RETLW	B'00111100'
   	RETLW	B'01000010'
   	RETLW	B'01000010'
   	RETLW	B'01111110';A 1
   	RETLW	B'01000010'
   	RETLW	B'01000010'
   	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'01111100'
	RETLW	B'01000010'
	RETLW	B'01111100'
	RETLW	B'01000010';B 2
	RETLW	B'01000010'
	RETLW	B'01111100'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'00111100'
	RETLW	B'01000010'
	RETLW	B'01000000'
	RETLW	B'01000000';C 3
	RETLW	B'01000010'
	RETLW	B'00111100'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'01111000'
	RETLW	B'01000100'
	RETLW	B'01000010'
	RETLW	B'01000010';D 4
	RETLW	B'01000100'
	RETLW	B'01111000'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'01111110'
	RETLW	B'01000000'
	RETLW	B'01111100'
	RETLW	B'01000000';E 5
	RETLW	B'01000000'
	RETLW	B'01111110'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'01111110'
	RETLW	B'01000000'
	RETLW	B'01111100'
	RETLW	B'01000000'
	RETLW	B'01000000';F 6
	RETLW	B'01000000'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'00111100'
	RETLW	B'01000010'
	RETLW	B'01000000'
	RETLW	B'01001110'
	RETLW	B'01000010';G 7
	RETLW	B'00111100'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'01000010'
	RETLW	B'01000010'
	RETLW	B'01111110'
	RETLW	B'01000010'
	RETLW	B'01000010';H 8
	RETLW	B'01000010'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'00111110'
	RETLW	B'00001000'
	RETLW	B'00001000'
	RETLW	B'00001000';I 9
	RETLW	B'00001000'
	RETLW	B'00111110'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'00000010'
	RETLW	B'00000010'
	RETLW	B'00000010'
	RETLW	B'01000010'
	RETLW	B'01000010';J 10
	RETLW	B'00111100'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'01000100'
	RETLW	B'01001000'
	RETLW	B'01110000'
	RETLW	B'01001000';K 11
	RETLW	B'01000100'
	RETLW	B'01000010'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'01000000'
	RETLW	B'01000000'
	RETLW	B'01000000'
	RETLW	B'01000000';L 12
	RETLW	B'01000000'
	RETLW	B'01111110'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'01000010'
	RETLW	B'01100110'
	RETLW	B'01011010'
	RETLW	B'01000010';M 13
	RETLW	B'01000010'
	RETLW	B'01000010'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'01000010'
	RETLW	B'01100010'
	RETLW	B'01010010';N 14
	RETLW	B'01001010'
	RETLW	B'01000110'
	RETLW	B'01000010'
	RETLW	B'00000000'
	
	RETLW	B'00000000'
	RETLW	B'00111100'
	RETLW	B'01000010'
	RETLW	B'01000010'
	RETLW	B'01000010';O 15
	RETLW	B'01000010'
	RETLW	B'00111100'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'01111100'
	RETLW	B'01000010'
	RETLW	B'01000010';P 16
	RETLW	B'01111100'
	RETLW	B'01000000'
	RETLW	B'01000000'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'00111100'
	RETLW	B'01000010'
	RETLW	B'01000010'
	RETLW	B'01010010';Q 17
	RETLW	B'01001010'
	RETLW	B'00111100'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'01111100'
	RETLW	B'01000010';R 18
	RETLW	B'01000010'
	RETLW	B'01111100'
	RETLW	B'01000100'
	RETLW	B'01000010'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'00111100'
	RETLW	B'01000000'
	RETLW	B'00111100';S 19
	RETLW	B'00000010'
	RETLW	B'01000010'
	RETLW	B'00111100'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'11111110'
	RETLW	B'00010000'
	RETLW	B'00010000'
	RETLW	B'00010000';T 20
	RETLW	B'00010000'
	RETLW	B'00010000'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'01000010'
	RETLW	B'01000010'
	RETLW	B'01000010'
	RETLW	B'01000010';U 21
	RETLW	B'01000010'
	RETLW	B'00111100'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'01000010'
	RETLW	B'01000010'
	RETLW	B'01000010'
	RETLW	B'01000010';V 22
	RETLW	B'00100100'
	RETLW	B'00011000'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'01000010'
	RETLW	B'01000010'
	RETLW	B'01000010'
	RETLW	B'01000010';W 23
	RETLW	B'01011010'
	RETLW	B'00100100'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'01000010'
	RETLW	B'00100100'
	RETLW	B'00011000'
	RETLW	B'00011000';X 24
	RETLW	B'00100100'
	RETLW	B'01000010'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'10000010'
	RETLW	B'01000100'
	RETLW	B'00101000'
	RETLW	B'00010000';Y 25
	RETLW	B'00010000'
	RETLW	B'00010000'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'01111110'
	RETLW	B'00000100'
	RETLW	B'00001000'
	RETLW	B'00010000';Z 26
	RETLW	B'00100000'
	RETLW	B'01111110'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'00111100'
	RETLW	B'01000010'
	RETLW	B'00000010'
	RETLW	B'00111100';27 N�MERO "2"
	RETLW	B'01000000'
	RETLW	B'01111110'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'00111100'
	RETLW	B'01000110'
	RETLW	B'01001010'
	RETLW	B'01010010';28 N�MERO "0"
	RETLW	B'01100010'
	RETLW	B'00111100'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'01111110'
	RETLW	B'00000010'
	RETLW	B'00000100'
	RETLW	B'00001000';29 N�MERO "7"
	RETLW	B'00010000'
	RETLW	B'00010000'
	RETLW	B'00000000'

	RETLW	B'01111100'
	RETLW	B'10000010'
	RETLW	B'10011010'
	RETLW	B'10100010'
	RETLW	B'10100010';30 COPYRIGHT
	RETLW	B'10011010'
	RETLW	B'10000010'
	RETLW	B'01111100'
;------------------------------------------------------------------------------	
	NOP
	NOP
	NOP	
;--------------------------SET 1 DE CAR�CTERES MODO1---------------------------
BYTEPANT1
	CLRF	PCLATH
	BSF	PCLATH,0
	ADDWF	BYTECHAR,W
	ADDWF	PCL,F
	RETLW	B'00000000'
	RETLW	B'00000000'
	RETLW	B'00000000'
	RETLW	B'00000000'
	RETLW	B'00000000'; SPACE 0
	RETLW	B'00000000'
	RETLW	B'00000000'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'00111100'
	RETLW	B'01000010'
	RETLW	B'01000010'
	RETLW	B'01111110';A 1
	RETLW	B'01000010'
	RETLW	B'01000010'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'01111100'
	RETLW	B'01000010'
	RETLW	B'01111100'
	RETLW	B'01000010';B 2
	RETLW	B'01000010'
	RETLW	B'01111100'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'00111100'
	RETLW	B'01000010'
	RETLW	B'01000000'
	RETLW	B'01000000';C 3
	RETLW	B'01000010'
	RETLW	B'00111100'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'01111000'
	RETLW	B'01000100'
	RETLW	B'01000010'
	RETLW	B'01000010';D 4
	RETLW	B'01000100'
	RETLW	B'01111000'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'01111110'
	RETLW	B'01000000'
	RETLW	B'01111100'
	RETLW	B'01000000';E 5
	RETLW	B'01000000'
	RETLW	B'01111110'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'01111110'
	RETLW	B'01000000'
	RETLW	B'01111100'
	RETLW	B'01000000'
	RETLW	B'01000000';F 6
	RETLW	B'01000000'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'00111100'
	RETLW	B'01000010'
	RETLW	B'01000000'
	RETLW	B'01001110'
	RETLW	B'01000010';G 7
	RETLW	B'00111100'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'01000010'
	RETLW	B'01000010'
	RETLW	B'01111110'
	RETLW	B'01000010'
	RETLW	B'01000010';H 8
	RETLW	B'01000010'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'00111110'
	RETLW	B'00001000'
	RETLW	B'00001000'
	RETLW	B'00001000';I 9
	RETLW	B'00001000'
	RETLW	B'00111110'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'00000010'
	RETLW	B'00000010'
	RETLW	B'00000010'
	RETLW	B'01000010'
	RETLW	B'01000010';J 10
	RETLW	B'00111100'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'01000100'
	RETLW	B'01001000'
	RETLW	B'01110000'
	RETLW	B'01001000';K 11
	RETLW	B'01000100'
	RETLW	B'01000010'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'01000000'
	RETLW	B'01000000'
	RETLW	B'01000000'
	RETLW	B'01000000';L 12
	RETLW	B'01000000'
	RETLW	B'01111110'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'01000010'
	RETLW	B'01100110'
	RETLW	B'01011010'
	RETLW	B'01000010';M 13
	RETLW	B'01000010'
	RETLW	B'01000010'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'01000010'
	RETLW	B'01100010'
	RETLW	B'01010010';N 14
	RETLW	B'01001010'
	RETLW	B'01000110'
	RETLW	B'01000010'
	RETLW	B'00000000'
	
	RETLW	B'00000000'
	RETLW	B'00111100'
	RETLW	B'01000010'
	RETLW	B'01000010'
	RETLW	B'01000010';O 15
	RETLW	B'01000010'
	RETLW	B'00111100'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'01111100'
	RETLW	B'01000010'
	RETLW	B'01000010';P 16
	RETLW	B'01111100'
	RETLW	B'01000000'
	RETLW	B'01000000'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'00111100'
	RETLW	B'01000010'
	RETLW	B'01000010'
	RETLW	B'01010010';Q 17
	RETLW	B'01001010'
	RETLW	B'00111100'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'01111100'
	RETLW	B'01000010';R 18
	RETLW	B'01000010'
	RETLW	B'01111100'
	RETLW	B'01000100'
	RETLW	B'01000010'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'00111100'
	RETLW	B'01000000'
	RETLW	B'00111100';S 19
	RETLW	B'00000010'
	RETLW	B'01000010'
	RETLW	B'00111100'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'11111110'
	RETLW	B'00010000'
	RETLW	B'00010000'
	RETLW	B'00010000';T 20
	RETLW	B'00010000'
	RETLW	B'00010000'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'01000010'
	RETLW	B'01000010'
	RETLW	B'01000010'
	RETLW	B'01000010';U 21
	RETLW	B'01000010'
	RETLW	B'00111100'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'01000010'
	RETLW	B'01000010'
	RETLW	B'01000010'
	RETLW	B'01000010';V 22
	RETLW	B'00100100'
	RETLW	B'00011000'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'01000010'
	RETLW	B'01000010'
	RETLW	B'01000010'
	RETLW	B'01000010';W 23
	RETLW	B'01011010'
	RETLW	B'00100100'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'01000010'
	RETLW	B'00100100'
	RETLW	B'00011000'
	RETLW	B'00011000';X 24
	RETLW	B'00100100'
	RETLW	B'01000010'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'10000010'
	RETLW	B'01000100'
	RETLW	B'00101000'
	RETLW	B'00010000';Y 25
	RETLW	B'00010000'
	RETLW	B'00010000'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'01111110'
	RETLW	B'00000100'
	RETLW	B'00001000'
	RETLW	B'00010000';Z 26
	RETLW	B'00100000'
	RETLW	B'01111110'
	RETLW	B'00000000'

	RETLW	B'00000000'
	RETLW	B'00011000'
	RETLW	B'00101000'
	RETLW	B'00001000'
	RETLW	B'00001000';27 N�MERO "1"
	RETLW	B'00001000'
	RETLW	B'00111110'
	RETLW	B'00000000'

	RETLW	B'00011110'
	RETLW	B'00111111'
	RETLW	B'00011010'
	RETLW	B'00011111'
	RETLW	B'00011110';28 JET SET WILLY(1)
	RETLW	B'00001100'
	RETLW	B'00011110'
	RETLW	B'00111111'

	RETLW	B'01111111'
	RETLW	B'11111111'
	RETLW	B'11111111'
	RETLW	B'11011110'
	RETLW	B'00011111';29 JET SET WILLY(2)
	RETLW	B'00111011'
	RETLW	B'01100011'
	RETLW	B'01110011'

	RETLW	B'10000000'
	RETLW	B'11000000'
	RETLW	B'11000000'
	RETLW	B'11000000'
	RETLW	B'00000000';30 JET SET WILLY(3)
	RETLW	B'01000000'
	RETLW	B'11000000'
	RETLW	B'10000000'
;------------------------------------------------------------------------------
	NOP
	NOP
	NOP
;------------------------------------------------------------------------------

TEXTO; EL SIGUIENTE TEXTO SE UBICAR� EN LOS REGISTROS DE MEMORIA DEL BANCO 0
	CLRF	PCLATH
	BSF	PCLATH,1
	MOVF	BYTECHAR,W
	ADDWF	PCL,F
	DT "      videopic      "
	DT "                    "
	DT "   este programa    "
	DT " muestra caracteres "

TEXTO2; EL SIGUIENTE TEXTO SE UBICAR� EN LOS REGISTROS DE MEMORIA DEL BANCO 1
	CLRF	PCLATH
	BSF	PCLATH,1
	MOVF	BYTECHAR,W
	ADDWF	PCL,F
	DT " en una pantalla de "
	DT " tv mediante un pic "
	DT "                    "
	DT "  ".126,.123,.124,.124,.125," esteban pa  "    

;------------------------INICIALIZACI�N DE LOS PUERTOS-------------------------
START
	BSF	STATUS,RP0
	BCF	STATUS,RP1
	MOVLW	B'11111110'
	MOVWF	TRISB
	MOVLW	B'00000110'
	MOVWF	ADCON1
	MOVLW	B'00000110'
	MOVWF	TRISA
	MOVLW	B'11010111'
	MOVWF	TRISC
	MOVLW	B'00000000'
	MOVWF	SSPSTAT
	BCF	STATUS,RP0
	CLRF	PORTB

;---------RUTINA DE INICIALIZACI�N Y ENLACE A LOS MODOS DE VIDEO---------------
	

	MOVLW	MODO_PANT
	MOVWF	FLAGSTV
	MOVLW	B'00100000'
	MOVWF	SSPCON
	CALL	BORRAPANT; INSERTA EN LOS REGISTROS DE MEMORIA EL VALOR "0"
	CALL	CONV_CHAR; CONVIERTE LOS VALORES ASCII DE LOS TEXTOS A VALORES
	CALL	CONV_CHAR2;PARA QUE PUEDAN SER UTILIZADOS POR EL PROGRAMA
	BTFSS	FLAGSTV,0
	GOTO	START_MODE0; PONE LA PANTALLA EN MODO 0
	GOTO	START_MODE1; PONE LA PANTALLA EN MODO 1

	

;----------------------------------MODO DE VIDEO 0-----------------------------
PAUSA2US
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	RETURN
	
STARTMODE0
	NOP; ESTOS DOS NOP SON PARA SINCRONIZAR LOS 20 PRIMEROS
	NOP; CARACTERES CON EL RESTO DE LINEAS
MODE0
	CLRF	SSPCON
	CLRF	PORTC
	BCF	PORTA,0; INICIO DEL PULSO DE SINCRONISMO HORIZONTAL
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	BSF	PORTA,0; FIN DEL PULSO DE SINCRONISMO HORIZONTAL
	CALL	PAUSA4US
	CALL	PAUSA4US

	CALL	PAUSA2US
	BSF	SSPCON,5
	NOP
	MOVF	INDF,W; COMIENZO DE LOS 20 CAR�CTERES
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	BCF	SSPBUF,5
	CALL	PAUSA4US
	CALL	PAUSA2US
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	INCF	BYTECHAR,F
	DECFSZ	NUMCHAR,F; CARACTERES 8*8 COMPLETOS?
	GOTO	NOCOMPLETOS
	CLRF	BYTECHAR
	MOVLW	LONG_Y
	MOVWF	NUMCHAR
	DECFSZ	NUMCOL,F;COLUMNA COMPLETA DE CARACTERES?
	GOTO	MODE0
	NOP; COMIENZO DE LA SEGUNDA PARTE DE LA PANTALLA
	NOP
MODE0_ZONA2
	CLRF	SSPCON
	CLRF	PORTC
	BCF	PORTA,0; INICIO SYNC
	BTFSS	FLAGSTV,0
	GOTO REG_ZONA2
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
SIGUE_ZONA2
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	BSF	PORTA,0; FIN SYNC
	CALL	PAUSA4US
	CALL	PAUSA4US	
	CALL	PAUSA2US
	BSF	SSPCON,5
	NOP
	MOVF	INDF,W; COMIENZO DE LOS 20 CARACTERES
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT
	MOVWF	SSPBUF
	INCF	FSR,F
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	BCF	SSPBUF,5	
	CALL	PAUSA4US
	CALL	PAUSA2US
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	INCF	BYTECHAR,F
	DECFSZ	NUMCHAR,F; CARACTERES 8*8 COMPLETOS?
	GOTO	NOCOMPLETOS_ZONA2
	CLRF	BYTECHAR
	MOVLW	LONG_Y
	MOVWF	NUMCHAR
	DECFSZ	NUMCOL,F;COLUMNA COMPLETA DE CARACTERES?
	GOTO	MODE0_ZONA2
	RETURN

NOCOMPLETOS_ZONA2
	NOP
	MOVLW	LONG_X
	SUBWF	FSR,F
	GOTO MODE0_ZONA2

REG_ZONA2
	MOVLW	CHARMAXXY
	MOVWF	NUMCOL	
	MOVLW	PANT2
	MOVWF	FSR
	BSF	FLAGSTV,0
	GOTO SIGUE_ZONA2

NOCOMPLETOS
	NOP
	MOVLW	LONG_X
	SUBWF	FSR,F
	GOTO MODE0


;---------------------------SINCRONISMO VERTICAL-------------------------------
PAUSA4P5
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	RETURN

PAUSA27P4
	CALL	PAUSA4P5
	CALL	PAUSA4P5
	CALL	PAUSA4P5
	CALL	PAUSA4P5
	CALL	PAUSA4P5
	CALL	PAUSA4P5
	RETURN

PIGUALADORES
	BCF	PORTA,0
	CALL	PAUSA27P4
	BSF	PORTA,0
	CALL	PAUSA4P5
	BCF	PORTA,0
	CALL	PAUSA27P4
	BSF	PORTA,0
	CALL	PAUSA4P5
	BCF	PORTA,0
	CALL	PAUSA27P4
	BSF	PORTA,0
	CALL	PAUSA4P5
	BCF	PORTA,0
	CALL	PAUSA27P4
	BSF	PORTA,0
	CALL	PAUSA4P5
	BCF	PORTA,0
	CALL	PAUSA27P4
	BSF	PORTA,0
	CALL	PAUSA4P5
	BCF	PORTA,0
	CALL	PAUSA27P4
	BSF	PORTA,0
	CALL	PAUSA4P5
	RETURN

PVERTICALESALM
	BSF	PORTA,0
	CALL	PAUSA27P4
	BCF	PORTA,0
	CALL	PAUSA4P5
	BSF	PORTA,0
	CALL	PAUSA27P4
	BCF	PORTA,0
	CALL	PAUSA4P5
	BSF	PORTA,0
	CALL	PAUSA27P4
	BCF	PORTA,0
	CALL	PAUSA4P5
	BSF	PORTA,0
	CALL	PAUSA27P4
	BCF	PORTA,0
	CALL	PAUSA4P5
	BSF	PORTA,0
	CALL	PAUSA27P4
	BCF	PORTA,0
	CALL	PAUSA4P5
	BSF	PORTA,0
	CALL	PAUSA27P4
	BCF	PORTA,0
	CALL	PAUSA4P5
	RETURN

SYNCVERT
	CLRF	SSPCON
	CLRF	PORTC
	CALL	PIGUALADORES
	CALL	PVERTICALESALM
	CALL	PIGUALADORES
	RETURN


PAUSA4US
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP	
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	RETURN


;----------------------------------LINEA NEGRA---------------------------------
LINEA64US
	CLRF	SSPCON
	CLRF	PORTC
	BCF	PORTA,0
	CALL	PAUSA4US
	BSF	PORTA,0
	CALL	PAUSA4US
	CALL	PAUSA4US
	CALL	PAUSA4US
	CALL	PAUSA4US
	CALL	PAUSA4US
	CALL	PAUSA4US
	CALL	PAUSA4US
	CALL	PAUSA4US
	CALL	PAUSA4US
	CALL	PAUSA4US
	CALL	PAUSA4US
	CALL	PAUSA4US
	CALL	PAUSA4US
	CALL	PAUSA4US
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	RETURN


;---------------------GENERACION DE UN CUADRO DE TV EN MODO 0------------------
START_MODE0
PANTALLA
	CLRF	FLAGSTV
	CLRF	BYTECHAR
	MOVLW	CHARMAXXY
	MOVWF	NUMCOL
	MOVLW	LONG_Y
	MOVWF	NUMCHAR
	MOVLW	INICPANT
	MOVWF	FSR
	MOVLW	.124
	MOVWF	LINE
NL1	CALL LINEA64US
	DECFSZ	LINE,F
	GOTO	NL1
	CALL	STARTMODE0
	MOVLW	.124
	MOVWF	LINE
NL3	CALL	LINEA64US
	DECFSZ	LINE,F
	GOTO	NL3
	BCF	PORTA,0
	CALL 	PAUSA4US
	BSF	PORTA,0
	CALL	PAUSA4US
	CALL	PAUSA4US
	CALL	PAUSA4US
	CALL	PAUSA4US
	CALL	PAUSA4US
	CALL	PAUSA4US
	CALL	PAUSA4US
	CALL	SYNCVERT
	GOTO	PANTALLA

;-----------------GENERACION DE UN CUADRO DE TV EN MODO 1----------------------

START_MODE1
	MOVLW	B'00100001'
	MOVWF	SSPCON
PANTALLA_MODE1
	CLRF	BYTECHAR
	MOVLW	CHARMAXY_MODE1
	MOVWF	NUMCOL
	MOVLW	LONGY_MODE1
	MOVWF	NUMCHAR
	MOVLW	INICPANT
	MOVWF	FSR
	MOVLW	.30
	MOVWF	LINE
NM1	CALL LINEA64US
	DECFSZ	LINE,F
	GOTO	NM1
	CALL	MODE1
	MOVLW	.18
	MOVWF	LINE
NM3	CALL	LINEA64US
	DECFSZ	LINE,F
	GOTO	NM3
	BCF	PORTA,0
	CALL 	PAUSA4US
	BSF	PORTA,0
	CALL	PAUSA4US
	CALL	PAUSA4US
	CALL	PAUSA4US
	CALL	PAUSA4US
	CALL	PAUSA4US
	CALL	PAUSA4US
	CALL	PAUSA4US
	CALL	SYNCVERT
	GOTO	PANTALLA_MODE1


;------------------------------MODO DE VIDEO 1---------------------------------

MODE1
	CLRF	SSPCON
	CLRF	PORTC
	BCF	PORTA,0; INICIO DEL PULSO DE SINCRONISMO HORIZONTAL
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	BSF	PORTA,0; FIN DEL PULSO DE SINCRONISMO HORIZONTAL
	CALL	PAUSA4US
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	MOVLW	B'00100001'
	MOVWF	SSPCON
	MOVF	INDF,W; COMIENZO DE LOS 7 CARACTERES
	CALL	BYTEPANT1
	MOVWF	SSPBUF
	CALL	DELAY_MODE1
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT1
	MOVWF	SSPBUF
	CALL	DELAY_MODE1
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT1
	MOVWF	SSPBUF
	CALL	DELAY_MODE1
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT1
	MOVWF	SSPBUF
	CALL	DELAY_MODE1
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT1
	MOVWF	SSPBUF
	CALL	DELAY_MODE1
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT1
	MOVWF	SSPBUF
	CALL	DELAY_MODE1
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT1
	MOVWF	SSPBUF
	CALL	DELAY_MODE1
	INCF	FSR,F; FIN DE LOS 7 CARACTERES
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	CLRF	SSPBUF
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	INCF	BYTECHAR,F
	NOP
	NOP
	NOP
	MOVLW	LONGX_MODE1
	SUBWF	FSR,F
	DECF	BYTECHAR,F
	NOP
	NOP
	;REPITE LA LINEA
	CLRF	SSPCON
	CLRF	PORTC
	BCF	PORTA,0; INICIO DEL SINCRONISMO HORIZONTAL
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	BSF	PORTA,0; FIN DEL SINCRONISMO HORIZONTAL
	CALL	PAUSA4US
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	MOVLW	B'00100001'
	MOVWF	SSPCON	
	MOVF	INDF,W; COMIENZO DE LOS 7 CARACTERES
	CALL	BYTEPANT1
	MOVWF	SSPBUF
	CALL	DELAY_MODE1
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT1
	MOVWF	SSPBUF
	CALL	DELAY_MODE1
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT1
	MOVWF	SSPBUF
	CALL	DELAY_MODE1
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT1
	MOVWF	SSPBUF
	CALL	DELAY_MODE1
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT1
	MOVWF	SSPBUF
	CALL	DELAY_MODE1
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT1
	MOVWF	SSPBUF
	CALL	DELAY_MODE1
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT1
	MOVWF	SSPBUF
	CALL	DELAY_MODE1
	INCF	FSR,F; FIN DE LOS 7 CARACTERES
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	CLRF	SSPBUF
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	INCF	BYTECHAR,F
	NOP
	NOP
	NOP
	MOVLW	LONGX_MODE1
	SUBWF	FSR,F
	DECF	BYTECHAR,F
	NOP
	NOP
	;REPITE LA LINEA
	CLRF	SSPCON
	CLRF	PORTC
	BCF	PORTA,0; INICIO DEL SINCRONISMO HORIZONTAL
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	BSF	PORTA,0; FIN DEL SINCRONISMO HORIZONTAL
	CALL	PAUSA4US
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	MOVLW	B'00100001'
	MOVWF	SSPCON	
	MOVF	INDF,W; COMIENZO DE LOS 7 CARACTERES
	CALL	BYTEPANT1
	MOVWF	SSPBUF
	CALL	DELAY_MODE1
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT1
	MOVWF	SSPBUF
	CALL	DELAY_MODE1
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT1
	MOVWF	SSPBUF
	CALL	DELAY_MODE1
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT1
	MOVWF	SSPBUF
	CALL	DELAY_MODE1
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT1
	MOVWF	SSPBUF
	CALL	DELAY_MODE1
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT1
	MOVWF	SSPBUF
	CALL	DELAY_MODE1
	INCF	FSR,F
	MOVF	INDF,W
	CALL	BYTEPANT1
	MOVWF	SSPBUF
	CALL	DELAY_MODE1
	INCF	FSR,F; FIN DE LOS 7 CARACTERES
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	CLRF	SSPBUF
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	INCF	BYTECHAR,F
	DECFSZ	NUMCHAR,F; CARACTERES 8*8 COMPLETOS?
	GOTO	NOCOMPLETOS_MODE1
	CLRF	BYTECHAR
	MOVLW	LONGY_MODE1
	MOVWF	NUMCHAR
	DECFSZ	NUMCOL,F;COLUMNA COMPLETA DE CARACTERES?
	GOTO	MODE1
	RETURN

NOCOMPLETOS_MODE1
	NOP
	MOVLW	LONGX_MODE1
	SUBWF	FSR,F
	GOTO MODE1

DELAY_MODE1
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	NOP
	RETURN
;------------------------------------------------------------------------------

;PONE A "0" LOS REGISTROS DE MEMORIA DEL BANCO 0 Y 1 ,QUE UTILIZA
;EL PROGRAMA PARA REPRESENTAR LOS CARACTERES EN PANTALLA.
BORRAPANT
	BCF	STATUS,RP0
	BCF	STATUS,RP1
	MOVLW	.80
	MOVWF	CONT
	MOVLW	INICPANT
	MOVWF	FSR
BORRA
	MOVLW	B'00000000'
	MOVWF	INDF
	INCF	FSR,F
	DECFSZ	CONT,F
	GOTO	BORRA
BORRAPANT2
	BCF	STATUS,RP0
	BCF	STATUS,RP1
	MOVLW	.80
	MOVWF	CONT
	MOVLW	PANT2
	MOVWF	FSR
BORRA2
	MOVLW	B'00000000'
	MOVWF	INDF
	INCF	FSR,F
	DECFSZ	CONT,F
	GOTO	BORRA2
	RETURN


;------------------------------------------------------------------------------

;CONVIERTE LOS CARACTERES ASCII DE LOS TEXTOS A CAR�CTERES PARA QUE PUEDAN SER UTILIZADOS POR EL PROGRAMA
CONV_CHAR
	MOVLW	.80; NUMERO DE CARACTERES A MOSTRAR EN EL BANCO0
	MOVWF	CONT
	MOVLW	INICPANT
	MOVWF	FSR
	CLRF	BYTECHAR; CONTIENE EL PUNTERO DE LA POSICION DE TEXTO
OTRAVEZ	
	CALL	TEXTO
	MOVWF	INDF
	MOVLW	.96
	MOVWF	LINE
	MOVF	LINE,W
	SUBWF	INDF,F
	BCF	STATUS,C
	RLF	INDF
	BCF	STATUS,C
	RLF	INDF
	BCF	STATUS,C
	RLF	INDF
	INCF	BYTECHAR,F
	INCF FSR,F
	DECFSZ	CONT,F
	GOTO	OTRAVEZ
	CLRF	PCLATH
	RETURN	

CONV_CHAR2
	MOVLW	.80; NUMERO DE CARACTERES A MOSTRAR EN EL BANCO1
	MOVWF	CONT
	MOVLW	PANT2
	MOVWF	FSR
	CLRF	BYTECHAR; CONTIENE EL PUNTERO DE LA POSICION DE TEXTO
OTRAVEZ2	
	CALL	TEXTO2
	MOVWF	INDF
	MOVLW	.96
	MOVWF	LINE
	MOVF	LINE,W
	SUBWF	INDF,F
	BCF	STATUS,C
	RLF	INDF
	BCF	STATUS,C
	RLF	INDF
	BCF	STATUS,C
	RLF	INDF
	INCF	BYTECHAR,F
	INCF FSR,F
	DECFSZ	CONT,F
	GOTO	OTRAVEZ2
	CLRF	PCLATH
	RETURN	

	END