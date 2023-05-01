ORG 1000H 
A DB 041H ;valor ASCII de A

ORG 2000H
MOV BX,OFFSET A
MOV AL, 1
MOV AH, 0
ITER: INT 7
ADD BYTE PTR [BX], 20H ;pasa al equivalente en minuscula
INT 7
SUB BYTE PTR [BX],1FH ; pasa a la siguiente mayus
INC AH
CMP AH,26
JNZ ITER
INT 0
END
