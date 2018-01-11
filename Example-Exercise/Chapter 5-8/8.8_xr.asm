;Exercise 8.8:
                           
.MODEL SMALL
.STACK 100H
.DATA

VAR DB 30  
MSG_1  DB  'Enter string : $'
MSG_2  DB  10,13,'String in reverse order : $'

.CODE

MAIN PROC 
    MOV AX,@DATA    ;initialize DS
    MOV DS,AX

    LEA DX, MSG_1   ;load and display MSG_1 
    MOV AH, 9
    INT 21H


    XOR CX,CX   ;clear CX
    XOR SI,SI   ;clear SI
    MOV AH,1

INPUT:
    INT 21H
    CMP AL,' '
    JE REPLACE  ;compare AL with space

    CMP AL,0DH
    JE REPLACE  ;compare AL with CR

    PUSH AX
    INC CX
    JMP INPUT

REPLACE:
    POP DX
    MOV VAR[SI],DL  ;if space or CR char pushed in VAR
    INC SI
    
    LOOP REPLACE
    CMP AL,0DH
    JE END_INPUT    ;if CR END_INPUT

    MOV VAR[SI],' ' ;else send a space in VAR
    INC SI
    JMP INPUT   ;take input

END_INPUT:
    MOV CX,SI   ;counter for printing character
    AND SI,0H   ;clear SI

    LEA DX, MSG_1   ;display MSG_2 
    MOV AH, 9
    INT 21H
    MOV AH,2

DISPLAY:
    MOV DL,VAR[SI]
    INC SI
    INT 21H
    
    LOOP DISPLAY

    MOV AH,4CH  ;DOS exit
    INT 21H

MAIN ENDP
END MAIN