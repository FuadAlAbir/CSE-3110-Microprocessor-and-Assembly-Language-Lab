; DATE: 26 JUNE 2019 

; INPUT [string]: a-z, A-Z, * at the end of the string
; OUTPUT [string]: first UPPER character followed by the last UPPER character
; SAMPLE INPUT/OUTPUT
    ; INPUT: aABccCPp*
    ; OUTPUT: AP
    
.MODEL SMALL
.STACK 100H
.DATA         
    iSTR DB 'Input:$'
    oSTR DB 'Output:$'
    var DB 0

.CODE
MAIN PROC    
    MOV AX, @DATA
    MOV DS, AX 
    
    MOV AH, 9
    LEA DX, iSTR                    ; INPUT_PROMPT                           
    INT 21H
    
    _INPUT_STRING:
        MOV AH, 1
        INT 21H   
            
        CMP AL, 2AH                 ; IF *, BREAK 
        JZ _BREAK
        
        CMP AL, 5AH
        JBE _UPPER_CHAR
        JMP _INPUT_STRING
        _UPPER_CHAR: 
            MOV CL, AL              ; LAST_UPPER: CL   
            CMP var, 0
            JZ _FIRST_CHAR
            JMP _INPUT_STRING
            _FIRST_CHAR:
                MOV CH, AL          ; FIRST_UPPER: CH
                MOV var, 1
                JMP _INPUT_STRING
            JMP _INPUT_STRING
    
     
     
    _BREAK:  
    MOV AH, 2           ; new line
    MOV DL, 0DH
    INT 21H
    MOV DL, 0AH
    INT 21H 
            
    MOV AH, 9           ; OUTPUT_PROMPT
    LEA DX, oSTR                           
    INT 21H
    MOV AH, 2
    MOV DL, CH          ; FIRST_CHAR
    INT 21H                   
    
    MOV AH, 2 
    MOV DL, CL          ; LAST_CHAR
    INT 21H

    
    MOV AH, 4CH
    INT 21H         
    
    MAIN ENDP
END MAIN