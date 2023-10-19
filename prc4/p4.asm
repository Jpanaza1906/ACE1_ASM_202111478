.RADIX 16
.MODEL small
.STACK
.DATA ;; Segmento de datos
;;---------------------------------Encabezado-----------------------------------------
encabezado  DB 0AH, 0DH, "UNIVERSIDAD SAN CARLOS DE GUATEMALA", 0AH, 0DH
            DB "FACULTAD DE INGENIERIA", 0AH, 0DH
            DB "ESCUELA DE CIENCIAS Y SISTEMAS", 0AH, 0DH
            DB "ARQUITECTURA DE COMPUTADORES Y ENSAMBLADORES 1", 0AH, 0DH
            DB "SECCION A", 0AH, 0DH
            DB "SEGUNDO SEMESTRE 2023", 0AH, 0DH
            DB 0AH, 0DH, "NOMBRE: Sergio Saul Ralda Mejia", 0AH, 0DH
            DB "202103216", 0AH, 0DH
            DB "Practica 4", 0AH, 0DH, "$"
;;---------------------------------Fin de Encabezado---------------------------------
;;----------------------------------Menu----------------------------------------------
menu DB 0AH, 0DH, "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%", 0AH, 0DH
               DB "%%%%%%%%%%%%%%%%%%%%%%%%%%%  MENU  %%%%%%%%%%%%%%%%%%%%%%%%%%%%", 0AH, 0DH
     DB "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%", 0AH, 0DH
     DB "% 1. Cargar Archivo                                           %", 0AH, 0DH
     DB "% 2. Modo Calculadora                                         %", 0AH, 0DH
     DB "% 3. Modo Factorial                                           %", 0AH, 0DH
     DB "% 4. Generar Reporte                                          %", 0AH, 0DH
     DB "% 5. Salir                                                    %", 0AH, 0DH
     DB "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%", 0AH, 0DH, "$"
;;---------------------------------Fin de Menu----------------------------------------
;;---------------------------------Cargar Archivo-------------------------------------
buffer_entrada  DB 28,00
                DB 28 dup(00)
nombre_guardar db 0ch dup(00),00
mensaje_carga  db 0AH, 0DH, "Ingrese la ruta completa del archivo: ", 0AH, 0DH, "$"
mensaje_err_extension db 0AH, 0DH, "Error: La extension del archivo debe ser .arq", 0AH, 0DH, "$"
mensaje_err_archivo db 0AH, 0DH, "Error: El archivo solicitado no existe", 0AH, 0DH, "$"
mensaje_err_lectura db 0AH, 0DH, "Error: No se pudo leer el archivo", 0AH, 0DH, "$"
handle_archivo dw ?
buffer_lectura  db 0fffh dup(00)
operacion   db 40, 00
            db 40 dup(00)
ptr_coperacion dw 0000
numeros db "0123456789"
operadores db "+-*/"
pila_num db 15 dup(00)
cont_pila dw 0000
num1 DW 0000
num2 DW 0000
resul_parcial dw 0000
cont_nums db 00
aux_num dw 0000
cadena_resul db 06 dup(' '), '$'

error_num db 0AH, 0DH, "Error: El archivo contiene un caracter invalido en la operacion", 0AH, 0DH, "$"
error_oper db 0AH, 0DH, "Error: El archivo contiene una operacion invalida", 0AH, 0DH, "$"
nombre_prueba db 00,00,"file.arqa",00
parabre db "("
parcierra db ")"
presionar_enter db 0AH, 0DH, "Presione ENTER para continuar...", 0AH, 0DH, "$"

;;---------------------------------Fin de Cargar Archivo-----------------------------

;;---------------------------------Modo Calculadora-----------------------------------
menu_calculadora db 0AH, 0DH, "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%", 0AH, 0DH
                           db "%%%%%%%%%%%%%%%%%%%%%  MODO CALCULADORA  %%%%%%%%%%%%%%%%%%%%%%", 0AH, 0DH
                           db "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%", 0AH, 0DH, "$"

ingrese_numero db 0AH, 0DH, "Ingrese un numero: ", 0AH, 0DH, "$"
ingrese_operador db 0AH, 0DH, "Ingrese un operador: ", 0AH, 0DH, "$"
ingrese_operador_igual db 0AH, 0DH, "Ingrese un operador o '=' para obtener el resultado: ", 0AH, 0DH, "$"
mostrar_resultado db 0AH, 0DH, "El resultado es: $"
desea_guardar db 0AH, 0DH, "Desea guardar el resultado? (S/N): ", 0AH, 0DH, "$"
modo db 00  ;; 0-> cargar archivo, 1-> modo calculadora, 2 -> factorial
numero_calc dw 0000
numpos dw 0001
tipo_ingreso db 00 ;; 0-> numero, 1-> operador, 2-> operador igual
operador_calculadora db 00
maxoperaciones db 00
cadenamaxima db 0AH, 0DH, "Error: Se ha excedido el numero de operaciones", 0AH, 0DH, "$"
;;---------------------------------Fin de Modo Calculadora---------------------------

;;---------------------------------Factorial-------------------------------------------

menu_factorial db 0AH, 0DH, "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%", 0AH, 0DH
                         db "%%%%%%%%%%%%%%%%%%%%%%%%  MODO FACTORIAL  %%%%%%%%%%%%%%%%%%%%%", 0AH, 0DH
                         db "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%", 0AH, 0DH, "$"

ingrese_numero_factorial db 0AH, 0DH, "Ingrese un numero: ", 0AH, 0DH, "$"
ingrese_numero_valido db 0AH, 0DH, "Error: Ingrese un numero valido", 0AH, 0DH, "$"

operaciones_fac db 0AH, 0DH, "Operaciones: $"
resultado_fac_cadena db 0AH, 0DH, "El resultado es: $"


auxfac db 00
factorial_n db 00
resultado_fac db 01
resultado_ant_fact db 01



;;---------------------------------Fin de Factorial-----------------------------------

;;============================================== Reporte =======================================================

