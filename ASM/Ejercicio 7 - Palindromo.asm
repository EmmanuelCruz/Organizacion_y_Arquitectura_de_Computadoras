# author: Cruz Hernández Emmanuel
# No. Cuenta: 314272588

.data
	string: .asciiz "osobaboso"
	result: .asciiz "\nLa cadena es palindromo: "
	true: .asciiz "True"
	false: .asciiz "False"
.text
	li $v0,4		# Imrpime el mensaje result.
	la $a0,result		# Carga la dirección de result.
	syscall
	
	la $t0,string		# Carga la direccion de string.
	la $t1,string		# Carga la dirección de string aux.
	
	li $s1,0		# Se define contador en 0.
	li $s2,0		# Obtiene el ultimo en la cadena.
	
run:
	lb $t2,0($t0)		# Obtiene el caracter de string.
	addi $t0,$t0,1		# El apuntador avanza al siguiente caracter.
	beq $t2,$s2,done	# Verifica si el caracter es igual a $s2.
	addi $s1,$s1,1		# Incrementa el contador.
	j run			# Salta a run.
	
done:
	subi $t0,$t0,2		# Regreso el apuntador dos posiciones.

compare:
	lb $t2,0($t0)		# Guardo en t2 el ultimo caracter de string
	lb $t3,0($t1)		# Guardo en t3 el primer caracter de string
	beq $t3,$s2,t		# Si se termino la cadena salta a label t.
	bne $t2,$t3,f		# Si no son iguales salto a label f	
	subi $t0,$t0,1		# El puntador regresa al caracter anterior.
	addi $t1,$t1,1		# El apuntador avanza al siguiente caracter.
	j compare		# Salto a compare. Vuelvo a comparar.
	
f:
	li $v1,4		# Imprime false.
	la $a0,false		# Carga la dirección de false.
	syscall
	j end			# Salta a termino de programa.
t:
	li $v1,4		# Imprime true.
	la $a0,true		# Carga la dirección de true.
	syscall
	
end:	nop			# Fin del programa
