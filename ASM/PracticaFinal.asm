# PRÁCTICA 7 - ORGANIZACIÓN Y ARQUITECTURA DE COMPUTADORAS.
# INTEGRANTES DEL EQUIPO
# Cruz Hernández Emmanuel.
# Montes Incin Sara Doris.
# Rebollar Pérez Ailyn.
# Vega Monroy Daniela Susana

.data
	welcome: .asciiz "\nBIENVENIDO A PRÁCTICA 7"
	opcion: .asciiz "\n\nIngresa una opción:\n"
	opcPal: .asciiz "\nIngresa la cadena a verifcar si es palíndromo: "
	error: .asciiz "\nComando inválido\n"
	help: .asciiz "help"
	helpr: .asciiz  "[rev]"
	helpc: .asciiz "[cat]"
	helpp: .asciiz  "[pal]"
	helpe: .asciiz "[exit]"
	rev: .asciiz "rev"
	revArch: .asciiz "La reversa del texto del archivos es:\n"
	cat: .asciiz "cat"
	pal: .asciiz "pal"
	exit: .asciiz "exit"
	cadena: .asciiz "\nIgresa una cadena: "
	cadres: .asciiz "\nLa cadena invertida es: "
	dr: .asciiz "\n[rev] Imprime la reversa de una cadena. Si no se especifica un archivo, se utiliza la entrada estándar"
	dc: .asciiz "\n[cat] Concatena los archivos y los muestra en pantalla"
	de: .asciiz "\n[exit] Termina la ejecución del intérprete de comandos, terminando así la simulación de MARS"
	dp: .asciiz "\n[pal] Verifica si una cadena es palíndromo"
	true: .asciiz "\nLa cadena es palindromo"
	false: .asciiz "\nLa cadena no es palindromo"
	str:	.asciiz "Introduzca el nombre del archivo:\n"
	str_err:.asciiz "El archivo no existe. No se realizó la operación\n"
	concatF: .asciiz "La concatenación del texto en los archivos es:\n"
	opRev: .asciiz "¿Quieres leer un archivo? [S/N]\n"
	cadleida: .space 1000
	cadinvertida: .space 1000
	in: .data 16
	
.text
	la $a0, welcome	# Cargar direccion de cadena de bienvenida
	li $v0, 4	# Cargar codigo de llamada para imprimir cadena
	syscall		# Llamada al sistema
	
option:
	la $t0, help	# Cargamos la dirección de help en t0
	la $t1, rev	# Cargamos la dirección de rev en t1
	la $t2, cat	# Cargamos la dirección de cat en t2
	la $t3, exit	# Cargamos la dirección de exit en t3
		
	la $a0, opcion	# Cargar direccion de cadena de opción.
	li $v0, 4	# Cargar codigo de llamada para imprimir cadena
	syscall		# Llamada al sistema
	
	la $a0, in	# Cargar direccion del entrada
	li $a1, 16	# Tamano del entrada
	li $v0, 8	# Cargar codigo de llamada para leer cadena
	syscall		# Llamada al sistema
	li $s2, 0	# Cargamos como inmediato a 0.
	li $s1, 0
	
	move $t6, $a0	# Guardo una copia en $t6 para no perder la referencia.
	
compare1:
	lb $t4, 0($t0)	# Carga el primer caracter de help
	lb $t5, 0($t6)	# Carga el primer caracter de la entrada
	beq $t4, $s2, hr	# Si la cadena es igual salta a la opción h
	bne $t4, $t5, compare2Aux	# Si las cadenas no son iguales salta a compare2Aux
	addi $t0, $t0, 1	# Se mueve al siguiente caracter a comparar.
	addi $t6, $t6, 1	# Se mueve al siguiente caracter a comparar.
	j compare1	# Compara al siguiente caracter.
	
hr:	
	addi $t6, $t6, 1	# Se mueve al siguiente caracter a comparar.
	lb $t5, 0($t6)	# Carga el primer caracter de la entrada
	beq $t5, $s2, h
	move $t7, $t6
	la $t0, helpr
comphr:	
	lb $t4, 0($t0)	# Carga el primer caracter de helpr
	lb $t5, 0($t7)	# Carga el primer caracter de la entrada
	beq $t4, $s2, hrev	# Si la cadena es igual salta a la opción h.
	bne $t4, $t5, hc	# Si las cadenas no son iguales salta a compare2Aux
	addi $t0, $t0, 1	# Se mueve al siguiente caracter a comparar.
	addi $t7, $t7, 1	# Se mueve al siguiente caracter a comparar.
	j comphr	# Compara al siguiente caracter.
	
