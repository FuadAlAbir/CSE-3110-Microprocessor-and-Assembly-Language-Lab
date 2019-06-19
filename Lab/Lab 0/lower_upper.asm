.MODEL SMALL
.STACK 100H
.DATA
    iSTR DB 'ENTER A CHARACTER:$'
    oSTR DB 'CHARACTER SHIFT:$'
    
.CODE
MAIN PROC
    MOV AX, @DATA       ; load data
    MOV DS, AX
    
    MOV AH, 9           ; input string prompt
    LEA DX, iSTR
    INT 21H
    
    MOV AH, 1           ; character input
    INT 21H    
    MOV BL, AL          ; storing the character
    
    MOV AH, 2           ; new line
    MOV DL, 0DH
    INT 21H
    MOV DL, 0AH
    INT 21H
    
    MOV AH, 9           ; output string tag
    LEA DX, oSTR
    INT 21H              
    
    CMP BL, 61H         ; comparing character if it is lower case or not
    JB _print_lower     ; if BL is UPPER, it executes JB   
    
    _print_upper:
        SUB BL, 20H       
        JMP _rest
        
    _print_lower:
        ADD BL, 20H
        
    _rest:  
        MOV AH, 2        ; character output mode
        MOV DL, BL       ; load toggled character to DL
        INT 21H
        
        MOV AH, 4CH      ; return to DOS
        INT 21H     

    MAIN ENDP
END MAIN