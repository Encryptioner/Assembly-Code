;Exercise 4.11: Write a program to display a 10*10 solid box of asterisks.

.MODEL SMALL
.STACK 100H

.DATA

MSG DB 10,13,'**********$'

.CODE

MAIN PROC
    
;initialize DS
	MOV AX,@DATA
	MOV DS,AX
	
;print string
	MOV CX,10   ;loop counter 
	LEA DX,MSG
	MOV AH,9
	
TOP:
	INT 21H 
	LOOP TOP
	
;return to DOS
	MOV AH,4CH
	INT 21H

MAIN ENDP
END MAIN

