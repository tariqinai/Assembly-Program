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
;New line macro
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
  inp db "Input Number.","$"
  show db "Output Number.","$"
  bin db "Binary Number.","$"
  oct db "Octal Number.","$"
  hex db "Hexadecimal Number.","$"
.code
main proc
  mov ax,@data
  mov ds,ax 
;;;;;;;;;;;;;;;;;;;;;;;;;;;
    lea dx,inp 
    str
    call Input  ;input from user using proc
    lea dx,show
    str
    call Print  ;output from user using proc
    line
    lea dx,bin 
    str
    call Binary ;Binary conversion
    line
    lea dx,oct 
    str
    call Octal ;Octa Conversion
    line
    lea dx,hex 
    str
    call Hexa ;HexaDecimal Conversion
;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
;;Binary proc
Binary proc
  pushRegs
    mov bx,2
    mov ax,preNo
    mov cx,0
doAgainB:
    mov dx,0h
    div bx
    inc cx
    push dx
    cmp ax,0
    jne doAgainB

showBin:
  pop dx
  add dx,48
  mov ah,02h
  int 21h
  loop showBin
popRegs
Ret
Binary endp
;;;;;;;;;;;;;;;
;;;;;Octal proc
Octal proc
  pushRegs
    mov bx,8
    mov ax,preNo
    mov cx,0
doAgainO:
    mov dx,0h

    div bx
    inc cx
    push dx
    cmp ax,0
    jne doAgainO

showOct:
  pop dx
  add dx,48
  mov ah,02h
  int 21h
  loop showOct
popRegs
Ret
Octal endp
;;;;;;;;;;;;;;;;;;;;
;;Hexadecimal number
Hexa proc
  pushRegs
    mov bx,16
    mov ax,preNo
    mov cx,0
doAgainH:
    mov dx,0h

    div bx
    inc cx
    push dx
    cmp ax,0
    jne doAgainH

showHexa:
  pop dx
  add dx,48
  mov ah,02h
  int 21h
  loop showHexa
popRegs
Ret
Hexa endp
;;;;;;;;;;;;;;;;;;;
end 