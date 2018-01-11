;EXAMPLE 10.4 


.MODEL SMALL

.STACK 100H

.DATA
  
 W DW 1,2,3,3  

.CODE



MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    
    CALL REVERSE


MOV AH,4CH
INT 21H

MAIN ENDP


REVERSE PROC 
    
    
    MOV BX,4
    MOV CX,BX
    DEC BX
    SHL BX,1
    SHR CX,1
    
    
    LEA SI,W
    MOV DI,SI
    ADD DI,BX;LAST ELEMENT 
    add ah,[si]
        
    
XCHG_LOOP:
    
    MOV AX,[SI]
    XCHG AX,[DI]
    MOV [SI],AX
    
    MOV [BX],1;SUPPOSE TO BE ILLEGAL
    
    ADD SI,2
    SUB DI,2
    
    LOOP XCHG_LOOP 
    
    
    LEA SI,W;1ST ELEMENT
    MOV CX,4
    
PRINT:
    
    MOV AX,[SI]
    MOV DX,AX
    ADD DX,30H
    
    MOV AH,2
    INT 21H
    
    ADD SI,2
    LOOP PRINT 
    
    RET
    
REVERSE ENDP

        
;end   
END MAIN