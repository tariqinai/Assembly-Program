;;;   Macros ;;;
; Push and pop Registers for Procs
pushRegs Macro
  push ax
  push bx
  push cx
  push dx
endM
popRegs Macro
  pop ax
  pop bx
  pop cx
  pop dx
endM
;;;;;;;;;;;;;;;;;;;;;
line macro
  mov dl,13 
  mov ah,02h  
  INT 21h

  mov dl,10
  mov ah,02h
  int 21h
endM 
str macro
  mov ah,09h
  int 21h
endM
getch macro
  mov ah,01h
  int 21h 
endM
.model samll
.stack 100h
.data
  alpha db 0
  str1 db "This is Alphabet.","$"
  str2 db "Sorry!!! only Alphabet Please." ,"$"
.code
main proc
  mov ax,@data
  mov ds,ax 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    call isAlphabet 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov ah,04ch
int 21h
main endp
isAlphabet proc
  pushRegs
    getch
    mov alpha,al

    cmp alpha,65
    jl cond
    cmp alpha,90
    jg cond

    line
    lea dx , str1
    str

    jmp exit
cond:
    cmp alpha,97
    jl exit
    cmp alpha,122
    jg exit

    line
    lea dx , str1
    str

exit:
  popRegs
Ret 
isAlphabet endp
end 