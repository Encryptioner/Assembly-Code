.MODEL SMALL

.STACK 100H 

.DATA

S1 DB 'HELLO$'
S2 DB  6 DUP (?)

.CODE
MAIN PROC
    
    MOV AX,@DATA
    MOV DS,AX
    MOV ES,AX
    
    LEA SI,S1
    LEA DI,S2
    
    CLD
    
    MOV CX,6
    REP MOVSB
    
    
    LEA DX,S2
    MOV AH,9
    INT 21H
    
;REVERSE    
    
    LEA SI,S1+4
    LEA DI,S2
    
    STD
    
    MOV CX,5
    
MOVE:
    MOVSB
    ADD DI,2
    LOOP MOVE
    
    
    LEA DX,S2
    MOV AH,9
    INT 21H
    
    
MOV AH,4CH
INT 21H

MAIN ENDP
END MAIN
    
    
