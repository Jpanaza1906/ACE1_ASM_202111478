JUGADOR_CARRIL equ 01
JUGADOR_ACERA  equ 02
ACERA          equ 03
CARRIL         equ 04
CARRO          equ 05
CAMION         equ 06

USUARIO_NORMAL         equ 01
USUARIO_ADMIN          equ 02
USUARIO_ADMIN_ORIGINAL equ 03

TAM_NOMBRE equ 14
TAM_CONTRA equ 19

NO_BLOQUEADO equ 00
BLOQUEADO    equ 01
.MODEL small
.RADIX 16
.STACK
.DATA
vidas    db "O  O  O$"

x_elemento dw 0000
y_elemento dw 0000

coordenadas_jugador dw 0000
coordenada_actual   dw 0000

sprite_jugador db 00, 00, 00, 05, 05, 00, 00, 00 
               db 00, 00, 00, 05, 05, 00, 00, 05 
               db 00, 05, 05, 05, 05, 05, 05, 00 
               db 05, 00, 00, 05, 05, 00, 00, 00 
               db 00, 00, 00, 05, 05, 00, 00, 00 
               db 00, 00, 05, 05, 05, 05, 00, 00 
               db 00, 00, 05, 00, 00, 05, 00, 00 
               db 00, 05, 05, 00, 00, 05, 05, 00 

sprite_jugador_carril db 13, 13, 13, 05, 05, 13, 13, 13 
                      db 13, 13, 13, 05, 05, 13, 13, 05 
                      db 13, 05, 05, 05, 05, 05, 05, 13 
                      db 05, 13, 13, 05, 05, 13, 13, 13 
                      db 13, 13, 13, 05, 05, 13, 13, 13 
                      db 13, 13, 05, 05, 05, 05, 13, 13 
                      db 13, 13, 05, 13, 13, 05, 13, 13 
                      db 1f, 05, 05, 13, 1f, 05, 05, 13 

sprite_jugador_acera db 17, 17, 17, 05, 05, 17, 17, 17 
                     db 17, 17, 17, 05, 05, 17, 17, 05 
                     db 17, 05, 05, 05, 05, 05, 05, 17 
                     db 05, 17, 17, 05, 05, 17, 17, 17 
                     db 17, 17, 17, 05, 05, 17, 17, 17 
                     db 17, 17, 05, 05, 05, 05, 17, 17 
                     db 17, 17, 05, 1a, 17, 05, 17, 17 
                     db 17, 05, 05, 17, 17, 05, 05, 17 

sprite_carril  db 13, 13, 13, 13, 13, 13, 13, 13 
               db 13, 13, 13, 13, 13, 13, 13, 13 
               db 13, 13, 13, 13, 13, 13, 13, 13 
               db 13, 13, 13, 13, 13, 13, 13, 13 
               db 13, 13, 13, 13, 13, 13, 13, 13 
               db 13, 13, 13, 13, 13, 13, 13, 13 
               db 13, 13, 13, 13, 13, 13, 13, 13 
               db 1f, 1f, 13, 13, 1f, 1f, 13, 13 

sprite_banqueta db 17, 17, 17, 17, 17, 17, 17, 17 
                db 17, 17, 17, 1a, 17, 17, 17, 17 
                db 17, 17, 17, 1a, 17, 17, 17, 17 
                db 17, 17, 17, 1a, 17, 17, 17, 17 
                db 17, 17, 17, 1a, 17, 17, 17, 17 
                db 17, 17, 17, 1a, 17, 17, 17, 17 
                db 17, 17, 17, 1a, 17, 17, 17, 17 
                db 17, 17, 17, 17, 17, 17, 17, 17 

mapa_objetos db 3e8 dup (00)

opcion_principal_1  db "F1  Iniciar sesion$"
opcion_principal_2  db "F2  Registro$"
opcion_principal_3  db "F3  Salir$"

opcion1  db "F1  Jugar$"
opcion2  db "F2  Salir$"

