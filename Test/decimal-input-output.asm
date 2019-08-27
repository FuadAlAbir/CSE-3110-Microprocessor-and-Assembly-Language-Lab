;INCLUDE 'EMU8086.INC'
.MODEL SMALL
.STACK 100H  
.DATA     
    iSTR_1 DB 'FIRST DECIMAL:$'
    iSTR_2 DB 'SECOND DECIMAL:$'
    oSTR_T DB 'TOTAL:$'
    oSTR_O DB 'OUTPUT:$'
    oSTR_B DB 'BINARY:$'
    
    INPUT1 DB 0
    INPUT2 DB 0
    SUM DB 0
    PUSH_C DB 0
    INP1_C DB 0
    INP2_C DB 0
    COUNT DB 0
    TEN DB 10
    
.CODE    

PRINT_LINE PROC

    
PRINT_LINE ENDP

MAIN PROC     
    MOV AX, @DATA
    MOV DS, AX 
    
    MOV AH, 9
    LEA DX, iSTR_1
    INT 21H
    
    XOR CX, CX
    XOR DX, DX
     
    _FIRST_INPUT:
        MOV AH, 1
        INT 21H
        CMP AL, 0DH
        JZ _END_FIRST_INPUT
        SUB AL, 48
        MOV INPUT1, AL
        MOV AL, TEN
        MUL DL
        ADD AL, INPUT1
        MOV DL, AL
        MOV INPUT1, DL
        INC INP1_C
        JMP _FIRST_INPUT
    _END_FIRST_INPUT: 
    
    MOV AH, 2
    MOV DL, 0DH
    INT 21H
    MOV DL, 0AH
    INT 21H

    MOV DL, INPUT1
    MOV AH, 2
    INT 21H
    
    MOV AH, 2
    MOV DL, 0DH
    INT 21H
    MOV DL, 0AH
    INT 21H
    
    MOV AH, 9
    LEA DX, iSTR_2
    INT 21H
    
    XOR CX, CX
    XOR DX, DX
    
 
    _SECOND_INPUT:
        MOV AH, 1
        INT 21H
        CMP AL, 0DH
        JZ _END_SECOND_INPUT 
        SUB AL, 48
        MOV INPUT2, AL
        MOV AL, TEN
        MUL DL
        ADD AL, INPUT2
        MOV DL, AL
        MOV INPUT2, DL
        INC INP2_C
        JMP _SECOND_INPUT
    _END_SECOND_INPUT:
        MOV AH, 2
        MOV DL, 0DH
        INT 21H
        MOV DL, 0AH
        INT 21H
        
        MOV DL, INPUT2
        MOV AH, 2
        INT 21H
        
        MOV AH, 2
        MOV DL, 0DH
        INT 21H
        MOV DL, 0AH
        INT 21H
    
    MOV AH, 9
    LEA DX, oSTR_T
    INT 21H  
    MOV BH, INPUT1
    MOV BL, INPUT2
    ADD BH, BL 
    MOV SUM, BH
    MOV DL, BH
    
    MOV AH, 2
    INT 21H
    
    MOV AH, 2
    MOV DL, 0DH
    INT 21H
    MOV DL, 0AH
    INT 21H 
    
    MOV AH, 9
    LEA DX, oSTR_B
    INT 21H
             
    MOV AH, 2
    MOV DL, 0DH
    INT 21H
    MOV DL, 0AH
    INT 21H
    
  
    
    XOR BX, BX
    MOV BL, SUM
    MOV CL, 8
    _OUTPUT_BITSTRING:
        SHL BL, 1    
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



DECIMAL_OUTPUT PROC  
    MOV AH, 9
    LEA DX, oSTR_O
    INT 21H 
    
    XOR CX, CX
    MOV AH, INP1_C
    MOV AL, INP2_C
    ADD AH, AL
    MOV COUNT, AH
    MOV CL, COUNT 
    
    MOV BL, 10
    XOR AH, AH
    MOV AL, INPUT2
    
    FOR_PUSH:
        DIV BL
        XOR DX, DX
        MOV DL, AH
        ADD DL, 48
        PUSH DX
        INC PUSH_C
        LOOP FOR_PUSH
    
    XOR CX, CX
    MOV CL, PUSH_C
    MOV AH, 2
    
    FOR_POP:
        POP DX
        INT 21H
        LOOP FOR_POP
        
    RET
DECIMAL_OUTPUT ENDP

END MAIN 



///

