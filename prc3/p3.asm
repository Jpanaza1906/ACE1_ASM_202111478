.RADIX 16
.MODEL SMALL ;; Definicion del modelo de memoria
;; Definicion de segmentos
ficha_a equ 'O'
ficha_b equ 'X'
.STACK 
.DATA ;; Segmento de datos

;;---------------------------------Encabezado-----------------------------------------
usac DB 0AH, 0DH, "Universidad San Carlos de Guatemala", 0AH, 0DH, "$"
facultad DB "Facultad de Ingenieria", 0AH, 0DH, "$"
curso DB "Arquitectura de Computadores y Ensambladores 1", 0AH, 0DH, "$"
seccion DB "Seccion 'A'", 0AH, 0DH, "$"
semestre DB "Segundo Semestre 2023" , 0AH, 0DH, "$"
nombre DB 0AH, 0DH, "Nombre: Jose David Panaza Batres", 0AH, 0DH, "$"
carne DB "Carnet: 202111478", 0AH, 0DH, "$"
continue DB 0AH, 0DH, "Presione 'Enter' para continuar...", 0AH, 0DH, "$"
;;---------------------------------Fin de Encabezado---------------------------------
;;---------------------------------Lectura-------------------------------------------
filename DB "AYUDA.TXT", 0 ;; Nombre del archivo
buffer DB 51 DUP (?) ;; Buffer de lectura
buffer_size DW 51 ;; Tamaño del buffer
handle DW ? ;; Handle del archivo
line_count DW 0 ;; Contador de lineas
page_message DB 0AH, 0DH, "Presione 'n' para avanzar a la siguiente pagina o 'q' para salir...", 0AH, 0DH, "$" ;; Mensaje de pagina
open_error_message DB 0AH, 0DH, "Error al abrir el archivo", 0AH, 0DH, "$" ;; Mensaje de error al abrir el archivo
read_error_message DB 0AH, 0DH, "Error al leer el archivo", 0AH, 0DH, "$" ;; Mensaje de error al leer el archivo
allowed_chars db "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 $.,;:!?()[]{}<>-=\n\r\t", 0AH, 0DH, "$"
cadenaInvalida DB 0AH, 0DH, "La cadena contiene caracteres no permitidos.", 0AH, 0DH, "$"
;;---------------------------------Fin de Lectura-------------------------------------
;;---------------------------------Menu de Juego--------------------------------------
menu0   db 0a,"Elija una opcion:", 0a, "a. Jugador VS Jugador ",0a,"s. Jugador VS PC" , 0a, "d. Cargar", 0a, "f. Salir", 0a, "$"
mensaje_nombre_a db 0a,"Escriba el nombre del jugador 1: ", 0a, "$"
mensaje_nombre_b db 0a,"Escriba el nombre del jugador 2: ", 0a, "$"
mensaje_nombrej db 0a,"Escriba el nombre del jugador: ", 0a, "$"
nl db 0a, "$"
columna_ingreso db 0a," Ingrese la columna: ", 0a, "$"
gano db 0a," Gano el jugador: ", 0a, "$"
empate db 0a," Empate ", 0a, "$"
buffer_nombre db 20,00
              db 20 dup(00)
nombre_jugador_a db 00
                 db 20 dup(00)  
nombre_jugador_b db 00
                 db 20 dup(00)

tablero db 2a dup (00)
encabezado_tablero  db "  A   S   D   F   J   K   L  ", 0a
                    db " ___ ___ ___ ___ ___ ___ ___", 0a, "$"
antes_fila db "| $"
entre_columnas db " | $"
pie_tablero db "|___|___|___|___|___|___|___|", 0a, "$"
ficha_actual db ficha_a
fa db 0
fb db 0
hordia db 0
verdia db 0
totalfichas db 0
pc_name db "PC", 0a, "$"
last_number db 0
;;---------------------------------Fin de Menu de Juego--------------------------------
;;------------------------------------Guardar partida-----------------------------------
nombre_guardar db 0c dup (00),00
extension_guardar db ".SAV", 00
buffer_entrada  db 0ff,00
                db 0ff dup (00)
mensaje_guardar db 0a, "Escriba el nombre del archivo: ", 0a, "$"
handle_guardar dw 000
handle_cargar dw 000
;;------------------------------------Fin de Guardar partida----------------------------
;;--------------------------------------Reporte de Partidas------------------------------
filename_reporte db "REP.HTM", 0 ;; Nombre del archivo
html_eskeleton db "<html><head><title>Reporte de Partidas</title></head><body><h1>Reporte de Partidas</h1>", 0
table_header db "<table><tr><th>Nombre Jugador A</th><th>Nombre Jugador B</th><th>Ficha</th><th> Ganador </th></tr>", 0
new_table db "<table>"
html_row db "<tr><td>", 0
html_othercol db "</td><td>", 0
html_endrow db "</td></tr>", 0
table_end db "</table>", 0
html_end db "</body></html>", 0
handle_reporte dw 000
.CODE 
.STARTUP ;; Inicio de programa
;; logica del programa
ENCABEZADO:
;;-------------------------------Mostrar Encabezado-------------------------------
    mov AH, 09 ;; Funcion para mostrar cadena de caracteres
    mov DX, offset usac ;; Direccion de memoria de la cadena de caracteres
    int 21 ;; interrupcion para mostrar cadena de caracteres
    mov AH, 09 ;; Funcion para mostrar cadena de caracteres
    mov DX, offset facultad ;; Direccion de memoria de la cadena de caracteres
    int 21 ;; interrupcion para mostrar cadena de caracteres
    mov AH, 09 ;; Funcion para mostrar cadena de caracteres
    mov DX, offset curso ;; Direccion de memoria de la cadena de caracteres
    int 21 ;; interrupcion para mostrar cadena de caracteres
    mov AH, 09 ;; Funcion para mostrar cadena de caracteres
    mov DX, offset seccion ;; Direccion de memoria de la cadena de caracteres
    int 21 ;; interrupcion para mostrar cadena de caracteres
    mov AH, 09 ;; Funcion para mostrar cadena de caracteres
    mov DX, offset semestre ;; Direccion de memoria de la cadena de caracteres
    int 21 ;; interrupcion para mostrar cadena de caracteres
    mov AH, 09 ;; Funcion para mostrar cadena de caracteres
    mov DX, offset nombre ;; Direccion de memoria de la cadena de caracteres
    int 21 ;; interrupcion para mostrar cadena de caracteres
    mov AH, 09 ;; Funcion para mostrar cadena de caracteres
    mov DX, offset carne ;; Direccion de memoria de la cadena de caracteres
    int 21 ;; interrupcion para mostrar cadena de caracteres
    mov AH, 09 ;; Funcion para mostrar cadena de caracteres
    mov DX, offset continue ;; Direccion de memoria de la cadena de caracteres
    int 21 ;; interrupcion para mostrar cadena de caracteres