cadena_pedir_nombre db "Escriba su nombre: $"
cadena_pedir_contra db "Escriba su clave: $"

;; ESTRUCTURA USUARIO -> 2f bytes
usuario_nombre    db 14 dup (00)
usuario_contra    db 19 dup (00)
usuario_tipo      db         00
usuario_bloqueado db         00

;; ESTRUCTURA JUEGO   -> 06 bytes
juego_cod_usuario dw 0000
juego_tiempo      dw 0000
juego_puntos      dw 0000

buffer_entrada db 0ff,00
               db 0ff dup (00)

usuarios_archivo db "USRS.ACE",00

cadena_limpiar db "                                       $" 
.CODE
.STARTUP
		;; ingreso al modo de video 13h
		mov AL, 13
		mov AH, 00
		int 10
		;; ...
menu_principal:
		mov DH, 08
		mov DL, 08
		mov BH, 00
		mov AH, 02
		int 10
		mov DX, offset opcion_principal_1
		mov AH, 09
		int 21
		mov DH, 0a
		mov DL, 08
		mov BH, 00
		mov AH, 02
		int 10
		mov DX, offset opcion_principal_2
		mov AH, 09
		int 21
		mov DH, 0c
		mov DL, 08
		mov BH, 00
		mov AH, 02
		int 10
		mov DX, offset opcion_principal_3
		mov AH, 09
		int 21
esperar_opcion_menu_principal:
		mov AH, 00
		int 16
		cmp AH, 3b
		je menu_usuario
		cmp AH, 3c
		je registro
		cmp AH, 3d
		je fin
		jmp esperar_opcion_menu_principal

registro:
		call limpiar_pantalla
		mov DH, 08
		mov DL, 04
		mov BH, 00
		mov AH, 02
		int 10
		mov DX, offset cadena_pedir_nombre
		mov AH, 09
		int 21
		mov DX, offset buffer_entrada
		mov AH, 0a
		int 21
		mov AL, TAM_NOMBRE
		mov DI, offset usuario_nombre
		call copiar_dato
		;;
		mov DH, 0a
		mov DL, 04
		mov BH, 00
		mov AH, 02
		int 10
		mov DX, offset cadena_pedir_contra
		mov AH, 09
		int 21
		mov DX, offset buffer_entrada
		mov AH, 0a
		int 21
		mov AL, TAM_CONTRA
		mov DI, offset usuario_contra
		call copiar_dato
		;;
		mov AL, USUARIO_NORMAL
		mov [usuario_tipo], AL
		;;
		mov AL, NO_BLOQUEADO
		mov [usuario_bloqueado], AL
		;;
		call escribir_usuario
		call limpiar_pantalla
		jmp menu_principal

menu_usuario:
		call limpiar_pantalla
		mov DH, 08
		mov DL, 08
		mov BH, 00
		mov AH, 02
		int 10
		mov DX, offset opcion1
		mov AH, 09
		int 21
		mov DH, 0a
		mov DL, 08
		mov BH, 00
		mov AH, 02
		int 10
		mov DX, offset opcion2
		mov AH, 09
		int 21
		;;
esperar_opcion_menu:
		mov AH, 00
		int 16
		cmp AH, 3b
		je jugar
		cmp AH, 3c
		je menu_principal
		jmp esperar_opcion_menu

