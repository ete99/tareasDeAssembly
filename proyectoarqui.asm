.data 
mat: .space 400
matsz: .word 100
NL: .asciiz "\n"
espacio: .asciiz " "
mensaje: .asciiz "Introduzca 1 para realizar el procedimiento, 0 para terminar el programa\n"
mProducto: .asciiz "El mayor producto es:"
.text

main: 
lw $s0,matsz #tamaño de matriz
la $s1,mat
li $s3,0 #mayor valor de mult
li $t0,0 #contador
li $s4,10
addi $s2,$s1,400

initlp: beq $t0, $s0,salir #En esta funcion se inicializan los elementos de la matriz con numero aleatorios de 0 a 100
li $a1,5		#se introduce el mayor numero-1 que sale del random
li $v0,42
syscall
sw $a0,($s1)
addi $s1,$s1,4	#se suma 4 a la direccion, siguiente elemento de la "mat"
addi $t0,$t0,1	#se suma 1 al contador
b initlp
salir:
li $t0,0
la $s1,mat

imprimir:
beq $s0,$t0,paso2 #verifica si tiene que salir loop
div $t0,$s4
mfhi $t6
beq $t6,0,SaltoFila
volver:
lw $a0,($s1) #asigna a $a0 el valor a imprimir
li $v0,1 #$v0 es 1 para imprimir int
syscall #imprime int
la $a0,espacio #imprime nueva linea
li $v0,4 #4 para imprimir una cadenam que es espacio
syscall #imprime
addi $s1,$s1,4 #suma 4 al ptr , siguiente elemento a imprimir
addi $t0,$t0,1 #suma 1 al contador
b imprimir #realiza el loop


paso2: 
lw $s0,matsz
li $t0,1 #contador = 0 
la $s1,mat #puntero regresa a primera pos de mat
b Dizq1

sumar:
beq $t0,$s0,fin
addi $s1,$s1,4
addi $t0,$t0,1
b Dizq1



Dizq1:
la $s7, mat #puntero regresa a primera pos de mat
addi $s5, $s1, -132 #puntero a la posicion mas alejada en esta direccion
sle $t1,$s7,$s5 #verifica que el numero mas alejado este dentro de la matriz
beq $t1, 0, Arriba #si esta fuera, salta a la siguiente funcion (direccion)
lw $s4,($s5)
addi $s5, $s5, 44
lw $t3,($s5)
mul $s4, $s4, $t3
addi $s5, $s5, 44
lw $t3,($s5)
mul $s4, $s4, $t3
addi $s5, $s5, 44
lw $t3,($s5)
mul $s4, $s4, $t3
sle $t1, $s3, $s4 #verifica que el resultado de la multiplicacion sea mayor que el mayor valor hasta ahora
beq $t1, 0, Arriba
move $s3, $s4 #si es asi, pone ese valor en el valor mayor para la siguiente comparacion
b Arriba

Arriba:
#puntero $s7 ya esta guardado, regresa a primera pos de mat
addi $s5, $s1, -120 #puntero a la posicion mas alejada en esta direccion
sle $t1,$s7,$s5 #verifica que el numero mas alejado este dentro de la matriz
beq $t1, 0, Dder1 #si esta fuera, salta a la siguiente funcion (direccion)
lw $s4,($s5)
addi $s5, $s5, 40
lw $t3,($s5)
mul $s4, $s4, $t3
addi $s5, $s5, 40
lw $t3,($s5)
mul $s4, $s4, $t3
addi $s5, $s5, 40
lw $t3,($s5)
mul $s4, $s4, $t3
sle $t1, $s3, $s4 #verifica que el resultado de la multiplicacion sea mayor que el mayor valor hasta ahora
beq $t1, 0, Dder1
addi $s3, $s4, 0 #si es asi, pone ese valor en el valor mayor para la siguiente comparacion
b Dder1

Dder1:
addi $s5, $s1, -108 #puntero a la posicion mas alejada en esta direccion
sle $t1,$s7,$s5 #verifica que el numero mas alejado este dentro de la matriz
beq $t1, 0, Der #si esta fuera, salta a la siguiente funcion (direccion)
lw $s4,($s5)
addi $s5, $s5, 36
lw $t3,($s5)
mul $s4, $s4, $t3
addi $s5, $s5, 36
lw $t3,($s5)
mul $s4, $s4, $t3
addi $s5, $s5, 36
lw $t3,($s5)
mul $s4, $s4, $t3
sle $t1, $s3, $s4 #verifica que el resultado de la multiplicacion sea mayor que el mayor valor hasta ahora
beq $t1, 0, Der
addi $s3, $s4, 0 #si es asi, pone ese valor en el valor mayor para la siguiente comparacion
b Der