reporte_html db "<!DOCTYPE html><html><head><meta charset='utf-8'><meta http-equiv='X-UA-Compatible' content='IE=edge'>"
             db "<title>Reporte</title><meta name='viewport' content='width=device-width, initial-scale=1'>"
             db "<style>body{display: block;justify-content: center;align-items: center;height: 100vh;margin: 0;}table{border-collapse: collapse;width: 50%;"
             db "margin-top: 20px;}th,td{border: 1px solid #dddddd;text-align: left;padding: 8px;}th{background-color: #f2f2f2;}</style></head>"
             db "<body><h1>Practica 4 Arqui 1 Seccion A</h1><h2>Estudiante: Sergio Saul Ralda Mejia</h2><h2>Carnet: 202103216</h2>"
             db "<h2>Fecha: "
             dia_cadena DB 02 dup (30),'/' 
             mes_cadena DB 02 dup (30),'/'
             anho_cadena DB 04 dup (30)
             db "</h2>"
             db "<h2>Hora: "
             hora_cadena DB 02 dup (30),':'
             minutos_cadena DB 02 dup (30),':'
             segundos_cadena DB 02 dup (30)
             db "</h2>"
             db "<table style='display: block;'><thead><tr><th style='text-align: center;' >Id Operacion</th><th>Operacion</th><th>Resultado</th></tr>"
             db "</thead><tbody>"
             ;;filas de operaciones
             inicio_tabla db 0514 dup (00) ;Cada fila son 130 bytes y se coloco capactidad para 10 filas
             ;;fin filas de operaciones
             db "</tbody></table></body></html>"

fila_tabla_operacion db "<tr><td>"
                     cadena_id_operacion db 02 dup (30) ;;2 bytes para el id de la operacion
                     db "</td><td style='text-align: center;'>"
                     cadena_operacion db 1E dup (00) ;;30 bytes para la operacion inicializados en nulo
                     db "</td><td style='text-align: center;'>"
                     cadena_signo_resultado_operacion db 01 dup ('+') ;;1 byte para el signo del resultado de la operacion
                     cadena_resultado_operacion db 06 dup(30) ;;6 bytes para el resultado de la operacion inicializados en '0'
                     db "</td></tr>" ;;130 bytes por fila

dia_numero db 00
mes_numero db 00
ahno_numero dw 0000

hora_numero db 00
minutos_numero db 00
segundos_numero db 00

nombre_reporte db "REP.HTM",00
handle_reporte dw 0000

offset_tabla dw 0000
offset_cadena_operacion dw 0000

count_id_operacion db 00

cadena_error_factorial db 0AH, 0DH, "Error: El numero ingresado debe ser mayor o igual a 0 y menor o igual a 4", 0AH, 0DH, "$"

;;============================================== Fin de Reporte ================================================

.CODE
.STARTUP ;; Inicio del programa
;; logica del programa
INICIO:
;;---------------------------------Encabezado-----------------------------------------
    mov AH, 09 ;; Funcion para mostrar cadena de caracteres
    mov DX, offset encabezado ;; Direccion de memoria de la cadena de caracteres
    int 21 ;; interrupcion para mostrar cadena de caracteres
;;---------------------------------Fin de Encabezado---------------------------------
MENU_PRINCIPAL:
;;----------------------------------Menu----------------------------------------------
    mov AH, 09 ;; Funcion para mostrar cadena de caracteres
    mov DX, offset menu ;; Direccion de memoria de la cadena de caracteres
    int 21 ;; interrupcion para mostrar cadena de caracteres

    mov AH, 01 ;; Funcion para leer un caracter
    int 21 ;; interrupcion para leer un caracter
    cmp AL, '1' ;; Compara si el caracter es igual a 1
    je CARGAR_ARCHIVO ;; Si es igual a 1, salta a la etiqueta CARGAR
    cmp AL, '2' ;; Compara si el caracter es igual a 2
    je MODO_CALCULADORA ;; Si es igual a 2, salta a la etiqueta CALCULADORA
    cmp AL, '3' ;; Compara si el caracter es igual a 3
    je FACTORIAL ;; Si es igual a 3, salta a la etiqueta FACTORIAL
    cmp AL, '4' ;; Compara si el caracter es igual a 4
    je CREAR_REPORTE ;; Si es igual a 4, salta a la etiqueta CREAR_REPORTE
    cmp AL, '5' ;; Compara si el caracter es igual a 5
    je SALIR ;; Si es igual a 5, salta a la etiqueta SALIR
    jmp MENU_PRINCIPAL ;; Si no es igual a ninguno de los anteriores, salta a la etiqueta MENU
;;---------------------------------Fin de Menu----------------------------------------
CARGAR_ARCHIVO:
    ;;Se muestra el mensaje para ingresar la ruta del archivo
    mov AH, 09 ;; Funcion para mostrar cadena de caracteres
    mov DX, offset mensaje_carga ;; Direccion de memoria de la cadena de caracteres
    int 21 ;; interrupcion para mostrar cadena de caracteres
    mov modo, 00
    ;;Se pide la ruta del archivo
    mov AH, 0AH ;; Funcion para leer cadena de caracteres
    mov DX, offset buffer_entrada ;; Direccion de memoria de la cadena de caracteres
    int 21 ;; interrupcion para leer cadena de caracteres
    ;;Se coloca caracter nulo al final de la entrada leida
    mov DI, offset buffer_entrada + 1 ;; Direccion de memoria del byte que contiene logitud de la cadena
    mov AX, 0000 ;; Se limipiar AX
    mov AL, [DI] ;; Se obtiene la longitud de la cadena
    add DI, AX ;; Se obtiene la direccion del ultimo byte de la cadena
    inc DI ;; Se incrementa la direccion del siguiente byte despues de la cadena
    mov AL, 00 ;; Se coloca el caracter nulo
    mov [DI], AL ;; Se coloca el caracter nulo al final de la cadena
    mov SI, offset buffer_entrada + 2 ;; Direccion donde comienza la cadena del nombre del archivo
;;Se verifica la extension del archivo
LOOP_VERIFICAR_EXTENSION:
    mov AL, [SI] ;; Se obtiene el primer caracter del buffer
    inc SI ;; Se incrementa el indice del buffer
    cmp AL, '.' ;; Se compara si el caracter es igual a '.'
    je VERIFICAR_EXTENSION ;; Si es igual a '.' salta a la etiqueta EXTENSION
    cmp AL, 00
    jne LOOP_VERIFICAR_EXTENSION ;; Si es igual a '$' salta a la etiqueta ERR_EXTENSION
