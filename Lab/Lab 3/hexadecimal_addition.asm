.MODEL SMALL
.STACK 100H
.DATA 
    _P DB 0

.CODE
MAIN PROC
    MOV AX,@DATA        
    MOV DS,AX
        
    XOR BX,BX       
    MOV CL,4      

    MOV AH,1              

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
        XOR DX, DX   
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
        XOR CX, CX    
    
    MOV _P, 0    
    _REVERSE:
        CMP _P, 16
        JE _SUM_SEGMENT
        
        ROL DX, 1
        RCR CX, 1
        ADD _P, 1
        JMP _REVERSE 
                                      
    _SUM_SEGMENT:
        ;ADD BX, DX          ; ORIGINAL HEX - DX
        ADD BX, CX           ; REVERSED HEX - CX
        JC _CARRY_ONE
                   
    MOV DH, 0   
    _OUTPUT_SUM:
        CMP DH, 16
        JE _EXIT
                               
        ROL BX, 1
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
