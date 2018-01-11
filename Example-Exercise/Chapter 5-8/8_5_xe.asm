;Example 8.5: multiplication

.MODEL SAMLL
.STACK 100H 

.DATA
MSG DB 'HELLO!$'

.CODE

MAIN PROC
    
    CALL MULTIPLY
    
    MOV AH,4CH
    INT 21H
    
MAIN ENDP

MULTIPLY PROC ;it's not multiplication program. just checking if procedur in stack is working
    
    MOV AX,@DATA
	MOV DS,AX
	
	LEA DX,MSG
	MOV AH,9
	INT 21H
	
	MOV BX,56H
	
MULTIPLY ENDP

    END MAIN