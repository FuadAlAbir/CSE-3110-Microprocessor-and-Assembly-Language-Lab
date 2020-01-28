segment .text
global start

start:
mov     DL, 'a'
mov     AH, 2h
int     21h

mov     AX, 4C00h
int     21h 
