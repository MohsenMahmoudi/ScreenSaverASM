; multi-segment executable file template.

data segment
    ; add your data here!
    i dw 0
    color db 0
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:
    mov ax, data
    mov ds, ax
    mov es, ax

    ; add your code here
    mov al, 13h
	mov ah, 0
	int 10h
    
again:
    mov i,0
    mainfor:
        mov dx,i         
        mov cx,i 
        
       
        for1:
        inc dx
        mov ax,200
        sub ax,i
        cmp dx,ax
        jge for2 
        mov al, color
        mov ah, 0ch
        int 10h
        jmp for1
        
        
        for2:
        inc cx
        mov ax,320
        sub ax,i
        cmp cx,ax
        jg for3
        mov al, color
    	mov ah, 0ch
    	int 10h 
        jmp for2

        
        for3:
        dec dx
        cmp dx,i
        jbe for4
        mov al, color
    	mov ah, 0ch
    	int 10h
        jmp for3
  
        for4:
        dec cx
        cmp cx,i
        jbe skip   
        mov al,color
    	mov ah, 0ch
    	int 10h  
    	jmp for4

    	
    	skip:
    	
    	mov ah,01h
        int 16h
        jnz exit 
    	
        MOV     AH, 00H
        INT     1AH 
        add dx,01h;delay time
        mov frst,dx
        TIMER:
        MOV     AH, 00H
        INT     1AH
        CMP     DX,frst
        JB      TIMER
    	
    inc i                          
    cmp i,200
    jb mainfor
inc color    
mov ah,01h
int 16h
jz again                              
                              
exit:
    mov ax, 4c00h ; exit to operating system.
    int 21h  

      
ends


DELAY PROC 
    frst dw ?

    RET
DELAY ENDP

end start ; set entry point and stop the assembler.