hrev:
	la $a0, dr	# Cargar direccion de cadena de bienvenida
	li $v0, 4	# Cargar codigo de llamada para imprimir cadena
	syscall		# Llamada al sistema
	j option

hc:
	move $t7, $t6
	la $t0, helpc
comphc:	
	lb $t4, 0($t0)	# Carga el primer caracter de helpr
	lb $t5, 0($t7)	# Carga el primer caracter de la entrada
	beq $t4, $s2, hcat	# Si la cadena es igual salta a la opción h.
	bne $t4, $t5, hp	# Si las cadenas no son iguales salta a compare2Aux
	addi $t0, $t0, 1	# Se mueve al siguiente caracter a comparar.
	addi $t7, $t7, 1	# Se mueve al siguiente caracter a comparar.
	j comphc	# Compara al siguiente caracter.
	
hcat:
	la $a0, dc	# Cargar direccion de cadena de bienvenida
	li $v0, 4	# Cargar codigo de llamada para imprimir cadena
	syscall		# Llamada al sistema
	j option
		
hp:
	move $t7, $t6
	la $t0, helpp
comphp:	
	lb $t4, 0($t0)	# Carga el primer caracter de helpr
	lb $t5, 0($t7)	# Carga el primer caracter de la entrada
	beq $t4, $s2, hpal	# Si la cadena es igual salta a la opción h.
	bne $t4, $t5, he	# Si las cadenas no son iguales salta a compare2Aux
	addi $t0, $t0, 1	# Se mueve al siguiente caracter a comparar.
	addi $t7, $t7, 1	# Se mueve al siguiente caracter a comparar.
	j comphp	# Compara al siguiente caracter.
	
hpal:
	la $a0, dp	# Cargar direccion de cadena de bienvenida
	li $v0, 4	# Cargar codigo de llamada para imprimir cadena
	syscall		# Llamada al sistema
	j option
	
he:
	move $t7, $t6
	la $t0, helpe
comphe:	
	lb $t4, 0($t0)	# Carga el primer caracter de helpr
	lb $t5, 0($t7)	# Carga el primer caracter de la entrada
	beq $t4, $s2, hexit	# Si la cadena es igual salta a la opción h.
	bne $t4, $t5, err	# Si las cadenas no son iguales salta a compare2Aux
	addi $t0, $t0, 1	# Se mueve al siguiente caracter a comparar.
	addi $t7, $t7, 1	# Se mueve al siguiente caracter a comparar.
	j comphe	# Compara al siguiente caracter.
	
hexit:
	la $a0, de	# Cargar direccion de cadena de bienvenida
	li $v0, 4	# Cargar codigo de llamada para imprimir cadena
	syscall		# Llamada al sistema
	j option
	
compare2Aux:
	move $t6, $a0	# Reescribo mi valor de referencia.
compare2:
	lb $t4, 0($t1)	# Carga el primer caracter de rev
	lb $t5, 0($t6)	# Carga el primer caracter de la entrada
	beq $t4, $s2, r	# Si la cadena es igual salta a la opción r.
	bne $t4, $t5, compare3Aux	# Si las cadenas no son iguales salta a compare3Aux
	addi $t1, $t1, 1	# Se mueve al siguiente caracter a comparar.
	addi $t6, $t6, 1	# Se mueve al siguiente caracter a comparar.
	j compare2	# Compara al siguiente caracter.

compare3Aux:
	move $t6, $a0	# Reescribo mi valor de referencia.
compare3:
	lb $t4, 0($t2)	# Carga el primer caracter de cat
	lb $t5, 0($t6)	# Carga el primer caracter de la entrada
	beq $t4, $s2, c	# Si la cadena es igual salta a la opción c.
	bne $t4, $t5, compPalAux	# Si las cadenas no son iguales salta a compare4Aux
	addi $t2, $t2, 1	# Se mueve al siguiente caracter a comparar.
	addi $t6, $t6, 1	# Se mueve al siguiente caracter a comparar.
	j compare3	# Compara al siguiente caracter.

compPalAux:
	move $t6, $a0	# Reescribo mi valor de referencia.
	la $t2, pal
