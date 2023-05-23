.data 
A: .word 3
B: .word 2
C: .word 1
D: .word 0

.code
ld r1, A(r0)
ld r2, B(r0)
ld r3, C(r0)
daddi r4, r0, 0
bne r1, r2, F1
daddi r4, r4, 1
F1: bne r1, r3, F2
daddi r4, r4, 1
F2: bne r2, r3, F3
daddi r4, r4, 1
F3: sd r4, D(r0)
halt

#El programa genera en el peor de los casos, cuando todos los valores son distintos 3 atascos Branch Taken, ademas
#sin forwarding se producen atascos RAW, solucionable con NOPS. 
#se deberia analizar si existe una forma de hacerlo sin BTS, descartamos el BTB ya que este muy probablemente produsca
#predicciones erroneas y el delay slot tampoco tiene sentido en principio, ya que no estamos en loops y no tendria sentido ejecutar cosas, 
#saltar.