ERR_EXTENSION:
    ;;Se muestra el mensaje de error de extension
    mov AH, 09 ;; Funcion para mostrar cadena de caracteres
    mov DX, offset mensaje_err_extension ;; Direccion de memoria de la cadena de caracteres
    int 21 ;; interrupcion para mostrar cadena de caracteres
    jmp CARGAR_ARCHIVO ;; Salta a la etiqueta CARGAR_ARCHIVO
ERR_ARCHIVO:
    ;;Se muestra el mensaje de error de extension
    mov AH, 09 ;; Funcion para mostrar cadena de caracteres
    mov DX, offset mensaje_err_archivo ;; Direccion de memoria de la cadena de caracteres
    int 21 ;; interrupcion para mostrar cadena de caracteres
    jmp CARGAR_ARCHIVO ;; Salta a la etiqueta CARGAR_ARCHIVO
ERR_READ:
    ;;Se muestra el mensaje de error de extension
    mov AH, 09 ;; Funcion para mostrar cadena de caracteres
    mov DX, offset mensaje_err_lectura ;; Direccion de memoria de la cadena de caracteres
    int 21 ;; interrupcion para mostrar cadena de caracteres
    jmp CARGAR_ARCHIVO ;; Salta a la etiqueta CARGAR_ARCHIVO
ERROR_OPERACION:
    ;;Se muestra el mensaje de error de extension
    mov AH, 09 ;; Funcion para mostrar cadena de caracteres
    mov DX, offset error_oper ;; Direccion de memoria de la cadena de caracteres
    int 21 ;; interrupcion para mostrar cadena de caracteres
    jmp CARGAR_ARCHIVO ;; Salta a la etiqueta CARGAR_ARCHIVO
VERIFICAR_EXTENSION:
    ;;Se verifica la extension del archivo
    mov AL, [SI] ;; Se obtiene el primer caracter del buffer
    cmp AL, 'a' ;; Se compara si el caracter es igual a 'a'
    jne ERR_EXTENSION ;; Si no es igual a 'a' salta a la etiqueta ERR_EXTENSION

    inc SI ;; Se incrementa el indice del buffer
    mov AL, [SI] ;; Se obtiene el primer caracter del buffer
    cmp AL, 'r' ;; Se compara si el caracter es igual a 'r'
    jne ERR_EXTENSION ;; Si no es igual a 'r' salta a la etiqueta ERR_EXTENSION

    inc SI ;; Se incrementa el indice del buffer
    mov AL, [SI] ;; Se obtiene el primer caracter del buffer
    cmp AL, 'q' ;; Se compara si el caracter es igual a 'q'
    jne ERR_EXTENSION ;; Si no es igual a 'q' salta a la etiqueta ERR_EXTENSION
    ;verifica que no haya mas caracteres despues de la extension
    inc SI
    mov AL, [SI]
    cmp AL, 00
    jne ERR_EXTENSION
APERTURA_ARCHIVO:
    ;; se abre el archivo
    mov AH, 3Dh ;; Interrupcion para abrir un archivo
    mov AL, 00h ;; Modo de apertura
    mov DX, offset buffer_entrada + 2 ;; Direccion de memoria
    int 21 ;; interrupcion para abrir un archivo donde comienza el nombre del archivo
    jc ERR_ARCHIVO ;; Si el archivo no existe salta a la etiqueta ERR_ARCHIVO
    mov handle_archivo, AX ;; Se guarda el handle del archivo
    ;;Se lee el archivo
    mov AH, 3Fh ;; Funcion para leer un archivo
    mov BX, handle_archivo ;; Se obtiene el handle del archivo
    mov CX, 0fffh ;; Se colocan cuantos bytes se leen
    mov DX, offset buffer_lectura ;; Direccion de memoria de la cadena de caracteres
    int 21 ;; interrupcion para leer un archivo
    jc ERR_READ ;; Si hay un error al leer el archivo salta a la etiqueta READ_ERROR
    ;;AX devuelve el numero de bytes leidos
    ;;Se coloca caracter nulo al final de la entrada leida
    mov SI, offset buffer_lectura
    add SI, AX
    mov AL , 00
    mov [SI], AL
    ;;Se muestra el buffer_lectura
    ;mov AH, 09 ;; Funcion para mostrar cadena de caracteres
    ;mov DX, offset buffer_lectura ;; Direccion de memoria de la cadena de caracteres
    ;int 21 ;; interrupcion para mostrar cadena de caracteres
    ;Se guarda donde inicia la operacion incluyendo el ID
    mov ptr_coperacion, offset buffer_lectura
OPERACIONES:
    ;;Op1: +*85+/18-21, Op2: +2+2*78,Resul: +/871[caracter nulo]
    ;;Separa las operaciones
    mov SI, ptr_coperacion
    ;;Si es caracter nulos, se termina el programa
    mov AL, [SI]
    cmp AL, 00
    je ESPERAR_ENTER
    ;Salto de linea
    mov AH, 02h
    mov DL, 0Ah
    int 21h
MOSTRAR_ID:
    mov AL, [SI]
    cmp AL, ':'
    je OPERACION_CARGA
    cmp AL, ' '
    je INCREMETO_ID
    ;Imprime Caracter del ID de la operacion
    mov DL, AL
    mov AH, 02h
    int 21h
INCREMETO_ID:
    inc SI
    jmp MOSTRAR_ID
OPERACION_CARGA:
    ;;aqui se muestra el signo igual
    mov DL, '='
    mov AH, 02h
    int 21h
    ;; Se inserta Caracter Nulo en la pila principal
    mov AX, 0000
    push AX
    ;;
    ;dec SI
CICLO_METER_PILA:
    inc SI
    mov AL, [SI]
    ;;si es espacio, se omite
    cmp AL, ' '
    je CICLO_METER_PILA
    ;;si es coma o nulo, se evalua la operacion actual
    cmp AL, ','
    je GUARDAR_PTR
    cmp AL, 00
    je GUARDAR_PTR
    ;;metemos a la pila
    push SI 
    jmp CICLO_METER_PILA
GUARDAR_PTR:
    ;;guardar ptr
    cmp AL, ','
    je INCREMENTA_PARA_SIG_OPERACION
    cmp AL, 00
    jne GUARDA_DIRECCION_ACTUAL
