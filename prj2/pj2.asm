;;----------------------------------------- CONSTANTES -----------------------------------------
;;-------------------------------------------JUEGO-------------------------------------------
JUGADOR_CARRIL	equ 01
JUGADOR_ACERA	equ 02
ACERA			equ 03
CARRIL			equ 04
R_CARROMORADO	equ 05
R_CARROAZUL		equ 06
L_CARROVERDE	equ 07
L_CARROAMARILLO	equ 08
CAMIONINI		equ 09
CAMIONFIN		equ 10
;;-----------------------------------------FIN JUEGO-----------------------------------------
;;-------------------------------------------USUARIOS-------------------------------------------
USUARIO_NORMAL			equ 02
USUARIO_ADMIN 			equ 01
USUARIO_ADMIN_ORIGINAL	equ 00

SIZE_NAME	 			equ 20
SIZE_PASSWORD 			equ 25
NO_BLOQUEADO			equ 00
BLOQUEADO				equ 01
;;-----------------------------------------FIN USUARIOS-----------------------------------------

;;---------------------------------------FIN CONSTANTES---------------------------------------
.MODEL small
.RADIX 16 ;;HEXADECIMAL
.STACK
.DATA
;;----------------------------------------- HEADER TABLERO-----------------------------------------

vidas dw 0003h
vida_caracter db "O  $"
novida_caracter  db "#  $"
horas db "00:"
minutos db "00:"
segundos db "00$"
conthora dw 0000h
contminuto dw 0000h
contsegundo dw 0000h
cadena_punteo db 05 dup('0'), '$' ;;00000 -> 00002
punteo_actual dw 0000h
;;-----------------------------------------FIN HEADER TABLERO-----------------------------------------

;;---------------------------------------- FOOTER TABLERO-----------------------------------------



dia_cadena db 02 dup (30),'/' 
mes_cadena db 02 dup (30),'/'
anho_cadena db 04 dup (30),' '
hora_cadena db 02 dup (30),':'
minutos_cadena db 02 dup (30),':'
segundos_cadena db 02 dup (30), '$'

dia_numero dw 0000
mes_numero dw 0000
ahno_numero dw 0000

hora_numero dw 0000
minutos_numero dw 0000
segundos_numero dw 0000

;;----------------------------------------FIN FOOTER TABLERO-----------------------------------------

;;-----------------------------------------TABLERO-----------------------------------------
offset_DS_data DW 0000h
count_col_sprite DW 0008h
count_fila_sprite DW 0008h
col_pantalla DW 0000h
fila_pantalla DW 0000h
direccion_sprite DW 0000h
indice_video DW 0000h 

;;
fila_tablero db 0000
col_tablero db 0000

mapa_tablero db 3e8 dup(00)
x_elemento dw 0000
y_elemento dw 0000
coordenadas_jugador dw 0000
coordenada_actual   dw 0000

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
sprite_carro_morado_derecha db 13, 00, 00, 13, 13, 00, 00, 13
							db 05, 05, 05, 05, 05, 05, 05, 05
							db 05, 09, 09, 05, 05, 05, 09, 05
							db 05, 09, 09, 05, 05, 05, 09, 05
							db 05, 09, 09, 05, 05, 05, 09, 05
							db 05, 09, 09, 05, 05, 05, 09, 05
							db 05, 05, 05, 05, 05, 05, 05, 05
							db 13, 00, 00, 13, 13, 00, 00, 13
sprite_carro_azul_derecha   db 13, 00, 00, 13, 13, 00, 00, 13
							db 01, 01, 01, 01, 01, 01, 01, 01
							db 01, 09, 09, 01, 01, 01, 09, 01
							db 01, 09, 09, 01, 01, 01, 09, 01
							db 01, 09, 09, 01, 01, 01, 09, 01
							db 01, 09, 09, 01, 01, 01, 09, 01
							db 01, 01, 01, 01, 01, 01, 01, 01
							db 13, 00, 00, 13, 13, 00, 00, 13
sprite_carro_verde_izq      db 13, 00, 00, 13, 13, 00, 00, 13
							db 02, 02, 02, 02, 02, 02, 02, 02
							db 02, 09, 02, 02, 02, 09, 09, 02
							db 02, 09, 02, 02, 02, 09, 09, 02
							db 02, 09, 02, 02, 02, 09, 09, 02
							db 02, 09, 02, 02, 02, 09, 09, 02
							db 02, 02, 02, 02, 02, 02, 02, 02
							db 13, 00, 00, 13, 13, 00, 00, 13
sprite_carro_amarillo_izq   db 13, 00, 00, 13, 13, 00, 00, 13
							db 06, 06, 06, 06, 06, 06, 06, 06
							db 06, 09, 06, 06, 06, 09, 09, 06
							db 06, 09, 06, 06, 06, 09, 09, 06
							db 06, 09, 06, 06, 06, 09, 09, 06
							db 06, 09, 06, 06, 06, 09, 09, 06
							db 06, 06, 06, 06, 06, 06, 06, 06
							db 13, 00, 00, 13, 13, 00, 00, 13

sprite_inicio_camion_blanco 	db 13, 00, 00, 13, 13, 00, 00, 13
								db 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f
								db 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f
								db 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f
								db 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f
								db 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f
								db 0f, 0f, 0f, 0f, 0f, 0f, 0f, 0f
								db 13, 00, 00, 13, 13, 00, 00, 13
sprite_fin_camion_blanco 		db 13, 13, 13, 13, 13, 13, 13, 13
								db 0f, 0f, 0f, 0f, 13, 00, 00, 13
								db 0f, 0f, 0f, 0f, 07, 07, 07, 07
								db 0f, 0f, 0f, 0f, 07, 07, 07, 07
								db 0f, 0f, 0f, 0f, 07, 07, 07, 07
								db 0f, 0f, 0f, 0f, 07, 07, 07, 07
								db 0f, 0f, 0f, 0f, 13, 00, 00, 13
								db 13, 13, 13, 13, 13, 13, 13, 13


cadena_limpiar db "                                        $" 
segundo_ant dw 0000h
carro_random db 00h
cont_fila db 00h
semilla_random dw 01h
fila_mapa db 00h
columna_mapa db 00h
fila_jugador db 00h
columna_jugador db 00h

gameover_cadena db "GAME  OVER$"

tiempo_base_velocidad_lenta db 00h
tiempo_base_velocidad_media db 00h
tiempo_base_velocidad_rapida db 00h

