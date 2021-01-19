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
.data
  preNo dw 0
  currNo dw 0

  filename db 50 dup(0)
  filehandler dw 0
  para db 100 dup('$') 
  msg1 db "Total Number of paragraph is : " ,"$" 
  msg2 db "Enter Your paragraph (0-100) : " , "$" 
  msg3 db "Enter filename (0-50) : " , "$"
  len dw 0 
.code 
main proc 
  mov ax,@data 
  mov ds,ax 
  mov es,ax
;;;;;;;;;;;;;;;;;;;;;;;;;;;      
;;; Filename Input
    lea dx,msg3
    str
    mov si, offset filename
    fname:
        cin
        cmp al,0dh
        je efname
        mov byte ptr[si],al
        inc si
    jmp fname
    efname:
;;;Create New File
    mov ah,03CH
    lea dx,filename 
    mov cx,0h
    int 21h
    mov filehandler,ax
;;Paragrapgh input
    lea dx,msg2
    str 
    mov si, offset para
    Input:
        cin
        cmp al,0dh
        je endpara
        mov byte ptr[si],al
        inc len 
        inc si  
    jmp Input
    endpara:
;;;Write File
    mov ah,40h
    mov bx,filehandler
    mov cx,len
    lea dx,para
    int 21h 
    mov bx,ax
;;Displaying total number of chracters
    lea dx,msg1
    str
    mov preNo,bx
    call Print
;;Closing file
exit:
    mov ah,03eh
    mov bx,filehandler
    int 21h


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