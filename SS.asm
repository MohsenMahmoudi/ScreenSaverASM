; multi-segment executable file template.

data segment
    ; add your data here!
    pkey db "press any key...$"
    outchar db 0
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    ;mov es, ax

    ; add your code here
    xor dx,dx
    xor bx,bx
    mov bl,11 
    xor si,si

    
print:
    mov ah,01
    int 16h
    jnz return_to_os
    
    cmp dl,80
    jnge skip
    
    xor dl,dl
    inc dh
    dec bl
    mov ah,86h

    mov cx,0aFh
    int 15h

    cmp dh,25
    jnge skip
    
    xor dx,dx

    skip: 
    
     
    mov ah,2
    int 10h
    
    inc si 
    mov cl,[si]
    cmp cl,0
    jne s
    
    call random 
    
    s: 
    mov     al, cl
    mov     cx, 1
    mov     ah, 09h
    int     10h
    
    
    
    inc dl      
    jmp print
     
       
    lea dx, pkey
    mov ah, 9
    int 21h        ; output string at ds:dx
    
    return_to_os:
    ; wait for any key....    
    mov ah, 1
    int 21h
    
    mov ax, 4c00h ; exit to operating system.
    int 21h    
ends
proc random
   push bx
   push dx
   push ax
   mov ah,0
   int 1ah
   mov cl,dl
   pop ax
   pop dx
   pop bx
   ret 
endp
end start ; set entry point and stop the assembler.
