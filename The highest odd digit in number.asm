;;Get a 16 bit number from user and display the largest odd digit in the number.
;;;Sol:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
char_out macro
  mov ah,02h
  int 21h
endM
char_in macro
  mov ah,01h
  int 21h
endM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.model samll
.stack 100h
.data
  preNo db 0
  currNo db 0
  greater db 0
  divide db 2
  zero db 0
  str1 db "The highest odd number in digit is : ","$"
.code
main proc
  mov ax,@data
  mov ds,ax 
;;;;;;;;;;;;;;;;;;;;;;;;;;;      
  call Input_Check_Odd ;;; Input 16 bit number
  lea dx,str1
  str
  mov dl,greater
  add dl,48
  char_out
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  mov ah,04ch
  int 21h
main endp 
Input_Check_Odd proc
  pushRegs
    mov preNo,0
    mov currNo,0
    
    mov bl,10   ;;; For the purpose of 10 Multiply
InputAgain:    
    char_in   ;;Input 

    cmp al,0dh
    je endInput
    sub al,48

    mov ah,0h  ;; 0 Initialize
    mov currNo,al
    ;;;;; Highest Odd 

    cmp al , greater
    jl continue
    
    div divide

    cmp ah,zero
    je continue
    mov al,currNo
    mov greater,al
    
    ;;;;;;;;;;;;
  continue:
    mov al,preNo
    mov dx,0h  ;; 0 Initialize
    mul bl
    add al,currNo 
    mov preNo,al
    jmp InputAgain
endInput:
popRegs
Ret
Input_Check_Odd endp
end 