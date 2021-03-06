.MODEL SMALL
.STACK 100H  

.DATA 

NUM DB ?
NUM1 DB '1' 

MSG1 DB 10,13,"ENTER A HEX DIGIT : $" 
MSG2 DB 10,13,"IN DECIMAL IT IS : $" 
MSG3 DB 10,13,"LOWER CASE LETTER : $"
MSG4 DB 10,13,"ASCII VALUE IS : $"

.CODE

MAIN PROC
       
;INITIALIZE DS 
    MOV AX,@DATA
    MOV DS,AX 
    
;DISPLAY MESSAGE
    LEA DX,MSG1 ;GET MESSAGE
    MOV AH,9    ;DISPLAY STRING FUNCTION
    INT 21H     ;DISPLAY MESSAGE
      
;READ INPUT
    MOV AH,1    ;READ CHAR FUNCTION
    INT 21H     ;CHAR IN AL
    MOV NUM,AL  ;SAVE IT IN NUM
    
;CHECK IF IT IS 0-9 OR A-F
    CMP NUM,'A'
    JNGE DECIMAL  
    
    CMP NUM,'F'
    JNLE DECIMAL
    
    
;THEN DISPLAY LOWER CASE CHARACTER
    LEA DX,MSG3
    MOV AH,9
    INT 21H
    
    MOV AH,2
    ADD NUM,20H
    MOV DL,NUM
    INT 21H  
    
;DISPLAY DECIMAL VALUE OF A-F
    SUB NUM,20H
    SUB NUM,11H ;AS 'A' IS 11H GREATER THAN 0
    
    LEA DX,MSG2
    MOV AH,9
    INT 21H
     
    MOV AH,2
    MOV DL,NUM1 ;PRINTING 1 AT FIRST
    INT 21H     ;AND DISPLAY IT 
    MOV DL,NUM  ;NOW DIGIT (0-5) NEEDED ACCORDING TO INPUT
    INT 21H     ;AND DISPLAY IT 
    
    ADD NUM,31H
    
    CMP NUM,'a'
    JNGE 9A  
    
    CMP NUM,'c'
    JNLE 9A 
    
9A:
    SUB NUM,43
    MOV AH,2
    MOV DL,9
    INT 21H
    MOV DL,NUM
    INT 
    
    
    JMP EXIT
    
  
    
    
DECIMAL:
    LEA DX,MSG2
    MOV AH,9
    INT 21H
    
    MOV AH,2
    MOV DL,NUM
    INT 21H
    
    
EXIT:
    MOV AH,4CH  ;DOS EXIT FUNCTION
    INT 21H     ;EXIT TO DOS
    
MAIN ENDP
END MAIN
       
    