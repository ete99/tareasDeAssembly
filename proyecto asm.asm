.data
array: .space 400
MxN: .space 8
salir: .asciiz "\nPara salir del programa inserte una matriz de 0 filas y/o 0 columnas\n"
cons1: .asciiz "\nInsertar numero de Filas:\n"
cons2: .asciiz "\nInsertar numero de Columnas:\n"
res: .asciiz "\nEl numero de caminos es:\n"

.text
#trae las direcciones de los datos necesarios
la $a3, array
la $s0, MxN

# menu:
while:
	#imprime las instrucciones para salir del programa
	li $v0, 4
	la $a0, salir
	syscall

	# imprime cons1
	li $v0, 4
	la $a0, cons1
	syscall

	# lee 'M' la cantidad de filas
	li $v0, 5
	syscall
	addi $v0,$v0, 1 #para que funcione bien el algoritmo
	sw $v0, 0($s0) # guarda en s0 para pasar a las funciones

	# imprime cons2
	li $v0, 4
	la $a0, cons2
	syscall

	# lee 'N' la cantidad de columnas
	li $v0, 5
	syscall
	addi $v0,$v0, 1
	sw $v0, 4($s0) # guarda en s0 para pasar a las funciones

	#carga las dimensiones en registros temporales
	lw $t9, 0($s0)
	lw $t8, 4($s0)

	#resta 1 por que estan aumentados en 1 las dimesiones
	addi $t9, $t9, -1
	addi $t8, $t8, -1 
	
	#verifica si alguna dimesion es 0 y salta al final si asi es
	beq $t8, $0, finwhile
	beq $t9, $0, finwhile
	
	#llama a la funcion
	jal cuentaMat
	
	#mueve el resultado a $a1
	move $a1, $v0 

	#imprime "El numero de caminos es:"
	li $v0, 4
	la $a0, res
	syscall

	#imprime el resultado
	li $v0, 1
	move $a0, $a1
	syscall
	
	#vuelve al inicio del ciclo
	j while
finwhile:

# salir del programa
li $v0, 10
syscall


# codigo equivalente a la funcion cuentaMat en c:
#
# int cuentaMat(int m, int n)
# {
#     // crea la tabla de los tamanhos insertados + 1 para que funcione correctamente
#     int matriz[m+1][n+1];
#     // la primera fila lleva solo unos ya que lleva solo un camino del origen para llegar
#     for (int i=0; i<m; i++)
#        matriz[i][0] = 1;
# 
#     // la primera columna lleva solo unos ya que lleva solo un camino del origen para llegar
#     for (int j=0; j<n; j++)
#         matriz[0][j] = 1;
# 
#     // calcula la cantidad de caminos a las celdas(ignorando la primera fila y columna) sumando la de la izquierda y la de arriba,
#     // por que los movimientos habiles son a la derecha y abajo.
#     for (int i=1; i<m; i++)
#     {
#         for (int j=1; j<n; j++){
#             matriz[i][j] = matriz[i-1][j] + matriz[i][j-1];
#         }
#    }
#
#     return matriz[m-1][n-1];
# }
#



cuentaMat:
	 li $t1, 0#i
	 li $t2, 0#j
	 li $t0, 1#1
	 li $t3, 0  
	 lw $t4, 0($s0)# filas
	 lw $t5, 4($s0)# columnas
	 
	 while1:beq $t2, $t5, finWhile1 ##pone en 1 la primera fila  
	 	mult $t2, $t5 # $t3 = rowIndex * Ncolumnas
	  	mflo $t3
 	 	add $t3, $t3, $t1 # $t3 + colIndex
 	 	sll $t3, $t3, 2 #porque es un int y es un word
 	 	add $t3, $t3, $a3 #a3 array
 	 	sw $t0, ($t3) #pone en 1 los
 	 	
 		addi $t2,$t2,1 
 		j while1
  	finWhile1:
	
	 li $t1, 0#i
	 li $t2, 0#j
	 li $t3, 0  
	 
	 while2:beq $t2, $t4, finWhile2 ##pone en 1 la primera columna
	 	mult $t1, $t5 # $t3 = rowIndex * Ncolumnas
	  	mflo $t3
 	 	add $t3, $t3, $t2  # $t3 + colIndex
 	 	sll $t3, $t3, 2 #porque es un int y es un word
 	 	add $t3, $t3, $a3 #a3 array
 	 	sw $t0, ($t3) #pone en 1 los
 	 	
 		addi $t2,$t2,1 
 		j while2
  	finWhile2:
	
	li $t1, 1#i
	 li $t2, 1#j
	 li $t3, 0  
	 while3: beq $t1, $t4, finWhile3 #ciclo i
	 	while4: beq $t2, $t5, finWhile4 #ciclo j
	 	
	 		#calcula la posicion del actual
	 	 	mult $t2, $t5 # rowIndex * Ncolumnas
	 	 	mflo $t3 # $t3 = rowIndex * Ncolumnas
	 	 	add $t3, $t3, $t1 # $t3 + colIndex
	 	 	sll $t3, $t3, 2 #porque es un int
	 	 	add $t3, $t3, $a3 #a3 array
	 	 	
	 	 	#calcula la posicion de arriba
	 	 	addi $t6, $t2,-1 #$t6 = (rowIndex-1)
	 	 	mult $t6, $t5 #(rowIndex-1) * Ncolumnas
	 	 	mflo $t6 #$t6 = (rowIndex-1) * Ncolumnas
	 	 	add $t6, $t6, $t1 # $t6 + colIndex
	 	 	sll $t6, $t6, 2 #porque es un int
	 	 	add $t6, $t6, $a3 #a3 array
	 	 	
	 	 	#calcula la posicion de izquierda
	 	 	addi $t7, $t1,-1 #$t7 = (colIndex-1)
	 	 	mult $t2, $t5 # rowIndex * Ncolumnas
	 	 	mflo $t0 # $t3 = rowIndex * Ncolumnas
	 	 	add $t0, $t0, $t7 # $t0 + (colIndex-1)
	 	 	sll $t0, $t0, 2 #porque es un int
	 	 	add $t0, $t0, $a3 #a3 array
	 	 	
	 	 	##carga de la direccion
	 	 	lw $s1, ($t6)
	 	 	lw $s2, ($t0)
	 	 	
	 	 	##suma //matriz[i][j] = matriz[i-1][j] + matriz[i][j-1];
	 	 	add $t0, $s1, $s2
	 	 	
	 	 	## guarda en la direccion
	 	 	sw $t0, ($t3) #pone en 1 los
	 	 	
	 	 	
	 		addi $t2,$t2,1
 	 		j while4
 	 	finWhile4:
 	 	li $t2, 1#j=0
	 	addi $t1,$t1,1
	 	j while3
	 finWhile3:
	 
	move $t1, $t4 # M
	move $t2, $t5 # N
	addi $t1, $t1,-1# M-1
	addi $t2, $t2,-1# N-1
	li $t3, 0  
	 #calcula la posicion del elemento (M-1, N-1)
	mult $t2, $t5 # rowIndex * Ncolumnas
 	mflo $t3 # $t3 = rowIndex * Ncolumnas
  	add $t3, $t3, $t1 # $t3 + colIndex
 	sll $t3, $t3, 2 #porque es un int
  	add $t3, $t3, $a3 #a3 array
  	lw $v0, ($t3)
jr $ra
	
	
	
	
	
	
