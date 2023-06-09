PIC EQU 20H
EOI EQU 20H
TIMER EQU 10H
N_F10 EQU 9
N_CLK EQU 10

ORG 36
IP_F10 DW RUT_F10

ORG 40
IP_CLK DW RUT_CLK

ORG 1000H
SEG DB ?

ORG 3000H
RUT_F10: PUSH AX
MOV AL, 0FDH
OUT PIC+1, AL
MOV AL, EOI
OUT PIC, AL
POP AX
IRET

RUT_CLK: PUSH AX
CMP SEG, 30H
JZ FIN 
INT 7
DEC SEG
JMP CONT
FIN: MOV AL, 0FFH
OUT PIC+1, AL
CONT: MOV AL, 0
OUT TIMER, AL
MOV AL, EOI
OUT PIC, AL
POP AX
IRET

ORG 2000H
CLI
MOV AL, 0FEH ;HABILITA INT DEL F10
OUT PIC+1, AL ;REGISTRO IMR DEL PIC
MOV AL, N_F10
OUT PIC+4, AL
MOV AL, N_CLK
OUT PIC+5, AL
MOV AL, 1
OUT TIMER+1, AL ;REGISTRO CMP DEL TIMER
MOV AL, 0 
OUT TIMER, AL ;REGISTRO CONT DEL TIMER
MOV BX, OFFSET SEG
INT 6
MOV AL, 1
STI
LAZO: JMP LAZO
END