;;---------------------------------Fin de Encabezado---------------------------------
;;---------------------------------Pausa---------------------------------
PAUSA: ;; Etiqueta para pausar el programa
    ;;si viene exactamente un enter, entonces continua
    mov AH, 1 ;; Funcion para leer un caracter
    int 21 ;; interrupcion para leer un caracter
    cmp AL, 0DH ;; Compara si el caracter es un enter
    JNE PAUSA ;; Si no es un enter, entonces vuelve a pedir un caracter
;;---------------------------------Fin de Pausa---------------------------------
;;---------------------------------Lectura---------------------------------
ABRIR_ARCH:
;Abrir archivo
    mov AH, 3DH ;; Funcion para abrir un archivo
    mov AL, 0 ;; Modo de apertura
    mov DX, offset filename ;; Direccion de memoria del nombre del archivo
    int 21 ;; interrupcion para abrir un archivo
    JC OPEN_ERROR ;; Si hay error, entonces salta a la etiqueta OPEN_ERROR
    mov handle, AX ;; Guarda el handle del archivo
LEER_ARCH:
;Leer archivo
    mov AH, 3FH ;; Funcion para leer un archivo
    mov BX, handle ;; Handle del archivo
    mov CX, buffer_size ;; Tamaño del buffer
    mov DX, offset buffer ;; Direccion de memoria del buffer
    int 21 ;; interrupcion para leer un archivo
    JC READ_ERROR ;; Si hay error, entonces salta a la etiqueta READ_ERROR
;Mostrar archivo
    ;;Si el buffer esta vacio, entonces salta a la etiqueta RESPUESTA_ARCH
    cmp AX, 0 ;; Compara si el buffer esta vacio
    je RESPUESTA_ARCH ;; Si esta vacio, entonces salta a la etiqueta RESPUESTA_ARCH
    ;;Agregarle $ al final del buffer
    mov SI, offset buffer ;; Direccion de memoria del buffer
    add SI, buffer_size ;; Suma el tamaño del buffer a la direccion de memoria del buffer
    DEC SI ;; Decrementa la direccion de memoria del buffer
    mov AL, '$' ;; Caracter $
    mov [SI], AL ;; Guarda el caracter $ en la direccion de memoria del buffer
;;Se verifica si la cadena contiene solo caracteres permitidos
    mov SI, 0 ;; Se inicializa el indice de la cadena
    mov CX, 0 ;; Se inicializa el contador de caracteres permitidos
    mov AL, buffer[SI] ;; Se obtiene el primer caracter de la cadena
;Se recorre la cadena caracter por caracter
LOOP_VERIFICAR:
    ;cmp AL, 0 ;; Se verifica si el caracter es el caracter nulo
    ;je CADENA_VALIDA ;; Si es el caracter nulo, entonces la cadena es valida

    ;verificar si el caracter es permitido
    mov DI, 0 ;; Se inicializa el indice de los caracteres permitidos
    mov AH, AL ;; Se guarda el caracter en AH
    mov AL, allowed_chars[DI] ;; Se obtiene el primer caracter permitido
COMPARAR_CARACTER:
    cmp AH, AL ;; Se compara el caracter con el caracter permitido
    je CARACTER_PERMITIDO ;; Si son iguales, entonces el caracter es permitido
    inc DI ;; Se incrementa el indice de los caracteres permitidos
    mov AL, allowed_chars[DI] ;; Se obtiene el siguiente caracter permitido
    ;;si el DI es igual al tamaño de la cadena de caracteres permitidos, entonces la cadena es invalida
    cmp DI, 64 ;; Se compara el indice de los caracteres permitidos con el tamaño de la cadena de caracteres permitidos
    je CADENA_INVALIDA ;; Si son iguales, entonces la cadena es invalida
    jmp COMPARAR_CARACTER ;; Si no es el caracter nulo, entonces se vuelve a comparar el caracter con el caracter permitido
    ;jmp FIN_LECTURA ;; Si es el caracter nulo, entonces la cadena es invalida
    ;jmp CADENA_INVALIDA ;; Si es el caracter nulo, entonces la cadena es invalida
    ;jmp CADENA_VALIDA ;; Si no es el caracter nulo, entonces la cadena es valida

CARACTER_PERMITIDO:
    inc SI ;; Se incrementa el indice de la cadena
    mov AL, buffer[SI] ;; Se obtiene el siguiente caracter de la cadena
    inc CX ;; Se incrementa el contador de caracteres permitidos
    ;;Si el contador SI es igual al tamaño del buffer, entonces la cadena es valida
    cmp CX, buffer_size ;; Se compara el contador de caracteres permitidos con el tamaño del buffer
    je CADENA_VALIDA ;; Si son iguales, entonces la cadena es valida
    jmp LOOP_VERIFICAR ;; Se vuelve a verificar el siguiente caracter de la cadena
