.data
cant: .word 8
datos: .word 1, 2, 3, 4, 5, 6, 7, 8
res: .word 0
.code
dadd r1, r0, r0
ld r2, cant(r0)
loop: ld r3, datos(r1)
daddi r2, r2, -1
dsll r3, r3, 1
sd r3, res(r1)
bnez r2, loop
daddi r1, r1, 8 ;con Forwarding funciona 10 puntos sin Forwarding tenemos atascos RAW, en ese caso si ponemos la linea daddi r2... tenemos dos RAW menos
halt

;a) - El efecto que tiene la opcion delay slot es que permite que no existan Branch taken satall. La inst nop tiene como objetivo darle tiempo al salto, y no tener ningun BTS
;     si no estuviera se ejecutaria el halt y terminaria el programa antes de tiempo. (1.068 CPI, 63 ciclos 59 instrucciones). 
;   - El algoritmo modificado tiene (1.078 CPI, 55 ciclos para 51 instrucciones).