tiempo_base_velocidad_lenta_aux db 00h
tiempo_base_velocidad_media_aux db 00h
tiempo_base_velocidad_rapida_aux db 00h

tiempo_actual db 00h
bandera_tiempo	db 00h

;;---------------------------------------FIN TABLERO---------------------------------------

;;----------------------------------------USUARIOS----------------------------------------
usuarios_archivo db "USRS.ACE", 00
cadena_login_titulo db "============LOGIN============$"
cadena_usuariologin db "USUARIO: $"
cadena_passwordlogin db "PASSWORD: $"
cadena_error_apertura db "ERROR AL ABRIR EL ARCHIVO$"
cadena_error_lectura db "ERROR AL LEER EL ARCHIVO$"
cadena_error_login db "USUARIO O PASSWORD INCORRECTOS$"

buffer_entrada_usuario 	db 32, 00
						db 32 dup(00)
buffer_entrada_password db 32, 00
						db 32 dup(00)

usuario_actual db 14 dup(00), '$'


usuario_leido db 14 dup(00)
password_usuario db 19 dup(00)
rol_usuario db 00 ;; 0 -> admin original | 1 -> admin | 2 -> usuario
estado_usuario db 00 ;; 0 -> no bloqueado | 1 -> bloqueado
handle_usuarios dw 0000h
cont_login db 00h

cadenaarchivo	db "jose"
				db 10 dup(00)
				db "123"
				db 16 dup(00)
cadena_logincorrecto db "LOGIN CORRECTO$"
;Colaborador1
;jbatres
;202111478A*
;Colaborador2
;smejia
;202103226A*
;;--------------------------------------FIN LOGIN--------------------------------------

;;---------------------------------------INICIO MENU ADMIN ORIGINAL---------------------------------------
cadena_menu_admin_original db "=======MENU ADMIN ORIGINAL=======",0ah,0ah
cadena_menu_admin_original_opcion1 db 0ah, 0ah, "	F1	REGISTRAR USUARIO",0ah,0ah
cadena_menu_admin_original_opcion2 db "	F2	PROMOVER USUARIO",0ah,0ah
cadena_menu_admin_original_opcion3 db "	F3	DESBLOQUEAR USUARIO",0ah,0ah
cadena_menu_admin_original_opcion4 db "	F4	ORDENAR PUNTAJES",0ah,0ah
cadena_menu_admin_original_opcion5 db "	F5	VER ESTADISTICAS",0ah,0ah
cadena_menu_admin_original_opcion6 db "	F6	JUGAR",0ah,0ah
cadena_menu_admin_original_opcion7 db "	F7	ULTIMAS PARTIDAS",0ah,0ah
cadena_menu_admin_original_opcion8 db "	F8	CERRAR SESION$"


;;--------------------------------------- MENU PRINCIPAL---------------------------------------

.CODE
.STARTUP 
;;===========================================INICIO_INSTRUCCIONES===========================================

;;-----------------------------------------MODO DE VIDEO-----------------------------------------
    ;Cambiar a modo video 13h
    mov AL, 13h
    mov AH, 00h 
    int 10h
	jmp LOGIN
;;---------------------------------------FIN MODO DE VIDEO---------------------------------------

;;ecribir en archivo
	mov CX, 0000
	mov DX, offset usuarios_archivo
	mov AH, 3ch
	int 21h
	mov handle_usuarios, AX
	;;;escribir en archivo
	mov BX, handle_usuarios
	mov CX, 2dh
	mov DX, offset cadenaarchivo
	mov AH, 40h
	int 21h
	;cerrar archivo
	mov BX, handle_usuarios
	mov AH, 3eh
	int 21h

;;------------------------------------------INICIO LOGIN ----------------------------------------------
ERROR_APERTURA:
	mov AH, 02h
	mov BH, 00h
	mov DH, 18h
	mov DL, 00h
	int 10h

	mov DX, offset cadena_error_apertura
	mov AH, 09h
	int 21h
	;;esperar a presionar una tecla
	mov AH, 01h
	int 21h

	jmp LOGIN
ERROR_LECTURA:
	mov AH, 02h
	mov BH, 00h
	mov DH, 18h
	mov DL, 00h
	int 10h
	mov DX, offset cadena_error_lectura
	mov AH, 09h
	int 21h
	;;esperar a presionar una tecla
	mov AH, 01h
	int 21h

	jmp LOGIN
ERROR_LOGIN:
	mov AH, 02h
	mov BH, 00h
	mov DH, 18h
	mov DL, 00h
	int 10h
	mov DX, offset cadena_error_login
	mov AH, 09h
	int 21h

	;;esperar a presionar una tecla
	mov AH, 01h
	int 21h

	jmp LOGIN
LOGIN:
	call limpiar_pantalla
	;;colocar cursor en la posicion fila, col -> 04h, 06h
	mov AH, 02h
	mov BH, 00h
	mov DH, 04h
	mov DL, 05h
	int 10h

	;;imprimir cadena_login_titulo
	mov DX, offset cadena_login_titulo
	mov AH, 09h
	int 21h

;;------------------------------------USUARIO------------------------------------

	;;colocar cursor en la posicion fila, col -> 08h, 06h
	mov AH, 02h
	mov BH, 00h
	mov DH, 08h
	mov DL, 06h
	int 10h

	;;imprimir cadena_usuariologin
	mov DX, offset cadena_usuariologin
	mov AH, 09h
	int 21h

	;;pedir nombre de usuario
	mov AH, 0ah
	mov DX, offset buffer_entrada_usuario
	int 21h

	mov AL, [buffer_entrada_usuario+1]
	mov AH, 00
	mov SI, AX
	mov DI, offset buffer_entrada_usuario+2
	add DI, SI
	mov AL, 00
	mov [DI], AL

;;------------------------------------PASSWORD------------------------------------

	;;colocar cursor en la posicion fila, col -> 0ah, 06h
	mov AH, 02h
	mov BH, 00h
	mov DH, 0ah
	mov DL, 06h
	int 10h

	;;imprimir cadena_passwordlogin
	mov DX, offset cadena_passwordlogin
	mov AH, 09h
	int 21h

	;;pedir password
	mov AH, 0ah
	mov DX, offset buffer_entrada_password
	int 21h

	mov AL, [buffer_entrada_password+1]
	mov AH, 00
	mov SI, AX
	mov DI, offset buffer_entrada_password+2
	add DI, SI
	mov AL, 00
	mov [DI], AL

