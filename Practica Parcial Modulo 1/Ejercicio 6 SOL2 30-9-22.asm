HAND EQU 40H

ORG 1000H
CADENA DB "Hola Gente COMO va Yo ando ACa"
fin db ?

SELECCIONADO: MOV DL, 0
CMP BYTE PTR [BX], 41H
JS FINAL
CMP BYTE PTR [BX], 5BH
JNS FINAL
MOV DL,1
FINAL: RET


ORG 2000H
MOV AL, 01111111b
OUT HAND+1, AL
MOV BX, OFFSET CADENA
MOV CL, OFFSET FIN - OFFSET CADENA
POLLING: IN AL, HAND+1
AND AL, 1
JNZ POLLING
CALL SELECCIONADO
CMP DL, 1
JNZ NOIMP
MOV AL, [BX]
OUT HAND, AL
NOIMP: INC BX
DEC CL
JNZ POLLING
INT 0
END