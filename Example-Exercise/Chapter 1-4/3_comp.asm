
.MODEL SMALL 

.STACK 100H

.DATA    

  MESSAGE1 DB 0AH,0DH,'****RESULT IS POSITIVE****','$'
  MESSAGE2 DB 0AH,0DH,'****RESULT IS NEGATIVE****','$'
  MESSAGE3 DB 0AH,0DH,'****RESULT IS ZERO****','$'

  INPUT_M1 DB 0AH,0DH,'ENTER 1ST NUM ',0DH,0AH,'$'
  INPUT_M2 DB 0AH,0DH,'ENTER 2ND NUM ',0DH,0AH,'$' 
  
.CODE    

MAIN PROC 
    
    MOV AX,@DATA
    MOV DS,AX

    MOV DX,OFFSET INPUT_M1  
    
    MOV AH,09
    INT 21H

    MOV AH,01
    INT 21H
    MOV BL,AL  
    
    MOV DX,OFFSET INPUT_M2

    MOV AH,09
    INT 21H  
    

    MOV AH,01
    INT 21H
    MOV CL,AL 
    
    SUB BL,CL
    ADD BL,30H  
    MOV CL,0
    ADD CL,30H    
    
    

    CMP BL,CL
    JE  EQUAL
    JGE GREAT

    MOV DX,OFFSET MESSAGE2
    JMP PRINT 
    
EQUAL:  MOV DX,OFFSET MESSAGE3 

    JMP PRINT
                  
    
GREAT:  MOV DX,OFFSET MESSAGE1   
    
PRINT:  MOV AH,09
        INT 21H    
        
        
    MOV AH,4CH
    INT 21H  
 
    
MAIN ENDP
END MAIN