;;------------------------------------VERIFICAR CREDENCIALES------------------------------------

	;;abrir archivo de usuarios
	mov AH, 3dh
	mov AL, 00h
	mov DX, offset usuarios_archivo
	int 21h
	;;error de apertura
	jc ERROR_APERTURA
	mov handle_usuarios, AX
LEER_USUARIO:
	;;leer usuario
	mov AH, 3fh
	mov BX, handle_usuarios
	mov CX, 2fh ;;se lee toda la estructura
	mov DX, offset usuario_leido
	int 21h
	;;error de lectura
	jc ERROR_LECTURA
	
	cmp AX, 00h
	je ERROR_LOGIN

	;;comparar usuario
	mov SI, offset usuario_leido
	mov DI, offset [buffer_entrada_usuario + 2] ;; inicio cadena
	mov CX, 2dh ;;tamaño de la cadena 45 decimal = 2dh
	mov cont_login, 00h
CICLO_LEER_USUARIO:
	mov AL, [SI]
	cmp AL, [DI]
	; jose010101010101010101010101010101010101001123
	; jose0101010101010101 -> 20 espacios
	jne LEER_USUARIO
	cmp cont_login, 13h
	jne SEGUIR_LEYENDO
	mov DI, offset [buffer_entrada_password + 1] ;; inicio cadena
SEGUIR_LEYENDO:
	inc SI
	inc DI
	inc cont_login
	loop CICLO_LEER_USUARIO
;;Si termina usuario correcto
;;imprimir caracter 'a'
	mov AH, 02h
	mov BH, 00h
	mov DH, 18h
	mov DL, 00h
	int 10h
	mov DX, offset cadena_logincorrecto
	mov AH, 09h
	int 21h

	;;esperar a presionar una tecla
	mov AH, 01h
	int 21h

	;;se compara el rol del usuario
	cmp rol_usuario, USUARIO_ADMIN_ORIGINAL
	je MENU_ADMIN_ORIGINAL
	cmp rol_usuario, USUARIO_ADMIN
	;je MENU_ADMIN
	cmp rol_usuario, USUARIO_NORMAL
	;je MENU_NORMAL

	jmp LOGIN
;;------------------------------------------FIN LOGIN ----------------------------------------------

;;------------------------------------------INICIO MENU ADMIN ORIGINAL ----------------------------------------------

MENU_ADMIN_ORIGINAL:
	call limpiar_pantalla
	;;Mostrar encabezado
	mov AH, 02h
	mov BH, 00h
	mov DH, 01h
	mov DL, 04h
	int 10h
	mov DX, offset cadena_menu_admin_original
	mov AH, 09h
	int 21h

	;;Se leen las Fs
	


finito:
	jmp finito





;;--------------------------------------------FIN MENU ADMIN ORIGINAL ----------------------------------------------

;;-----------------------------------------INICIO TABLERO-----------------------------------------
CREAR_TABLERO_JUEGO:
	;;Guardar Centencimas Base
	mov AH, 2ch
	int 21
	;DL -> centecimas
	mov tiempo_base_velocidad_lenta, DL
	mov tiempo_base_velocidad_media, DL
	mov tiempo_base_velocidad_rapida, DL

	;;se limpia la pantalla
	call limpiar_pantalla
;;----------------------------------------- DATOS HEADER -----------------------------------------
	;;imprimir cadena_punteo
	call imprimir_cadena_punteo

	;;imprimir vidas
	call imprimir_vidas

	;;imprimir tiempo
	call imprimir_tiempo

;;---------------------------------------FIN DATOS HEADER---------------------------------------
;;----------------------------------------- DATOS FOOTER -----------------------------------------
	;;imprimir usuario
	call imprimir_usuario_footer
	;;imprimir fecha
	call imprimir_fechahora_footer
;;---------------------------------------FIN DATOS FOOTER---------------------------------------

;;------------------------------------------ DATOS TABLERO ------------------------------------------
	;Tablero Base
	call TABLERO_BASE
;;----------------------------------------FIN DATOS TABLERO----------------------------------------
	call POSICIONAR_VEHICULOS

	;;posiciones iniciales jugador
	mov fila_jugador, 17h
	mov columna_jugador, 13h

JUEGO:
	;;se imprime el jugador 
	call MOVER_JUGADOR

	;Pinta la Pantalla
	call pintar_mapa

	;;Verificar vidas -> Game Over
	cmp vidas, 00h
	je GAME_OVER

	;;Actualizar Movimientos Vehiculos
	;;col 0 o 27
	;;random de la fila 2 a 16
	call MOVER_VEHICULOS



	;;Actualizar Fecha_Hora
	call imprimir_fechahora_footer

	;;Actualizar Cronometros
	call imprimir_tiempo

	;;Verificar Colicion
		;;Si Pierde Las 3 Vidas se Termina el Juego

	;;Actualizar Vidas
	call imprimir_vidas

	;;Verificar Suma Punteo

	;;Actualizar Punteo
	call imprimir_cadena_punteo

	;;Verificar si se presiono tecla
		;;Actualizar Movimiento
		;;Menu Pausa
	call DETECTAR_TECLA

	jmp JUEGO
;
GAME_OVER:
	call limpiar_pantalla
	call imprimir_gameover
	jmp CREAR_TABLERO_JUEGO
    ;jmp FINAL_PROGRAMA

;; ==============================================  SUBRUTINAS  ==============================================

;; Delay Sin Parar El Programa
;; Entrada : DL -> Tiempo Base
;			 DH -> Tiempo de Espera
;			 DI -> direccion del tiempo base
;; Salida : bandera_tiempo = 0 -> no Paso Tiempo de Espera(DH) | 1 -> Paso Tiempo de Espera(DH)
DELAY:
	push DX
	mov AH, 2ch
	int 21h
	mov tiempo_actual, DL
	mov CL, DL ;;Copia Tiempo Actual
	pop DX
	cmp tiempo_actual, DL
	jae RESTA
	add tiempo_actual, 64
RESTA:
	sub tiempo_actual, DL
	cmp tiempo_actual, DH
	jae SI_PASO
	mov bandera_tiempo, 00h
	mov [DI], DL
	jmp FINAL_DELAY
SI_PASO:
	mov bandera_tiempo, 01h
	mov [DI], CL
