.MODEL SMALL
.STACK 100H
 
.DATA
MSG1 DB 10,13,'...EVEN NUMBER...$'
MSG2 DB 10,13,'...ODD NUMBER...$'

.CODE

MAIN PROC 
    MOV AX,@DATA
	MOV DS,AX
    
    MOV AH,1
    INT 21H          
    
    TEST AL,1  ;CHECKING IF THE NUMBER IS EVEN
       
    JZ EVEN
    JMP ODD
    

EVEN:
    LEA DX,MSG1
	MOV AH,9
	INT 21H 
	JMP EXIT
	
ODD:
    LEA DX,MSG2
	MOV AH,9
	INT 21H

EXIT:    
    MOV AH,4CH
    INT 21H 
    
MAIN ENDP
END MAIN