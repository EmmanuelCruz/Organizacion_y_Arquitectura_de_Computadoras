# Calcula el resultado de la serie. Ejercicio 4 - Practica05

.data
	n: .word 10		# Número de veces que se realiza la suma.
	m: .float 4.0		# Auxiliar que representa el 4.
	d: .float 2.0		# Auxiliar que auxilia el 2.
	u: .float 1.0		# Auxiliar que auxilia el 1.
	
.text
	lwc1 $f1,n		# Cargamos en el registro f1 a n.
	lwc1 $f7,m		# Cargamos en el registro f7 a m.
	lwc1 $f8,d		# Cargamos en el registro f8 a d.
	lwc1 $f9,u		# Cargamos en el registro f9 a u.
	lw $t1,n
	
loop:	mul.s $f3,$f2,$f8	# Guardamos en el registro t3: 2n
	add.s $f3,$f3,$f9	# Guardamos en el regitro t3: 2n+1
	div.s $f4,$f9,$f3	# Guardamos en el registro t4: 1/(2n+1)
	add.s $f6,$f6,$f4	# Sumamos la operación que ya teníamos con la nueva.
	
	beq $t2,$t1,end		# Si n=m, salta a la etiqueta end
	
	addi $t2,$t2,1		# Incrementa en 1 el contador n.
	add.s $f2,$f2,$f9	# Incrementa en 1 el contador n.
	mul.s $f3,$f2,$f8	# Guardamos en el registro f3: 2n
	add.s $f3,$f3,$f9	# Guardamos en el regitro f3: 2n+1
	div.s $f5,$f9,$f3	# Guardamos en el registro f5: 1/(2n+1)
	sub.s $f6,$f6,$f5	# Sumamos la operación que ya teníamos con la nueva.
	
	beq $t2,$t1,end		# Si n=m, salta a la etiqueta end
	
	addi  $t2,$t2,1		# Incrementa en 1 el contador n.
	add.s $f2,$f2,$f9	# Incrementa en 1 el contador n.
	j loop			# Si n distinto de m salta a etiqueta loop.
	
end:	mul.s $f6,$f6,$f7	#Al resultado final de la suma le multiplicamos 4.NOTA: EL RESULTADO SE GUARDA EN $f6. 