FINAL_DELAY:
	ret

;; ---------------------------------------------- MOVER JUGADOR ----------------------------------------------
;; 
MOVER_JUGADOR:
	;;Colocar en mapa
	;;Entrada: AL -> columna
	;;         AH -> fila
	;;         BL -> valor a colocar
	mov AL, columna_jugador
	mov AH, fila_jugador

	cmp fila_jugador, 01h
	je SUMAR_PUNTEO
	cmp fila_jugador, 17h
	je REEMPLAZAR_ACERA_JUGADOR
	mov BL, JUGADOR_CARRIL
	call COLOCAR_EN_MAPA
	jmp retorno_mover_jugador
SUMAR_PUNTEO:
	add punteo_actual, 000ah
	mov fila_jugador, 17h
	mov columna_jugador, 13h
	mov AL, columna_jugador
	mov AH, fila_jugador
	mov BL, JUGADOR_ACERA
	call COLOCAR_EN_MAPA
	jmp retorno_mover_jugador 
REEMPLAZAR_ACERA_JUGADOR:
	mov BL, JUGADOR_ACERA
	call COLOCAR_EN_MAPA
retorno_mover_jugador:
	ret
;; ---------------------------------------------- FIN MOVER JUGADOR ----------------------------------------------
;; ----------------------------------------------- DETECTAR TECLA ------------------------------------------------------
DETECTAR_TECLA:
	mov AH, 01h 
	int 16h
	jz NO_TECLA
	;;se coloca en mapa la acera o carril dependiendo la fila del jugador
	mov AL, columna_jugador
	mov AH, fila_jugador
	cmp fila_jugador, 01h
	je PINTAR_ACERA_JUGADOR
	cmp fila_jugador, 17h
	je PINTAR_ACERA_JUGADOR
	mov BL, CARRIL
	call COLOCAR_EN_MAPA
	jmp SIG
PINTAR_ACERA_JUGADOR:
	mov BL, ACERA
	call COLOCAR_EN_MAPA
SIG:
	mov AH, 00h
	int 16h
	;;AH ->  scan code
	;; flecha arriba -> 48h
	;; flecha abajo -> 50h
	;; flecha derecha -> 4dh
	;; flecha izquierda -> 4bh
	cmp AH, 48h
	je MOVER_ARRIBA
	cmp AH, 50h
	je MOVER_ABAJO
	cmp AH, 4dh
	je MOVER_DERECHA
	cmp AH, 4bh
	je MOVER_IZQUIERDA
	jmp NO_TECLA
MOVER_ARRIBA:
	cmp fila_jugador, 02h
	jb NO_TECLA
	dec fila_jugador
	mov AL, columna_jugador
	mov AH, fila_jugador
	call OBTENER_DE_MAPA
	cmp BL, 04h
	je SIGUE_NORMAL_ARRIBA
	cmp BL, 03h
	je SIGUE_NORMAL_ARRIBA
	jmp PERDER_CHOQUE
SIGUE_NORMAL_ARRIBA:
	jmp NO_TECLA
MOVER_ABAJO:
	cmp fila_jugador, 16h
	ja NO_TECLA
	inc fila_jugador
	mov AL, columna_jugador
	mov AH, fila_jugador
	call OBTENER_DE_MAPA
	cmp BL, 04h
	je SIGUE_NORMAL_ABAJO
	cmp BL, 03h
	je SIGUE_NORMAL_ABAJO
	jmp PERDER_CHOQUE
SIGUE_NORMAL_ABAJO:
	jmp NO_TECLA
MOVER_DERECHA:
	cmp columna_jugador, 26h
	ja NO_TECLA
	inc columna_jugador
	mov AL, columna_jugador
	mov AH, fila_jugador
	call OBTENER_DE_MAPA
	cmp BL, 04h
	je SIGUE_NORMAL_DERECHA
	cmp BL, 03h
	je SIGUE_NORMAL_DERECHA
	jmp PERDER_CHOQUE
SIGUE_NORMAL_DERECHA:
	jmp NO_TECLA
MOVER_IZQUIERDA:
	cmp columna_jugador, 01h
	jb NO_TECLA
	dec columna_jugador
	mov AL, columna_jugador
	mov AH, fila_jugador
	call OBTENER_DE_MAPA
	cmp BL, 04h
	je SIGUE_NORMAL_IZQUIERDA
	cmp BL, 03h
	je SIGUE_NORMAL_IZQUIERDA
	jmp PERDER_CHOQUE
SIGUE_NORMAL_IZQUIERDA:
	jmp NO_TECLA
PERDER_CHOQUE:
	dec vidas
	mov fila_jugador, 17h
	mov columna_jugador, 13h
NO_TECLA:
	ret



;;----------------------------------------------- MOVER VEHICULOS -----------------------------------------------
;; cada fila tiene -> 27h columnas
;; max 16h columnas  
MOVER_VEHICULOS:
	mov fila_mapa, 02h
	mov columna_mapa, 00h
ciclo_fila_mov_vehiculos:
	;;se verifica el final de las filas
	cmp fila_mapa, 16h
	ja retorno_mov_vehiculos

ciclo_col_mov_vehiculos:
	cmp columna_mapa, 27h
	ja siguiente_fila_mov_vehiculos
	;; se utiliza obtener mapa y se verifica el objeto
	;; obtener_de_mapa -
	;; ENTRADA:
	;;  AL -> x del elemento columna
	;;  AH -> y del elemento fila
	;; SALIDA:
	;;  BL -> código del elemento
	mov AL, columna_mapa
	mov AH, fila_mapa
	push AX
	call OBTENER_DE_MAPA
	pop AX
	;;BL ESTA EL numero del OBJETO
	;;se verifica si es un vehiculo que se mueve a la derecha
	;; 05, 06
	cmp BL, 05
	je MOV_DERECHA_OBJ
	cmp BL, 06
	je MOV_DERECHA_OBJ
	;;se verifica si es un vehiculo que se mueve a la izquierda
	;; 07, 08
	cmp BL, 07
	je MOV_IZQUIERDA_OBJ
	cmp BL, 08
	je MOV_IZQUIERDA_OBJ
	;;se verifica si es un camion que se mueve a la derecha
	;; 09
	cmp BL, 09
	je MOV_DERECHA_CAMION
	jmp CONTINUE_COL_MOV_VEHICULOS

