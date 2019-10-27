; Author    : Fuad Al Abir
; Date      : 27 Oct 2019
; 2018_Q7_a : Suppose the following string has been declared:
;             STRING1 DB "THIS IS A STRING"
;             STRING2 DB 11 DUP(?)
;             Write some code that will couse STRING1 to be copied into
;             STRING2 with the blank characters removed.


.MODEL SMALL
.DATA
STRING1 DB "THIS IS A STRING$"  
STRING2 DB 11 DUP(?)                    

.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    MOV ES,AX
    LEA SI,STRING1
    LEA DI,STRING2                  
    MOV CX, 11h
    
    _loop:
    MOV BL, [SI]
    CMP BL, ' '
    JZ _space
    
    MOV [DI], BL
    INC SI
    INC DI
    DEC CX
    JNZ _loop
    JMP _print
    
    _space:
    INC SI
    DEC CX
    JNZ _loop
    
    _print:
    LEA DX, STRING2
    MOV AH, 9
    INT 21H
    
    MOV AH,4CH
    INT 21H

    MAIN ENDP
END MAIN