compPal:
	lb $t4, 0($t2)	# Carga el primer caracter de cat
	lb $t5, 0($t6)	# Carga el primer caracter de la entrada
	beq $t4, $s2, palindromo	# Si la cadena es igual salta a la opción c.
	bne $t4, $t5, compare4Aux	# Si las cadenas no son iguales salta a compare4Aux
	addi $t2, $t2, 1	# Se mueve al siguiente caracter a comparar.
	addi $t6, $t6, 1	# Se mueve al siguiente caracter a comparar.
	j compPal	# Compara al siguiente caracter.

compare4Aux:
	move $t6, $a0	# Reescribo mi valor de referencia.
compare4:
	lb $t4, 0($t3)	# Carga el primer caracter de exit
	lb $t5, 0($t6)	# Carga el primer caracter de la entrada
	beq $t4, $s2, end	# Si la cadena es igual salta a la opción exit.
	bne $t4, $t5, err	# Si las cadenas no son iguales salta a error
	addi $t3, $t3, 1	# Se mueve al siguiente caracter a comparar.
	addi $t6, $t6, 1	# Se mueve al siguiente caracter a comparar.
	j compare4	# Compara al siguiente caracter.

h:	
	la $a0, dr	# Cargar direccion de cadena de bienvenida
	li $v0, 4	# Cargar codigo de llamada para imprimir cadena
	syscall		# Llamada al sistema
	la $a0, dc	# Cargar direccion de cadena de bienvenida
	li $v0, 4	# Cargar codigo de llamada para imprimir cadena
	syscall		# Llamada al sistema
	la $a0, dp	# Cargar direccion de cadena de bienvenida
	li $v0, 4	# Cargar codigo de llamada para imprimir cadena
	syscall		# Llamada al sistema
	la $a0, de	# Cargar direccion de cadena de bienvenida
	li $v0, 4	# Cargar codigo de llamada para imprimir cadena
	syscall		# Llamada al sistema	
	j option	# Regreso al menú de opciones.

r:	

	li $v0, 4	#Llamada al sistema para imprimir una cadena
 	la $a0, opRev 	#Puntero a la cadena a imprimir
 	syscall
	
	la $a0, in		# Cargar direccion del buffer
	li $a1, 16		# Tamano del buffer
	li $v0, 8		# Cargar codigo de llamada para leer cadena
	syscall				# Llamada al sistema

	lb $t2, 0($a0)
	beq $t2, 'N', rev1
	beq $t2, 'S', rev2
	j err
rev1:
	li $v0, 4	#Llamada al sistema para imprimir una cadena
 	la $a0, cadena 	#Puntero a la cadena a imprimir
 	syscall

	li $v0, 8 	#Llamada al sistema para leer una cadena
 	la $a0, cadleida	#Puntero al espacio reservado
 	li $a1, 100 	#Longitud maxima de la cadena le’da
 	syscall
 
 	la $a0, cadleida	#Argumento 1: puntero a la cadena leida
	la $a1, cadinvertida	#Argumento 2: puntero al espacio reservado para almacenar la cadena invertida
	jal invierte
 
	li $v0, 4	#Llamada al sistema para imprimir una cadena
	la $a0, cadres	#Puntero a la cadena a imprimir
 	syscall
 
	li $v0, 4 	#Llamada al sistema para imprimir una cadena
	la $a0, cadinvertida  #Puntero a la cadena a imprimir
 	syscall
 	j option	# Regreso al menú de opciones.
 
invierte:
 	li $t1, 0	#Contador de la longitud
bucle:
 	lb $t0, ($a0)	#Leo un caracter de la cadena origen
 	beqz $t0, desapila	#Si es el fin de cadena, he acabado de leer
 	addi $sp, $sp, -1	#Apilo el caracter en la pila
 	sb $t0, ($sp)
 	addi $t1, $t1, 1	#Cuento que he apilado un caracter mas
 	addi $a0, $a0, 1	#Actualizo el puntero
 	j bucle
 	
desapila:
 	lb $t0, ($sp)	#Desapilo una letra de la pila
 	addi $sp, $sp, 1
 	sb $t0, ($a1) 	#La guardo en la cadena de destino
 	addi $a1, $a1, 1	#Actualizo el puntero de la cadena de destino
 	addi $t1, $t1, -1	#Ya he leido una letra
 	bnez $t1, desapila	#Mientras me queden letras apiladas, sigo desapilando
 	sb $zero, ($a1)	#Al final, almaceno el caracter fin de cadena
 	jr $ra	#Fin de la función


