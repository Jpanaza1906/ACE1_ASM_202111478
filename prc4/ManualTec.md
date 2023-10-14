# Manual Técnico de la Aplicación de Operaciones

## Introducción
Esta aplicación tiene la funcionalidad de realizar diversas operaciones, tales como cálculos en modo calculadora, cálculo de factorial y generación de reportes a partir de un archivo que contiene operaciones en formato de prefijo.

## Modos de Funcionamiento

### 1. Modo Cargar Archivo
En este modo, la aplicación permite cargar un archivo que contiene operaciones en formato de prefijo. El archivo debe seguir un formato específico para que la aplicación pueda interpretar las operaciones correctamente.

#### Formato del Archivo
Cada línea del archivo debe contener una operación en notación de prefijo. Por ejemplo:
```
+ 5 3 2   // Representa la operación de suma: 5 + 3 + 2
* 4 6 2   // Representa la operación de multiplicación: 4 * 6 * 2
```

### 2. Modo Calculadora
En este modo, la aplicación permite realizar operaciones matemáticas básicas, como suma, resta, multiplicación y división, ingresando los operandos y el operador correspondiente.

#### Operaciones Soportadas
- Suma: `+`
- Resta: `-`
- Multiplicación: `*`
- División: `/`

### 3. Modo Factorial
En este modo, la aplicación permite calcular el factorial de un número ingresado por el usuario.

#### Operación Soportada
- Factorial: `n!`

### 4. Modo Reportes
En este modo, la aplicación generará reportes basados en las operaciones cargadas desde un archivo en el modo "Cargar Archivo".

#### Formato del Reporte
El reporte mostrará cada operación, su resultado y el tipo de operación realizada.

## Uso de la Aplicación

1. Abrir la aplicación y seleccionar el modo de operación deseado.
2. En el modo "Cargar Archivo", cargar un archivo que contenga las operaciones en formato de prefijo siguiendo las indicaciones dadas.
3. En el modo "Calculadora", ingresar los operandos y el operador correspondiente para realizar la operación deseada.
4. En el modo "Factorial", ingresar un número para calcular su factorial.
5. En el modo "Reportes", generar un reporte a partir de las operaciones cargadas previamente y visualizarlo.

¡Esperamos que esta aplicación sea de utilidad y facilite la realización de operaciones matemáticas de forma eficiente y organizada!