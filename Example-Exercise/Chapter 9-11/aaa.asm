;Exercise 4.8: Write a program to (a) display a "?", (b) read two decimal digit whose sum is less than 10, (c) display them and their sum on next line, with an appropriate message.


.MODEL SMALL
.STACK 100H

MAIN PROC 
    
    mov ah,0
    mov al,'8';8=38h=56
    
    add al,'3';3=33h=51
    
    ;after adding ah=0h, al=6bh=107 
    
    aaa  ;ah=01h, al=01h=257 
    
    or ax,3030h ;ah=31h=1, al=31h=1
  
         
MAIN ENDP 

END MAIN