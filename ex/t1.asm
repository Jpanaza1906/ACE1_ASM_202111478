;;se mueve el DS
    mov AX, FF00
    mov DS, AX
LECTURA_PUERTO:
    mov AX, 0000h ;; se inicializa el registro
    in AL, 2300h  ;; se obtiene la informacion del puerto

    mov DL, AL ;; se guarda en DL

    and AL, c0 ;; xx000000 -> 11000000 mascara
    rol AL, 2 ;; 000000xx -> se rotan a la izquierda

    ;;S1-S0-0-0-d3-d2-d1-d0
    and DL, 0fh ;; 00001111 -> mascara
    mov AH, 0 ;; se inicializa el registro
    
    ;;AL se encuentra el numero estado
    ;;DL se encuentra la informacion del puerto
    ;;se crera una mascara para obtener el estado deseado
    mov BL, 01h ;; 00000001 -> mascara

    ;;se mueve la mascara a la izquierda segun el estado
    shl BL, AL ;; 00000001 -> 00000010 -> 00000100 -> 00001000

    ;;se aplicara la mascara a DL
    and DL, BL ;; 00000000 -> 00000010 -> 00000100 -> 00001000


    ;; desplazar al bit 1 
    shr DL, AL ;; se desplaza a la derecha segun el estado
    shl DL, 1 ;; se desplaza a la izquierda para que quede en el bit 1

    out 3000h, DL ;; se envia la informacion al puerto

    jmp LECTURA_PUERTO ;; se regresa a la lectura del puerto



    