INCREMENTA_PARA_SIG_OPERACION:
    inc SI
GUARDA_DIRECCION_ACTUAL:
    mov ptr_coperacion, SI ;;Guarda direccion donde comienza la siguiente operacion incluyendo el ID
EVALUAR_OPERACION:    
    ;;mostrar pila
    ;pop SI
    ;cmp SI, 0000
    ;je OPERACIONES
    ;mov AH, 02h
    ;mov DL, [SI]
    ;int 21h
    ;jmp EVALUAR_OPERACION

    ;;Verifica si es nulo 
    pop SI
    cmp SI, 0000
    je IMPRIMIR_OPERACION
    ;;verificar si es numero valido
    mov DI, offset numeros
    mov CX, 0000
    mov CL, 0a
    mov AL, [SI] ;;
;;ENTRADA -> AL
;;DI -> offset numeros
CICLO_EVAL_NUMS:
    cmp AL, [DI]
    je ES_NUMERO_EN_ASCII
    inc DI
    loop CICLO_EVAL_NUMS
    ;;si no es numero, se evalua si es operador
    mov DI, offset operadores
    mov CX, 0000
    mov CL, 04
CICLO_EVAL_OPERADORES:
    cmp AL, [DI]
    je ES_OPERADOR
    inc DI
    loop CICLO_EVAL_OPERADORES
    cmp AL, ')'
    je YAES_NUMERO
    ;;si no es operador, se muestra error
    mov AH, 09 ;; Funcion para mostrar cadena de caracteres
    mov DX, offset error_num ;; Direccion de memoria de la cadena de caracteres
    int 21 ;; interrupcion para mostrar cadena de caracteres
    jmp CARGAR_ARCHIVO
ES_NUMERO_EN_ASCII:
    ;;si es numero, se guarda en num1
    call ascii_a_num
    mov AH, 00
    jmp GUARDAR_NUM 
YAES_NUMERO:
    pop SI ;; ####(->5
    mov AX, SI ;;guarda el numero en AX
    pop SI ;; ###->( saca el parentesis

GUARDAR_NUM:
    ;; mete el primer numero
    cmp cont_nums, 00
    je GUARDAR_NUM1
    ;; mete el segundo numero
    cmp cont_nums, 01
    je GUARDAR_NUM2
    ;; si se pasa de 2 nums, hace cambio
    jmp CAMBIO_NUMS
GUARDAR_NUM1:
    mov num1, AX ;;0000 0000 0000 0010
    inc cont_nums
    cmp modo, 01
    je DECIDIR_ENTRADA
    jmp EVALUAR_OPERACION
GUARDAR_NUM2:
    mov num2, AX ;;0000 0000 0000 0010
    inc cont_nums
    cmp modo, 01
    je DECIDIR_ENTRADA
    jmp EVALUAR_OPERACION
CAMBIO_NUMS:
    mov BX, num1 ;;0011
    mov aux_num, BX ;; aux_num = 0011
    call push_pila  ;;mete 0011 a la pila
    ;;num2 lo pasa a num1
    mov BX, num2
    mov num1, BX ;;num1 = 0010
    ;;num2 es igual a AL
    mov num2, AX  ;;num2 = 0111
    jmp EVALUAR_OPERACION
ES_OPERADOR:
    ;;reinicio de contadores
    cmp cont_nums, 00
    je ERROR_OPERACION
    ;;si es operador, se evalua
    cmp AL, '+' 
    je SUMA
    cmp AL, '-' ;;-8 = -8
    je RESTA
    cmp AL, '*' ;*8
    je MULTIPLICACION
    cmp AL, '/'
    je DIVISION
SUMA:
    cmp cont_nums, 01
    jne SIGSUMA
    mov num2, 0000
SIGSUMA:
    mov cont_nums, 00
    mov AX, num1
    add AX, num2 ;;AX = SUMA

    cmp modo, 01
    jne SEGUIR_SUMA
    mov num1, AX
    jmp DECIDIR_ENTRADA
SEGUIR_SUMA:
    ;;se mete par abre
    mov BX, offset parabre
    push BX
    ;;
    push AX
    ;;se mete para cierra
    mov BX, offset parcierra
    push BX  
    ;;si contpila es mayor = 0
    cmp cont_pila, 00
    je EVALUAR_OPERACION
    call pop_pila
    ;;se mete par abre
    mov BX, offset parabre
    push BX
    ;;
    mov BX, aux_num
    push BX
    ;;se mete para cierra
    mov BX, offset parcierra
    push BX  
    jmp EVALUAR_OPERACION
RESTA:
    ;;se verifica si contnum es 1
    cmp cont_nums, 01
    jne SIGRESTA
    ;; num2 asignarle -1
    inc cont_nums
    mov num2, 0001
    neg num2
    jmp MULTIPLICACION
SIGRESTA:
    mov cont_nums, 00
    mov AX, num2
    sub AX, num1 ;;-53
    jmp SEGUIR_RESTA
RESTA_MODOCAL:
    mov cont_nums, 00 
    mov AX, num1
    sub AX, num2    
    cmp modo, 01
    jne SEGUIR_RESTA
    mov num1, AX
    jmp DECIDIR_ENTRADA
SEGUIR_RESTA:

    ;;se mete par abre
    mov BX, offset parabre
    push BX
    ;;
    push AX
    ;;se mete para cierra
    mov BX, offset parcierra
    push BX  
    ;;si contpila es mayor = 0
    cmp cont_pila, 00
    je EVALUAR_OPERACION
    call pop_pila
    ;;se mete par abre
    mov BX, offset parabre
    push BX
    ;;
    mov BX, aux_num
    push BX
    ;;se mete para cierra
    mov BX, offset parcierra
    push BX  
    jmp EVALUAR_OPERACION
MULTIPLICACION:
    cmp cont_nums, 01    ; 0  -> num1 -> 1 -> num2 -> 2  -> no es 2
    je ERROR_OPERACION
    mov cont_nums, 00    ;;se reinicia el contador
    mov AX, num1
    mul num2

    ;;si es modo calculadora
    cmp modo, 01
    jne SEGUIR_MULTIPLICACION
    mov num1, AX
    jmp DECIDIR_ENTRADA
