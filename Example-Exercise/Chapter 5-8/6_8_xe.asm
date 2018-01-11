;Title: implementing loop

.MODEL SMALL
.STACK 100H

.CODE

MAIN PROC
    
    MOV CX,10
    MOV AH,2
    MOV DL,'*'
    
TOP:
    INT 21H
    LOOP TOP  
    
    MOV AH,2
    MOV DL,10
    INT 21H
    MOV DL,13
    INT 21H
    
    
    MOV CX,0
    MOV AH,2
    MOV DL,'*'
    JCXZ SKIP   ;jump if CX is zero
    
TOP2:
    INT 21H
    LOOP TOP2   ;As CX contains zero, CX value decreases to FFFFh means 65535 times
     
SKIP:  
    MOV AH,4CH
    INT 21H
    
END MAIN
MAIN ENDP