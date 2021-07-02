	.text
main:
	la	$a0,n1
	la	$a1,n2
	jal	swap
	li	$v0,1	# print n1 and n2; should be 27 and 14
	lw	$a0,n1
	syscall
	li	$v0,11
	li	$a0,' '
	syscall
	li	$v0,1
	lw	$a0,n2
	syscall
	li	$v0,11
	li	$a0,'\n'
	syscall
	li	$v0,10	# exit
	syscall

swap:	# your code goes here
	addiu $sp , $sp, -8
	lw $t0 , 0($sp)
	lw $t1, 0($a0)
	sw $t1, 0($t0)
	lw $t1, 0($a1)
	sw $t1, 0($a0)
	sw $t0, 0($a1)
	
	
	jr $ra
		
			
				
					
						
							
								
									
	#lw $t1, 0($a0)
	#sw $t1, 0($t0)
	#sw $a1, 0($t2)
	#lw $a0 , 0($t2)
	
	
	

	#jr $ra
	
	
	#sw $a1 ,($t0)
	#lw $a0 ,($t0)
	#lw $t0 ,($sp)
	#lw $a1 ,($t0)
	
	
	



	.data
n1:	.word	14
n2:	.word	27