SEGUIR_MULTIPLICACION:

    ;;se mete par abre
    mov BX, offset parabre
    push BX
    ;;
    push AX
    ;;se mete para cierra
    mov BX, offset parcierra
    push BX 
    ;;si contpila es mayor = 0
    cmp cont_pila, 00
    je EVALUAR_OPERACION
    call pop_pila
    ;;se mete par abre
    mov BX, offset parabre
    push BX
    ;;
    mov BX, aux_num
    push BX
    ;;se mete para cierra
    mov BX, offset parcierra
    push BX 
    jmp EVALUAR_OPERACION
DIVISION:
    cmp cont_nums, 01    ; 0  -> num1 -> 1 -> num2 -> 2  -> no es 2
    je ERROR_OPERACION
    mov cont_nums, 00    ;;se reinicia el contador
    mov CX, num1
    mov AX, num2
    idiv CL
    mov AH, 00
    cbw
    jmp SEGUIR_DIVISION
DIVISION_MODOCALC:
    mov cont_nums, 00
    mov CX, num2
    mov AX, num1
    idiv CL
    mov AH, 00
    cbw
    ;;si es modo calculadora
    cmp modo, 01
    jne SEGUIR_DIVISION
    mov num1, AX
    jmp DECIDIR_ENTRADA
SEGUIR_DIVISION:
    ;;se mete par abre
    
    mov BX, offset parabre
    push BX
    push AX
    ;;se mete para cierra
    mov BX, offset parcierra
    push BX   
    ;;si contpila es mayor = 0
    cmp cont_pila, 00
    je EVALUAR_OPERACION
    call pop_pila
    ;;se mete par abre
    mov BX, offset parabre
    push BX
    ;;
    mov BX, aux_num
    push BX
    ;;se mete para cierra
    mov BX, offset parcierra
    push BX 
    jmp EVALUAR_OPERACION
IMPRIMIR_OPERACION:
    ;;reiniciar contadores
    mov cont_nums, 00
    mov cont_pila, 00

    clc ;;se limpia el carry
    ;;verifico si el numero es negativo
    mov BX, num1
    add BH, 80h ; carry = 1

    mov BL, 00
    adc BL, 00 ;;entrampa carry

    cmp BL, 01
    jne IMPRIMIR_MAS
    ;; se le saca complemento a 2 AX
    neg num1
    ;; imprimos un signo negativo
    mov AH, 02h
    mov DL, '-'
    int 21h
    ;;Poner signo '-' cadena_signo_resultado_operacion
    mov cadena_signo_resultado_operacion, '-'
    jmp IMPRIMIR_NUM
IMPRIMIR_MAS:
    ;; imprimos un signo negativo
    mov AH, 02h
    mov DL, '+'
    int 21h
    ;;Poner signo '+' cadena_signo_resultado_operacion
    mov cadena_signo_resultado_operacion, '+'
IMPRIMIR_NUM:
    ;;imprimir resultado de num1
    mov AX, num1
    call numAstr
    ;mov AH, 02h
    ;mov DL, 'a' ;;cambiar resultado
    ;int 21h
    ;;imprimir cadena_result
    mov AH, 09h
    mov DX, offset cadena_resul
    int 21h

    ;;copiar cadena_resul a cadena_resultado_operacion 
    mov DI, offset cadena_resultado_operacion
    mov SI, offset cadena_resul
    mov CX, 06h
 COPIAR_RESULTADO:
    mov AL, [SI]
    mov [DI], AL
    inc DI
    inc SI
    loop COPIAR_RESULTADO   
    ;;modo calculadora
    cmp modo, 01
    je PREGUNTAR_GUARDAR

    jmp OPERACIONES


;;---------------------------------FUNCIONES-------------------------------------------
;;funcion push pila_num-----------------------------
;;auxnum -> valor a meter
push_pila:
    mov DX, offset pila_num
    add DX, cont_pila
    mov DI, DX
    mov BX, aux_num
    mov [DI], BH
    mov [DI+1], BL 
    add cont_pila, 02 
    ret
;;funcion pop pila_num-----------------------------
;;SALIDA -> aux_num
;;564
pop_pila:
    sub cont_pila, 02
    mov DX, offset pila_num ;;.564
    add DX, cont_pila ;;56.4  
    mov DI, DX
    mov BH, [DI]
    mov BL, [DI+1]
    mov aux_num, BX
    ret
;;funcion que convierte ascii a numero-----------------------------------
;;ENTRADA -> AL
;;SALIDA -> AL
ascii_a_num:    
    sub AL, 30h
    ret

;;funcion que convierte binario a ascii-----------------------------------
;;Entrada -> AX
;;Salida -> num1


;; numAstr - convierte un número entero en cadena
;;     Entrada: AX -> numero de entrada
;;     Salida:  cadena_resul -> el número convertido a cadena
numAstr:                                ;;; Limpiar la cadena
    mov CX, 06h
    mov BX, offset cadena_resul ;;direccion cadena resultado
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
    mov BX, offset cadena_resul
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
    cmp BX, offset cadena_resul    ;;; Si el índice actual no es la direccion de la primera cifra
    jne revisar_cifra        ;;; revisar la cifra anterior para ver si nuevamente hay que incrementarla
    mov BX, SI               ;;; Reestablecer la posición de las unidades en el registro original
    cmp AX, 0000h            ;;; Si el número de entrada no es 0
    jne unidad               ;;; Volver a incrementar unidades
retorno:        
    ret                      ;;; Si no retornar

ESPERAR_ENTER:
    ;;mostrar mensaje de presionar enter
    mov AH, 09 ;; Funcion para mostrar cadena de caracteres
    mov DX, offset presionar_enter ;; Direccion de memoria de la cadena de caracteres
    int 21 ;; interrupcion para mostrar cadena de caracteres

    mov AH, 1 ;; Funcion para leer un caracter
    int 21 ;; interrupcion para leer un caracter
    cmp AL, 0DH ;; Compara si el caracter es un enter
    JNE ESPERAR_ENTER ;; Si no es un enter, entonces vuelve a pedir un caracter
    JMP MENU_PRINCIPAL ;; Si es un enter, entonces vuelve al menu principal

