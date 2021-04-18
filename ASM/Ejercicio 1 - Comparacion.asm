.data
Input: .asciiz "\nThis is Lab-05 of the course CSCS323 Computer Organization and Assembly Language.We are FCCU/CS Students"
Check: .asciiz "C"
Result: .asciiz "\nThe number of times this character occurs in the string is: "

.text
.globl main
main:
    # output the result string
    li      $v0,4               # print_string syscall number
    la      $a0,Result          # string address
    syscall

    la      $t0,Input           # load address of Input
    li      $s1,0               # Set Counter to zero

    la      $t1,Check           # load address of Check
    lb      $t3,0($t1)          # get "check" char value

    li      $s2,0               # get end of string (EOS) char

compare:
    lb      $t2,0($t0)          # get next char in 'Input'
    addi    $t0,$t0,1           # advance pointer to next char

    beq     $t2,$s2,done        # is current char 0?  if yes, fly and print

    bne     $t2,$t3,compare     # does current match check? If no, loop
    addi    $s1,$s1,1           # yes, increment count
    b       compare             # loop

done:
    li      $v0,1               # print_int syscall
    move    $a0,$s1             # get total count to correct register
    syscall
