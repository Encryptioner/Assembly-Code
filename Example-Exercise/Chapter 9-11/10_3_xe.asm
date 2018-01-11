;EXAMPLE 10.3  


.MODEL SMALL

.STACK 100H

.DATA
  
 W DW 1,2,3,3  

.CODE



MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    XOR AX,AX
    LEA SI,W
    MOV CX,4
    
ADDONS:
    ADD AX,[SI]
    ADD SI,2
    LOOP ADDONS
    
    
    MOV BX,AX        
    MOV AH,2
    MOV DX,BX
    ADD DX,30H
    INT 21H


MOV AH,4CH
INT 21H

MAIN ENDP
   END MAIN