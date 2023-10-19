    ;; se direcciona DS
    mov AX, FF00h
    mov DS, AX
    ;; se inicializa el stack pointer
    mov SP, 00FF

    ;; se apagan los led
    mov AL, 00h
    out 3000h, AL
INICIO:
    mov BL, 01h ;; se realiza la mascara empezando con 00000001
PRESION:
    in AL, 2300h ;;se lee el puerto
    ror BL, 1 ;; Se rota a la derecha para ver el bit 6 si el 7 no es

    test AL, BL ;;se hace un and para ver si el bit 7 esta en 1
    jz PRESION ;;si el bit 7 esta en 0 se vuelve a leer

    call REBOTE
    ;;en AL esta el valor del puerto 10000000 o 01000000 o 00100000 ...
LIBERA:
    in AL, 2300h ;;se lee el puerto
    test AL, BL ;;se hace un and para ver si se libero el mismo bit
    jnz LIBERA ;;si el bit esta en 1 se vuelve a leer

    call REBOTE

    ;;en BL esta el valor del puerto donde se presiono el boton
    ;; se supone que presion el boton 3 el registro BL tiene 00000100
    mov CL, 00h ;; se inicializa el contador en 0
    mov AL, BL ;; se copia el valor de BL a AL
    mov BL, 80h ;; se realiza una mascara empezando con 10000000
VER: ;; AL -> 00000100 BL -> 00000001 CL -> 00000000
    rol BL, 1 ;; se desplaza a la izquierda para ver el bit 1 si el 0 no es
    inc CL ;; se incrementa el contador
    test AL, BL
    jz VER ;; si el bit 0 esta en 0 se vuelve a rotar
    dec CL ;; se decrementa el contador

    mov AL, CL ;; se copia el valor del contador a AL
    out 3000h, AL ;; se muestra el valor del contador en los leds

    jmp INICIO
    

REBOTE:
    ;; 2500 a hexa es 9C4
    mov SI, 9C4h
I3:
    dec SI
    jz I1
    ;; 1000 a hexa es 3E8
    mov DI, 3E8h
I2:
    dec DI
    jnz I2
    jmp I3
I1:
    ret


