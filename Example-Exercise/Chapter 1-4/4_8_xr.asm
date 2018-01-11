;Exercise 4.8: Write a program to (a) display a "?", (b) read two decimal digit whose sum is less than 10, (c) display them and their sum on next line, with an appropriate message.

.MODEL SMALL
.STACK 100H

.DATA
                                                                                                                                                   
     NUM1 DB ?
     ANS DB ?
     MSG1 DB 10,13,"ENTER 1ST NUMBER : $"
     MSG2 DB 10,13,"ENTER 2ND NUMBER : $"  
     MSG3 DB 10,13,"SUM = $"

.CODE

MAIN PROC
    
;initialize DS
      MOV AX,@DATA
      MOV DS,AX
     , 
;display a "?"
      MOV AH,2
      MOV DL,'?'
      INT 21H
      
;read first value
      LEA DX,MSG1
      MOV AH,9
      INT 21H
     
      MOV AH,1
      INT 21H
      SUB AL,48    ;to get appropriate digit value
      MOV NUM1,AL  ;store it in NUM1
     
;read second value
      LEA DX,MSG2
      MOV AH,9
      INT 21H
     
      MOV AH,1
      INT 21H
      SUB AL,48
      
      ADD AL,NUM1  ;addition
      ADD AL,48    ;to print corresponding ASCII digit
      MOV ANS,AL   ;store it in ANS
           
;printing sum of two number
      LEA DX,MSG3
      MOV AH,9
      INT 21H
     
      MOV AH,2
      MOV DL,ANS
      INT 21H
     
;return to DOS
      MOV AH,4CH
      INT 21H  
         
MAIN ENDP 
END MAIN