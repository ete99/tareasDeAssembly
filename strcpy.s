	.data
c1:	.asciiz	"Hola"
c2:	.space	20

	.text
	la	$a0, c1
	la	$a1, c2

	jal	strcpy1

	li	$v0, 10
	syscall

#int strcpy (char x[], char y[])
#{
#	int i;
#
#	i=0;
#	while ((x[i] = y[i]) != '\0'){
#		i++;
#	}
#	return i;	// no contamos el NULL
#}
#
########################################
# Versión con índice i
########################################
# Parámetros
# $a0 -> dirección de cadena fuente
# $a1 -> dirección de cadena destino
# Valor de retorno
# $v0 -> cantidad de bytes copiados, el NULL debe ser copiado pero no contado
strcpy:
	addi	$v0, $zero, 0	# i = 0; valor de retorno
sc_mientras1:
	add	$t0, $a0, $v0	# calculamos dirección de cfuente[i]
	add	$t1, $a1, $v0	# calculamos dirección de cdestino[i]
	lb	$t2, 0($t0)
	sb	$t2, 0($t1)	# copiamos
	beq	$t2, $zero, sc_finmientras1
	addi	$v0, $v0, 1	# i++;
	j	sc_mientras1

sc_finmientras1:
	jr	$ra		#retonamos


#int strcpy (char x[], char y[])
#{
#	int i;
#
#	i=0;
#	while ((*x++ = *y++) != '\0')
#		i++;
#
#	return i;	// no contamos el NULL
#}
#
########################################
# Versión con punteros
########################################
# Parámetros
# $a0 -> dirección de cadena fuente
# $a1 -> dirección de cadena destino
# Valor de retorno
# $v0 -> cantidad de bytes copiados, el NULL debe ser copiado pero no contado
strcpy1:
	addi	$v0, $zero, 0	# $v0 = 0
sc1_mientras1:
	lb	$t0, 0($a0)	#copiamos cfuente[i] a $t0
	sb	$t0, 0($a1)	#copiamos $t0 a cdestino[i]
	beq	$t0, $zero, sc1_finmientras1 # salimos si x[0]=0
	addi	$a0, $a0, 1	#incrementamos punteros
	addi	$a1, $a1, 1
	addi	$v0, $v0, 1 	# incrementamos contador
	b	sc1_mientras1
sc1_finmientras1:
	jr	$ra		# retornamos
	