jugar:
		call limpiar_pantalla
		mov DH, 00
		mov DL, 10
		mov BH, 00
		mov AH, 02
		int 10
		;;
		mov DX, offset vidas
		mov AH, 09
		int 21
		;; ...
		mov AL, 00
		mov AH, 01
		mov BL, ACERA
		call colocar_en_mapa
		mov AL, 01
		mov AH, 01
		mov BL, ACERA
		call colocar_en_mapa
		mov AL, 02
		mov AH, 01
		mov BL, ACERA
		call colocar_en_mapa
		mov AL, 00
		mov AH, 02
		mov BL, CARRIL
		call colocar_en_mapa
		mov AL, 01
		mov AH, 02
		mov BL, CARRIL
		call colocar_en_mapa
		mov AL, 02
		mov AH, 02
		mov BL, CARRIL
		call colocar_en_mapa
		mov AL, 00
		mov AH, 03
		mov BL, CARRIL
		call colocar_en_mapa
		mov AL, 01
		mov AH, 03
		mov BL, CARRIL
		call colocar_en_mapa
		mov AL, 02
		mov AH, 03
		mov BL, CARRIL
		call colocar_en_mapa
		mov AL, 00
		mov AH, 04
		mov BL, CARRIL
		call colocar_en_mapa
		mov AL, 01
		mov AH, 04
		mov BL, CARRIL
		call colocar_en_mapa
		mov AL, 02
		mov AH, 04
		mov BL, CARRIL
		call colocar_en_mapa
		mov AL, 01
		mov AH, 03
		mov BL, JUGADOR_CARRIL
		call colocar_en_mapa
		mov AL, 00
		mov AH, 05
		mov BL, ACERA
		call colocar_en_mapa
		mov AL, 01
		mov AH, 05
		mov BL, ACERA
		call colocar_en_mapa
		mov AL, 02
		mov AH, 05
		mov BL, ACERA
		call colocar_en_mapa
		;;
		call pintar_mapa

infinito:
		jmp infinito
		jmp fin

;; pintar_pixel - pinta un pixel en una posición x, y
;; ENTRADAS:
;;  - SI - x
;;  - DI - y
;;  - CL - color 
;; SALIDA:
pintar_pixel:
		;; DS tiene cierto valor
		;; se preservó DS
		push DS
		;; se coloca la dirección del scanner del modo de video
		mov DX, 0a000
		mov DS, DX
		;;
		mov AX, 140 ;; tamaño máximo de x ;; tamaño máximo de x
		mul DI
		;; DX-AX resultado de la multiplicación
		add AX, SI
		;; índice hacia la memoria del pixel
		mov BX, AX
		mov [BX], CL
		pop DS
		ret

;; pintar_sprite - pinta el sprite en la posición especificada en memoria
;; ENTRADA:
;;   BX -> datos del sprite a pintar
pintar_sprite:
		mov SI, [x_elemento]
		mov DI, [y_elemento]
		xchg BP, CX
		mov CX, 0000
		mov CL, 08    ;; altura del jugador, 8 en este caso
ciclo_filas:
		xchg BP, CX
		mov CX, 0000
		mov CL, 08    ;; anchura del jugador, 8 en este caso
ciclo_columnas:
		push BX
		push CX
		mov CL, [BX]
		call pintar_pixel
		pop CX
		pop BX
		inc SI
		inc BX
		loop ciclo_columnas
		;; terminó una fila
		;;; incremento y
		inc DI
		;;; reinicio x
		mov SI, [x_elemento]
		xchg BP, CX
		loop ciclo_filas
		ret

;; colocar_en_mapa -
;; ENTRADA:
;;  AL -> x del elemento
;;  AH -> y del elemento
;;  BL -> código del elemento
colocar_en_mapa:
		push AX    ;; guardar las posiciones en la pila
		mov AL, AH
		mov AH, 00
		mov DI, AX
		mov AX, 28 ;; tamaño máximo de x
		mul DI
		;; DX-AX resultado de la multiplicación
		pop DX
		mov DH, 00
		add AX, DX  ;; AX = 28*y + x
		;; índice hacia la memoria del pixel
		mov SI, offset mapa_objetos
		add SI, AX
		mov [SI], BL
		ret

;; obtener_de_mapa -
;; ENTRADA:
;;  AL -> x del elemento
;;  AH -> y del elemento
;; SALIDA:
;;  BL -> código del elemento
obtener_de_mapa:
		push AX    ;; guardar las posiciones en la pila
		mov AL, AH
		mov AH, 00
		mov DI, AX
		mov AX, 28 ;; tamaño máximo de x
		mul DI
		;; DX-AX resultado de la multiplicación
		pop DX
		mov DH, 00
		add AX, DX  ;; AX = 28*y + x
		;; índice hacia la memoria del pixel
		mov SI, offset mapa_objetos
		add SI, AX
		mov BL, [SI]
		ret

