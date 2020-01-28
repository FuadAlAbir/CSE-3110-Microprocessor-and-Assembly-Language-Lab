.MODEL SMALL
.STACK 100H
.DATA
.CODE
MAIN PROC  
    
    MOV AH, 1
    INT 21H  
           
    ;MOV AH, 2
    ;MOV DL, 0DH
    ;INT 21H  
    ;MOV DL, 0AH
    ;INT 21H
           
    MOV AH, 2
    MOV DL, AL
    ;SUB DL, 20H
    INT 21H
    
    MOV AH, 4CH
    INT 21H
    
    MAIN ENDP
END MAIN