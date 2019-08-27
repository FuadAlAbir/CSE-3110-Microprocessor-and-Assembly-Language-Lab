; DATE: 07 AUGUST 2019 

; INPUT : 3 digit decimal number
; OUTPUT: binary equivalent in reverse order
; SAMPLE INPUT/OUTPUT
    ; INPUT : 032
    ; OUTPUT: 00000100

.MODEL SMALL
.STACK 100H
.DATA
    iSTR DB 'INPUT:$'     
    oSTR DB 'OUTPUT:$'
    INPUT DB 0

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    _INPUT_PROMPT:
        MOV AH, 9
        LEA DX, iSTR
        INT 21H
        
    XOR CX, CX
    XOR DX, DX
    
    _INPUT_DECIMAL:
        MOV AH, 1
        INT 21H
        CMP AL, 0DH
        JZ _END_INPUT
        SUB AL, 48
        MOV INPUT, AL
        MOV AL, 10
        MUL DL
        ADD AL, INPUT
        MOV DL, AL
        MOV INPUT, DL
        JMP _INPUT_DECIMAL
    _END_INPUT: 
    
    MOV AH, 2
    MOV DL, 0DH
    INT 21H
    MOV DL, 0AH
    INT 21H

    _OUTPUT_PROMPT:
        MOV AH, 9
        LEA DX, oSTR
        INT 21H
        
    MOV AH, 2 
    MOV CX, 8
    XOR BX, BX
    MOV BL, INPUT    
    _OUTPUT_BITSTRING:
        SHR BL, 1    
        JC _STORE_ONE
        JNC _STORE_ZERO
        _STORE_ONE:
            MOV DL, 31H
            JMP _PRINT
        _STORE_ZERO:
            MOV DL, 30H
        _PRINT:
            INT 21H
            LOOP _OUTPUT_BITSTRING

    MOV AH, 4CH
    INT 21H

MAIN ENDP

END MAIN 