Der:
addi $s5, $s1, 12 #puntero a la posicion mas alejada en esta direccion
slt $t1,$s5,$s2
beq $t1,0, Dder2
lw $s4,($s5)
addi $s5, $s5, -4
lw $t3,($s5)
mul $s4, $s4, $t3
addi $s5, $s5, -4
lw $t3,($s5)
mul $s4, $s4, $t3
addi $s5, $s5, -4
lw $t3,($s5)
mul $s4, $s4, $t3
sle $t1, $s3, $s4 #verifica que el resultado de la multiplicacion sea mayor que el mayor valor hasta ahora
beq $t1, 0, Dder2
addi $s3, $s4, 0 #si es asi, pone ese valor en el valor mayor para la siguiente comparacion
b Dder2

Dder2:
addi $s5, $s1, 132 #puntero a la posicion mas alejada en esta direccion
slt $t1,$s5,$s2
beq $t1,0, Abajo
lw $s4,($s5)
addi $s5, $s5, -44
lw $t3,($s5)
mul $s4, $s4, $t3
addi $s5, $s5, -44
lw $t3,($s5)
mul $s4, $s4, $t3
addi $s5, $s5, -44
lw $t3,($s5)
mul $s4, $s4, $t3
sle $t1, $s3, $s4 #verifica que el resultado de la multiplicacion sea mayor que el mayor valor hasta ahora
beq $t1, 0, Abajo
addi $s3, $s4, 0 #si es asi, pone ese valor en el valor mayor para la siguiente comparacion
b Abajo

Abajo:
addi $s5, $s1, 120 #puntero a la posicion mas alejada en esta direccion
slt $t1,$s5,$s2
beq $t1,0, Dizq2
lw $s4,($s5)
addi $s5, $s5, -40
lw $t3,($s5)
mul $s4, $s4, $t3
addi $s5, $s5, -40
lw $t3,($s5)
mul $s4, $s4, $t3
addi $s5, $s5, -40
lw $t3,($s5)
mul $s4, $s4, $t3
sle $t1, $s3, $s4 #verifica que el resultado de la multiplicacion sea mayor que el mayor valor hasta ahora
beq $t1, 0, Dizq2
addi $s3, $s4, 0 #si es asi, pone ese valor en el valor mayor para la siguiente comparacion
b Dizq2

Dizq2:
addi $s5, $s1, 108 #puntero a la posicion mas alejada en esta direccion
slt $t1,$s5,$s2
beq $t1,0, Izq
lw $s4,($s5)
addi $s5, $s5, -36
lw $t3,($s5)
mul $s4, $s4, $t3
addi $s5, $s5, -36
lw $t3,($s5)
mul $s4, $s4, $t3
addi $s5, $s5, -36
lw $t3,($s5)
mul $s4, $s4, $t3
sle $t1, $s3, $s4 #verifica que el resultado de la multiplicacion sea mayor que el mayor valor hasta ahora
beq $t1, 0, Izq
addi $s3, $s4, 0 #si es asi, pone ese valor en el valor mayor para la siguiente comparacion
b Izq

Izq:
addi $s5, $s1, -12 #puntero a la posicion mas alejada en esta direccion
sle $t1,$s7,$s5 #verifica que el numero mas alejado este dentro de la matriz
beq $t1, 0, sumar #si esta fuera, salta a la siguiente funcion (direccion)
lw $s4,($s5)
addi $s5, $s5, 4
lw $t3,($s5)
mul $s4, $s4, $t3
addi $s5, $s5, 4
lw $t3,($s5)
mul $s4, $s4, $t3
addi $s5, $s5, 4
lw $t3,($s5)
mul $s4, $s4, $t3
sle $t1, $s3, $s4 #verifica que el resultado de la multiplicacion sea mayor que el mayor valor hasta ahora
beq $t1, 0, sumar
addi $s3, $s4, 0 #si es asi, pone ese valor en el valor mayor para la siguiente comparacion
b sumar

SaltoFila:
la $a0,NL #imprime nueva linea
li $v0,4 #4 para imprimir una cadenam que es NL
syscall #imprime
b volver

fin: 
la $a0,NL #imprime nueva linea
li $v0,4 #4 para imprimir una cadenam que es espacio
syscall #imprime


la $a0, mProducto	#imprime el mensaje "el mayor producto es:"
li $v0, 4
syscall 

move $a0,$s3	#mueve los contenidos del mayor producto para ser impreso
li $v0,1
syscall

la $a0,NL #imprime nueva linea
li $v0,4 #4 para imprimir una cadenam que es espacio
syscall #imprime

la $a0, mensaje	#Imprime instruccion
li $v0, 4
syscall 

li $v0, 5	#scanf
syscall 
bne $v0, 0, main	#si el nr leido es distinto a 0 se repite el proceso
li $v0, 10		#si es 0 se termina el programa
syscall
