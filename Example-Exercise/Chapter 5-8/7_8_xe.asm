.MODEL SMALL
.STACK 100H 

.CODE

MAIN PROC 
   
    MOV AH,1
    INT 21H          
    MOV BX,AX 
    
    
    MOV CL,1
    SHL AX,CL  ;MULTIPLYING BY 2
    MOV BX,AX  
    
    ;GO  TO A NEW LINE
    MOV AH,2    ;DISPLAY CHAR FUNCTION
    MOV DL,0DH  ;CARRIAGE RETURN
    INT 21H     ;EXECUTE CARRIAGE RETURN
    MOV DL,0AH  ;LINE FEED
    INT 21H     ;EXECUTE LINE FEED
    
;DISPLAY
    SUB BX,48
    MOV AH,2
    MOV DX,BX
    INT 21H     ;DISPLAY 2=10 >100=ASCII VALUE d

EXIT:    
    MOV AH,4CH
    INT 21H 
    
MAIN ENDP
END MAIN