;;============================================== MODO CALCULADORA =======================================================
MODO_CALCULADORA:
    ;;Se muestra el mensaje para ingresar la ruta del archivo
    mov AH, 09 ;; Funcion para mostrar cadena de caracteres
    mov DX, offset menu_calculadora ;; Direccion de memoria de la cadena de caracteres
    int 21 ;; interrupcion para mostrar cadena de caracteres
    mov modo, 01
    ;; Se inicializa cont_nums, y cont_pila
    mov cont_nums, 00
    mov cont_pila, 00
    mov maxoperaciones, 00
DECIDIR_ENTRADA:
    ;;se verifica si ya hay dos operadores
    cmp cont_nums, 02
    jne SEGUIR_DECIENDO_ENTRADA
    ;;se hace la operacion
    cmp operador_calculadora, '+'
    je SIGSUMA
    cmp operador_calculadora, '-'
    je RESTA_MODOCAL
    cmp operador_calculadora, '*'
    je MULTIPLICACION
    cmp operador_calculadora, '/'
    je DIVISION_MODOCALC
SEGUIR_DECIENDO_ENTRADA:
    cmp tipo_ingreso, 00
    je INGRESE_NUMERO_MENU
    cmp tipo_ingreso, 01
    je INGRESE_OPERADOR_MENU
    cmp tipo_ingreso, 02
    je INGRESE_NUMERO_MENU
    cmp tipo_ingreso, 03
    je INGRESE_OPERADOR_IGUAL_MENU
INGRESE_NUMERO_MENU:
    mov numpos, 0001 ;;se inicializa numpos
    inc tipo_ingreso
    mov AH, 09 ;; Funcion para mostrar cadena de caracteres
    mov DX, offset ingrese_numero ;; Direccion de memoria de la cadena de caracteres
    int 21 ;; interrupcion para mostrar cadena de caracteres
    jmp PEDIR_ENTRADA
INGRESE_OPERADOR_MENU:
    inc tipo_ingreso
    mov AH, 09 ;; Funcion para mostrar cadena de caracteres
    mov DX, offset ingrese_operador ;; Direccion de memoria de la cadena de caracteres
    int 21 ;; interrupcion para mostrar cadena de caracteres

    ;;se pide un caracter
    mov AH, 01 ;; Funcion para leer un caracter
    int 21 ;; interrupcion para leer un caracter
    mov operador_calculadora, AL ;+-*/
    inc maxoperaciones
    ;;copiar AL a cadena_operaciones
    mov DI, offset cadena_operacion
    add DI, offset_cadena_operacion
    mov [DI], AL
    inc offset_cadena_operacion
    ;
    jmp INGRESE_NUMERO_MENU
INGRESE_OPERADOR_IGUAL_MENU: ;;num1 = 33, tipoingreso = 3
    dec tipo_ingreso ;; tipoingreso = 2
    mov cont_nums, 01
    mov AH, 09 ;; Funcion para mostrar cadena de caracteres
    mov DX, offset ingrese_operador_igual ;; Direccion de memoria de la cadena de caracteres
    int 21 ;; interrupcion para mostrar cadena de caracteres

    ;;se pide un caracter
    mov AH, 01 ;; Funcion para leer un caracter
    int 21 ;; interrupcion para leer un caracter
    mov operador_calculadora, AL
    cmp AL, '='                         ; 8 + 8 + 
    je RESULTADO_CALCULADORA
    ;;copiar AL a cadena_operaciones
    mov DI, offset cadena_operacion
    add DI, offset_cadena_operacion
    mov [DI], AL
    inc offset_cadena_operacion
    ;
    inc maxoperaciones
    cmp maxoperaciones, 0a
    jb INGRESE_NUMERO_MENU
    ;;Mostrar mensaje de error
    mov AH, 09 ;; Funcion para mostrar cadena de caracteres
    mov DX, offset cadenamaxima ;; Direccion de memoria de la cadena de caracteres
    int 21 ;; interrupcion para mostrar cadena de caracteres
    jmp RESULTADO_CALCULADORA

PEDIR_ENTRADA:
    ;;Se pide una cadena de caracteres
    mov AH, 0AH ;; Funcion para leer cadena de caracteres
    mov DX, offset buffer_entrada ;; Direccion de memoria de la cadena de caracteres
    int 21 ;; interrupcion para leer cadena de caracteres

    ;;Se coloca caracter nulo al final de la entrada leida
    mov DI, offset buffer_entrada + 1 ;; Direccion de memoria del byte que contiene logitud de la cadena
    mov AX, 0000 ;; Se limipiar AX
    mov AL, [DI] ;; Se obtiene la longitud de la cadena
    add DI, AX ;; Se obtiene la direccion del ultimo byte de la cadena
    inc DI ;; Se incrementa la direccion del siguiente byte despues de la cadena
    mov AL, 00 ;; Se coloca el caracter nulo
    mov [DI], AL ;; Se coloca el caracter nulo al final de la cadena
    ;; Cpiar buffer_entrada a cadena_operacion hasta encontrar nulo
    ;;
    mov SI, offset buffer_entrada + 2 ;; Direccion donde comienza la cadena del nombre del archivo
    mov DI, offset cadena_operacion
    add DI, offset_cadena_operacion ;;buffer entrada +55  cadena_operacion  +33+55
    mov CX, 0000
    mov CL, [SI-1] ;; Se obtiene la longitud de la cadena
    add offset_cadena_operacion, CX
LOOP_COPIAR_BUFFER:
    mov AL, [SI]
    mov [DI], AL
    inc SI
    inc DI
    loop LOOP_COPIAR_BUFFER
    ;;
    ;;
    mov SI, offset buffer_entrada + 2;; Direccion donde comienza la cadena del numero del archivo
    ;; se meten NULO
    mov AX, 0000
    push AX
CICLO_METER_PILA_NUMS:
    mov AL, [SI]
    cmp AL, 00
    je CONVERTIR_A_NUM_REAL
    ;;metemos a la pila
    push SI 
    inc SI
    jmp CICLO_METER_PILA_NUMS
CONVERTIR_A_NUM_REAL: ;; EN AX se guarda el numero calculado final -56
    mov AX, 0000
