;Exercise 7.11: Write a program that prompts the user to type a binary number of 16 digits or less and outputs it in hex on the next line. If the user enters a illegal character, he or she could be prompted to begin again.

.MODEL SMALL
.STACK 100H
.DATA

COUNT DB ?
MSG1 DB 10,13,'TYPE A BINARY NUMBER : $'
MSG2 DB 10,13,'ILLEGAL BINARY DIGIT. TRY AGAIN !! $'
MSG3 DB 10,13,'IN HEX IT IS : $'

.CODE
MAIN PROC
    
;initialize DX
    MOV AX,@DATA
    MOV DS,AX
AGAIN:    
;input message
    LEA DX,MSG1
    MOV AH,9
    INT 21H
    
    XOR BX,BX   ;clear BX
    MOV CL,16   ;counter for 16 bit input
    MOV AH,1    ;input character function
    INT 21H     ;input a character
    
WHILE_:
    DEC CL         
    CMP AL,13   ;carriage return
    JE END_WHILE;yes, exit
    
;checking if it is legal binary digit
    CMP AL,49    
    JG ILLEGAL   
    CMP AL,48
    JL ILLEGAL
    
    SHL BX,1    ;make room for new bit
    
    MOV COUNT,AL
    CMP AL,49
    JE SET
    
    JMP SHIFT   ;binary bit is 0
    
SET:
    OR BX,1     ;if binary bit is 1, set it in BX

SHIFT:
    CMP CL,0    ;maximum 16 bits
    JE END_WHILE
    
    INT 21H     ;input a character            
    JMP WHILE_  ;loop until CR
    
END_WHILE:
;HEX output message    
    LEA DX,MSG3
    MOV AH,9
    INT 21H
    
    MOV CX,4    ;loop counter
    MOV AH,2    ;for print
    
TOP:
    MOV DL,BH
    SHR DL,4    ;get value of 1st 4 bit  of BX
    
    CMP DL,9    ;if ASCII is greater than 9 it is A-F
    JG LETTER
    
    ADD DL,48   ;print digit
    INT 21H
    SHL BX,4    ;to get next 4 digit of binary input to convert in hex 
    
    LOOP TOP
    CMP CX,0    ;exit when all 4 hex bit is printed 
    JZ EXIT
    
LETTER:
    ADD DL,55   ;print letter
    INT 21H
    SHL BX,4
    LOOP TOP
    
    JMP EXIT

;when illegal character is input
ILLEGAL:
    LEA DX,MSG2
    MOV AH,9
    INT 21H
    JMP AGAIN
        
EXIT:
    JMP AGAIN
    MOV AH,4CH
    INT 21H
    
END MAIN
MAIN ENDP
    
    
    