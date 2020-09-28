	.data 
a:	.word	7 6 5 4 3 2 8 9 8 7 6 5 4 7 8 9 9 8 7 5 3 6 78 9 0 7 5 3 1 1 

	.text

	la 	$a0, a	# dirección de inicio del vector a ordenar
	li 	$a1, 30	# tamaño del vector
	jal	sort

	li	$v0, 10
	syscall


# swap: intercambia el contenido de dos elemntos de un vector
# Parámetros:
# $a0 -> dirección de inicio del vector de enteros
# $a1 -> el índice del elemento a ser intercambiado (k)
#        v(k) <-> v(k+1)
# Retorno:
# Ninguno, Al retornar los elementos del vector 
# están intercambiados
# Realizado por: 
# Fecha: 
swap: sll $t1, $a1, 2   # $t1 = k * 4
      add $t1, $a0, $t1 # $t1 = v+(k*4)
                        #   (address of v[k])
      lw $t0, 0($t1)    # $t0 (temp) = v[k]
      lw $t2, 4($t1)    # $t2 = v[k+1]
      sw $t2, 0($t1)    # v[k] = $t2 (v[k+1])
      sw $t0, 4($t1)    # v[k+1] = $t0 (temp)
      jr $ra            # return to calling routine

# sort: ordena un vector de enteros por el método
# de la burbuja
# Parámetros:
# $a0 -> dirección de inicio del vector de enteros
# $a1 -> tamaño del vecctor
# Retorno:
# Ninguno, Al retornar el vector está ordenado
# Realizado por: 
# Fecha: 
sort:    addi $sp, $sp, -20     # make room on stack for 5 registers
         sw $ra, 16($sp)        # save $ra on stack
         sw $s3, 12($sp)        # save $s3 on stack
         sw $s2, 8($sp)         # save $s2 on stack
         sw $s1, 4($sp)         # save $s1 on stack
         sw $s0, 0($sp)         # save $s0 on stack
         move $s2, $a0           # save $a0 into $s2
         move $s3, $a1           # save $a1 into $s3
         move $s0, $zero         # i = 0
for1tst: slt  $t0, $s0, $s3      # $t0 = 0 if $s0 ? $s3 (i ? n)
         beq  $t0, $zero, exit1  # go to exit1 if $s0 ? $s3 (i ? n)
         addi $s1, $s0, -1       # j = i – 1
for2tst: slti $t0, $s1, 0        # $t0 = 1 if $s1 < 0 (j < 0)
         bne  $t0, $zero, exit2  # go to exit2 if $s1 < 0 (j < 0)
         sll  $t1, $s1, 2        # $t1 = j * 4
         add  $t2, $s2, $t1      # $t2 = v + (j * 4)
         lw   $t3, 0($t2)        # $t3 = v[j]
         lw   $t4, 4($t2)        # $t4 = v[j + 1]
         slt  $t0, $t4, $t3      # $t0 = 0 if $t4 ? $t3
         beq  $t0, $zero, exit2  # go to exit2 if $t4 ? $t3
         move $a0, $s2           # 1st param of swap is v (old $a0)
         move $a1, $s1           # 2nd param of swap is j
         jal  swap               # call swap procedure
         addi $s1, $s1,-1        # j –= 1
         j    for2tst            # jump to test of inner loop
exit2:   addi $s0, $s0, 1        # i += 1
         j    for1tst            # jump to test of outer loop
exit1:   lw $s0, 0($sp)         # restore $s0 from stack
         lw $s1, 4($sp)         # restore $s1 from stack
         lw $s2, 8($sp)         # restore $s2 from stack
         lw $s3, 12($sp)        # restore $s3 from stack
         lw $ra, 16($sp)        # restore $ra from stack
         addi $sp, $sp, 20      # restore stack pointer
         jr $ra                 # return to calling routine
