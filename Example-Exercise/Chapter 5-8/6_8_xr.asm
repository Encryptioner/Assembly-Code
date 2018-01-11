;Exercise 6.8: Write a program to display a "?", read two capital letters and display them on the next line in alphabetical order.

.MODEL SMALL
.STACK 100H
          
.DATA

LETTER1 DB ?
LETTER2 DB ?  

.CODE
MAIN PROC
       
;DISPLAY ?
    MOV AH,2
    MOV DL,'?'
    INT 21H
    
;DISPLAY NEW LINE
    MOV AH,2
    MOV DL,10
    INT 21H
    MOV DL,13
    INT 21H
    
;READ INPUT
    MOV AH,1        ;READ TWO CAPITAL LETTER
    INT 21H         ;LETTER IN AL
    MOV LETTER1,AL  ;SAVE IT IN LETTER1
    
    INT 21H
    MOV LETTER2,AL
    
;DISPLAY NEW LINE
    MOV AH,2
    MOV DL,10
    INT 21H
    MOV DL,13
    INT 21H
    
;CHECKING ASCII VALUE DIFFERENCE
    MOV AL,LETTER2
    CMP LETTER1,AL  ;COMPARE ASCII VALUE
    JG BELOW        ;IF LETTER1-LETTER2 >0 JUMP TO BELOW
    
    MOV AH,2
    MOV DL,LETTER1  ;ASCII VALUE OF LETTER1 IS SMALLER AS IT DOESN'T FULFIL THE CONDITION
    INT 21H 
    MOV DL,LETTER2
    INT 21H
    JMP EXIT
    
BELOW:
    MOV AH,2
    MOV DL,LETTER2  ;ASCII VALUE OF LETTER IS SMALLER 
    INT 21H 
    MOV DL,LETTER1
    INT 21H 
    
EXIT:
    MOV AH,4CH  ;DOS EXIT FUNCTION
    INT 21H     ;EXIT TO DOS
    
MAIN ENDP
END MAIN      