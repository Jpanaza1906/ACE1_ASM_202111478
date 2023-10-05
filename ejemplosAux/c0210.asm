.RADIX 16
.MODEL SMALL ;; Definicion del modelo de memoria
;; Definicion de segmentos
.STACK 
.DATA ;; Segmento de datos

cadena db "Hola mundo", 0ah, 0dh, "$"
x_jugador dw 0a
y_jugador dw 0a
sprite_jugador  db 00, 00, 00, 05, 05, 00, 00, 00
                db 00, 00, 05, 00, 00, 05, 00, 00
                db 00, 05, 00, 00, 00, 00, 05, 00
                db 00, 05, 00, 00, 00, 00, 05, 00
                db 05, 05, 00, 00, 00, 00, 05, 05
                db 00, 05, 00, 00, 00, 00, 05, 00
                db 00, 00, 05, 00, 00, 05, 00, 00
                db 00, 00, 00, 05, 05, 00, 00, 00
.CODE 
.STARTUP ;; Inicio de programa
;; logica del programa
    ;; ingreso modo de video
    mov AL, 13
    mov AH, 00
    int 10
    ;; escribir en pantalla
    mov AX, [x_jugador]
    mov SI, AX
    mov AX, [y_jugador]
    mov DI, AX
    mov CL, 05
    call pintar_pixel
infinito:
    jmp infinito
    jmp fin
;;pinta_pixel - pinta un pixel en
;;ENTRADAS
;; -SI - x
;; -DI - y
;; -CL - color
pintar_pixel:
    ;; DS tiene cierto valor, se guarda en la pila
    push DS
    ;;direccion del escaner de la direccion de video
    mov DX, 0A000
    mov DS, DX
    ;;
    mov AX, 140 ;; tamaño maximo de x
    mul DI ;; multiplica el valor de DI por 140
    ;;resultado queda DX-AX
    add AX, SI ;; suma el valor de SI a AX
    ;; indice hacia la memoria del pixel
    mov BX, AX  
    ;; color del pixel
    mov [BX], CL
    ;; restaura el valor de DS
    pop DS
    ret
;;pintar_jugador - pinta el jugador en pantalla
;;ENTRADAS
;; -SI - x
;; -DI - y
;; -CL - color
pintar_jugador:
    mov SI, [x_jugador]
    mov DI, [y_jugador]
    mov BX, offset sprite_jugador
    mov CX, 0000
    mov CL, 08
    xchg BP, CX
ciclo_filas:
    mov CX, 0000
    mov CL, 08
ciclo_columnas:
    push CX
    mov CL, [BX]
    call pintar_pixel
    pop CX
    inc SI
    inc BX
    loop ciclo_columnas
    ;;termino una fila
    inc DI
    mov SI, [x_jugador]
    xchg BP, CX
    loop ciclo_filas
fin:
.EXIT
END