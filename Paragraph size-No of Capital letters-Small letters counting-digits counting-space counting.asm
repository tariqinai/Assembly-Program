;1.Get a paragraph of text from user and display the given information : 
;1. Size of given text ( Total Text size is : 123 ) 
;2. Total no of Capital Letters 
;3. Total no of Small letters 
;4. Total no of digits 
;5. total no of spaces


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
getch macro 
  mov ah, 01h
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
  arr db 256 DUP("?")
  totalwords dw 0
  str1 db "The total size of text are :  " , "$"
  str2 db "The total number of capital letters are :  " , "$"
  str3 db "The total number of small letters are :  " , "$"
  str4 db "The total number of digits letters are :  " , "$"
  str5 db "The total number of Spaces are :  " , "$"
  cap dw 0
  lowl dw 0
  no dw 0
  spc dw 0
.code
main proc
  mov ax,@data
  mov ds,ax 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    mov cx, 256
    mov si, offset arr

  Inputarr:
    getch 
    
    cmp al,13
    je skip

    mov byte ptr [si], al
    inc si
    inc totalwords

    cmp al,65
    jl cond2
    cmp al,90
    jg cond2

    capital:
      inc cap
cond2:
    cmp al,97
    jl cond3
    cmp al,122
    jg cond3

  small:
    inc lowl
cond3:
    cmp al,48
    jl cond4
    cmp al,57
    jg cond4

  digit:
    inc no
cond4:
    cmp al,32
    jl exit
    cmp al,32
    jg exit
  space:
    inc spc
exit:
  loop Inputarr
  skip:
  lea dx,str1
  str
  mov bx,totalwords
  mov preNo,bx
  call Print

  line
  lea dx,str2
  str
  mov bx,cap
  mov preNo,bx
  call Print

  line
  lea dx,str3
  str
  mov bx,lowl
  mov preNo,bx
  call Print

  line
  lea dx,str4
  str
  mov bx,no
  mov preNo,bx
  call Print

  line
  lea dx,str5
  str
  mov bx,spc
  mov preNo,bx
  call Print

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  mov ah,04ch
  int 21h
main endp
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

