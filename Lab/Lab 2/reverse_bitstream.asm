; DATE: 03 JULY 2019 

; INPUT : Bitstring of length 8 
; OUTPUT: Bitstring of length 8 - reverse of INPUT
; SAMPLE INPUT/OUTPUT
    ; INPUT : 11010110
    ; OUTPUT: 01101011
    
.MODEL SMALL
.STACK 100H
.DATA
.CODE

MAIN PROC
    
    XOR BL, BL
    
    MOV AH, 1
    MOV CX, 8
    _INPUT_BITSTRING:
        INT 21H
        SUB AL, 30H
        SHL BL, 1
        OR BL, AL
        LOOP _INPUT_BITSTRING
        
    MOV AH, 2
    MOV DL, 0DH
    INT 21H
    MOV DL, 0AH
    INT 21H
    
    MOV CX, 8    
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

    _END:
    MOV AH, 4CH
    INT 21H 
    
    MAIN ENDP
END MAIN
