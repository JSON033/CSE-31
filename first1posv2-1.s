main:
	lui	$a0,0x8000
	jal	first1pos
	jal	printv0
	lui	$a0,0x0001
	jal	first1pos
	jal	printv0
	li	$a0,1
	jal	first1pos
	jal	printv0
	add	$a0,$0,$0
	jal	first1pos
	jal	printv0
	li	$v0,10
	syscall

first1pos:	# your code goes here

	beq $a0, $zero, return
	li $t0, 0x80000000
	li $t1, 31 
	and $t2, $a0,$t0
	beq $t2,$zero, loop
	j end
	
loop:   srl $t0,$t0,1
	addi $t1,$t1,-1	
	and $t2, $a0,$t0
	beq $t2,$zero, loop
	j end
	
	
return: addi $v0,$zero,-1
	jr $ra
	
end:    move $v0,$t1
	jr $ra

printv0:
	addi	$sp,$sp,-4
	sw	$ra,0($sp)
	add	$a0,$v0,$0
	li	$v0,1
	syscall
	li	$v0,11
	li	$a0,'\n'
	syscall
	lw	$ra,0($sp)
	addi	$sp,$sp,4
	jr	$ra
