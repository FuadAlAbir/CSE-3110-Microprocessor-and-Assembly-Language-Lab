 
; DATE: 02 JULY 2019 

; INPUT  [string]: 8-bit binary string
; OUTPUT [string]: 8-bit binary string [reversed]

; SAMPLE INPUT/OUTPUT
    ; INPUT:  11001001
    ; OUTPUT: 10010011
    
.MODEL SMALL
.STACK 100H
.DATA         
    iSTR DB ' Input:$'
    oSTR DB 'Output:$'
    var DB 0

.CODE
MAIN PROC    
    MOV AX, @DATA
    MOV DS, AX 
    
    MOV AH, 9
    LEA DX, iSTR                    ; INPUT_PROMPT                           
    INT 21H
                 
    XOR BL, BL                      ; XOR BX, BX
    XOR BH, BH
    
    CMP var, 1
    JE _END
    
    MOV AH, 1
    MOV CX, 8
    MOV var, 1
    _BI_INPUT:
        INT 21H
        SUB AL, 48
        SHL BL, 1
        OR BL, AL
        
    LOOP _BI_INPUT

    MOV AH, 2
    MOV DL, 0DH
    INT 21H
    MOV DL, 0AH
    INT 21H  
    
    MOV CX, 8
    _REVERSING:
        SHL BL, 1
        RCR BH, 1
        LOOP _REVERSING
        
    MOV AH, 9
    LEA DX, oSTR                    ; OUTPUT_PROMPT                           
    INT 21H
    
    MOV AH, 2
    MOV CX, 8   
    _PRINT_8_BIT_REGISTER:
        SHL BH, 1
        JC _PRT_1
        JNC _PRT_0
        _PRT_1:
            MOV DL, 1
            JMP _EXECUTE
        _PRT_0:
            MOV DL, 0
        _EXECUTE:
            ADD DL, 48
            INT 21H
            
        LOOP _PRINT_8_BIT_REGISTER
         
    _END:
    MOV AH, 4CH
    INT 21H         
    
    MAIN ENDP
END MAIN