MOV_DERECHA_OBJ:
	push AX
	push CX
	push DX
	push DI
	;
	mov DL, tiempo_base_velocidad_media
	mov DH, 1Eh
	mov DI, offset tiempo_base_velocidad_media_aux
	call DELAY
	;
	pop DI
	pop DX
	pop CX
	pop AX
	cmp bandera_tiempo, 00h
	je siguiente_fila_mov_vehiculos
	call MOVER_DERECHA_OBJETO
	;call MOVER_DERECHA_OBJETO
	jmp siguiente_fila_mov_vehiculos
MOV_IZQUIERDA_OBJ:
	push AX
	push CX
	push DX
	push DI
	;
	mov DL, tiempo_base_velocidad_rapida
	mov DH, 0ah
	mov DI, offset tiempo_base_velocidad_rapida_aux
	call DELAY
	;
	pop DI
	pop DX
	pop CX
	pop AX
	cmp bandera_tiempo, 00h
	je siguiente_fila_mov_vehiculos
	call MOVER_IZQUIERDA_OBJETO
	jmp siguiente_fila_mov_vehiculos
MOV_DERECHA_CAMION:
	push AX
	push CX
	push DX
	push DI
	;
	mov DL, tiempo_base_velocidad_lenta
	mov DH, 5Ah
	mov DI, offset tiempo_base_velocidad_lenta_aux
	call DELAY
	;
	pop DI
	pop DX
	pop CX
	pop AX
	cmp bandera_tiempo, 00h
	je siguiente_fila_mov_vehiculos
	call MOVER_DERECHA_CAMION
	jmp siguiente_fila_mov_vehiculos
CONTINUE_COL_MOV_VEHICULOS:
	inc columna_mapa
	jmp ciclo_col_mov_vehiculos

siguiente_fila_mov_vehiculos:
	inc fila_mapa
	mov columna_mapa, 00h
	jmp ciclo_fila_mov_vehiculos

retorno_mov_vehiculos:
	push AX
	mov AL, tiempo_base_velocidad_lenta_aux
	mov tiempo_base_velocidad_lenta, AL
	mov AL, tiempo_base_velocidad_media_aux
	mov tiempo_base_velocidad_media, AL
	mov AL, tiempo_base_velocidad_rapida_aux
	mov tiempo_base_velocidad_rapida, AL
	pop AX
	ret

;;----------------------------------------------MOVER DERECHA OBJETO----------------------------------------------
;;entrada: AL -> columna
;;         AH -> fila
;;         BL -> objeto
MOVER_DERECHA_OBJETO:
	;;se dibuja carril en la posicion actual
	mov BH, 00
	push BX
	push AX
	mov BL, CARRIL
	call COLOCAR_EN_MAPA
	pop AX
	pop BX
	;;incremento una columna
	inc AL

	cmp AL, 27h
	jbe INSERTAR_OBJETO_DERECHA
	mov AL, 00h
INSERTAR_OBJETO_DERECHA:
	push BX
	push AX
	call OBTENER_DE_MAPA
	mov CL, BL
	;;verificar si es 
	pop AX
	pop BX
	cmp CL, 01h
	jne NOQUITAR_VIDA
	dec vidas
	mov fila_jugador, 17h
	mov columna_jugador, 13h
NOQUITAR_VIDA:
	;;COLOCAMOS en mapa
	push BX
	push AX
	call COLOCAR_EN_MAPA
	pop AX
	pop BX
	ret

;;----------------------------------------------MOVER DERECHA CAMION----------------------------------------------
;;entrada: AL -> columna
;;         AH -> fila
;;         BL -> objeto
;; == 09| 10
MOVER_DERECHA_CAMION:
	;; se dibuja carril en la posicion actual
	mov BH, 00
	push BX
	push AX ;;posicion camion inicio
	mov BL, CARRIL
	call COLOCAR_EN_MAPA
	pop AX ;;posicion camion inicio
	pop BX
	;;incremento una columna
	inc AL 	
	cmp AL, 27h
	jb INSERTAR_TODO_CAMION
	je INSERTAR_SOLO_INICIO_CAMION
	mov AL, 00h
	jmp INSERTAR_TODO_CAMION

INSERTAR_SOLO_INICIO_CAMION:
	mov BL, CAMIONINI
	call COLOCAR_EN_MAPA
	jmp RETORNO_MOV_CAMION
INSERTAR_TODO_CAMION:
	push BX
	push AX
	mov BL, CAMIONINI
	call COLOCAR_EN_MAPA
	pop AX
	pop BX
	inc AL
	push BX
	push AX
	call OBTENER_DE_MAPA
	mov CL, BL
	pop AX
	pop BX
	cmp CL, 01h
	jne NOQUITAR_VIDACAMION
	dec vidas
	mov fila_jugador, 17h
	mov columna_jugador, 13h
NOQUITAR_VIDACAMION:
	mov BL, CAMIONFIN
	call COLOCAR_EN_MAPA
RETORNO_MOV_CAMION:
	ret


;;----------------------------------------------FIN MOVER DERECHA OBJETO----------------------------------------------
;; ---------------------------------------------- MOVER IZQUIERDA OBJETO ----------------------------------------------
;;entrada: AL -> columna
;;         AH -> fila
;;         BL -> objeto
MOVER_IZQUIERDA_OBJETO:
	;;se dibuja carril en la posicion actual
	mov BH, 00
	push BX
	push AX
	mov BL, CARRIL
	call COLOCAR_EN_MAPA
	pop AX
	pop BX
	;;incremento una columna
	cmp AL, 00h
	je MOVER2
	dec AL
	jmp INSERTAR_OBJETO_IZQUIERDA
MOVER2:
	mov AL, 27h
INSERTAR_OBJETO_IZQUIERDA:
	push BX
	push AX
	call OBTENER_DE_MAPA
	mov CL, BL
	pop AX
	pop BX
	cmp CL, 01h
	jne NOQUITAR_VIDAIZQ
	dec vidas
	mov fila_jugador, 17h
	mov columna_jugador, 13h
NOQUITAR_VIDAIZQ:
	push BX
	push AX
	call COLOCAR_EN_MAPA
	pop AX
	pop BX
	ret
	

;; ---------------------------------------------- POSICIONAR VEHICULOS ----------------------------------------------
;;posiciona los vehiculos en el tablero
POSICIONAR_VEHICULOS:
	mov cont_fila, 02h
	;;random de vehiculos rango 5 a 9