CADENA_VALIDA:
    ;;Mostrar el buffer
    mov AH, 09 ;; Funcion para mostrar cadena de caracteres
    mov DX, offset buffer ;; Direccion de memoria del buffer
    int 21 ;; interrupcion para mostrar cadena de caracteres
    ;;contar el numero de lineas
    inc line_count ;; incrementa el contador de lineas
    cmp line_count, 14 ;; Compara si el contador de lineas es igual a 20
    JL LEER_ARCH ;; Si es menor o igual a 20, entonces vuelve a leer el archivo
    mov line_count, 0 ;; Reinicia el contador de lineas
RESPUESTA_ARCH:
;Preguntar si desea continuar
    mov AH, 09 ;; Funcion para mostrar cadena de caracteres
    mov DX, offset page_message ;; Direccion de memoria de la cadena de caracteres
    int 21 ;; interrupcion para mostrar cadena de caracteres
    ;;Leer respuesta
    mov AH, 1 ;; Funcion para leer un caracter
    int 21 ;; interrupcion para leer un caracter
    cmp AL, "n" ;; Compara si el caracter es n
    je LEER_ARCH ;; Si es n, entonces vuelve a leer el archivo
    cmp AL, "q" ;; Compara si el caracter es q
    je FIN_LECTURA ;; Salta a la etiqueta FIN
    ;;Si no es n o q, entonces vuelve a preguntar
    jmp RESPUESTA_ARCH
CADENA_INVALIDA:
    mov AH, 09 ;; Funcion para mostrar cadena de caracteres
    mov DX, offset cadenaInvalida ;; Direccion de memoria de la cadena de caracteres
    int 21 ;; interrupcion para mostrar cadena de caracteres
    jmp FIN_LECTURA
OPEN_ERROR:
    ;Error al abrir el archivo
    mov AH, 09 ;; Funcion para mostrar cadena de caracteres
    mov DX, offset open_error_message ;; Direccion de memoria de la cadena de caracteres
    int 21 ;; interrupcion para mostrar cadena de caracteres
READ_ERROR:
    ;Error al leer el archivo
    mov AH, 09 ;; Funcion para mostrar cadena de caracteres
    mov DX, offset read_error_message ;; Direccion de memoria de la cadena de caracteres
    int 21 ;; interrupcion para mostrar cadena de caracteres

FIN_LECTURA:
    ;Cerrar archivo
    mov AH, 3EH ;; Funcion para cerrar un archivo
    mov BX, handle ;; Handle del archivo
    int 21 ;; interrupcion para cerrar un archivo
;;---------------------------------Fin de Lectura---------------------------------
;;---------------------------------Menu de Juego--------------------------------------
MENU_JUEGO:
    mov DX, offset menu0
    mov AH, 09
    int 21
    ;;Se espera el caracter de entrada
    mov AH, 08H
    int 21
    ;;Leer respuesta
    cmp AL, "a" ;; Compara si el caracter es a
    je JUGAR 
    cmp AL, "s" ;; Compara si el caracter es s
    je JUGARPC ;; 
    cmp AL, "d" ;; Compara si el caracter es s
    je CARGAR 
    cmp AL, "f" ;; Compara si el caracter es d
    je SALIR 
    jmp MENU_JUEGO
JUGAR:
    ;;reiniciar tablero
    mov SI, offset tablero
    mov CX, 2a
    mov AL, 00
    ciclo_reiniciar_tablero:
        mov [SI], AL
        inc SI
        loop ciclo_reiniciar_tablero
    ;;reiniciar ficha actual
    mov AL, ficha_a
    mov [ficha_actual], AL
    ;;reiniciar contadores
    mov fa, 00
    mov fb, 00
    ;;reiniciar nombres
    mov SI, offset nombre_jugador_a
    mov CX, 20
    mov AL, 00
    ciclo_reiniciar_nombre_a:
        mov [SI], AL
        inc SI
        loop ciclo_reiniciar_nombre_a
    mov SI, offset nombre_jugador_b
    mov CX, 20
    mov AL, 00
    ciclo_reiniciar_nombre_b:
        mov [SI], AL
        inc SI
        loop ciclo_reiniciar_nombre_b
    ;; se muestra lo que se solicita
    mov DX, offset mensaje_nombre_a
    mov AH, 09
    int 21
    mov DX, offset buffer_nombre
    mov AH, 0AH
    int 21
    ;;se lee la cadena
    mov DI, offset nombre_jugador_a
    call copiar_cadena
    ;;
    mov DX, offset nl
    mov AH, 09
    int 21
    ;;
    mov DX, offset mensaje_nombre_b
    mov AH, 09
    int 21
    mov DX, offset buffer_nombre
    mov AH, 0AH
    int 21
    ;;
    mov DI, offset nombre_jugador_b
    call copiar_cadena
    ;;
    mov DX, offset nl
    mov AH, 09
    int 21
pedir_columna:
    mov AL, [ficha_actual]
    cmp AL, ficha_a
    jne imprimir_jugador_b
    ;;se imprime jugador a
    mov SI, offset nombre_jugador_a
    add SI, 20
    mov AL, '$'
    mov [SI], AL
    ;;mostrar el nombre del jugador
    mov DX, offset nombre_jugador_a
    mov AH, 09
    int 21
    jmp sig
imprimir_jugador_b:
    mov SI, offset nombre_jugador_b
    add SI, 20
    mov AL, '$'
    mov [SI], AL
    ;;mostrar el nombre del jugador
    mov DX, offset nombre_jugador_b
    mov AH, 09
    int 21
    ;;
