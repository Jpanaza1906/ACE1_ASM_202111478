.RADIX 16
.MODEL SMALL ;; Definicion del modelo de memoria
;; Definicion de segmentos
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
menu0   db "Elija una opcion:", 0a, "a"

.CODE 
.STARTUP ;; Inicio de programa
;; logica del programa
ENCABEZADO:
;;-------------------------------Mostrar Encabezado-------------------------------
    MOV AH, 09H ;; Funcion para mostrar cadena de caracteres
    MOV DX, OFFSET usac ;; Direccion de memoria de la cadena de caracteres
    int 21H ;; Interrupcion para mostrar cadena de caracteres
    MOV AH, 09H ;; Funcion para mostrar cadena de caracteres
    MOV DX, OFFSET facultad ;; Direccion de memoria de la cadena de caracteres
    int 21H ;; Interrupcion para mostrar cadena de caracteres
    MOV AH, 09H ;; Funcion para mostrar cadena de caracteres
    MOV DX, OFFSET curso ;; Direccion de memoria de la cadena de caracteres
    int 21H ;; Interrupcion para mostrar cadena de caracteres
    MOV AH, 09H ;; Funcion para mostrar cadena de caracteres
    MOV DX, OFFSET seccion ;; Direccion de memoria de la cadena de caracteres
    int 21H ;; Interrupcion para mostrar cadena de caracteres
    MOV AH, 09H ;; Funcion para mostrar cadena de caracteres
    MOV DX, OFFSET semestre ;; Direccion de memoria de la cadena de caracteres
    int 21H ;; Interrupcion para mostrar cadena de caracteres
    MOV AH, 09H ;; Funcion para mostrar cadena de caracteres
    MOV DX, OFFSET nombre ;; Direccion de memoria de la cadena de caracteres
    int 21H ;; Interrupcion para mostrar cadena de caracteres
    MOV AH, 09H ;; Funcion para mostrar cadena de caracteres
    MOV DX, OFFSET carne ;; Direccion de memoria de la cadena de caracteres
    int 21H ;; Interrupcion para mostrar cadena de caracteres
    MOV AH, 09H ;; Funcion para mostrar cadena de caracteres
    MOV DX, OFFSET continue ;; Direccion de memoria de la cadena de caracteres
    int 21H ;; Interrupcion para mostrar cadena de caracteres
;;---------------------------------Fin de Encabezado---------------------------------
;;---------------------------------Pausa---------------------------------
PAUSA: ;; Etiqueta para pausar el programa
    ;;si viene exactamente un enter, entonces continua
    MOV AH, 1H ;; Funcion para leer un caracter
    INT 21H ;; Interrupcion para leer un caracter
    CMP AL, 0DH ;; Compara si el caracter es un enter
    JNE PAUSA ;; Si no es un enter, entonces vuelve a pedir un caracter
;;---------------------------------Fin de Pausa---------------------------------
;;---------------------------------Lectura---------------------------------
ABRIR_ARCH:
;Abrir archivo
    MOV AH, 3DH ;; Funcion para abrir un archivo
    MOV AL, 0 ;; Modo de apertura
    MOV DX, OFFSET filename ;; Direccion de memoria del nombre del archivo
    INT 21H ;; Interrupcion para abrir un archivo
    JC OPEN_ERROR ;; Si hay error, entonces salta a la etiqueta OPEN_ERROR
    MOV handle, AX ;; Guarda el handle del archivo
LEER_ARCH:
;Leer archivo
    MOV AH, 3FH ;; Funcion para leer un archivo
    MOV BX, handle ;; Handle del archivo
    MOV CX, buffer_size ;; Tamaño del buffer
    MOV DX, OFFSET buffer ;; Direccion de memoria del buffer
    INT 21H ;; Interrupcion para leer un archivo
    JC READ_ERROR ;; Si hay error, entonces salta a la etiqueta READ_ERROR
;Mostrar archivo
    ;;Si el buffer esta vacio, entonces salta a la etiqueta RESPUESTA_ARCH
    CMP AX, 0 ;; Compara si el buffer esta vacio
    JE RESPUESTA_ARCH ;; Si esta vacio, entonces salta a la etiqueta RESPUESTA_ARCH
    ;;Agregarle $ al final del buffer
    MOV SI, OFFSET buffer ;; Direccion de memoria del buffer
    ADD SI, buffer_size ;; Suma el tamaño del buffer a la direccion de memoria del buffer
    DEC SI ;; Decrementa la direccion de memoria del buffer
    MOV AL, '$' ;; Caracter $
    MOV [SI], AL ;; Guarda el caracter $ en la direccion de memoria del buffer
;;Se verifica si la cadena contiene solo caracteres permitidos
    MOV SI, 0 ;; Se inicializa el indice de la cadena
    MOV CX, 0 ;; Se inicializa el contador de caracteres permitidos
    MOV AL, buffer[SI] ;; Se obtiene el primer caracter de la cadena