CICLO_CONVERTIR_A_NUM_REAL:
    pop SI
    ;;se verifica si es nulo para terminar
    cmp SI, 0000
    je GUARDAR_NUM
    ;;si es negativo
    mov BL, '-' 
    cmp [SI], BL
    je ES_NEGATIVO
    ;;si es positivo
    mov BL, '+'
    cmp [SI], BL
    je CICLO_CONVERTIR_A_NUM_REAL

    ;;guardo AX
    mov numero_calc, AX ;;numero_calc= 0

    mov AL, [SI] ;; AL -> 2 ascii

    call ascii_a_num ;;me devuelve el numero en AL
    mov AH, 00      ;; AX = 0000 0000 0000 0010
    mul numpos      ;; AX = AX * 1; = 2

    add numero_calc, AX ;; 0 + 2 = 2
    mov BL, 0a  
    mov AX, numpos ;; AX = 1
    mul BL          ;; AX = AX * 10; = 10
    mov numpos, AX ;; numpos = 10
    
    mov AX, numero_calc ;; AX = 2

    jmp CICLO_CONVERTIR_A_NUM_REAL

ES_NEGATIVO:
    ;;complemento a 2 de AX
    neg AX
    JMP CICLO_CONVERTIR_A_NUM_REAL

RESULTADO_CALCULADORA:
    ;;se muestra el resultado
    mov AH, 09 ;; Funcion para mostrar cadena de caracteres
    mov DX, offset mostrar_resultado ;; Direccion de memoria de la cadena de caracteres
    int 21 ;; interrupcion para mostrar cadena de caracteres
    jmp IMPRIMIR_OPERACION
PREGUNTAR_GUARDAR:
    ;;Se muestra el mensaje para guardar
    mov AH, 09 ;; Funcion para mostrar cadena de caracteres
    mov DX, offset desea_guardar ;; Direccion de memoria de la cadena de caracteres
    int 21 ;; interrupcion para mostrar cadena de caracteres
    ;;se pide un caracter
    mov AH, 01 ;; Funcion para leer un caracter
    int 21 ;; interrupcion para leer un caracter
    cmp AL, 'S' ;; Compara si el caracter es igual a S
    je GUARDAR_RESULTADO ;; Si es igual a S, salta a la etiqueta GUARDAR_RESULTADO
    cmp AL, 'N' ;; Compara si el caracter es igual a N
    je MENU_PRINCIPAL ;; Si es igual a N, salta a la etiqueta MENU_PRINCIPAL
    jmp PREGUNTAR_GUARDAR ;; Si no es igual a ninguno de los anteriores, salta a la etiqueta RESULTADO_CALCULADORA
GUARDAR_RESULTADO:
    ;;Incrementar count_id_operacion
    inc count_id_operacion
    ;;converti count_id_operacion a string
    mov AH, 00
    mov AL, count_id_operacion
    call numAstr
    ;;copiar los utimos 2 caracteres de cadena_resul a cadena_resultado_operacion
    mov DI, offset cadena_id_operacion
    mov SI, offset cadena_resul ;;000000
    mov AL, [SI+4]
    mov [DI], AL
    inc DI
    inc SI
    mov AL, [SI+4]
    mov [DI], AL
    ;;copiar fila_tabla_operacion a inicio_tabla
    mov DI, offset fila_tabla_operacion
    mov SI, offset inicio_tabla
    add SI, offset_tabla
    mov CX, 0083
    add offset_tabla, CX
COPIAR_FILA:
    mov AL, [DI]
    mov [SI], AL
    inc DI
    inc SI
    loop COPIAR_FILA
    ;;reiniciar offset de la cadena de la operacion
    mov offset_cadena_operacion, 0000
    ;;limpiar cadena_operacion
    mov DI, offset cadena_operacion
    mov CX, 001E
LIMPIAR_CADENA_OPERACION:
    mov AL, 00
    mov [DI], AL
    inc Di
    loop LIMPIAR_CADENA_OPERACION
    jmp MENU_PRINCIPAL

;;============================================== MODO FACTORIAL =======================================================

ERROR_FACTORIAL:
    ;;se muestra el mensaje de error
    mov AH, 09 ;; Funcion para mostrar cadena de caracteres
    mov DX, offset cadena_error_factorial ;; Direccion de memoria de la cadena de caracteres
    int 21 ;; interrupcion para mostrar cadena de caracteres
    jmp MENU_PRINCIPAL

FACTORIAL:
    mov auxfac, 00
    mov resultado_fac, 01
    mov resultado_ant_fact, 01
    mov factorial_n, 00
    ;;imprimir menu factorial
    mov AH, 09 ;; Funcion para mostrar cadena de caracteres
    mov DX, offset menu_factorial ;; Direccion de memoria de la cadena de caracteres
    int 21 ;; interrupcion para mostrar cadena de caracteres

    ;;se muestra el mensaje para ingresar numero
    mov AH, 09 ;; Funcion para mostrar cadena de caracteres
    mov DX, offset ingrese_numero_factorial ;; Direccion de memoria de la cadena de caracteres
    int 21 ;; interrupcion para mostrar cadena de caracteres

    ;;se pide un numero
    mov AH, 01 ;; Funcion para leer un caracter
    int 21 ;; interrupcion para leer un caracter

    ;;LO guarda en AL
    call ascii_a_num
    ;;--> AL -> num binario

    mov factorial_n, AL

    ;;Comparar si factorial_n es mayor o igual a 0 o menor o igual a 4
    cmp factorial_n, 00
    jl ERROR_FACTORIAL 
    cmp factorial_n, 04
    jg ERROR_FACTORIAL
    ;;se muestra el mensaje para las operaciones
    mov AH, 09 ;; Funcion para mostrar cadena de caracteres
    mov DX, offset operaciones_fac;; Direccion de memoria de la cadena de caracteres
    int 21 ;; interrupcion para mostrar cadena de caracteres