sig:
    mov DX, offset nl
    mov AH, 09
    int 21
    ;;
    mov DL, ficha_actual
    mov AH, 02
    int 21
    ;;
    mov DX, offset columna_ingreso
    mov AH, 09
    int 21
    mov AH, 01
    int 21
    cmp AL, "e"
    je MENU_JUEGO
    ;; AL -> columna
    call id_a_numero
    ;;si en AL viene un 7 quiere decir que quiere guardar partida
    cmp AL, 07
    je guardarjvj_partida
    ;; AL -> columna
    call buscar_vacio
    ;; DL -> 00 si se logro encontrar un espacio vacio
    cmp DL, 0FF
    je pedir_columna
    ;; DI -> direccion de la celda disponible
    ;; Se coloca la ficha
    mov AL, ficha_actual
    mov [DI], AL
    ;;
    mov DX, offset nl
    mov AH, 09
    int 21
    ;;
    call imprimir_tablero
    call verificar_filas
    call verificar_columnas
    call verficar_diagonales_ascendentes
    call verificar_diagonales_descendentes
    call verificar_empate
    ;; cambiar turno
    ;;Se verifica la ficha actual
    mov AL, [ficha_actual]
    cmp AL, ficha_a
    je cambiar_a_b
    ;;
    mov AL, ficha_a
    mov [ficha_actual], AL
    jmp pedir_columna
cambiar_a_b:
    mov AL, ficha_b
    mov [ficha_actual], AL
    jmp pedir_columna
    ;;
;; copiar_cadena - copia una cadena
;;    ENTRADAS: DI -> dirección hacia donde guardar
copiar_cadena:
		;; DI tengo ^
	mov SI, offset buffer_nombre
	inc SI
	mov AL, [SI]
	mov [DI], AL
	inc SI   ;; moverme a los bytes de la cadena
	inc DI   ;; para guardar esos bytes en el lugar correcto
	;;
	mov CX, 0000  ;; limpiando CX
	mov CL, AL
    jmp ciclo_copiar_cadena

ciclo_copiar_cadena:
    mov AL, [SI]
    mov [DI], AL
    inc SI
    inc DI
    LOOP ciclo_copiar_cadena

    ret
;; id_a_numero - convierte un caracter a un numero
;; SALIDA AL -> numero de columa o coordenada X
id_a_numero:
    cmp AL, "a"
    je columna_a
    cmp AL, "s"
    je columna_s
    cmp AL, "d"
    je columna_d
    cmp AL, "f"
    je columna_f
    cmp AL, "j"
    je columna_j
    cmp AL, "k"
    je columna_k
    cmp AL, "l"
    je columna_l
    cmp AL, "w"
    je columna_w
    jmp pedir_columna
columna_a:
    mov AL, 00
    ret
columna_s:
    mov AL, 01
    ret
columna_d:
    mov AL, 02
    ret
columna_f:
    mov AL, 03
    ret
columna_j:
    mov AL, 04
    ret
columna_k:
    mov AL, 05
    ret
columna_l:
    mov AL, 06
    ret
columna_w:
    mov AL, 07
    ret

;; buscar_vacio - busca un espacio vacio en la columna
;; ENTRADA: AL -> columna o X
;; SALIDA: DI -> numero de fila con espacio disponible
;;         DL -> 00 si se logro encontrar un espacio vacio
;;               0FF si no se logro encontrar un espacio vacio
buscar_vacio:
    ;; X en AL, Y en DL -> (AL, DL)
    mov DL, 05
ciclo_buscar_vacio:
    ;; indice = (7 * DL) + AL
    mov DH, AL
    ;; 7 * DL
    mov AL, 07
    mul DL
    ;; 7 * DL + DH
    ;; AL + DH
    add AL, DH
    ;; AX -> indice
    mov DI, offset tablero
    add DI, AX
    ;; verifico el contenido
    mov AL, [DI]
    cmp AL, 00
    je retorno_buscar_vacio
    dec DL
    mov AL, DH
    cmp DL, 00
    jge ciclo_buscar_vacio
retorno_fallido_buscar_vacio:
    mov DL, 0FF
    ret
retorno_buscar_vacio:
    mov DL, 00
    ret
;;obtener_vcasilla - obtiene el valor de una casilla
;; ENTRADA: BH -> X
;;          BL -> Y
;; SALIDA DL -> valor de la casilla
obtener_vcasilla:
    ;; inidice = 7 * BL + BH
    ;; 7 * BL = AX
    mov AL, 07
    mul BL
    ;; 7*BL + BH
    ;; AL + BH
    add AL, BH
    ;; AX -> indice
    mov DI, offset tablero
    add DI, AX
    ;; verifico el contenido
    mov DL, [DI]
    ret
;; imprimir_tablero - imprime el tablero
imprimir_tablero:
    ;;
    mov DX, offset encabezado_tablero
    mov AH, 09
    int 21
    ;;
    mov BX, 0000
    ;;inicializacion de contadores
    mov SI, 0006
    xchg SI, CX
ciclo_columnas:
    xchg SI, CX
    mov CX, 0007
    ;;
    mov DX, offset antes_fila
    mov AH, 09
    int 21
    ;;
ciclo_fila:
    call obtener_vcasilla
    cmp DL, 00
    je imprimir_vacia
    cmp DL, ficha_a
    je imprimir_ficha_a
    cmp DL, ficha_b
    je imprimir_ficha_b
imprimir_vacia:
    mov DL, ' '
    mov AH, 02
    int 21
    mov DX, offset entre_columnas
    mov AH, 09
    int 21
    jmp avanzar_fila
