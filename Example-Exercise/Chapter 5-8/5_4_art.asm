;Title: Check Flags
;used in DEBUG to check flag settings

.MODEL SMALL
.STACK 100H  

.CODE 

MAIN PROC 
    
    MOV AX,4000H    ;AX=4000H
    ADD AX,AX       ;AX=8000H
    SUB AX,0FFFFH   ;AX=8001H
    NEG AX          ;AX=7FFFH
    INC AX          ;AX=8000H 
    
    MOV AH,4CH
    INT 21H 
    
MAIN ENDP
END MAIN