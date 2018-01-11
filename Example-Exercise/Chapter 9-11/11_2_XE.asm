.MODEL SMALL

.STACK 100H 

.DATA

W DW 1,2,4,5,6,?

.CODE
MAIN PROC
    
    MOV AX,@DATA
    MOV DS,AX
    MOV ES,AX
    
    LEA SI,W+8H
    LEA DI,W+0AH
    
    STD
    
    MOV CX,3
    REP MOVSW
    
    MOV WORD PTR [DI],3
    
    
    MOV CX,6
    XOR BX,BX
    
MOVE:
    MOV DX,W[BX]
    ADD DX,30H
    MOV AH,2
    INT 21H
    
    ADD BX,2
    LOOP MOVE
    
    
MOV AH,4CH
INT 21H

MAIN ENDP
END MAIN
          
