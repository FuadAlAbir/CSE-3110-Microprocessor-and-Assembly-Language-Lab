; Author    : Fuad Al Abir
; Date      : 27 Oct 2019
; 2018_Q6_c : Write an assembly language program that demonstrate
;             the use of based indexed addressing mode. Use necessary
;             comments to clarify the code.

.MODEL SMALL
.STACK 100h
.DATA
.CODE
MAIN PROC
    
    MOV [0FF10h], 6162h   ; store values (ab as ASCII char) in address FF10
    MOV BX, 0FF00h        ; setting BX and SI to invoke the address FF10
    MOV SI, 0010h         ; in Based-indexed addressing mode    
                          
    MOV CX, [BX + SI]     ; BASED INDEXED ADDRESSING MODE
                          ; MOV the value stored at address [BX + SI] = FF10 to CX
                          
    MOV AH, 2
    MOV DL, CH
    INT 21h               ; print the high part, CH = a = 61h
    MOV DL, CL
    INT 21h               ; print the low part,  CL = b = 62h

    _exit:
    MOV AH, 4Ch
    INT 21h
    
    MAIN ENDP
END MAIN
