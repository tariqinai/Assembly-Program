line macro 
  mov dl, 10 
  mov ah, 02h 
  int 21h 
  
  mov dl, 13 
  mov ah, 02h 
  int 21h 
endm

.model small 
.stack 100h 
.data 
  o db 'Even Number. ' , '$' 
  e db 'Odd Number. ' ,'$' 
.code 
  main proc 
    mov ax, @data 
    mov ds, ax 
  
    mov ah, 01h 
    int 21h 
    
    mov ah, 0 
    mov bl, 2 
    div bl 
    cmp ah, 1 
    je odd 
    cmp ah, 0 
    je even 
  odd: 
    line 
    mov dx, offset o 
    mov ah, 09h 
    int 21h 
    
    mov ah, 04ch 
    int 21h 
  even:
    line
    mov dx, offset e
    mov ah, 09h 
    int 21h 
    
    mov ah, 04ch 
    int 21h 
  main endp 
end