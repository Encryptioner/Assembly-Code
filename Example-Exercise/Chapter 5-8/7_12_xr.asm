;Exercise 7.12: Write a program that prompts the user to enter two binary numbers of up to 8 digit each and print their sum on the next line in binary. If the user enters an illegal character, he should be prompt to begin again. Each input ends with a carriage return.

.MODEL SMALL
.STACK 100H
.DATA 

MSG1 DB 10,13,'TYPE 1ST BINARY NUMBER (UP TO 8 DIGITS): $'
MSG2 DB 10,13,'TYPE 2ND BINARY NUMBER (UP TO 8 DIGITS): $'
MSG3 DB 10,13,'BINARY SUM = $'
MSG4 DB 10,13,'...ILLEGAL CHARATER.TRY AGAIN...$'
 
.CODE

MAIN PROC
;initialize DX
    MOV AX,@DATA
    MOV DS,AX

AGAIN:
;take input1
    LEA DX,MSG1
    MOV AH,9
    INT 21H
    
    XOR BX,BX   ;initialize BX to zero
    MOV CX,8
    MOV AH,1

INPUT1:
    INT 21H
    CMP AL,13   ;carriage return
    JE END1     
    
    CMP AL,48   ;checking illegal character
    JL REPEAT
    CMP AL,49
    JG REPEAT
    
    AND AL,0FH
    SHL BL,1    ;shifting BL for make room for next bit
    OR BL,AL    ;set bit
    LOOP INPUT1

;take input2
END1:
    LEA DX,MSG2
    MOV AH,9
    INT 21H

    MOV CX,8
    MOV AH,1

INPUT2:
    INT 21H
    CMP AL,13   ;carriage return
    JE END2
    
    CMP AL,48
    JL REPEAT
    CMP AL,49
    JG REPEAT
    
    AND AL,0FH
    SHL BH,1    ;shifting BH for make room for next bit
    OR BH,AL    ;set bit
    LOOP INPUT2
         
END2:
    LEA DX,MSG3
    MOV AH,9
    INT 21H
    
;starting summation
    ADD BL,BH
    JNC OUT_    ;jump if no carry. No modification needed
    MOV AH,2
    MOV DL,31H
    INT 21H     ;printing carried 1 at first

OUT_:                       
    MOV CX,8    ;for printing 8 bit summation
    MOV AH,2

F1:     
    SHL BL,1    ;need to shift to get next bit
    JNC F0      ;if no carry print 0
    MOV DL,31H  ;else print 1
    JMP DISPLAY
     
F0:
    MOV DL,30H  ;if output bit is 0

DISPLAY:
    INT 21H
    LOOP F1
    JMP EXIT
    
REPEAT:
    LEA DX,MSG4
    MOV AH,9
    INT 21H
    JMP AGAIN   

EXIT:
    MOV AH,4CH  ;DOS EXIT FUNCTION
    INT 21H     ;EXIT TO DOS
    
MAIN ENDP
END MAIN