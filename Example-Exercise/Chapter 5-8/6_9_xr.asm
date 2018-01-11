;Exercise 6.9: Write a program to display the extended ASCII characters. Display 10 characters per line, separated by blanks. Stop after the extended charactes has been displayed once.

.MODEL SMALL                                                                                                                                                                       
.STACK 100H  

.DATA
    NUM DW ?
    COUNT DW ?
    VAL DW ?
    CONST DW ? 

.CODE
MAIN PROC
    
;READ INPUT   
    MOV AH,1
    MOV AX,080h
    MOV NUM,AX
    MOV AX,0FFh
    
;GETTING NUMBER OF EXTENDED ASCII CHAR FOR LOOP    
    SUB NUM,AX
    MOV CX,NUM 

    MOV COUNT,10  ;TO PRINT NEW LINE
    MOV CONST,128 ;TO PRINT ONLY 128 CHAR
    JMP PRINT                        
    
NEWLINE:
    MOV AH,2
    MOV DL,10
    INT 21H
    MOV DL,13
    INT 21H 
    
    MOV COUNT,10 ;TO PRINT NEW LINE AGAIN
    MOV DX,VAL   ;RESTORE VALUE OF DL
    
    CMP CONST,0  ;IF CONST=0 ALL EXTENDED ASCII WAS PRNTED
    JE EXIT
    LOOP TOP
    
;STARTING INCREMENT TO PRINT BY SETTING DX VALUE
PRINT: 
    MOV AH,2
    MOV DX,080H
    JCXZ EXIT
TOP:
    INT 21H
    INC DX
        
    MOV VAL,DX   ;TO PRINT NEWLINE VALUE OF DL WILL BE CHANGED, SO NEED TO STORE
    
    MOV DL,' '   ;PRINT BLANK BETWEEN TWO CHARACTER
    INT 21H
    MOV DX,VAL   ;RESTORE VALUE OF DX
    
    DEC COUNT
    DEC CONST
    
;IF VALUE OF COUNT=0 IT WILL PRINT NEWLINE
    CMP COUNT,0
    JE NEWLINE
    
    CMP CONST,0  ;IF CONST=0 ALL EXTENDED ASCII WAS PRNTED
    JE EXIT
    LOOP TOP
    
    
EXIT:
    MOV AH,4CH   ;DOS EXIT FUNCTION
    INT 21H      ;EXIT TO DOS
    
MAIN ENDP
END MAIN
       
    