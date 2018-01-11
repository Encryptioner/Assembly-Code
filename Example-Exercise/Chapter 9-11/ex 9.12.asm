.MODEL SMALL
 .STACK 100H

 .DATA
   MSG_1  DB  'Enter the value of M = $'
   MSG_2  DB  0DH,0AH,'Enter the value of N = $'
   MSG_3  DB  0DH,0AH,'The GCD of M and N is = $'
 
 .CODE
   MAIN PROC
     MOV AX, @DATA                ; initialize DS
     MOV DS, AX

     LEA DX, MSG_1                ; load and display the string MSG_1
     MOV AH, 9
     INT 21H

     CALL INDEC                   ; call the procedure INDEC

     PUSH AX                      ; push AX onto the STACK

     LEA DX, MSG_2                ; load and display the string MSG_2
     MOV AH, 9
     INT 21H

     CALL INDEC                   ; call the procedure INDEC

     MOV BX, AX                   ; set BX=AX

     POP AX                       ; pop a value from STACK into AX
     
     @REPEAT:                     ; jump label
       XOR DX, DX                 ; clear DX
       DIV BX                     ; set AX=DX:AX\BX ,  AX=DX:AX%BX

       CMP DX, 0                  ; compare DX with 0
       JE @END_LOOP               ; jump to label @END_LOOP if CX=0

       MOV AX, BX                 ; set AX=BX
       MOV BX, DX                 ; set BX=DX
     JMP @LOOP                    ; jump to label @REPEAT 

     @END_LOOP:                   ; jump label

     LEA DX, MSG_3                ; load and display the string MSG_3
     MOV AH, 9
     INT 21H

     MOV AX, BX                   ; set AX=BX

     CALL OUTDEC                  ; call the procedure OUTDEC

     MOV AH, 4CH                  ; return control to DOS
     INT 21H
   MAIN ENDP

INCLUDE OUTDEC.ASM
INCLUDE INDEC9.ASM

 END MAIN
