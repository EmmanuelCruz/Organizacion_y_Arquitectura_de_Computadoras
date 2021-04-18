#Programa que calcula el mcd de 2 números naturales, este programa requiere que el primer valor sea mayor al segundo, 
#de lo contrario el programa terminara.

	.data 
	a: .word 3
	c: .word 11
	y: .word 0
	.text
	lw $t1,a #cargamos los valores a sus registros
	lw $t2,c
	lw $t4,y
	
	bnez $t2, prox #Checamos que c !=0 pues el divisor no puede ser 0. Saltamos a prox
	
	prox:
	beq $t1,$t2,else #Checamos si son iguales,de ser iguales vamos a else
	j next #De lo contrario vamos a next
	
	else:
	add $t4,$t4,$t1 #Signamos a t4, t1
	j end #Termina y el MCD esta en t4
	
	next:
	bgt $t1,$t2, then #Si t1 es mayor a t2 nos vamos a then
	j cond #de lo contrario vamos a cond
	
	then:
	div $t1,$t2 #dividimos
	mfhi $t4 #obtenemos el resultado de ti % t2
	j end #el programa termina y el MCD se guarda en t4
	
	cond:
	blt $t1,$t2,end #si el segundo valor es mayor al primero , el programa termina
	
	end: 
	
	
	
	