CICLO_FACTORIAL:
    ;;se imprime auxfac
    mov AH, 00
    mov AL, auxfac

    call numAstr
    call IMPRIMIR_SIN_CEROS_CADENA_NUMASTR

    ;;se imprime el signo !
    mov AH, 02h
    mov DL, '!'
    int 21h

    ;;se imprime el signo =
    mov AH, 02h
    mov DL, '='
    int 21h

    ;;se imprimme "resultado_ant_fact * auxfac =" si auxfac es mayor a 0
    cmp auxfac, 00
    je SEGUIR_FACTORIAL 

    ;se imprime : resultado_ant_fact * auxfac =
    mov AH, 00
    mov AL, resultado_ant_fact
    call numAstr
    call IMPRIMIR_SIN_CEROS_CADENA_NUMASTR

    ;;se imprime el signo *
    mov AH, 02h
    mov DL, '*'
    int 21h

    ;se imprime : auxfac
    mov AH, 00
    mov AL, auxfac
    call numAstr
    call IMPRIMIR_SIN_CEROS_CADENA_NUMASTR

    ;;se imprime el signo =
    mov AH, 02h
    mov DL, '='
    int 21h

SEGUIR_FACTORIAL:

    ;;se imprime el resultado
    mov AH, 00
    mov AL, resultado_fac

    call numAstr
    call IMPRIMIR_SIN_CEROS_CADENA_NUMASTR

    ;;se imprime pto y coma
    mov AH, 02h
    mov DL, ';'
    int 21h

    ;;se imprime un espacio 
    mov AH, 02h
    mov DL, ' '
    int 21h

    mov AL, auxfac
    cmp factorial_n, AL
    je RESULTADO_FACTORIAL
    inc auxfac
    ;calcular nuevo resultado. resultado = resultado * auxfac
    mov AH, 00
    mov AL, resultado_fac
    mov resultado_ant_fact, AL
    mul auxfac
    mov resultado_fac, AL
    jmp CICLO_FACTORIAL

RESULTADO_FACTORIAL:
    ;;se imprime resultado
    mov AH, 09
    mov DX, offset resultado_fac_cadena
    int 21

    ;;se convierte a string
    mov AH, 00
    mov AL, resultado_fac

    call numAstr
    call IMPRIMIR_SIN_CEROS_CADENA_NUMASTR

    jmp MENU_PRINCIPAL

IMPRIMIR_SIN_CEROS_CADENA_NUMASTR:
    mov CX, 0005
    mov BX, offset cadena_resul
QUITAR_CERO:
    mov AL, [BX]
    cmp AL, '0'
    je SEGUIR_LOOP
    ;;si no es cero, se imprime cadena_resul y carga a CX = 1 para que no imprima mas
    mov AH, 09h
    mov DX, BX
    int 21h
    jmp FIN  
SEGUIR_LOOP:
    inc BX
    loop QUITAR_CERO
    ;;si CX es cero, imprime el ultimo caracter de cadena_result
    cmp CX, 0000
    jne FIN 
    ;;es cero
    mov BX, offset cadena_resul + 5
    mov AH, 02h 
    mov DL, [BX]
    int 21h
FIN: 
    ret

CREAR_REPORTE:
    ;;obtener Fecha
    mov AH, 2Ah
    int 21h
    mov dia_numero, DL
    mov mes_numero, DH
    mov ahno_numero, CX
    ;;converti dia a cadena
    mov AH, 00
    mov AL, dia_numero
    call numAstr ;;Salida Cadena Resultado
    ;;Copiar solo los ultimos 2 caracteres de cadena_result a dia_cadena
    mov SI, offset cadena_resul + 4
    mov DI, offset dia_cadena
    mov AL, [SI]
    mov [DI], AL
    inc SI
    inc DI
    mov AL, [SI]
    mov [DI], AL
    ;;convertir mes a cadena
    mov AH, 00
    mov AL, mes_numero
    call numAstr ;;Salida Cadena Resultado
    ;;Copiar solo los ultimos 2 caracteres de cadena_result a mes_cadena
    mov SI, offset cadena_resul + 4
    mov DI, offset mes_cadena
    mov AL, [SI]
    mov [DI], AL
    inc SI
    inc DI
    mov AL, [SI]
    mov [DI], AL
    ;;convertir año a cadena
    mov AX, ahno_numero
    call numAstr ;;Salida Cadena Resultado
    ;;Copiar solo los ultimos 4 caracteres de cadena_result a ahno_cadena
    mov SI, offset cadena_resul + 2 ;;000000
    mov DI, offset anho_cadena
    mov CX, 0004
COPIAR_AHNO:
    mov AL, [SI]
    mov [DI], AL
    inc SI
    inc DI
    loop COPIAR_AHNO
    ;;Obtener hora
    mov AH, 2Ch
    int 21h
    mov hora_numero, CH
    mov minutos_numero, CL
    mov segundos_numero, DH
    ;;convertir hora a cadena
    mov AH, 00
    mov AL, hora_numero
    call numAstr ;;Salida Cadena Resultado
    ;;Copiar solo los ultimos 2 caracteres de cadena_result a hora_cadena
    mov SI, offset cadena_resul + 4
    mov DI, offset hora_cadena
    mov AL, [SI]
    mov [DI], AL
    inc SI
    inc DI
    mov AL, [SI]
    mov [DI], AL
    ;;convertir minutos a cadena
    mov AH, 00
    mov AL, minutos_numero
    call numAstr
    ;;Copiar solo los ultimos 2 caracteres de cadena_result a minutos_cadena
    mov SI, offset cadena_resul + 4
    mov DI, offset minutos_cadena
    mov AL, [SI]
    mov [DI], AL
    inc SI
    inc DI
    mov AL, [SI]
    mov [DI], AL
    ;;convertir segundos a cadena
    mov AH, 00
    mov AL, segundos_numero
    call numAstr
    ;;Copiar solo los ultimos 2 caracteres de cadena_result a segundos_cadena
    mov SI, offset cadena_resul + 4
    mov DI, offset segundos_cadena
    mov AL, [SI]
    mov [DI], AL
    inc SI
    inc DI
    mov AL, [SI]
    mov [DI], AL
    ;Crear archivo para reporte
    mov AH, 3ch
    mov CX, 0000
    mov DX, offset nombre_reporte
    int 21h
    mov handle_reporte, AX
    ;Escribir en Reporte
    mov AH, 40h
    mov BX, handle_reporte
    mov CX, 0831h
    mov DX, offset reporte_html
    int 21h
    ;Cerrar archivo
    mov AH, 3eh
    mov BX, handle_reporte
    int 21h
    jmp MENU_PRINCIPAL
SALIR:
.EXIT
END