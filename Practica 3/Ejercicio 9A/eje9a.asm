HAND EQU 40H

ORG 1000H
CHAR DB ?
DB ?
DB ? 
DB ? 
DB ?
FIN DB ?

ORG 2000H 
IN AL, HAND+1 
AND AL, 7EH
OUT HAND+1, AL
MOV BX, OFFSET CHAR
MOV DL, 5
WHILE: INT 6
INC BX
DEC DL
JNZ WHILE 
MOV BX, OFFSET CHAR
MOV DL, 5
POLL: IN AL, HAND+1
AND AL, 1
JNZ POLL 
MOV AL, [BX]
OUT HAND, AL 
INC BX
DEC DL
JNZ POLL
INT 0
END

