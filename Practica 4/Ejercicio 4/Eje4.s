.data
tabla: .word 20, 1, 14, 3, 2, 58, 18, 7, 12, 11
num: .word 7
long: .word 10
.code
ld r1, long(r0)
ld r2, num(r0)
dadd r3, r0, r0
dadd r10, r0, r0
loop: ld r4, tabla(r3)
beq r4, r2, listo
daddi r1, r1, -1
daddi r3, r3, 8
bnez r1, loop
j fin
listo: daddi r10, r0, 1
fin: halt


;a) - El algoritmo busca un valor en una tabla, si este existe guarda en el registro r10 el valor 1, sino finaliza el programa. 
;b) - El metodo Branch taken buffer es muy ventajoso para saltos con muchos repeticiones y acciones que no tengan saltos internos, basicamente lo que hace, es ignorar 
;c) - la condicion de salto y obligar a en la primera vuelta a no saltar, si deberia haber saltado, recibe una penalizacion y se configura para saltar, entonces en el 
;     proximo salto salta de forma obligada, si la prediccion es acertada, nos evitamos un branch taken stall, si no lo es cambia el estado del buffer y recibimos una 
;     penalizacion.
;                           CPI     RAW     BTS   
;     Branch taken buffer   1.588   16      4
;     Forwarding            1.651   16      8 