imprimir_ficha_a:
    mov DL, ficha_a
    mov AH, 02
    int 21
    mov DX, offset entre_columnas
    mov AH, 09
    int 21
    jmp avanzar_fila
imprimir_ficha_b:
    mov DL, ficha_b
    mov AH, 02
    int 21
    mov DX, offset entre_columnas
    mov AH, 09
    int 21
    jmp avanzar_fila
avanzar_fila:
    inc BH
    loop ciclo_fila
    mov DL, 0a
    mov AH, 02
    int 21
    ;;
    mov BH, 00
    inc BL
    xchg SI, CX
    loop ciclo_columnas
    ;;
    mov DX, offset pie_tablero
    mov AH, 09
    int 21
    ret
;;Se verifica si hay 4 fichas iguales en una fila
verificar_filas:
    ;;se verifica en nuestro arrelgo lineal tablero si hay 4 fichas iguales en una fila
    ;;se recorre el arreglo lineal tablero
    ;;AL -> X
    ;;DL -> Y
    ;;indice = 7 * DL + AL
    ;;se inicia un contandor en 5 para recorrer las filas
    mov DL, 05
    ;;inicio un contador en 0 para contar las fichas a
    mov fa, 00
    ;;inicio un contador en 0 para contar las fichas b
    mov fb, 00
    mov DH, 00

ciclo_verificar_filas:
    mov AL, 07
    mul DL
    ;; 7 * DL + DH
    ;; AL + DH
    add AL, DH
    ;; AX -> indice
    mov DI, offset tablero
    add DI, AX
    
    ;; verifico el contenido
    mov AL, [DI]
    cmp AL, ficha_a
    je contar_ficha_a
    cmp AL, ficha_b
    je contar_ficha_b
    ;;si viene espacio vacio se reinician los contadores
    mov fa, 00
    mov fb, 00
    jmp next_cl
contar_ficha_a:
    inc fa
    mov fb, 00
    jmp next_cl
contar_ficha_b:
    inc fb
    mov fa, 00
next_cl:
    ;;se verifica si hay 4 fichas iguales en una fila
    cmp fa, 03
    jg gano_a
    cmp fb, 03
    jg gano_b
    ;;se incrementa el contador de columnas
    inc DH
    cmp DH, 07
    jl ciclo_verificar_filas
    ;;se decrementa el contador de filas
    ;;se reinician los contadores de fichas
    mov DH, 00
    mov fa, 00
    mov fb, 00
    dec DL
    cmp DL, 00
    jge ciclo_verificar_filas
    ret
gano_a:
    mov DX, offset nl
    mov AH, 09
    int 21
    ;;se muestra que gano el jugador a
    mov DX, offset gano
    mov AH, 09
    int 21
    ;;se muestra el nombre del jugador a
    mov SI, offset nombre_jugador_a
    add SI, 20
    mov AL, '$'
    mov [SI], AL
    ;;mostrar el nombre del jugador
    mov DX, offset nombre_jugador_a
    mov AH, 09
    int 21
    ;;se crea el archivo de reporte
    call REPORTE
    jmp MENU_JUEGO
gano_b:
    mov DX, offset nl
    mov AH, 09
    int 21
    ;;se muestra que gano el jugador b
    mov DX, offset gano
    mov AH, 09
    int 21
    ;;se muestra el nombre del jugador b
    mov SI, offset nombre_jugador_b
    add SI, 20
    mov AL, '$'
    mov [SI], AL
    ;;mostrar el nombre del jugador
    mov DX, offset nombre_jugador_b
    mov AH, 09
    int 21
    call REPORTE
    jmp MENU_JUEGO

verificar_columnas:
    ;;se verifica en nuestro arrelgo lineal tablero si hay 4 fichas iguales en una fila
    ;;se recorre el arreglo lineal tablero
    ;;AL -> X
    ;;DL -> Y
    ;;indice = 7 * DL + AL
    ;;0 0 0 0 0 0 0
    ;;0 0 0 0 0 0 0
    ;;0 0 0 0 0 0 0
    ;;0 0 0 0 0 0 0
    ;;0 0 0 0 0 0 0
    ;;0 0 0 0 0 0 0
    mov DL, 05
    mov fa, 00
    mov fb, 00
    mov DH, 00
ciclo_verificar_columnas:
    mov AL, 07
    mul DL
    ;; 7 * DL + DH
    ;; AL + DH
    add AL, DH
    ;; AX -> indice
    mov DI, offset tablero
    add DI, AX

    ;; verifico el contenido
    mov AL, [DI]
    cmp AL, ficha_a
    je contar2_ficha_a
    cmp AL, ficha_b
    je contar2_ficha_b
    ;;si viene espacio vacio se reinician los contadores
    mov fa, 00
    mov fb, 00
    jmp next_cl2
contar2_ficha_a:
    inc fa
    mov fb, 00
    jmp next_cl2
contar2_ficha_b:
    inc fb
    mov fa, 00
next_cl2:
    ;;se verifica si hay 4 fichas iguales en una fila
    cmp fa, 03
    jg gano_a
    cmp fb, 03
    jg gano_b
    ;;se incrementa el contador de columnas
    dec DL
    cmp DL, 00
    jge ciclo_verificar_columnas
    ;;se decrementa el contador de filas
    ;;se reinician los contadores de fichas
    mov DL, 05
    mov fa, 00
    mov fb, 00
    inc DH
    cmp DH, 07
    jl ciclo_verificar_columnas
    ret
verficar_diagonales_ascendentes:
    ;;se verifica en nuestro arrelgo lineal tablero si hay 4 fichas igu
    mov DL, 05
    mov fa, 00
    mov fb, 00
    mov hordia, 00
    mov verdia, 05
    mov DH, 00
