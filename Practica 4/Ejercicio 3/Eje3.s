.data
A: .word 1
B: .word 6
array: .word 0
.code
ld r2, B(r0)
ld r1, A(r0)
ld r3, array(r0)
loop: daddi r2, r2, -1
sd r1, array(r3) ;almaceno el valor de r1 en la posicion array + desplazamiento determinado por r3. 
dsll r1, r1, 1
daddi r3, r3, 8 ;me muevo ocho pociciones en memoria (equivalen a 64bytes o .word).
bnez r2, loop
halt

;Codigo original.
;.data
;A: .word 1
;B: .word 6
;.code
;ld r1, A(r0)
;ld r2, B(r0)
;loop: dsll r1, r1, 1
;daddi r2, r2, -1
;bnez r2, loop
;halt


;a) - Se presentan atascos de tipo RAW a pesar de tener el forwarding ya que, la fase id del salto,
;     solicita el valor del registro r2 en la fase ex del daddi, pero cuando deberia ahora si 
;     de hacer uso del valor nos encontramos en la fase me del daddi, por 
;     esta razon, cuando intenta acceder al valor del registro r2, este todavia no se sobreescribio en la
;     fase me, el forwarding en este caso nos ahorra un atasco RAW en el acceso al registro r1 por la instruccion
;     dsll ya que en la fase id no puede acceder al valor ya que no se ejecuto el write back. 
;   - Branch taken es un atasco que se relaciona a los saltos, por asi decirlo es un problema en la toma del 
;     control del programa, sucede debido a que al tener un procesamiento paralelo, muchas veces, cuando se 
;     debe de ejecutar un salto, como esto no realiza hasta la fase ex, la instruccion siguiente comienza a 
;     ejecutarse hasta que efectivamente se realiza el salto y esta se deja de ejecutar, esto produce un atasco
;     en el flujo del programa, yo que tenemos instrucciones que se comienzan a procesar cuando no deberian.
;   - Se ejecutaron 21 instrucciones en 36 ciclos lo que nos da un CPI de 1.714.
;b) - Los atascos de tipo RAW son generados por las instrucciones dsll y bnez. \
;   - Para este caso dura 3 ciclos, la diferencia esta en que, como la instruccion de salto se encuentra atascada
;     mayor cantidad de tiempo, mas tiempo ademas se encuentra "esperando la siguiente instruccion". 
;   - En este caso tenemos 21 instrucciones en 43 ciclos lo que nos da un CPI de 2.048.       
;d) - Los resultados muestran que rotar a la izquierda a partir de 1 nos devuelve la potencia de 2 de la posicion
;     del bit.  