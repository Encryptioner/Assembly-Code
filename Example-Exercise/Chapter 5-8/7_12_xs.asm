.MODEL SMALL

.STACK 100H

.DATA 

 MS1 DB 'TYPE A BINARY NUMBER UP TO 8 DIGITS: $'
 MS2 DB 10,13,10,13,'TYPE A BINARY NUMBER UP TO 8 DIGITS: $'
 MS3 DB 10,13,10,13,'THE BINARY SUM =  $'
 MS4 DB 10,13,10,13,'ROTATED BINARY INPUT_1:  $'
 MS5 DB 10,13,10,13,'ROTATED BINARY INPUT_2:  $'
 

.CODE


MAIN PROC

MOV AX,@DATA
MOV DS,AX

;take input_1
LEA DX,MS1
MOV AH,9
INT 21H

XOR BX,BX
MOV CX,8
MOV AH,1

INPUT1_:
        INT 21H
        CMP AL,0DH
        JE END1_
        
        AND AL,0FH
        SHL BL,1
        OR BL,AL
        
        LOOP INPUT1_
        
        MOV AL,BL
        MOV CX,8
;reverse input_1
END1_:
        SHL AL,1
        RCR BL,1
        LOOP END1_
                
        
;reversed binary output message_1    
    LEA DX,MS4
    MOV AH,9
    INT 21H
    
    MOV CX,8     
    MOV AH,2     
    
TOP1:
    ROL BL,1     
    JNC NEXT01   
    
    MOV DL,'1'   
    INT 21H
    LOOP TOP1
    
    CMP CX,0      
    JZ NEW
    
NEXT01:
    MOV DL,'0'    
    INT 21H
    LOOP TOP1     
    
    JMP NEW

;take input_2    
NEW:

LEA DX,MS2
MOV AH,9
INT 21H

MOV CX,8
MOV AH,1

INPUT2_:
        INT 21H
        CMP AL,0DH
        JE END2_
        _
        AND AL,0FH
        SHL BH,1
        OR BH,AL
        LOOP INPUT2_
        
        MOV AL,BH
        MOV CX,8
        
;reverse input_2 
END2_:

        SHL AL,1
        RCR BH,1
        LOOP END2_

;reversed binary output message_2    
    LEA DX,MS5
    MOV AH,9
    INT 21H
    
    MOV CX,8     
    MOV AH,2     
    
TOP2:
    ROL BH,1     
    JNC NEXT02   
    
    MOV DL,'1'   
    INT 21H
    LOOP TOP2
    
    CMP CX,0      
    JZ NEW2
    
NEXT02:
    MOV DL,'0'    
    INT 21H
    LOOP TOP2     
    
    JMP NEW2
      
;start binary summation      
NEW2: 
      
     LEA DX,MS3
     MOV AH,9
     INT 21H

     ADD BL,BH
     JNC OUT_
       _
     MOV AH,2
     MOV DL,31H
     INT 21H

OUT_:       

     MOV CX,8
     MOV AH,2

F1_:
     
     SHL BL,1

     JNC F0_
     
     MOV DL,31H
     JMP DISPLAY_
     
F0_:
     MOV DL,30H
    

;display output
DISPLAY_:

    INT 21H
    LOOP F1_

    JMP EXIT

EXIT:

MOV AH,4CH
INT 21H

MAIN ENDP
   END MAIN