ciclo_verificar_diagonales_ascendentes:
    mov AL, 07
    mul DL
    ;; 7 * DL + DH
    ;; AL + DH
    add AL, DH
    ;; AX -> indice
    mov DI, offset tablero
    add DI, AX

    ;; verifico el contenido
    mov AL, [DI]
    cmp AL, ficha_a
    je contar3_ficha_a
    cmp AL, ficha_b
    je contar3_ficha_b
    ;;si viene espacio vacio se reinician los contadores
    mov fa, 00
    mov fb, 00
    jmp next_cl3
contar3_ficha_a:
    inc fa
    mov fb, 00
    jmp next_cl3
contar3_ficha_b:
    inc fb
    mov fa, 00
next_cl3:
    ;;se verifica si hay 4 fichas iguales
    ;;DL FILAS
    ;;DH COLUMNAS
    cmp fa, 03
    jg gano_a
    cmp fb, 03
    jg gano_b
    inc DH
    cmp DH, 07
    jge sig2
    dec DL
    cmp DL, 00
    jge ciclo_verificar_diagonales_ascendentes
sig2:
    ;;se debe seguir con las iteraciones
    mov DL, 05
    mov fa, 00
    mov fb, 00
    inc hordia
    mov DH, [hordia]
    cmp hordia, 07
    jl ciclo_verificar_diagonales_ascendentes
    dec verdia
    mov DL, [verdia]
    mov DH, 00
    mov fa, 00
    mov fb, 00
    cmp verdia, 00
    jge ciclo_verificar_diagonales_ascendentes
    ret
verificar_diagonales_descendentes:
    ;;se verifica en nuestro arrelgo lineal tablero si hay 4 fichas igu
    mov DL, 00
    mov fa, 00
    mov fb, 00
    mov hordia, 00
    mov verdia, 00
    mov DH, 00
ciclo_verificar_diagonales_descendentes:
    mov AL, 07
    mul DL
    ;; 7 * DL + DH
    ;; AL + DH
    add AL, DH
    ;; AX -> indice
    mov DI, offset tablero
    add DI, AX

    ;; verifico el contenido
    mov AL, [DI]
    cmp AL, ficha_a
    je contar4_ficha_a
    cmp AL, ficha_b
    je contar4_ficha_b
    ;;si viene espacio vacio se reinician los contadores
    mov fa, 00
    mov fb, 00
    jmp next_cl4
contar4_ficha_a:
    inc fa
    mov fb, 00
    jmp next_cl4
contar4_ficha_b:
    inc fb
    mov fa, 00
next_cl4:
    ;;se verifica si hay 4 fichas iguales
    ;;DL FILAS
    ;;DH COLUMNAS
    cmp fa, 03
    jg gano_a
    cmp fb, 03
    jg gano_b
    inc DH
    cmp DH, 07
    jge sig3
    inc DL
    cmp DL, 05
    jle ciclo_verificar_diagonales_descendentes
sig3:
    ;;se debe seguir con las iteraciones
    mov DL, 00
    mov fa, 00
    mov fb, 00
    inc hordia
    mov DH, [hordia]
    cmp hordia, 07
    jl ciclo_verificar_diagonales_descendentes
    inc verdia
    mov DL, [verdia]
    mov DH, 00
    mov fa, 00
    mov fb, 00
    cmp verdia, 05
    jle ciclo_verificar_diagonales_descendentes
    ret
verificar_empate:
    mov DL, 05
    mov DH, 00
    mov totalfichas, 00
ciclo_verificar_empate:
    mov AL, 07
    mul DL
    ;; 7 * DL + DH
    ;; AL + DH
    add AL, DH
    ;; AX -> indice
    mov DI, offset tablero
    add DI, AX

    ;; verifico el contenido
    mov AL, [DI]
    cmp AL, ficha_a
    je contarn_ficha
    cmp AL, ficha_b
    je contarn_ficha
    jmp next_cl5
contarn_ficha:
    inc totalfichas
next_cl5:
    inc DH
    cmp DH, 07
    jl ciclo_verificar_empate
    dec DL
    cmp DL, 00
    jge ciclo_verificar_empate
    cmp totalfichas, 42
    jge lempate
    ret
lempate:
    mov DX, offset nl
    mov AH, 09
    int 21
    ;;se muestra que gano el jugador b
    mov DX, offset empate
    mov AH, 09
    int 21
    call REPORTE
    jmp MENU_JUEGO

JUGARPC:
    mov SI, offset tablero
    mov CX, 2a
    mov AL, 00
    ciclo_reiniciarPC_tablero:
        mov [SI], AL
        inc SI
        loop ciclo_reiniciarPC_tablero
    ;;reiniciar ficha actual
    mov AL, ficha_a
    mov [ficha_actual], AL
    ;;reiniciar contadores
    mov fa, 00
    mov fb, 00
    ;;reiniciar nombres
    mov SI, offset nombre_jugador_a
    mov CX, 20
    mov AL, 00
    ciclo_reiniciarPC_nombre_a:
        mov [SI], AL
        inc SI
        loop ciclo_reiniciarPC_nombre_a
    mov SI, offset nombre_jugador_b
    mov CX, 20
    mov AL, 00
    ciclo_reiniciarPC_nombre_b:
        mov [SI], AL
        inc SI
        loop ciclo_reiniciarPC_nombre_b
    ;; se muestra lo que se solicita
    mov DX, offset mensaje_nombrej
    mov AH, 09
    int 21
    mov DX, offset buffer_nombre
    mov AH, 0AH
    int 21
    ;;se lee la cadena
    mov DI, offset nombre_jugador_a
    call copiar_cadena
    ;;le colocamos PC al nombre del jugador b
    mov SI, offset nombre_jugador_b
    mov AL, 'P'
    mov [SI], AL
    inc SI
    mov AL, 'C'
    mov [SI], AL
    ;;
    mov DX, offset nl
    mov AH, 09
    int 21
    ;;