rev2:

	la $t3, cadleida
	la $t4, cadinvertida
	move $t5, $zero

	la $a0, str		# Cargar direccion de cadena
	li $v0, 4		# Cargar codigo de llamada para imprimir cadena
	syscall			# Llamada al sistema
	
	la $a0, in		# Cargar direccion del buffer
	li $a1, 16		# Tamano del buffer
	li $v0, 8		# Cargar codigo de llamada para leer cadena
	syscall				# Llamada al sistema
	
	la $t0, in		# $t0 apuntador al inicio del nombre del archivo.
loopR:	lb $t1, ($t0)		# Cargar caracter
	beq $t1, '\n', eraseChR	# Si el caracter es salto de linea, branch
	beq $t1, $zero, eraseChR	# Fin de la cadena, no hay salto de linea
	addi $t0, $t0, 1	# Aumentat apuntador en 1
	j loopR			# Repetir
	
eraseChR:sb $zero,($t0)		# Remplazar carcater por \0
	la $a0, in		# Cargar direccion de cadena con nombre del archivo
	li $a1, 0		# Cargar bandera 0, solo lectura
	li $v0, 13		# Cargar codigo de llamada para leer archivo
	syscall				# Llamada al sistema
	beq $v0, -1, printErrR	# El descriptor es 0, no existe el archivo

	sb $zero, in		# Agregar caracter nulo al final del buffer
	move $t0, $v0		# Copiar descriptor del archivo a $t0
readR:	move $a0, $t0		# Cargar descriptor del archivo
	la $a1, in		# Cargar direccion del buffer de lectura
	li $a2, 1		# Cargar tamaño del buffer
	li $v0, 14		# Cargar codigo llamada para leer archivo
	syscall			# Llamada al sistema
	blt $v0, 1, lastRR	# Si se leyeron menos de 15 bytes, salto (ultima lectura)
		
	lb $t2, 0($a1)
	beq $t2, '\n', lastRR
	sb $t2, 0($t3)
	addi $t5, $t5, 1
	addi $t3, $t3, 1
	j readR			# Leer siguiente fragmento
lastRR:	
	addi $t5, $t5, 1
	subi $t3, $t3, 1
lastRR2:
	lb $t2, 0($t3)
	sb $t2, 0($t4)
	addi $t4, $t4, 1
	subi $t3, $t3, 1
	subi $t5, $t5, 1
	beqz $t5, endLRR
	j lastRR2

endLRR:
	sb $zero, in($v0)  	# Agregar caracter nulo despues del ultimo byte leido
	la $a0, in		# Cargar direccion de cadena
	li $v0, 4		# Cargar codigo de llamada para imprimir cadena
	syscall			# Llamada al sistema	
		
	move $a0, $t0		# Cargar descritor
	li $v0, 16		# Cargar codigo de llamada para cerrar archivo
	syscall			# Llamada al sistema
	j endRevR
printErrR:la $a0, str_err	# Cargar direccion de cadena
	li $v0, 4		# Cargar codigo de llamada para imprimir cadena
	syscall	
	j option
endRevR:	
	la $a0, revArch		# Cargar direccion de cadena
	li $v0, 4		# Cargar codigo de llamada para imprimir cadena
	syscall			# Llamada al sistema
	
	li $v0, 4 	#Llamada al sistema para imprimir una cadena
	la $a0, cadinvertida  #Puntero a la cadena a imprimir
 	syscall
	j option
c:	
	move $t4, $zero
	la $t3, cadleida
doThis:
	beq $t4, 2, endCat
	addi $t4, $t4, 1

	la $a0, str		# Cargar direccion de cadena
	li $v0, 4		# Cargar codigo de llamada para imprimir cadena
	syscall			# Llamada al sistema
	
	la $a0, in		# Cargar direccion del buffer
	li $a1, 16		# Tamano del buffer
	li $v0, 8		# Cargar codigo de llamada para leer cadena
	syscall				# Llamada al sistema
	
	la $t0, in		# $t0 apuntador al inicio del nombre del archivo.
loop:	lb $t1, ($t0)		# Cargar caracter
	beq $t1, '\n', eraseCh	# Si el caracter es salto de linea, branch
	beq $t1, $zero, eraseCh	# Fin de la cadena, no hay salto de linea
	addi $t0, $t0, 1	# Aumentat apuntador en 1
	j loop			# Repetir
	
