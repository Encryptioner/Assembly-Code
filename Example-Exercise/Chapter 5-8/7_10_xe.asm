.MODEL SMALL
.STACK 100H 

.CODE

MAIN PROC 
   
    MOV AX,65143
    MOV CL,2
    SHR AX,CL  ;DIVIDING BY 4  
    
;DISPLAY
    ;ADD AX,30H
    MOV AH,2
    MOV DX,AX
    INT 21H     ;PRINTING THE DIVIDED VALUE OF CORRESPONDING ASCII CODE 16353

EXIT:    
    MOV AH,4CH
    INT 21H 
    
MAIN ENDP
END MAIN