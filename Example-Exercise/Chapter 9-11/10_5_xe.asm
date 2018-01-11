;EXAMPLE 10.5 


.MODEL SMALL

.STACK 100H

.DATA
  
 W DW 1,2,3,3
 
 MONEY LABEL WORD;TYPE
 DOL1 DB 01H
 CEN1 DB 01H
  
 DOL DB 1AH
 CEN DB 52H
   

.CODE



MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    XOR AX,AX
    XOR BX,BX
    MOV CX,4
    
ADDONS:
    ADD AX,[BX]
    ADD BX,2
    LOOP ADDONS
    
    
    MOV DX,AX 
    ADD DX,30H
        
    MOV AH,2    
    INT 21H
    
    ;using of ptr
    ;MOV AX,WORD PTR DOL
    MOV AX,0 
    MOV AX,MONEY;WRONG OUTPUT 


MOV AH,4CH
INT 21H

MAIN ENDP
   END MAIN