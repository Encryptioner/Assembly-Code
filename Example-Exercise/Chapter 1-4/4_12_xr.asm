;Exercise 4.12: Write a program to (a) display a "?", (b) read three initials, (c) display them in the middle of an 11*11 box of asterisks and (d) beep the computer 
.MODEL SMALL
.STACK 100H

.DATA 

CHAR1 DB ?
CHAR2 DB ?
CHAR3 DB ?  
MSG DB 10,13,'???????????$'
MSG2 DB '????$'
MSG3 DB 10,13,'READ THREE INITIALS: $'
MSG4 DB 10,13,'...DOING BEEP...$' 

.CODE

MAIN PROC

;initialize DS
	MOV AX,@DATA
	MOV DS,AX
	
;display "?"
    MOV AH,2
    MOV DL,'?'
    INT 21H
    
    MOV AH,9
    LEA DX,MSG3
    INT 21H
	
;read input
    MOV AH,1    ;read char function
    INT 21H     ;save in AL
    MOV CHAR1,AL;save it in CHAR1
    INT 21H  
    MOV CHAR2,AL
    INT 21H  
    MOV CHAR3,AL
    
;print string of ? 5 times
	MOV CX,5 
	LEA DX,MSG
	MOV AH,9 

TOP1:
	INT 21H 
	LOOP TOP1 
	
;go to a new line
    MOV AH,2    ;display char function
    MOV DL,0DH  ;carriage return
    INT 21H     ;execute carriage return
    MOV DL,0AH  ;line feed
    INT 21H     ;execute line feed
	
;print "****"
	LEA DX,MSG2
	MOV AH,9
	INT 21H
	
;print 3 initial at middle
	MOV AH,2
	MOV DL,CHAR1
	INT 21H
	MOV DL,CHAR2
	INT 21H
	MOV DL,CHAR3
	INT 21H 
	
;print "****" again	
	LEA DX,MSG2
	MOV AH,9
	INT 21H
	
;print string of ? 5 times
	MOV CX,5 
	LEA DX,MSG
	MOV AH,9 

TOP2:
	INT 21H 
	LOOP TOP2
	
;doing beep
    MOV AH,9
    LEA DX,MSG4
    INT 21H
    
    MOV AH,2
    MOV DL,7
    INT 21H
	
;return to DOS
	MOV AH,4CH
	INT 21H 
	
MAIN ENDP
END MAIN

