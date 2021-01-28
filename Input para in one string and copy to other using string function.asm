;; Move string from 1 string to other .
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
cin macro
    mov ah,01h
    int 21h
endM
cout macro 
    mov ah,02h
    int 21h
endM

.model samll
.stack 100h
;;;;;;;;;;;;;;;;
.data
  str1 db 256 DUP('$')
  str2 db 256 DUP('$')
  len dw 0
  msg1 db "Enter a paragraph(#256) : ","$"
;;;;;;;;;;;;
.code 
main proc 
  mov ax,@data 
  mov ds,ax 
  mov es,ax
;;;;;;;;;;;;;;;;;;;;;;;;;;;      
;;;Source Filename Input
  lea dx, msg1
  str
  mov si,offset str1
strin:
  cin
  cmp al,0dh
  je next
  mov byte ptr[si],al
  inc si
  inc len
  jmp strin
next:
    mov cx,len
    mov si,offset str1
    mov di,offset str2
    cld
    rep movsb
    lea dx,str1
    str
    line
    lea dx,str2
    str
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  mov ah,04ch
  int 21h
main endp 
end 