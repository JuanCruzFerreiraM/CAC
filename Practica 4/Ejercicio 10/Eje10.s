.data
cadena: .asciiz "adbdcdedfdgdhdid" ; cadena a analizar
car: .asciiz "d" ; caracter buscado
cant: .word 0 ; cantidad de veces que se repite el caracter car en cadena

.code 
daddi r1, r0, 1 ;registros para desplazamientos 
lbu r5, cadena(r0)
daddi r3, r3, 17 ;cantidad de elementos en el string 
lbu r2, car(r0)
dadd r4, r0, r0 ;contador de igualdades 
loop: daddi r3, r3, -1
bne r5, r2, saltar
lbu r5, cadena(r1)
daddi r4, r4, 1
saltar:  bnez r3, loop
daddi r1, r1, 1
sd r4, cant(r0)
halt


