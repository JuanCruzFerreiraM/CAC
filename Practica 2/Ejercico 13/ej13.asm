PIC EQU 20H
EOI EQU 20H
N_CLICK EQU 10

ORG 40H
IP_CLICK DW RUT_CLK

ORG 1000H
MIN DB 30H
DB 30H
SEG DB 30H
DB 30H
SIGNO DB 3AH
FINAL DB ?

ORG 3000H
RUT_CLK: PUSH AX
INC SEG+1
CMP SEG+1, 3AH
JNZ FIN
MOV SEG+1, 30H
INC SEG
INT 7
CMP SEG, 36H
JNZ FIN 
MOV SEG, 30H
INC MIN+1
CMP MIN+1, 3AH
JNZ FIN
MOV MIN+1, 30H
INC MIN 
CMP MIN, 36H
JNZ FIN
MOV MIN, 30H
FIN: MOV AL, 0 
OUT TIMER, AL 
MOV AL, EOI
OUT PIC, AL
POP AX
IRET

ORG 2000H
CLI
MOV AL, 0FDH
OUT PIC+1, AL
MOV AL, N_CLICK
OUT PIC+5, AL
MOV AL, 1
OUT TIMER+1, AL
MOV AL, 0 
OUT TIMER, AL
MOV BX, OFFSET MIN
MOV AL, OFFSET FIN - OFFSET MIN
LAZO: JMP LAZO
END 