pedirpc_columna:
    mov AL, [ficha_actual]
    cmp AL, ficha_a
    jne imprimir_pc
    ;;se imprime jugador a
    mov SI, offset nombre_jugador_a
    add SI, 20
    mov AL, '$'
    mov [SI], AL
    ;;mostrar el nombre del jugador
    mov DX, offset nombre_jugador_a
    mov AH, 09
    int 21
    jmp sigpc
imprimir_pc:
    mov DX, offset pc_name
    mov AH, 09
    int 21
    ;;
sigpc:
    mov DX, offset nl
    mov AH, 09
    int 21
    ;;
    mov DL, ficha_actual
    mov AH, 02
    int 21
    ;;
    mov DX, offset columna_ingreso
    mov AH, 09
    int 21
    mov AH, 01
    int 21
    cmp AL, "e"
    je MENU_JUEGO
    ;; AL -> columna
    call id_a_numero
    ;; AL -> columna
    ;;si AL es 7 se guarda la partida y se sale
    cmp AL, 07
    je guardarjvpc_partida
    ;;se guarda el ultimo numero de columna ingresado
    mov [last_number], AL
    call buscar_vacio
    ;; DL -> 00 si se logro encontrar un espacio vacio
    cmp DL, 0FF
    je pedirpc_columna
    ;; DI -> direccion de la celda disponible
    ;; Se coloca la ficha
    mov AL, ficha_actual
    mov [DI], AL
    ;;
    mov DX, offset nl
    mov AH, 09
    int 21
    ;;
    call imprimir_tablero
    call verificar_filas
    call verificar_columnas
    call verficar_diagonales_ascendentes
    call verificar_diagonales_descendentes
    call verificar_empate
    ;; cambiar turno
agregar_ficha_pc:
    mov AL, ficha_b
    mov [ficha_actual], AL
    ;;se coloca un numero random del 0 al 6 en AL
    cmp last_number , 00
    je es_0
    cmp last_number, 03
    je es_3
    cmp last_number, 03
    jg mayor_a_3
    
    add last_number, 01
    jmp pcsig
mayor_a_3:
    sub last_number, 01
    jmp pcsig
es_0:
    add last_number, 01
    jmp pcsig
es_3:
    add last_number, 02
pcsig:
    mov AL, [last_number]
    ;;se verifica si la columna esta llena
    call buscar_vacio
    ;; DL -> 00 si se logro encontrar un espacio vacio
    cmp DL, 0FF
    je agregar_ficha_pc
    ;; DI -> direccion de la celda disponible
    ;; Se coloca la ficha
    mov AL, ficha_b
    mov [DI], AL
    ;;
    mov DX, offset nl
    mov AH, 09
    int 21

    call imprimir_tablero
    call verificar_filas
    call verificar_columnas
    call verficar_diagonales_ascendentes
    call verificar_diagonales_descendentes
    call verificar_empate
    ;; cambiar turno
    mov AL, ficha_a
    mov [ficha_actual], AL
    jmp pedirpc_columna

guardarjvj_partida:
    ;;se muestra el mensaje de guardado
    mov DX, offset mensaje_guardar
    mov AH, 09
    int 21
    mov DX, offset buffer_entrada
    mov AH, 0a
    int 21
    ;; DI <- primer byte del buffer
    mov DI, offset buffer_entrada
    inc DI
    ;; DI <- segundo byte, tamaño de cadena leida
    mov AL, [DI]
    cmp AL, 08
    ja guardarjvj_partida
    ;; cadena correcta
    call copiar_y_agregar_ext
    ;;
    mov CX, 0000
    mov DX, offset nombre_guardar
    mov AH, 3c
    int 21
    ;; AX -> handle
    mov [handle_guardar], AX
    ;; Se guardará nombre_a, nombre_b, tablero y ficha_actual
    mov BX, [handle_guardar]
    mov CX, 0020
    mov DX, offset nombre_jugador_a
    mov AH, 40
    int 21
    mov CX, 0020
    mov DX, offset nombre_jugador_b
    mov AH, 40
    int 21
    mov CX, 002a
    mov DX, offset tablero
    mov AH, 40
    int 21
    mov CX, 0001
    mov DX, offset ficha_actual
    mov AH, 40
    int 21

    mov AH, 3e
    mov BX, [handle_guardar]
    int 21
    jmp MENU_JUEGO

copiar_y_agregar_ext:
    mov CX, 0000
    mov CL, 0c
    mov BX, offset nombre_guardar
limpiar_nombre_guardar:
    mov AL, 00
    mov [BX], AL
    inc BX
    loop limpiar_nombre_guardar

    mov SI, offset nombre_guardar
    mov CX, 0000
    mov CL, [DI]
    inc DI
ciclo_copiar_sin_ext:
    mov AL, [DI]
    mov [SI], AL
    inc SI
    inc DI
    loop ciclo_copiar_sin_ext
    ;;;;
    mov CX, 0000
    mov CL, 04 ;; ".SAV"
    mov DI, offset extension_guardar
ciclo_copiar_ext:
    mov AL, [DI]
    mov [SI], AL
    inc DI
    inc SI
    loop ciclo_copiar_ext
    ret