ciclo_colocar_vehiculos:
	mov BL, 05h
	mov BH, 09h
	call NUMERO_RANDOM
	mov carro_random, AH ;;se guarda el random en carro_random

	;;random para posicionarlos en las columnas
	mov BL, 00h
	mov BH, 26h
	call NUMERO_RANDOM
	;;posicion fila en AH
	mov AL, AH			;random columna
	mov AH, cont_fila	;cada fila
	push AX
	mov BL, carro_random
	call COLOCAR_EN_MAPA

	cmp BL, 09h	
	jne NO_CAMION
	pop AX
	push AX
	inc AL
	mov BL, CAMIONFIN
	call COLOCAR_EN_MAPA
	
NO_CAMION:
	pop AX
	inc cont_fila
	cmp cont_fila, 16h
	jbe ciclo_colocar_vehiculos
	ret

;; ---------------------------------------------- GENERAR NUMEROS ALEATORIOS ----------------------------------------------
;; BL -> limite inferior
;; BH -> limite superior
;; SALIDA:
;;  AH -> número aleatorio

;; 48%16 = 
NUMERO_RANDOM:
	mov AH, 00h
	int 1ah
	;;en DX tenemos el número aleatorio
	mov AX, DX ;;numero random
	mul semilla_random
	
	ror AX, 1
	ror AX, 1
	ror AX, 1
	and AX, 03ffh

	mov semilla_random, AX
	inc semilla_random
	;;segun los limites
	sub BH, BL ;-> 16, 2 = 14 -> BH ->14
	inc BH ;-> 15
	;;	
	div BH

	;;ahora en AH -> se encuentra residuo
	add AH, BL

	;;AH -> NUMERO RANDOM
	ret

;; ---------------------------------------------- ACTUALIZAR CRONOMETRO ----------------------------------------------
INCREMENTAR_CRONOMETRO:
	inc contsegundo
	cmp contsegundo, 3ch
	jne FIN_CRONOMETRO
	mov contsegundo, 00h
	inc contminuto
	cmp contminuto, 3ch
	jne FIN_CRONOMETRO
	mov contminuto, 00h
	inc conthora
FIN_CRONOMETRO:
	ret
;; ---------------------------------------------- FIN ACTUALIZAR CRONOMETRO ----------------------------------------------

;; ---------------------------------------------- Tablero Base --------------------------------------------------
TABLERO_BASE:
	;; Y filas 1 -> 17
	;; X columnas 0 -> 27
	mov fila_tablero, 01h
	mov col_tablero, 00h
IMPRIMIR_INICIO_BANQUETA:
	mov AL, col_tablero  	;;columna
	mov AH, fila_tablero		;;fila
	mov BL, ACERA
	call COLOCAR_EN_MAPA
	inc col_tablero
	cmp col_tablero, 27
	jbe IMPRIMIR_INICIO_BANQUETA

	mov fila_tablero, 17h
	mov col_tablero, 00h
IMPRIMIR_FINAL_BANQUETA:
	mov AL, col_tablero  	;;columna
	mov AH, fila_tablero		;;fila
	mov BL, ACERA
	call COLOCAR_EN_MAPA
	inc col_tablero
	cmp col_tablero, 27
	jbe IMPRIMIR_FINAL_BANQUETA

	mov fila_tablero, 02h
	mov col_tablero, 00h
IMPRIMIR_CARRILES:
	mov AL , col_tablero
	mov AH, fila_tablero
	mov BL, CARRIL
	call COLOCAR_EN_MAPA
	inc col_tablero
	cmp col_tablero, 27
	jbe IMPRIMIR_CARRILES
	mov col_tablero, 00h
	inc fila_tablero
	cmp fila_tablero, 16
	jbe IMPRIMIR_CARRILES
	ret
;; ---------------------------------------------- FIN Tablero Base ----------------------------------------------

;; ---------------------------------------------- COL0CAR EN MAPA ----------------------------------------------
;;Colocar en mapa
;;Entrada: AL -> columna
;;         AH -> fila
;;         BL -> valor a colocar
COLOCAR_EN_MAPA:
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
	mov SI, offset mapa_tablero
	add SI, AX
	mov [SI], BL
	ret
;; ---------------------------------------------- FIN COL0CAR EN MAPA ----------------------------------------------

;; --------------------------------------------- OBTENER DE MAPA ---------------------------------------------
;; obtener_de_mapa -
;; ENTRADA:
;;  AL -> x COLUMNA del elemento
;;  AH -> y FILA del elemento
;; SALIDA:
;;  BL -> código del elemento
OBTENER_DE_MAPA:
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
	mov SI, offset mapa_tablero
	add SI, AX
	mov BL, [SI]
	ret
;; --------------------------------------------- FIN OBTENER DE MAPA ---------------------------------------------

;; ---------------------------------------------- PINTAR MAPA ----------------------------------------------
;;sprites a pintar
;;pintar jugador acer
pintar_jugador_acera:
		mov BX, offset sprite_jugador_acera
		jmp pintar_sprite_en_posicion
;;pintar jugador carril
pintar_jugador_carril:
		mov BX, offset sprite_jugador_carril
		jmp pintar_sprite_en_posicion
;;pintar acera
pintar_acera:
		mov BX, offset sprite_banqueta
		jmp pintar_sprite_en_posicion
;;pintar carril
pintar_carril:
		mov BX, offset sprite_carril
		jmp pintar_sprite_en_posicion
;;pintar carro morado derecha
pintar_carro_morado_derecha:
		mov BX, offset sprite_carro_morado_derecha
		jmp pintar_sprite_en_posicion
;;pintar carro azul derecha
pintar_carro_azul_derecha:
		mov BX, offset sprite_carro_azul_derecha
		jmp pintar_sprite_en_posicion
;;pintar carro verde izquierda
pintar_carro_verde_izq:
		mov BX, offset sprite_carro_verde_izq
		jmp pintar_sprite_en_posicion
;;pintar carro amarillo izquierda
pintar_carro_amarillo_izq:
		mov BX, offset sprite_carro_amarillo_izq
		jmp pintar_sprite_en_posicion
;;pintar camion blanco inicio
pintar_camion_blanco_inicio:
		mov BX, offset sprite_inicio_camion_blanco
		jmp pintar_sprite_en_posicion
