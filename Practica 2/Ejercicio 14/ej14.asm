TIMER     EQU   10H
PIC       EQU   20H
EOI       EQU   20H
N_F10     EQU   9
N_CLK     EQU   10
          ORG   36
IP_F10    DW    RUT_F10
          ORG   40
IP_CLK    DW    RUT_CLK
          ORG   1000H
SEG       DB    30H
S1        DB    30H
FIN       DB    ?
          ORG   3000H
RUT_F10:  PUSH  AX
          IN    AL,PIC+1 ;Traemos el dato del IMR
          CMP   AL, 0FCH ;Verificamos si tenemos habilitado el timer
          JZ    DESH     
          MOV   AL, 0FCH ;Movemos a AL la mascara para habilitar las interrupciones por el timer
          OUT   PIC+1,AL ;Se lo pasamos al IMR
          JMP   FIN_F10
DESH:     MOV   AL, 0FEH
          OUT   PIC+1,AL
FIN_F10:  MOV   AL, EOI ;Pasamos EOI al PIC
          OUT   PIC, AL
          POP   AX
          IRET

RUT_CLK:  PUSH  AX
          INC   S1
          CMP   S1, 3AH
          JNZ   RESET
          MOV   S1, 30H
          INC   SEG
          CMP   SEG, 33H ;Verificamos si llego a 30 segundos
          JNZ   RESET
          INT   7        ;Imprimimos
          MOV   SEG, 30H ;Volvemos los segundos a 0
          MOV   AL, 0FEH ;Enmascaramos las interrupciones del timer
          OUT   PIC+1,AL
          JMP   ELSE
RESET:    INT   7
ELSE:     MOV   AL, 0
          OUT   TIMER, AL
          MOV   AL, EOI
          OUT   PIC, AL
          POP   AX
          IRET
          ORG   2000H
          CLI
          MOV   AL, 0FEH  ; 11111110
          OUT   PIC+1, AL ; PIC: registro IMR
          MOV   AL, N_CLK
          OUT   PIC+5, AL ; PIC: registro INT1
          MOV   AL, N_F10
          OUT   PIC+4, AL ; PIC: regristro INT0
          MOV   AL, 1
          OUT   TIMER+1, AL ; TIMER: registro COMP
          MOV   AL, 0
          OUT   TIMER, AL ; TIMER: registro CONT
          MOV   BX, OFFSET SEG
          MOV   AL, OFFSET FIN-OFFSET SEG
          STI
LAZO:     JMP LAZO
          END

