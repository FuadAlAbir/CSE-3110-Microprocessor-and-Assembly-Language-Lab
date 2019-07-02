; DATE: 02 JULY 2019 

; INPUT [string]: N/A
; OUTPUT [string]: 8-bit converted binary string from a hard-coded decimal

; SAMPLE INPUT/OUTPUT
    ; INPUT: N/A
    ; OUTPUT: 11111010
    
.MODEL SMALL
.STACK 100H
.DATA         
.CODE
    
MAIN PROC    
    
    MOV BL, 250
    MOV AH, 2 
    MOV CX, 8 
      
    _PRINT_8_BIT_REGISTER:
        SHL BL, 1
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
        
        
    MOV AH, 4CH
    INT 21H         
    
    MAIN ENDP
END MAIN
