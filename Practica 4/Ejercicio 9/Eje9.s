#Programa que simula un while, optimizado para su uso con delay slot. 0 atascos 1.200 CPI  

.data 
a: .word 3
x: .word 2
y: .word 5

.code
ld r1, a(r0)
ld r2, x(r0)
nop
beqz r1, fin
ld r3, y(r0)
loop: daddi r1, r1, -1
nop
bnez r1, loop
dadd r2, r2, r3
sd r1, a(r0)
sd r2, x(r0)
fin: halt 