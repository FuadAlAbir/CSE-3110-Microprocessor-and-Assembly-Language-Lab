; DATE: 17 JULY 2019 

; INPUT : Two 8 bit hexadecimal number
; OUTPUT: multiplication of them (w/o using MUL or IMUL)
; SAMPLE INPUT/OUTPUT
    ; INPUT : 02 05
    ; OUTPUT: 0000000000001010
    
.MODEL SMALL
.STACK 100H
.DATA 
    _P DB 0 
    ; FIRST INPUT: BX
    ; SECOND INPUT:DX

.CODE
MAIN PROC
    MOV AX, @DATA        
    MOV DS, AX
        
    XOR BL, BL       
    MOV CL, 4      

    MOV AH, 1              

    _FIRST_INPUT:
        INT 21H
        CMP AL, 20H
                
        JE _END_FIRST_INPUT    

        CMP AL, 41H  
        JGE _CHARACTER
              
        AND AL, 0FH   
        JMP _LEFT_SHIFT
        
    _CHARACTER:          
        SUB AL, 37H
                
    _LEFT_SHIFT:
        SHL BX, CL    
        OR  BL, AL     
        JMP _FIRST_INPUT
            
    _END_FIRST_INPUT:
        XOR DL, DL   
        MOV AH, 1 
             
    _SECOND_INPUT:          
        INT 21H    
        CMP AL, 0DH
        JE _END_SECOND_INPUT
         
        CMP AL, 41H
        JGE _CHARACTER_2
          
        AND AL, 0FH
        JMP _LEFT_SHIFT_2
          
    _CHARACTER_2:
        SUB AL, 37H
       
    _LEFT_SHIFT_2:
        SHL DX, CL
        OR  DL, AL
        JMP _SECOND_INPUT
      
   
    _END_SECOND_INPUT:
        
        MOV CX, DX

        MOV AH, 2
        MOV DL, 0AH
        INT 21H
        MOV DL, 0DH
        INT 21H
        
        MOV DX, CX
    
    XOR BH, BH
    MOV _P, 0
    XOR CX, CX
    
    _MULTIPLY: 
        ; TWO INP IS IN BL, DL
        ; OUTPUT TO BE STORED AT BL
        CMP _P, 8
        JE _MULTIPLY_END
        
        SHR DL, 1
        JC _SUM_INP1
        JNC _JUST_SHIFT
        
        
         _SUM_INP1:
            ; ADD BH, BL
            ADD CX, BX 
         _JUST_SHIFT:
            SHL BX, 1
            ADD _P, 1
            JMP _MULTIPLY
            
    _MULTIPLY_END:
        ; JC _CARRY_ONE
    
    ; MOV BL, BH  
                  
    MOV DH, 0   
    _OUTPUT_SUM:
        CMP DH, 16
        JE _EXIT
                               
        ROL CX, 1
        JC _PRINT_ONE
        JNC _PRINT_ZERO
        
     _PRINT_ONE:               
        MOV DL, 31H
        MOV AH, 2
        INT 21H
        ADD DH, 1
        JMP _OUTPUT_SUM
        
     _PRINT_ZERO:                 
        MOV DL, 30H
        MOV AH, 2
        INT 21h
        ADD DH, 1
        JMP _OUTPUT_SUM
        
     _CARRY_ONE:       
        MOV DL, 31H
        MOV AH, 2
        INT 21H
        JMP _OUTPUT_SUM
        
     _EXIT:
        MOV AH, 4CH
        INT 21H 
        
MAIN ENDP
END MAIN 
                         


 