;;pintar camion blanco fin
pintar_camion_blanco_fin:
		mov BX, offset sprite_fin_camion_blanco
		jmp pintar_sprite_en_posicion

;; pintar_mapa ---------------------------------------------
pintar_mapa:
		mov AX, 0000
		mov [coordenada_actual], AX
		mov CX, 19
ciclo_filas_mapa:
		xchg BP, CX
		mov CX, 28
ciclo_columnas_mapa:
		mov AX, [coordenada_actual]
		call OBTENER_DE_MAPA
		;; ============================
		;; selección de sprite a pintar
		;; ============================		
		;;jugador acera
		cmp BL, JUGADOR_ACERA
		je pintar_jugador_acera

		;;jugador carril
		cmp BL, JUGADOR_CARRIL
		je pintar_jugador_carril

		;;acera
		cmp BL, ACERA
		je pintar_acera

		;;carril
		cmp BL, CARRIL
		je pintar_carril

		;;carro morado a la derecha
		cmp BL, R_CARROMORADO
		je pintar_carro_morado_derecha

		;;carro azul a la derecha
		cmp BL, R_CARROAZUL
		je pintar_carro_azul_derecha

		;;carro verde a la izquierda
		cmp BL, L_CARROVERDE
		je pintar_carro_verde_izq

		;;carro amarillo a la izquierda
		cmp BL, L_CARROAMARILLO
		je pintar_carro_amarillo_izq

		;;camion blanco inicio
		cmp BL, CAMIONINI
		je pintar_camion_blanco_inicio

		;;camion blanco fin
		cmp BL, CAMIONFIN
		je pintar_camion_blanco_fin

		jmp ciclo_columnas_mapa_loop
		;; ==============================================
		;; definición de qué sprite pintar para cada caso
		;; ==============================================

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

;; ---------------------------------------------- IMPRIMIR SPRITE ----------------------------------------------

;;Imprimir Sprite 8x8
;;Entrada : direccion_sprite -> offset del sprite
;;          SI -> coordena fila de 00 a 18 HEX o 0 a 24 DEC
;;          DI -> coordenada columna de 00 a 27 HEX o 0 a 39 DEC
;;Tambien se utiliza AX,DX,CX,SI,DI, entrada_direccion se modifican
;Salida  : Ninguna
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
; pintar_pixel - pinta un pixel en una posición x, y
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

;; ---------------------------------------------- FIN IMPRIMIR SPRITE ----------------------------------------------

;; ---------------------------------------------- ROW MAYOR ----------------------------------------------
;Converti coordenada x,y a indice. Formula: indice = fila*N_columnas + columna
;Entrada :  SI -> coordenada fila
;           DI -> coordenada columna
;           AX -> N_columnas
;Salida  : AX -> indice de la coordenada x,y
ROW_MAYOR: 
    mul SI
    add AX, DI
    ret

;; ---------------------------------------------- FIN ROW MAYOR ----------------------------------------------

;; ---------------------------------------------- LIMPIAR PANTALLA ----------------------------------------------
;; limpiar_pantalla - limpia la pantalla
limpiar_pantalla:
		;;Colocal Cursos en 0,0
		mov DH, 00 ;; y fila
		mov DL, 00 ;; x col
		mov BH, 00
		mov AH, 02
		int 10h
		mov CX, 19
ciclo_limpiar_pantalla:
		mov DX, offset cadena_limpiar
		mov AH, 09
		int 21
		loop ciclo_limpiar_pantalla
		ret
;; ---------------------------------------------- FIN LIMPIAR PANTALLA ----------------------------------------------

;; ---------------------------------------------- IMPRIMIR CADENA RESULTADO ----------------------------------------------
;; numAstr - convierte un número entero en cadena
;;     Entrada: AX -> numero de entrada
;;				DI -> offset de la cadena
;;				CX -> tamaño de la cadena
;;     Salida:  offset de la cadena -> el número convertido a cadena
numAstr:         
    mov BX, DI ;;direccion cadena resultado
    mov DX, 0030h
limpiar:        
    mov [BX], DL
    inc BX
    loop limpiar
    dec BX                   ;;; Posicionarse en el caracter de las unidades
    cmp AX, 0000h            ;;; Si el número es 0 no hacer nada
    je retorno
	jg unidad
	neg AX
	mov DL, 2d
    mov BX, DI
	mov [BX], DL
unidad:         
    mov DL,[BX]              ;;; Incrementar las unidades
    inc DL
    mov [BX],DL
    dec AX                   ;;; Decrementar el número de entrada
    mov SI, BX               ;;; Guardar el dato de la posición de las unidades en otro registro
revisar_cifra:  
    mov DX, 3ah              ;;; Si en las unidades está el caracter 3Ah o :
    cmp [BX], DL
    je incrementa_ant        ;;; Saltar a la parte donde se incrementa la cifra anterior
    mov BX, SI               ;;; Restablecer la posición de las unidades en el registro original
    cmp AX, 0000h            ;;; Si el número de entrada no es 0
    jne unidad               ;;; Volver a incrementar unidades
    jmp retorno              ;;; Si no terminar rutina
incrementa_ant: 
    mov DX, 30h              ;;; Se coloca el caracter '0' en la cifra actual
    mov [BX], DL
    dec BX                   ;;; Se mueve el índice a la cifra anterior
    mov DL, [BX]             ;;; Se incrementa la cifra indexada por BX
    inc DL
    mov [BX], DL
    cmp BX, DI    			;;; Si el índice actual no es la direccion de la primera cifra
    jne revisar_cifra        ;;; revisar la cifra anterior para ver si nuevamente hay que incrementarla
    mov BX, SI               ;;; Reestablecer la posición de las unidades en el registro original
    cmp AX, 0000h            ;;; Si el número de entrada no es 0
    jne unidad               ;;; Volver a incrementar unidades
retorno:        
    ret                      ;;; Si no retornar
;; ---------------------------------------------- FIN IMPRIMIR CADENA RESULTADO ----------------------------------------------
;; ------------------------------------------------ IMPRIMIR cadena_punteo ----------------------------------------------
;;imprime el cadena_punteo en pantalla
imprimir_cadena_punteo:
	;;Se mueven los parametros de la funcion
	mov AX, punteo_actual		;;la cantidad
	mov DI, offset cadena_punteo ;;la cadena de salida
	mov CX, 05h					;; tamaño de cadena de salida
	call numAstr
	mov DH, 00 ;; y fila
	mov DL, 00 ;; x col
	mov BH, 00
	mov AH, 02
	int 10h

	mov DX, offset cadena_punteo
	mov AH, 09
	int 21
	ret

