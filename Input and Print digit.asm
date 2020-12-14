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
.model samll
.stack 100h
.data
  preNo dw 0
  currNo dw 0
.code
main proc
  mov ax,@data
  mov ds,ax 
;;;;;;;;;;;;;;;;;;;;;;;;;;;      
    call Input ;input from user using proc
    call Print ;output from user using proc 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  mov ah,04ch
  int 21h
main endp 
Input proc
  pushRegs
    mov preNo,0
    mov currNo,0
    
    mov bx,10   ;;; For the purpose of 10 Multiply
InputAgain:    
    mov ah,01h   ;;Input
    int 21h 

    cmp al,0dh
    je endInput
    sub al,48

    mov ah,0h
    mov currNo,ax
    mov ax,preNo
    mov dx,0h
    mul bx
    add ax,currNo 
    mov preNo,ax
    jmp InputAgain
endInput:
popRegs
Ret
Input endp
Print proc
  pushRegs
    mov ax,preNo
    mov bx,10
    mov cx,0
divAgain:
    mov dx,0h

    div bx
    inc cx
    push dx
    cmp ax,0
    jne divAgain
printNum:
    pop dx
    add dx,48
    mov ah,02h
    int 21h
    loop printNum
popRegs
Ret
Print endp
end 