; Author    : Fuad Al Abir
; Date      : 27 Oct 2019
; 2018_Q4_c : Write an assembly language program to display
;             a 5x5 grid of "*"

.MODEL SMALL
.STACK 100h
.DATA
.CODE
MAIN PROC    
    
    MOV AH, 2
    MOV BL, 5           ; five_rows    
    MOV CX, 5           ; five_cols                
    
    _print_asterix:
        MOV DL, '*'                    
        INT 21h         ; printing_single_* 
        
        CMP CX, 1
        JNZ _loop
        MOV DL, 0AH
        INT 21H
        MOV DL, 0DH
        INT 21H
        
        DEC BL
        CMP BL, 0
        JZ _5x5_done
        MOV CX, 6
        
        _loop:
            LOOP _print_asterix     ; When CX is 6 and get LOOPed
                                    ; 1 decrements immediately.
                                    ; That's why 6 is used.
        
    _5x5_done:
    MOV AH, 4Ch
    INT 21h
    
    MAIN ENDP
END MAIN
