;-------------------------------------------------------
;       WORD BY WORD STRING REVERSE WITH PROCEDURE
;-------------------------------------------------------

;.MODEL SMALL
;.STACK 100H  
;.DATA
;    var dw 40 DUP(?)
;.CODE
;MAIN PROC     
;    MOV AX, @DATA
;    MOV DS, AX 
;    
;    
;    MOV SI, offset var
;    XOR CX, CX
;    XOR BX, BX
;    
;    _INPUT:
;        MOV AH, 1
;        INT 21H
;        CMP AL, 20H
;        JE CALL _STORE_REVERSED_WORD
;        CMP AL, 0DH
;        JE _END_INPUT
;        
;        XOR DX, DX
;        MOV DL, AL
;        PUSH DX
;        INC CL
;        INC BL
;        JMP _INPUT   
;    
;    _END_INPUT:
;    INC BX
;    
;    CALL _NEW_LINE
;    
;    XOR CX, CX
;    MOV CX, BX
;    MOV SI, offset var
;    
;    CALL _PRINT_REVERSE
;                  
;    MOV AH, 4CH
;    INT 21H 
;         
;MAIN ENDP
;
;_NEW_LINE PROC
;    MOV AH, 2
;    MOV DL, 0AH
;    INT 21H
;    MOV DL, 0DH
;    INT 21H
;    RET
;_NEW_LINE ENDP
;
;_PRINT_REVERSE PROC
;    _PRINT:
;        MOV DX, [SI]
;        ADD SI, 2
;        INT 21H
;        LOOP _PRINT
;        RET
;_PRINT_REVERSE ENDP
;
;_STORE_REVERSED_WORD PROC
;    _SPACED:
;        INC BX
;        XOR DX, DX
;        POP DX
;        MOV var[SI], DX
;        ADD SI, 2
;        LOOP _SPACED
;    MOV var[SI], 20H
;    
;    XOR CX, CX
;    ADD SI, 2
;    JMP _INPUT
;    RET
;_STORE_REVERSED_WORD ENDP
;
;END MAIN            
     
    
;----------------------------------------------------------
;       WORD BY WORD STRING REVERSE WITHOUT PROCEDURE
;----------------------------------------------------------   


;.MODEL SMALL
;.STACK 100H  
;.DATA
;    var dw 40 DUP(?)
;.CODE
;MAIN PROC     
;    MOV AX, @DATA
;    MOV DS, AX 
;    
;    
;    MOV SI, offset var
;    XOR CX, CX
;    XOR BX, BX
;    
;    _INPUT:
;        MOV AH, 1
;        INT 21H
;        CMP AL, 20H
;        JE _SPACED
;        CMP AL, 0DH
;        JE _ENTERED
;        
;        XOR DX, DX
;        MOV DL, AL
;        PUSH DX
;        INC CL
;        INC BL
;        JMP _INPUT
;        
;
;    
;        
;    _SPACED:
;        INC BX
;        XOR DX, DX
;        POP DX
;        MOV var[SI], DX
;        ADD SI, 2
;        LOOP _SPACED
;        MOV var[SI], 20H
;        
;        XOR CX, CX
;        ADD SI, 2
;        JMP _INPUT
;        
;        
;        
;    _ENTERED:
;    INC BX
;    MOV AH, 2
;    MOV DL, 0AH
;    INT 21H
;    MOV DL, 0DH
;    INT 21H 
;    
;    XOR CX, CX
;    MOV CX, BX
;    MOV SI, offset var
;    
;    _PRINT:
;    MOV DX, [SI]
;    ADD SI, 2
;    INT 21H
;    LOOP _PRINT
;                   
;    MOV AH, 4CH
;    INT 21H 
;        
;    
;        
;MAIN ENDP
;END MAIN             

           
;-------------------------------------------------------
;       WHOLE STRING REVERSE WITH PROCEDURE
;-------------------------------------------------------           
           
;.MODEL SMALL
;.STACK 100H  
;.DATA
;.CODE
;MAIN PROC         
;    XOR CX, CX
;    XOR BX, BX
;    
;    _INPUT:
;        MOV AH, 1
;        INT 21H
;        CMP AL, 0DH
;        JE _END_INPUT
;        XOR DX, DX
;        MOV DL, AL
;        PUSH DX
;        INC CL
;        JMP _INPUT
;    
;    _END_INPUT:
;        CALL _NEW_LINE  
;        CALL _REVERSE
;       
;    MOV AH, 4CH
;    INT 21H 
;MAIN ENDP
;
;_NEW_LINE PROC
;    MOV AH, 2
;    MOV DL, 0AH
;    INT 21H
;    MOV DL, 0DH
;    INT 21H
;    RET
;_NEW_LINE ENDP
;
;_REVERSE PROC
;    POP DX
;    _PRINT: 
;    POP DX
;    INT 21H
;    lOOP _PRINT
;_REVERSE ENDP
;
;END MAIN         



;-------------------------------------------------------
;       WHOLE STRING REVERSE WITHOUT PROCEDURE
;-------------------------------------------------------
.MODEL SMALL
.STACK 100H  
.DATA
.CODE
MAIN PROC         
    XOR CX, CX
    XOR BX, BX
    
    _INPUT:
        MOV AH, 1
        INT 21H
        CMP AL, 0DH
        JE _ENTERED
        
        XOR DX, DX
        MOV DL, AL
        PUSH DX
        INC CL
        JMP _INPUT
    
    _ENTERED:
    MOV AH, 2
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H 
    
    _PRINT:
    POP DX
    INT 21H
    LOOP _PRINT
                   
    MOV AH, 4CH
    INT 21H 
      
MAIN ENDP 
END MAIN 

