;Exercise 7.10: Write a program that prmpts the user to type a hex number of four hex digits or less outputs it in binary on the next line. If the users enter an illegal character, he or she should be prompted to begin again. Accept only uppercase letter 

.MODEL SMALL
.STACK 100H
.DATA

MSG1 DB 10,13,'TYPE A HEX NUMBER : $'
MSG2 DB 10,13,'ILLEGAL HEX DIGIT. TRY AGAIN !! $'
MSG3 DB 10,13,'IN BINARY IT IS : $'

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
    MOV CL,4    ;counter for 4 bit input
    MOV AH,1    ;input character function
    INT 21H     ;input a character
    
WHILE_:         
    DEC CL
    CMP AL,13   ;carriage return
    JE END_WHILE;yes, exit
    
;convert character to binary value
    CMP AL,57   ;a digit? greater than ASCII '9'?
    JG LETTER   ;no. a letter
    
;input a digit
;checking illegal char
    CMP AL,48                   
    JL ILLEGAL
    
    AND AL,15   ;convert digit to 4 digit binary value
    JMP SHIFT   ;go to insert in BX
    
LETTER:
;checking illegal char
    CMP AL,65
    JL ILLEGAL
    CMP AL,70
    JG ILLEGAL
         
    SUB AL,55   ;covert letter to binary value starting from decimal 10  
    
SHIFT:
    SHL BX,4    ;make room for new value
    
;insert value in BX
    OR BL,AL    ;put value in low 4 bits
    
    CMP CL,0    ;stop taking input after 4 bit
    JE END_WHILE
    
    INT 21H     ;input a character
    JMP WHILE_  ;loop until CR
    
END_WHILE:
;binary output message    
    LEA DX,MSG3
    MOV AH,9
    INT 21H
    
    MOV CX,16    ;loop counter
    MOV AH,2     ;for print
    
TOP:
    ROL BX,1     ;bit rotated out
    JNC NEXT0    ;if 0 bit detected
    
    MOV DL,'1'   ;else print 1
    INT 21H
    LOOP TOP
    
    CMP CX,0     ;exit when all 16 bit is printed 
    JZ EXIT
                                                               
NEXT0:
    MOV DL,'0'   ;print 0 
    INT 21H
    LOOP TOP     ;loop until done
    
    JMP EXIT
    
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
    
    
    