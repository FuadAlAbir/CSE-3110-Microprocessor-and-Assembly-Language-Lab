; Author    : Fuad Al Abir
; Date      : 12 Nov 2019
; 2018_Q7_c : Sample Output:
;             Enter String: 123ABC4
;             Digits: 1234
;             Letters: ABC

.MODEL SMALL
.STACK 100h
.DATA
INP_PROMPT db 'Enter String: $'
OUT_PROMPT_DIGIT db 'Digits: $'
OUT_PROMPT_LETTER db 'Letters: $'
STR db 100 DUP ('$') 
NEWLINE db 0Ah, 0Dh, '$' 

MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX
    
    LEA DX, INP_PROMPT
    MOV AH, 9
    INT 21h
    
    LEA SI, STR
    
    _INP:
    MOV AH, 1
    INT 21h
    CMP AL, 0Dh
    JE _INP_END
    MOV [SI], AL
    INC SI
    JMP _INP
    
    _INP_END:
    LEA DX, NEWLINE
    MOV AH, 9
    INT 21h
    
    LEA DX, OUT_PROMPT_DIGIT
    MOV AH, 9
    INT 21h
    
    LEA SI, STR
    
    _DIGIT:
    MOV DX, [SI]
    CMP DL, '$'
    JE _DIGIT_END
    CMP DL, 39h
    JBE _PRINT_DIGIT
    JA _ELSE1
    
    _PRINT_DIGIT:
    MOV AH, 2
    INT 21h
    _ELSE1:
    INC SI
    JMP _DIGIT
    
    _DIGIT_END:
    LEA DX, NEWLINE
    MOV AH, 9
    INT 21h
    
    LEA DX, OUT_PROMPT_LETTER
    MOV AH, 9
    INT 21h    
    
    LEA SI, STR
    
    _LETTER:
    MOV DX, [SI]
    CMP DL, '$'
    JE _LETTER_END
    CMP DL, 39h
    JAE _PRINT_LETTER
    JB _ELSE2
    
    _PRINT_LETTER:
    MOV AH, 2
    INT 21h
    _ELSE2:
    INC SI
    LOOP _LETTER
    
    _LETTER_END:
    MOV AH, 4Ch
    INT 21h
    
    MAIN ENDP
END MAIN
