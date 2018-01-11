;Exercise 7.9: Write a program that prompts the user to enter a character and prints it ASCII code of the character in HEX on the next line. Repeat this process until the user types a carriage return.

.MODEL SMALL
.STACK 100H
.DATA

VAL DB ?
COUNT DB ?
HEX DB ?
MSG1 DB 10,13,'INPUT CHARACTER: $'
MSG2 DB 10,13,'ASCII VALUE IN HEXADECIMAL : $'

.CODE

MAIN PROC
    
;initialize DS
START:
	MOV AX,@DATA
	MOV DS,AX
	
;print string 
	LEA DX,MSG1
	MOV AH,9
	INT 21H
     
;TAKING INPUT CHARACTER   
    MOV AH,1
    INT 21H     
    MOV BX,AX
    
;CHECKING IF CARRIAGE RETURN
    CMP BL,13
    JE EXIT

    LEA DX,MSG2
	MOV AH,9
	INT 21H
	
;PROCESSING TO PRINT IN HEXADECIMAL
    MOV DL,BL
    SHR DL,4    ;1ST 4 BIT WILL DECLARE A NUMBER IN HEXADECIMAL
    
    CMP DL,9    ;CHECKING IF THE 1ST DIGIT IS 0-9 OR A-F
    JG CAPITAL1
    
    MOV AH,2    ;EXECUTE IF 1ST DIGIT IS 0-9
    ADD DL,30H
    INT 21H
    
DIGIT:;CONTINUE FOR 2ND DIGIT IN SAME PROCESS    
    ROL BL,4
    MOV DL,BL
    SHR DL,4
    
    CMP DL,9
    JG CAPITAL2
    
    MOV AH,2
    ADD DL,30H
    INT 21H
    
    JMP START   ;FOR NEXT INPUT
    
CAPITAL1:;EXECUTE IF 1ST DIGIT IS A-F
    MOV AH,2
    ADD DL,55
    INT 21H
    JMP DIGIT
    
CAPITAL2:
    MOV AH,2
    ADD DL,55
    INT 21H
    JMP START 

EXIT:    
    MOV AH,4CH
    INT 21H 
    
MAIN ENDP
END MAIN
