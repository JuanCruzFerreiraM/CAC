#El programa multiplica AxB mediante sumas repetidas, optimizado para su uso con Delay Slot. 
#Se obtuvo un programa con 0 atascos, en el peor de los casos al multiplicar por 1, se obtiene 1.444CPI

.data 
A: .word16 4
B: .word16 10

.code 
lh r2, B(r0)
daddi r3, r3, 0
lh r1, A(r0)
loop: daddi r2, r2, -1
nop
bnez r2, loop       
dadd r3, r3, r1
sd r3, A(r0)
halt    