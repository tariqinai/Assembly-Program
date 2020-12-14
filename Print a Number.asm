.model small ;Model Direcive
.stack 100h   ;Stack segment

.data    ;Data segment Directive

.code     ;code segment directive
  main proc    ;main procedure 
    ;printing 'A' due to ASCII chracter as 65
    mov dl,65 
    mov ah,2  
    INT 21h   
    ;this is for next line
    mov dl,10 
    mov ah,2  
    INT 21h   
    ;this is for revert back to start of new line
    mov dl,13 
    mov ah,2  
    INT 21h

    mov dl,66 
    mov ah,2  
    INT 21h    

    mov ah,4ch  ;Getting out of register
    INT 21h ;inturrupt routine for processor
  main endp     ;ending main procedure

End MAIN