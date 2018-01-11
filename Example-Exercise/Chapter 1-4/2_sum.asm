.MODEL SMALL
.STACK 100H


.DATA
     NUM1 DB ?
     NUM2 DB ?
     ANS DB ?
     MSG1 DB 10,13,"ENTER 1ST NUMBER : $"
     MSG2 DB 10,13,"ENTER 2ND NUMBER : $"  
     MSG3 DB 10,13,"SUM = $"

.CODE

MAIN PROC
    
      MOV AX,@DATA
      MOV DS,AX
     
      ;read first value
      LEA DX,MSG1
      MOV AH,9
      INT 21H
     
      MOV AH,1
      INT 21H
      SUB AL,30H
      MOV NUM1,AL
     
      ;read second value
      LEA DX,MSG2
      MOV AH,9
      INT 21H
     
      MOV AH,1
      INT 21H
      SUB AL,30H
      MOV NUM2,AL
     
      ADD AL,NUM1
              
      MOV ANS,AL
     
      MOV AH,0 
      AAA
      
     
      ADD AH,30H
      ADD AL,30H 
     
      MOV BX,AX
     
      ;printing sum of two number
      LEA DX,MSG3
      MOV AH,9
      INT 21H
     
      MOV AH,2
      MOV DL,BH
      INT 21H
     
      MOV AH,2
      MOV DL,BL
      INT 21H
     
      ;return to DOS
      MOV AH,4CH
      INT 21H  
         
MAIN ENDP 

END MAIN