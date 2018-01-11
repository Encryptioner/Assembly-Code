;CH_7_10

.MODEL  SMALL
.STACK  100H
.DATA 

COUNTL DB ?
COUNTD DB ?

MSG DB 10,13,'ENTRE HEX NUMBERS : $'
MSG1 DB 10,13,'ENTRE ANOTHER HEX NUMBERS : $'
MSG2 DB 10,13,'ILLEGAL HEX  NUMBER, TRY AGAIN : $'
MSG3 DB 10,13,'SUM OF TWO HEX NUMBERS : $'
MSG4 DB 10,13,'NUMBER OF LETTERS : $'
MSG5 DB 10,13,'NUMBER OF DIGITS : $'


F DB ?
Z DB ?
CA DB ?

.CODE
 MAIN PROC

	MOV AX,@DATA
	MOV DS,AX	; initialize DS
	
	MOV COUNTL,0
	MOV COUNTD,0

	MOV AH,9
	LEA DX,MSG
	INT 21H
	
	XOR BX,BX
	MOV CL,4
	MOV AH,1	;first HEX number input
	INT 21H
		
T:	CMP AL,0DH
	JE N		;entre key pressed 
	
	CMP AL,30H
	JL ILEGAL
	CMP AL,46H
	JG ILEGAL
	CMP AL,39H
	JLE NUM
	CMP AL,46H
	JLE ALPHA
	
	
NUM:	AND AL,0FH
	    JMP L

ALPHA:	SUB AL,37H
		
	
L: 	SHL BX,CL
	OR BL,AL
	JMP J

ILEGAL:   MOV AH,9
	LEA DX,MSG2
	INT 21H
	
J:	MOV AH,1	;new hex number injput
	INT 21H

	JMP T

N:	
	MOV AH,9
	LEA DX,MSG1
	INT 21H
	
	XOR CX,CX
	;MOV CL,4
	MOV AH,1
	INT 21H
		
TO:	CMP AL,0DH
	JE AD		;entre key pressed 
	
	CMP AL,30H
	JL ILEGAL2
	CMP AL,46H
	JG ILEGAL2
	CMP AL,39H
	JLE NUM2
	CMP AL,46H
	JLE ALPHA2
		
NUM2:	AND AL,0FH
	JMP L2

ALPHA2:	SUB AL,37H
		
L2: 	SHL CX,1
	SHL CX,1
	SHL CX,1
	SHL CX,1
	OR CL,AL
	JMP J2

ILEGAL2:   
    MOV AH,9
	LEA DX,MSG2
	INT 21H
	
J2:	MOV AH,1	;new hex number injput
	INT 21H

	JMP TO

AD:	MOV AH,9
	LEA DX,MSG3
	INT 21H
	ADD BX,CX	;sum of two HEX number BX+CX
	JNC NC
	MOV AH,2
	MOV DL,31h
	INT 21H
	
NC:
	
	XOR CX,CX
	MOV CX,4
	MOV DL,BH	;copy BH to DL

TOP:	 		;HEX output
	INC COUNTL
	SHR DL,1		;4 bit right shift DL
	SHR DL,1
	SHR DL,1
	SHR DL,1
	CMP DL,10
	JL P		;if it is degit
	JE A		;if it is character A
	CMP DL,11	;if it is character B
	JE B
	CMP DL,12	;if it is character C
	JE C
	CMP DL,13	;if it is character D
	JE B
	CMP DL,14	;if it is character E
	JE A
	CMP DL,15	;if it is character F
	JE B
	JMP R	
	
A:	XOR DL,4BH
	MOV AH,2
	INT 21H		;prints 'A' or 'E'
	JMP R

B:	XOR DL,49H	;prints 'B' or 'F'
	MOV AH,2
	INT 21H
	JMP R
C:	XOR DL,4FH	;prints 'C' 
	MOV AH,2
	INT 21H
	JMP R

P:	
    INC COUNTD
    OR DL,30H	;converting in digits
	MOV AH,2
	INT 21H
	
R:	ROL BX,1		;again 4 times rotate BX
	ROL BX,1
	ROL BX,1
	ROL BX,1
	MOV DL,BH
       LOOP TOP

MOV AH,9
LEA DX,MSG4
INT 21H
MOV DL,COUNTL
ADD DL,30H
INT 21H

MOV AH,9
LEA DX,MSG5
INT 21H
MOV DL,COUNTD
ADD DL,30H
INT 21H

	
; return to DOS		
	MOV AH,4CH
	INT 21H 	;DOS  exit
MAIN ENDP
           END MAIN