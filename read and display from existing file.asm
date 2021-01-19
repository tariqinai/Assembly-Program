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
  para db 10 dup('$') 
  msg3 db "Enter filename (0-50) : " , "$"
  len dw 0 
  nextB dw 0
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
;;;Open File
    mov ah,03DH
    mov dx,offset filename 
    mov al,0h 
    int 21h
    jc exit
    mov filehandler,ax

;;;Read From File 
read:
    mov ah,03FH
    mov bx,filehandler
    mov cx,1
    mov dx,offset para 
    int 21h
    mov nextB,ax
;;;Display on screen
    mov dx,offset para
    str
    cmp nextB,0
    jne read

;;Closing file
exit:
    mov ah,03eh
    mov bx,filehandler
    int 21h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  mov ah,04ch
  int 21h
main endp 


end 