;Se recorre la cadena caracter por caracter
LOOP_VERIFICAR:
    ;CMP AL, 0 ;; Se verifica si el caracter es el caracter nulo
    ;JE CADENA_VALIDA ;; Si es el caracter nulo, entonces la cadena es valida

    ;verificar si el caracter es permitido
    MOV DI, 0 ;; Se inicializa el indice de los caracteres permitidos
    MOV AH, AL ;; Se guarda el caracter en AH
    MOV AL, allowed_chars[DI] ;; Se obtiene el primer caracter permitido
COMPARAR_CARACTER:
    CMP AH, AL ;; Se compara el caracter con el caracter permitido
    JE CARACTER_PERMITIDO ;; Si son iguales, entonces el caracter es permitido
    INC DI ;; Se incrementa el indice de los caracteres permitidos
    MOV AL, allowed_chars[DI] ;; Se obtiene el siguiente caracter permitido
    ;;si el DI es igual al tamaño de la cadena de caracteres permitidos, entonces la cadena es invalida
    CMP DI, 64 ;; Se compara el indice de los caracteres permitidos con el tamaño de la cadena de caracteres permitidos
    JE CADENA_INVALIDA ;; Si son iguales, entonces la cadena es invalida
    JMP COMPARAR_CARACTER ;; Si no es el caracter nulo, entonces se vuelve a comparar el caracter con el caracter permitido
    ;JMP FIN_LECTURA ;; Si es el caracter nulo, entonces la cadena es invalida
    ;JMP CADENA_INVALIDA ;; Si es el caracter nulo, entonces la cadena es invalida
    ;JMP CADENA_VALIDA ;; Si no es el caracter nulo, entonces la cadena es valida

CARACTER_PERMITIDO:
    INC SI ;; Se incrementa el indice de la cadena
    MOV AL, buffer[SI] ;; Se obtiene el siguiente caracter de la cadena
    INC CX ;; Se incrementa el contador de caracteres permitidos
    ;;Si el contador SI es igual al tamaño del buffer, entonces la cadena es valida
    CMP CX, buffer_size ;; Se compara el contador de caracteres permitidos con el tamaño del buffer
    JE CADENA_VALIDA ;; Si son iguales, entonces la cadena es valida
    JMP LOOP_VERIFICAR ;; Se vuelve a verificar el siguiente caracter de la cadena
CADENA_VALIDA:
    ;;Mostrar el buffer
    MOV AH, 09H ;; Funcion para mostrar cadena de caracteres
    MOV DX, OFFSET buffer ;; Direccion de memoria del buffer
    INT 21H ;; Interrupcion para mostrar cadena de caracteres
    ;;contar el numero de lineas
    INC line_count ;; Incrementa el contador de lineas
    CMP line_count, 14 ;; Compara si el contador de lineas es igual a 20
    JL LEER_ARCH ;; Si es menor o igual a 20, entonces vuelve a leer el archivo
    MOV line_count, 0 ;; Reinicia el contador de lineas
RESPUESTA_ARCH:
;Preguntar si desea continuar
    MOV AH, 09H ;; Funcion para mostrar cadena de caracteres
    MOV DX, OFFSET page_message ;; Direccion de memoria de la cadena de caracteres
    INT 21H ;; Interrupcion para mostrar cadena de caracteres
    ;;Leer respuesta
    MOV AH, 1H ;; Funcion para leer un caracter
    INT 21H ;; Interrupcion para leer un caracter
    CMP AL, "n" ;; Compara si el caracter es n
    JE LEER_ARCH ;; Si es n, entonces vuelve a leer el archivo
    CMP AL, "q" ;; Compara si el caracter es q
    JE FIN_LECTURA ;; Salta a la etiqueta FIN
    ;;Si no es n o q, entonces vuelve a preguntar
    JMP RESPUESTA_ARCH
CADENA_INVALIDA:
    MOV AH, 09H ;; Funcion para mostrar cadena de caracteres
    MOV DX, OFFSET cadenaInvalida ;; Direccion de memoria de la cadena de caracteres
    INT 21H ;; Interrupcion para mostrar cadena de caracteres
    JMP FIN_LECTURA
OPEN_ERROR:
    ;Error al abrir el archivo
    MOV AH, 09H ;; Funcion para mostrar cadena de caracteres
    MOV DX, OFFSET open_error_message ;; Direccion de memoria de la cadena de caracteres
    INT 21H ;; Interrupcion para mostrar cadena de caracteres
READ_ERROR:
    ;Error al leer el archivo
    MOV AH, 09H ;; Funcion para mostrar cadena de caracteres
    MOV DX, OFFSET read_error_message ;; Direccion de memoria de la cadena de caracteres
    INT 21H ;; Interrupcion para mostrar cadena de caracteres

FIN_LECTURA:
    ;Cerrar archivo
    MOV AH, 3EH ;; Funcion para cerrar un archivo
    MOV BX, handle ;; Handle del archivo
    INT 21H ;; Interrupcion para cerrar un archivo
;;---------------------------------Fin de Lectura---------------------------------

.EXIT ;; Fin de programa
END ;; Fin de programa