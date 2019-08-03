.MODEL SMALL
.STACK 100H  
.DATA
    var dw 40 DUP(?)
.CODE
MAIN PROC     
    MOV AX, @DATA
    MOV DS, AX 
    
    
    MOV SI, offset var
    XOR CX, CX
    XOR BX, BX
    
    _INPUT:
        MOV AH, 1
        INT 21H
        CMP AL, 20H
        JE _SPACED
        CMP AL, 0DH
        JE _ENTERED
        
        XOR DX, DX
        MOV DL, AL
        PUSH DX
        INC CL
        INC BL
        JMP _INPUT
        

    
        
    _SPACED:
        INC BX
        XOR DX, DX
        POP DX
        MOV var[SI], DX
        ADD SI, 2
        LOOP _SPACED
        MOV var[SI], 20H
        
        XOR CX, CX
        ADD SI, 2
        JMP _INPUT
        
        
        
    _ENTERED:
    INC BX
    MOV AH, 2
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H 
    
    XOR CX, CX
    MOV CX, BX
    MOV SI, offset var
    
    _PRINT:
    MOV DX, [SI]
    ADD SI, 2
    INT 21H
    LOOP _PRINT
                   
    MOV AH, 4CH
    INT 21H 
        
    
        
MAIN ENDP
END MAIN 