;; ---------------------------------------------- IMPRIMIR VIDA ----------------------------------------------
;;segun el numero de vidas se imprime el caracter de vida o no vida
imprimir_vidas:
	mov DH, 00 ;; y fila
	mov DL, 10 ;; x coL
	mov BH, 00
	mov AH, 02 ;; interrupcion
	int 10h
	;;
	mov CX, 00h
	mov CL, 03h
	;;
	mov SI, vidas; le pasa un 02
ciclo_imp_vidas: ;;0
	cmp SI, 00h
	ja imprimir_vida
	mov DX, offset novida_caracter
	mov AH, 09
	int 21
	jmp ciclo
imprimir_vida:
	mov DX, offset vida_caracter
	mov AH, 09
	int 21
	dec SI
ciclo:
	loop ciclo_imp_vidas
	ret

;; ---------------------------------------------- FIN IMPRIMIR VIDA ----------------------------------------------
;; ---------------------------------------------- IMPRIMIR TIEMPO ----------------------------------------------
;;imprime el tiempo en pantalla
imprimir_tiempo:
	;;Se mueven los parametros de la funcion
	mov AX, conthora		;;la cantidad
	mov DI, offset horas ;;la cadena de salida
	mov CX, 02h					;; tamaño de cadena de salida
	call numAstr

	mov AX, contminuto		;;la cantidad
	mov DI, offset minutos ;;la cadena de salida
	mov CX, 02h					;; tamaño de cadena de salida
	call numAstr

	mov AX, contsegundo		;;la cantidad
	mov DI, offset segundos ;;la cadena de salida
	mov CX, 02h					;; tamaño de cadena de salida
	call numAstr


	mov DH, 00 ;; y fila
	mov DL, 20;; x col
	mov BH, 00
	mov AH, 02
	int 10h

	mov DX, offset horas
	mov AH, 09
	int 21
	ret

;; ---------------------------------------------- FIN IMPRIMIR TIEMPO ----------------------------------------------
;; ---------------------------------------------- IMPRIMIR USUARIO ----------------------------------------------
;;imprime el usuario en pantalla
imprimir_usuario_footer:
	mov DH, 18 ;; y fila
	mov DL, 00;; x col
	mov BH, 00
	mov AH, 02
	int 10h

	mov DX, offset usuario_actual
	mov AH, 09
	int 21
	ret

;; ---------------------------------------------- FIN IMPRIMIR USUARIO ----------------------------------------------
;; ---------------------------------------------- IMPRIMIR FECHA ----------------------------------------------

;;imprime la fecha en pantalla
imprimir_fechahora_footer:
	;;Se obtiene la fecha 
	mov AH, 2ah
	int 21h
	;;dia
	mov BH, 00
	mov BL, DL
	mov dia_numero, BX
	;;mes
	mov BH, 00
	mov BL, DH
	mov mes_numero, BX
	;;año
	mov ahno_numero, CX

	;;Se obtiene la hora
	mov AH, 2ch
	int 21h

	;;hora
	mov BH, 00
	mov BL, CH
	mov hora_numero, BX
	;;minutos
	mov BH, 00
	mov BL, CL
	mov minutos_numero, BX
	;;segundos
	mov BH, 00
	mov BL, DH
	mov segundos_numero, BX

	mov AX, segundos_numero
	cmp segundo_ant, AX
	je SIGUE_FECHAHORA
	mov segundo_ant, AX
	;;Funcion Incrementar Tiempo
	call INCREMENTAR_CRONOMETRO
	;;
SIGUE_FECHAHORA:
	;;Se mueven los parametros de la funcion
	mov AX, dia_numero		;;la cantidad
	mov DI, offset dia_cadena ;;la cadena de salida
	mov CX, 02h					;; tamaño de cadena de salida
	call numAstr

	mov AX, mes_numero		;;la cantidad
	mov DI, offset mes_cadena ;;la cadena de salida
	mov CX, 02h					;; tamaño de cadena de salida
	call numAstr

	mov AX, ahno_numero		;;la cantidad
	mov DI, offset anho_cadena ;;la cadena de salida
	mov CX, 04h					;; tamaño de cadena de salida
	call numAstr

	mov AX, hora_numero		;;la cantidad
	mov DI, offset hora_cadena ;;la cadena de salida
	mov CX, 02h					;; tamaño de cadena de salida
	call numAstr

	mov AX, minutos_numero		;;la cantidad
	mov DI, offset minutos_cadena ;;la cadena de salida
	mov CX, 02h					;; tamaño de cadena de salida
	call numAstr

	mov AX, segundos_numero		;;la cantidad
	mov DI, offset segundos_cadena ;;la cadena de salida
	mov CX, 02h					;; tamaño de cadena de salida
	call numAstr

	mov DH, 18;; y fila
	mov DL, 14;; x col
	mov BH, 00
	mov AH, 02
	int 10h

	mov DX, offset dia_cadena
	mov AH, 09
	int 21

	ret

;; ---------------------------------------------- FIN IMPRIMIR FECHA ----------------------------------------------
;; ----------------------------------------------IMPRIMIR GAME OVER ----------------------------------------------
;;imprime el game over en pantalla
imprimir_gameover:
	mov DH, 0b ;; y fila
	mov DL, 0f;; x col
	mov BH, 00
	mov AH, 02
	int 10h

	mov DX, offset gameover_cadena
	mov AH, 09
	int 21

	;;mostrar puntaje
	mov DH, 0c ;; y fila
	mov DL, 12; x col
	mov BH, 00
	mov AH, 02
	int 10h

	mov DX, offset cadena_punteo
	mov AH, 09
	int 21

	;;reiniciar variables juego
	mov vidas, 03h
	mov punteo_actual, 00h
	mov conthora, 00h
	mov contminuto, 00h
	mov contsegundo, 00h
	mov semilla_random, 01h

	MOV SI, 2710h
e2:	
	DEC SI
	JZ e3
	MOV DI, 222Eh
e1:		
	DEC DI
	JNZ e1
	JMP e2
e3:
	ret
FINAL_PROGRAMA:
jmp FINAL_PROGRAMA
;;---------------------------------------FIN_INSTRUCCIONES---------------------------------------
.EXIT
END  
