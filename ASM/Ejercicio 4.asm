# Programa que calcula el cociente y residuo de la división p/q
	.data
p: .word 98
q: .word 5 # El número 2 debe ser diferente de 0.
residuo: .word 0 # 
cociente: .word 0


	.text
	lw	$t0, p		# Valor del número 1
	lw 	$t1, q		# Valor de número 2
	lw	$t2, residuo	#Carga el valor de r
	lw	$t3, cociente	#Carga el valor de c
if: 
	beqz $t1, end # Si q es igual a cero, termina. 
	j else
else:  
while: 
	bleu $t2,$t0,d # Si el residuo auxiliar es menor o igual a p entonces pasa a d.
	sub $t3,$t3,2 # Resta 2 al cociente.
	mul $t2, $t1,$t3 # Multiplica el cociente por q y lo guarda en el residuo auxiliar.
	sub $t2,$t0,$t2 # Resta el residuo auxiliar a  p y obtiene el residuo. 
	move $v0,$t3 # Mueve a v0 el cociente
	move $v1,$t2 # Mueve a v1 el residuo
	j end # Manda al final del programa
	
d:
	mul $t2,$t1,$t3 # Multiplica el cociente por q y lo guarda en el residuo auxiliar. .
	add $t3,$t3,1 #Incrementa el cociente en 1.
	j while # Regresa al while.
		
end: # Termina el programa