guardarjvpc_partida:
    ;;se muestra el mensaje de guardado
    mov DX, offset mensaje_guardar
    mov AH, 09
    int 21
    mov DX, offset buffer_entrada
    mov AH, 0a
    int 21
    ;; DI <- primer byte del buffer
    mov DI, offset buffer_entrada
    inc DI
    ;; DI <- segundo byte, tamaño de cadena leida
    mov AL, [DI]
    cmp AL, 08
    ja guardarjvpc_partida
    ;; cadena correcta
    call copiar_y_agregar_ext
    ;;
    mov CX, 0000
    mov DX, offset nombre_guardar
    mov AH, 3c
    int 21
    ;; AX -> handle
    mov [handle_guardar], AX
    ;; Se guardará nombre_a, nombre_b, tablero y ficha_actual
    mov BX, [handle_guardar]
    mov CX, 0020
    mov DX, offset nombre_jugador_a
    mov AH, 40
    int 21
    mov CX, 0020
    mov DX, offset nombre_jugador_b
    mov AH, 40
    int 21
    mov CX, 002a
    mov DX, offset tablero
    mov AH, 40
    int 21
    mov CX, 0001
    mov DX, offset ficha_actual
    mov AH, 40
    int 21

    mov AH, 3e
    mov BX, [handle_guardar]
    int 21
    jmp MENU_JUEGO
CARGAR:
    ;;se muestra el mensaje
    mov DX, offset mensaje_guardar
    mov AH, 09
    int 21
    ;;se pide la entrada
    mov DX, offset buffer_entrada
    mov AH, 0a
    int 21
    ;; DI <- primer byte del buffer
    mov DI, offset buffer_entrada
    inc DI
    ;; DI <- segundo byte, tamaño de cadena leida
    mov AL, [DI]
    cmp AL, 08
    ja CARGAR
    ;; cadena correcta
    call copiar_y_agregar_ext
    ;;
    mov CX, 0000
    ;;se abre el archivo
    mov DX, offset nombre_guardar
    mov AH, 3d
    mov AL, 00
    int 21
    ;; AX -> handle
    mov [handle_cargar], AX
    ;; leo del archivo el nombre_a, nombre_b, tablero y ficha_actual
    ;; limpiar registro DX
    mov DX, 0000
    mov BX, [handle_cargar]
    mov CX, 0020
    mov DX, offset nombre_jugador_a
    mov AH, 3f
    int 21
    mov CX, 0020
    mov DX, offset nombre_jugador_b
    mov AH, 3f
    int 21
    mov CX, 002a
    mov DX, offset tablero
    mov AH, 3f
    int 21
    mov CX, 0001
    mov DX, offset ficha_actual
    mov AH, 3f
    int 21
    ;;se cierra el archivo
    mov AH, 3e
    mov BX, [handle_cargar]
    int 21
    ;;se muestra el tablero
    ;;si el jugador b es PC se llama a la funcion pedirpc_columna
    mov SI, offset nombre_jugador_b
    mov AL, 'P'
    cmp [SI], AL
    jne sigpc1
    inc SI
    mov AL, 'C'
    cmp [SI], AL
    je pedirpc_columna
sigpc1:
    jmp pedir_columna
    
REPORTE:
    ;;se crea el archivo
    mov CX , 0000
    mov DX, offset filename_reporte
    mov AH, 3c
    int 21
    ;; AX -> handle
    mov [handle_reporte], AX
    mov BX, [handle_reporte]
    ;; Se crea el reporte html
    mov CX, 0057
    mov DX, offset html_eskeleton
    mov AH, 40
    int 21

    ;;enter
    mov CX, 0001
    mov DX, offset nl
    mov AH, 40
    int 21

    ;;Se abre la tabla
    mov CX, 006d
    mov DX, offset table_header
    mov AH, 40
    int 21

    ;;enter
    mov CX, 0001
    mov DX, offset nl
    mov AH, 40
    int 21

    ;;Se abre una row
    mov CX, 0008
    mov DX, offset html_row
    mov AH, 40
    int 21

    ;;Se agrega el nombre del jugador a
    mov CX, 0020
    mov DX, offset nombre_jugador_a
    mov AH, 40
    int 21

    ;;otra row
    mov CX, 0009
    mov DX, offset html_othercol
    mov AH, 40
    int 21

    ;;Se agrega el nombre del jugador b
    mov CX, 0020
    mov DX, offset nombre_jugador_b
    mov AH, 40
    int 21

    ;;otra row
    mov CX, 0009
    mov DX, offset html_othercol
    mov AH, 40
    int 21

    ;;se agrega la ficha
    mov CX, 0001
    mov DX, offset ficha_actual
    mov AH, 40
    int 21

    ;;otra row
    mov CX, 0009
    mov DX, offset html_othercol
    mov AH, 40
    int 21

    ;; si la ficha actual es a se agrega el nombre del jugador a
    mov AL, [ficha_actual]
    cmp AL, ficha_a
    jne agregar_nombre_b
    mov CX, 0020
    mov DX, offset nombre_jugador_a
    mov AH, 40
    int 21
    jmp sigrep
agregar_nombre_b:
    mov CX, 0020
    mov DX, offset nombre_jugador_b
    mov AH, 40
    int 21
sigrep:
    ;; cierra row
    mov CX, 000a
    mov DX, offset html_endrow
    mov AH, 40
    int 21
    ;;Se cierra la tabla
    mov CX, 0008
    mov DX, offset table_end
    mov AH, 40
    int 21

    ;;enter
    mov CX, 0001
    mov DX, offset nl
    mov AH, 40
    int 21

    ;;
    mov CX, 002a
    mov DX, offset tablero
    mov AH, 40
    int 21

    ;;enter
    mov CX, 0001
    mov DX, offset nl
    mov AH, 40
    int 21

    ;;Se cierra html
    mov CX, 000e
    mov DX, offset html_end
    mov AH, 40
    int 21

    ;;se cierra el archivo
    mov AH, 3e
    mov BX, [handle_reporte]
    int 21
    ret
SALIR:
.EXIT ;; Fin de programa
END ;; Fin de programa