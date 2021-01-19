;;;Write a program that gets source file name and destination file name. It copies the all contents of source file to destination file. After copying the data it gives message,

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
  srcfile db 50 dup(0)
  destfile db 50 dup(0)
  srchandler dw 0
  desthandler dw 0
  para db 10 dup('$') 
  msg1 db "Enter source filename (0-50) : " , "$"
  msg2 db "Enter Destination filename (0-50) : " , "$"
  msg3 db "File is copied successfully!!! " , "$" 
  len dw 0 
  nextB dw 0
.code 
main proc 
  mov ax,@data 
  mov ds,ax 
  mov es,ax
;;;;;;;;;;;;;;;;;;;;;;;;;;;      
;;;Source Filename Input
    lea dx,msg1
    str
    mov si, offset srcfile
    src:
        cin
        cmp al,0dh
        je esrc
        mov byte ptr[si],al
        inc si
    jmp src
    esrc:
;;;Destination Filename Input
    lea dx,msg2
    str
    mov si, offset destfile
    dest:
        cin
        cmp al,0dh
        je edest
        mov byte ptr[si],al
        inc si
    jmp dest
    edest:
;;;Creation of destination output
    mov ah,03CH
    lea dx,destfile 
    mov cx,0h
    int 21h
    mov desthandler,ax

;;;Open File src
    mov ah,03DH
    mov dx,offset srcfile 
    mov al,0h
    int 21h
    jc exit1
    mov srchandler,ax

;;;Read From File 
read:
    mov ah,03FH
    mov bx,srchandler
    mov cx,1
    mov dx,offset para 
    int 21h
    mov nextB,ax 

    cmp nextB,0
    je exit1
;;;Destination file input
    mov dx, 0h
    mov cx, 0h
    mov bx, desthandler
    mov al, 2
    mov ah, 42h
    int 21h

    mov ah,40h
    mov bx,desthandler
    mov cx,1 
    lea dx,para
    int 21h 
    mov bx,ax
jmp read

    
;;Closing files
exit1:
    lea dx,msg3
    str
    mov ah,03eh
    mov bx,srchandler
    int 21h

    mov ah,03eh
    mov bx,desthandler
    int 21h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  mov ah,04ch
  int 21h
main endp 
end 