eraseCh:sb $zero,($t0)		# Remplazar carcater por \0
	la $a0, in		# Cargar direccion de cadena con nombre del archivo
	li $a1, 0		# Cargar bandera 0, solo lectura
	li $v0, 13		# Cargar codigo de llamada para leer archivo
	syscall				# Llamada al sistema
	beq $v0, -1, printErr	# El descriptor es 0, no existe el archivo

	sb $zero, in		# Agregar caracter nulo al final del buffer
	move $t0, $v0		# Copiar descriptor del archivo a $t0
read:	move $a0, $t0		# Cargar descriptor del archivo
	la $a1, in		# Cargar direccion del buffer de lectura
	li $a2, 1		# Cargar tamaño del buffer
	li $v0, 14		# Cargar codigo llamada para leer archivo
	syscall			# Llamada al sistema
	blt $v0, 1, lastR	# Si se leyeron menos de 15 bytes, salto (ultima lectura)
		
	lb $t2, 0($a1)
	beq $t2, '\n', lastR
	sb $t2, 0($t3)
	addi $t3, $t3, 1
	j read			# Leer siguiente fragmento
lastR:	sb $zero, in($v0)  	# Agregar caracter nulo despues del ultimo byte leido
	la $a0, in		# Cargar direccion de cadena
	li $v0, 4		# Cargar codigo de llamada para imprimir cadena
	syscall			# Llamada al sistema	
		
	move $a0, $t0		# Cargar descritor
	li $v0, 16		# Cargar codigo de llamada para cerrar archivo
	syscall			# Llamada al sistema

	j doThis		### Salto al fin del programa	

printErr:la $a0, str_err	# Cargar direccion de cadena
	li $v0, 4		# Cargar codigo de llamada para imprimir cadena
	syscall
	j option	
endCat:	
	la $a0, concatF		# Cargar direccion de cadena
	li $v0, 4		# Cargar codigo de llamada para imprimir cadena
	syscall			# Llamada al sistema
	
	li $v0, 4 	#Llamada al sistema para imprimir una cadena
	la $a0, cadleida  #Puntero a la cadena a imprimir
 	syscall
	j option	# Regreso al menú de opciones.

err:	
	la $a0, error	# Cargar direccion de cadena de error
	li $v0, 4	# Cargar codigo de llamada para imprimir cadena
	syscall		# Llamada al sistema
	j option	# Regreso al menú de opciones.
	
palindromo:
	la $a0, opcPal	# Cargar direccion de cadena de opción.
	li $v0, 4	# Cargar codigo de llamada para imprimir cadena
	syscall		# Llamada al sistema
	
	la $a0, in	# Cargar direccion del entrada
	li $a1, 50	# Tamano del entrada
	li $v0, 8	# Cargar codigo de llamada para leer cadena
	syscall		# Llamada al sistema

	
	
	move $t0,$a0         # Cargar la dirección de palabra.
	li $s1,0               # Contador
	move $t4,$a0
	move $t5,$a0

# Obtener la longitud de la cadena
longitud:
	lb      $t2,0($t0)	# obtener siguiente caracter de "palabra"
	addi    $t0,$t0,1	# avanza el apuntador
	beq    $t2,'\n',long	# verifica si ya llegó al final de la cadena
	addi    $s1,$s1,1	# Si aun no llega incrementa en 1 al contador.
	j       longitud	# regresa a vertificar.
    
long:
	move    $t1,$s1		# Longitud total de la cadena
	beq 	$t1,1,endp	# Verifica si la longitud de la cadena es 1
	subi $t1,$t1,1
if:
	add 	$t4,$t4,$t1	# Para moverse a la última posición de la cadena
else:	
	lb 	$t3,($t4) 	#Accede al último caracter
	lb 	$t6,0($t5)	# Accede al primer caracter
	bne 	$t6,$t3,fin	# Si no son iguales el primero y el último no es palindromo 
	sub 	$t7,$t4,$t5	# Verificar si la resta de la primera cadena menos la segunda es 1 o 2
	beq 	$t7,2,endp
	beq	$t7,1,endp 
	addi 	$t5,$t5,1	# Avanza el puntero de la segunda cadena.
	subi 	$t4,$t4,1	# Avanza el puntero de la primer cadena.
	j else


fin:
	li $v0,4
	la $a0,false # Imprimir que no es palindromo.
	syscall 
	j option
endp:
	li $v0,4
	la $a0,true # Imprimir que es palindromo.
	syscall 
	j option



end:	
	li $v0, 10
	syscall
