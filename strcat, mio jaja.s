	.data
cadena1:	.asciiz "Hola"
cadena2:	.asciiz " annia te quiero mucho, amor!!!"

	.text
main:
	la	$a0, cadena1
	la	$a1, cadena2
	jal	strcat
	
	la	$a0, cadena1
	li	$v0, 4 	# syscall para imprimir
	syscall		# Imprimimos la cadena
	li	$v0, 10 # syscall para terminar el programa
	syscall

####################################
# Función: strcat
# Copia la cadena apuntada por $a1 al final de la cadena apuntada por #a0.
# Se asume que la cadena destino tiene el tamaño adecuado.
# ALGORITMO
# determinamos dirección del final de la cadena en $a0
# copiamos la cadena en $a1 
# Parámetros: 
# $a0 -> Cadena al final de la que se realizará la copia
# $a1 -> Cadena que será copiada
# Retorno:
# La cadena copiada correctamente
# Autor: Vicente González
# Fecha: 30/11/2006
####################################
# Modificaciones: todo
# Descripción:
# Fecha: 10/9/18
# Realizada por: ete
####################################
strcat:
#copia la primera cadena ($a0) en $t0 para no alterar el resultado
se_mientras1:
	lb      $t0, 0($a0)	    # cargamos el byte de la cadena en $t0
	beq     $t0, $0, se_finmientras1 # si es cero salimos
	addi    $a0, $a0, 1	    # incrementamos para ver el siguiente valor
	j       se_mientras1    # es $t0 == 0? si no repite el ciclo
	# copiamos la cadena en $a
se_finmientras1:

#copia la segunda cadena ($a0) a la primera ($a0 que paso a $t0)!!!!
se_mientras2:
	lb      $t0, 0($a1)
	sb      $t0, 0($a0)
	addi    $a0, $a0, 1
	addi    $a1, $a1, 1	# incrementamos punteros
	bne     $t0, $zero, se_mientras2 # es el final de la cadena en $a1? Si no repetimos
se_finmientras2:

	jr      $31		# Si es el final, retornamos
