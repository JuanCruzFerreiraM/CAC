#El algoritmo esta pensado para un usarse con forwarding y delay slot, en ese caso tiene 0 atascos 
# 111 ciclos 107 instrucciones 1.037CPI. 

.data 
tabla: .word 1,2,3,4,5,6,7,8,9,10 ;arreglo original
x: .word 0 ;valor a comparar
cant: .word 0 ;cantidad de elementos mayores
res: .word 0,0,0,0,0,0,0,0,0,0 ;arreglo resultado
leng: .word 10 ;long. de los arreglos

.code 
ld r1, x(r0)
ld r2, leng(r0)
daddi r3, r0, 0 ;registro desplazaminetos.
daddi r4, r0, 1 ;lo usamos para sd del res
dadd r7, r0, r0
loop: ld r5, tabla(r3)
daddi r2, r2, -1
slt r6, r1, r5
nop
beq r6, r4, EsMayor
nop 
j sig
nop
EsMayor: sd r4, res(r3)
daddi r7, r7, 1
sig: bnez r2, loop
daddi r3, r3, 8
sd r7, cant(r0)
halt