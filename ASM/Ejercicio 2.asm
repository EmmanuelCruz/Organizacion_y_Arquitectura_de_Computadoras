#
# Programa que copia el contenido de un registro a otro
#

    .data
p: .word 90

    .text
    lw $t1 p
    add $t3,$t1,$zero