;; pintar_mapa - 
pintar_mapa:
		mov AX, 0000
		mov [coordenada_actual], AX
		mov CX, 19
ciclo_filas_mapa:
		xchg BP, CX
		mov CX, 28
ciclo_columnas_mapa:
		mov AX, [coordenada_actual]
		call obtener_de_mapa
		;; ============================
		;; selección de sprite a pintar
		;; ============================
		cmp BL, ACERA
		je pintar_acera
		cmp BL, CARRIL
		je pintar_carril
		cmp BL, JUGADOR_CARRIL
		je pintar_jugador_carril
		jmp ciclo_columnas_mapa_loop
		;; ==============================================
		;; definición de qué sprite pintar para cada caso
		;; ==============================================
pintar_acera:
		mov BX, offset sprite_banqueta
		jmp pintar_sprite_en_posicion
pintar_carril:
		mov BX, offset sprite_carril
		jmp pintar_sprite_en_posicion
pintar_jugador_carril:
		mov BX, offset sprite_jugador_carril
		jmp pintar_sprite_en_posicion
pintar_sprite_en_posicion:
		mov AX, [coordenada_actual]
		mov AH, 08
		mul AH
		mov [x_elemento], AX
		mov AX, [coordenada_actual]
		mov AL, AH
		mov AH, 08
		mul AH
		mov [y_elemento], AX
		push CX
		push BP
		call pintar_sprite
		pop BP
		pop CX
		jmp ciclo_columnas_mapa_loop
ciclo_columnas_mapa_loop:
		mov AX, [coordenada_actual]
		inc AL
		mov [coordenada_actual], AX
		loop ciclo_columnas_mapa
		mov AX, [coordenada_actual]
		mov AL, 00
		inc AH
		mov [coordenada_actual], AX
		xchg BP, CX
		loop ciclo_filas_mapa
		ret

;; escribir_usuario - escribe un usuario en el archivo USRS.ACE
;; ENTRADA:
;;   - [usuario_nombre] -> nombre del usuario
;;   - ...
escribir_usuario:
		mov AH, 3d
		mov AL, 02
		mov DX, offset usuarios_archivo
		int 21
		jc crear_archivo
		jmp escribir_estructura_usuario
crear_archivo:
		mov AH, 3c
		mov CX, 0000
		mov DX, offset usuarios_archivo
		int 21
escribir_estructura_usuario:
		;; posicionar en el final del archivo
		mov BX, AX   ; handle
		mov AL, 02
		mov CX, 0000
		mov DX, 0000
		mov AH, 42
		int 21
		;; guardar el usuario
		mov AH, 40
		mov CX, 002f
		mov DX, offset usuario_nombre
		int 21
		;; cerrar archivo
		mov AH, 3e
		int 21
		ret

;; copiar_dato - copia el contenido del buffer en el campo indicado
;; ENTRADA:
;;   - AL -> tamaño del campo
;;   - DI -> direccion del campo
copiar_dato:
		mov CX, 0000
		mov CL, AL
		mov AH, 00
		push DI
ciclo_limpiar_dato:
		mov [DI], AH
		inc DI
		loop ciclo_limpiar_dato
		pop DI
		;;
		mov SI, offset buffer_entrada
		inc SI
		mov AL, [SI]
		mov CX, 0000
		mov CL, AL
		inc SI
ciclo_copiar_dato:
		mov AL, [SI]
		mov [DI], AL
		inc DI
		inc SI
		loop ciclo_copiar_dato
		ret

;; limpiar_pantalla - limpia la pantalla
limpiar_pantalla:
		push CX
		mov CX, 1a
ciclo_limpiar_pantalla:
		mov DX, offset cadena_limpiar
		mov AH, 09
		int 21
		loop ciclo_limpiar_pantalla
		pop CX
		ret
fin:
.EXIT
END