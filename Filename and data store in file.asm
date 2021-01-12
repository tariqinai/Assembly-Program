; Take File name and Data and store it in file...

 

;;; MACROS;;;
pushReg macro
    push ax
    push bx
    push cx
    push dx
endm

 

popReg macro
    pop dx
    pop cx
    pop bx
    pop ax
endm

 

line macro
    pushReg
    mov dl, 0Ah
    mov ah, 02h
    int 21h

 

    mov dl, 0Dh
    mov ah, 02h
    int 21h
    popReg
endm

 

getch macro
    mov ah, 01h
    int 21h
endm

 

putchr macro chr
    pushReg
    mov dl, chr
    mov ah, 02h
    int 21h
    popReg
endm

 

putstr macro str
    pushReg
    mov dx, offset str
    mov ah, 09h
    int 21h
    popReg
endm

 

;;;MAIN PROGRAM;;;
.model small
.stack 100h
.data
    
    filename DB "new.txt", 0
    filehandler DW 0
    msg1 DB "Enter Paragraph : $"
		msg2 DB "Paragraph Length is : $"
		preNo dw 0
  	currNo dw 0

    para DB 100 DUP(?)
    paraLen DW 0

 

.code
main proc
    mov ax, @data
    mov ds, ax
    mov es, ax

 

; Creating File
    mov dx, offset filename
    mov cx, 0h
    mov ah, 03CH
    int 21h

 

    mov filehandler, ax 

 

; Inputing Paragraph
    putstr msg1
    mov si, offset para
    Input:
        getch
        cmp al, 0dh 
        je EndInput
        mov byte ptr [si], al 
        inc paraLen
        inc si
    jmp Input
 

    EndInput:

 

; Writing Paragraph into file
    mov dx, offset para
    mov cx, paraLen
    mov bx, filehandler
    mov ah, 40H
    int 21h

		putstr msg2
		mov preNo,cx
    call Print

 

    EndProg:
    mov ah, 04ch
    int 21h
main endp
Print proc
  pushReg
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
popReg
Ret
Print endp
end