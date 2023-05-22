.data
    A: .word 1
    B: .word 2
.code
    ld r1, A(r0)
    ld r2, B(r0)
    sd r2, A(r0)
    sd r1, B(r0)
halt

;a) - La instruccion que genera stalls es la instruccion en la linea 8 ya que debido a que 
;     esta intentando identificar el valor de un registro que no ha sido cargado ya que la
;     la instruccion anterior no ha llegado al write back.
;   - Esta generando un atasco de tipo RAW (Read after write).
;   - Tarda 2,2 CPI (5 inst en 10 ciclos).
;b) - No presenta ningun atasco ya que al prender el forwarding almacenamos en un buffer o dos depende 
;     donde necistamos utilizar ese valor, y de esta forma al postergar el acceso, no se genera un atasco de tipo
;     RAW. (No siempre se evita el RAW con el forwarding hay casos en los que solo disminuye la cantidad).
;   -  Tarda 1,8 CPI (5 inst en 9 cilcos, ejecuta en un ciclo menos que antes).
      