;INCLUDE 'EMU8086.INC'
.MODEL SMALL
.STACK 100H  
.DATA     
    iSTR_1 DB 'FIRST DECIMAL:$'
    iSTR_2 DB 'SECOND DECIMAL:$'
    oSTR_T DB 'TOTAL:$'
    oSTR_O DB 'OUTPUT:$'
    oSTR_B DB 'BINARY:$'
    
    INPUT1 DB 0
    INPUT2 DB 0
    SUM DB 0
    PUSH_C DB 0
    INP1_C DB 0
    INP2_C DB 0
    COUNT DB 0
    TEN DB 10
    
.CODE    

PRINT_LINE PROC

    
PRINT_LINE ENDP

MAIN PROC     
    MOV AX, @DATA
    MOV DS, AX 
    
    MOV AH, 9
    LEA DX, iSTR_1
    INT 21H
    
    XOR CX, CX
    XOR DX, DX
     
    _FIRST_INPUT:
        MOV AH, 1
        INT 21H
        CMP AL, 0DH
        JZ _END_FIRST_INPUT
        SUB AL, 48
        MOV INPUT1, AL
        MOV AL, TEN
        MUL DL
        ADD AL, INPUT1
        MOV DL, AL
        MOV INPUT1, DL
        INC INP1_C
        JMP _FIRST_INPUT
    _END_FIRST_INPUT: 
    
    MOV AH, 2
    MOV DL, 0DH
    INT 21H
    MOV DL, 0AH
    INT 21H

    MOV DL, INPUT1
    MOV AH, 2
    INT 21H
    
    MOV AH, 2
    MOV DL, 0DH
    INT 21H
    MOV DL, 0AH
    INT 21H 
    
    MOV BL, INP1_C
    MOV COUNT, BL       
    CALL DECIMAL_OUTPUT
           
    MOV AH, 2
    MOV DL, 0DH
    INT 21H
    MOV DL, 0AH
    INT 21H
    
    MOV AH, 9
    LEA DX, iSTR_2
    INT 21H
    
    XOR CX, CX
    XOR DX, DX
    
 
    _SECOND_INPUT:
        MOV AH, 1
        INT 21H
        CMP AL, 0DH
        JZ _END_SECOND_INPUT 
        SUB AL, 48
        MOV INPUT2, AL
        MOV AL, TEN
        MUL DL
        ADD AL, INPUT2
        MOV DL, AL
        MOV INPUT2, DL
        INC INP2_C
        JMP _SECOND_INPUT
    _END_SECOND_INPUT:
        MOV AH, 2
        MOV DL, 0DH
        INT 21H
        MOV DL, 0AH
        INT 21H
        
        MOV DL, INPUT2
        MOV AH, 2
        INT 21H
        
        MOV AH, 2
        MOV DL, 0DH
        INT 21H
        MOV DL, 0AH
        INT 21H
        
        MOV DL, INPUT2
        MOV INPUT1, DL
        MOV BL, INP2_C
        MOV COUNT, BL       
        CALL DECIMAL_OUTPUT
               
        MOV AH, 2
        MOV DL, 0DH
        INT 21H
        MOV DL, 0AH
        INT 21H
        
    MOV AH, 9
    LEA DX, oSTR_T
    INT 21H  
    MOV BH, INPUT1
    MOV BL, INPUT2
    ADD BH, BL 
    MOV SUM, BH
    MOV DL, BH
    
    MOV AH, 2
    INT 21H
    
    MOV AH, 2
    MOV DL, 0DH
    INT 21H
    MOV DL, 0AH
    INT 21H 
    
    MOV AH, 9
    LEA DX, oSTR_B
    INT 21H
             
    MOV AH, 2
    MOV DL, 0DH
    INT 21H
    MOV DL, 0AH
    INT 21H
    
  
    
    XOR BX, BX
    MOV BL, SUM
    MOV CL, 8
    _OUTPUT_BITSTRING:
        SHL BL, 1    
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



DECIMAL_OUTPUT PROC     ; CHANGE INPUT1, COUNT ACCORDINGLY  
    MOV AH, 9
    LEA DX, oSTR_O
    INT 21H 
    
    XOR CX, CX
;    MOV AH, INP1_C
;    MOV AL, INP2_C
;    ADD AH, AL
;    MOV COUNT, AH
    MOV CL, COUNT 
    
    MOV BL, TEN
    XOR AH, AH
    MOV AL, INPUT1
    
    FOR_PUSH:
        DIV BL
        XOR DX, DX
        MOV DL, AH
        ADD DL, 48
        PUSH DX
;        INC PUSH_C
        LOOP FOR_PUSH
    
    XOR CX, CX
    ;MOV CL, PUSH_C
    MOV CL, COUNT
    MOV AH, 2
    
    FOR_POP:
        POP DX
        INT 21H
        LOOP FOR_POP
        
    RET
DECIMAL_OUTPUT ENDP

END MAIN 
