;Exercise 7.8: Write a program that prompts the user to enter a character and on subsequent lines prints it ASCII code in bianary and the number of 1 bits in ASCII code.
 
.MODEL SMALL
.STACK 100H
.DATA

VAL DB ?
COUNT DB ?
MSG1 DB 'INPUT CHARACTER: $'
MSG2 DB 10,13,'ASCII VALUE IN BINARY : $'
MSG3 DB 10,13,'NUMBER OF 1 BITS : $'

.CODE

MAIN PROC
    
;initialize DS
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
    
    JMP BINARY  ;TO FIND ASCII VALUE IN BINARY  

;EVERY TIME VALUE OF VAL IS RIGHT SHIFTED
 ;AND TEST COMMAND DETERMINES IF IT IS 1 OR 0
  ;ACCORDING TO IT 1 OR 0 IS PRINTED
      
BELOW:;TO PRINT 0
    SHR VAL,1
    MOV AH,2
    MOV DL,'0'
    INT 21H
    
    CMP VAL,0   ;AFTER SHIFTING OF ALL BIT VALUE WILL BE O
    JZ DISPLAY  ;THEN DISPLAY
    
    LOOP TOP2

BINARY:
    LEA DX,MSG2
	MOV AH,9
	INT 21H
	
	
    MOV VAL,10000000B   ;STARTING FROM MSB
    MOV COUNT,0         ;INITIALIZE COUNT
    MOV CX,8
    
TOP2:
    TEST BL,VAL
    JZ BELOW
    
    SHR VAL,1       ;INCREMENTING BY RIGHT SHIFTING TO TEST NEXT BIT
     
    MOV AH,2
    MOV DL,'1'
    INT 21H
    
    INC COUNT       ;INCREMENTING COUNT
    LOOP TOP2
    
        
DISPLAY:
    LEA DX,MSG3
	MOV AH,9
	INT 21H
	
    ADD COUNT,48    ;FOR SHOWING IN DECIMAL
    MOV AH,2
    MOV DL,COUNT
    INT 21H         ;NUMBER OF 1 BITS IN BX

EXIT:    
    MOV AH,4CH
    INT 21H 
    
MAIN ENDP
END MAIN
