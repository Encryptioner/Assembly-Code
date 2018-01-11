;Exercise 6.10: Write a program that will prompt the user to enter a hex digit character, display it on next line n decimal and ask the user if he want to do it again. If the user types "Y" or "y" the program repeats. If the user types anything else, the program terminates. If the user enters an illegal character, prompt the user to try again.
;Exercise 6.11: Do programmming exercise 10, if the user fails to enter a hex digit character 3 tries, display a messsage and terminate the program 

.MODEL SMALL
.STACK 100H  

.DATA 

NUM DB ?
NUM1 DB '1' 
COUNT DB 0
MSG1 DB 10,13,"ENTER A HEX DIGIT : $" 
MSG2 DB 10,13,"IN DECIMAL IT IS : $"
MSG3 DB 10,13,"...ILLEGAL CHARACTER...TRY AGAIN... $"
MSG4 DB 10,13,'WANT TO REPEAT ? $'
MSG5 DB 10,13,'..WRONG HEXADECIMAL INPUT 3 TIMES. SO, PROGRAM TERMINATES..$'

.CODE

MAIN PROC
       
;INITIALIZE DS 
    MOV AX,@DATA
    MOV DS,AX 

TOP:    
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
    JL DECIMAL  
    
    CMP NUM,'F'
    JG DECIMAL
    
;DISPLAY DECIMAL VALUE OF A-F
    SUB NUM,11H ;AS 'A' IS 11H GREATER THAN 0
    
    LEA DX,MSG2
    MOV AH,9
    INT 21H
     
    MOV AH,2
    MOV DL,NUM1 ;PRINTING 1 AT FIRST
    INT 21H     ;AND DISPLAY IT 
    MOV DL,NUM  ;NOW DIGIT (0-5) NEEDED ACCORDING TO INPUT
    INT 21H     ;AND DISPLAY IT
    
    JMP REPEAT     
    
DECIMAL:
    CMP NUM,'0'
    JL ILLEGAL
    CMP NUM,'9'
    JG ILLEGAL
    
    LEA DX,MSG2
    MOV AH,9
    INT 21H
    
    MOV AH,2
    MOV DL,NUM
    INT 21H
    
    JMP REPEAT

;IF THE USER ENTER WRONG INPUT    
ILLEGAL:
    INC COUNT
    CMP COUNT,3
    JE ILLEGAL_3
    
    LEA DX,MSG3
    MOV AH,9
    INT 21H
    
    JMP TOP
;IF THE USER ENTER WRONG INPUT 3 TIMES. PROGRAM TERMINATES    
ILLEGAL_3:
    LEA DX,MSG5
    MOV AH,9
    INT 21H
    
    JMP EXIT

;IF THE USER INPUT "Y" OR "y" PROGRAM CONTINUE. ELSE TERMINATES    
REPEAT:
    LEA DX,MSG4
    MOV AH,9
    INT 21H
    
    MOV AH,1
    INT 21H
    
    CMP AL,'y'
    JE TOP
    CMP AL,'Y'
    JE TOP 
    
    JMP EXIT
        
EXIT:
    MOV AH,4CH  ;DOS EXIT FUNCTION
    INT 21H     ;EXIT TO DOS
    
MAIN ENDP
END MAIN  