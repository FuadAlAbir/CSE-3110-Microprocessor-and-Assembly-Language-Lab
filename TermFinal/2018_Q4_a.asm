
; 2018_Q4_a: 

; Author    : Fuad Al Abir
; Date      : 27 Oct 2019
; 2018_Q4_a : Write an assembly program to determine
;             the smallest number among three decimal numbers.

.MODEL SMALL
.STACK 100h
.DATA
.CODE
MAIN PROC
    
    MOV BL, 5       ; Let, BL holds the smallest
    MOV BH, 7
    MOV CH, 3
    
    _first_cmp:
    CMP BL, BH
    JLE _second_cmp
    MOV BL, BH      ; if BH < BL
    
    _second_cmp:
    CMP BL, CH
    JLE _print_smallest
    MOV BL, CH
    
    _print_smallest:
    MOV AH, 2
    MOV DL, BL
    ADD DL, 30h     ; printing ASCII char of decimal
    INT 21h
    
    MOV AH, 4Ch
    INT 21h
    
    MAIN ENDP
END MAIN
