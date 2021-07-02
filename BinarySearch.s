.data 

original_list: .space 100 
sorted_list: .space 100

str0: .asciiz "Enter size of list (between 1 and 25): "
str1: .asciiz "Enter one list element: \n"
str2: .asciiz "Content of original list: "
str3: .asciiz "Enter a key to search for: "
str4: .asciiz "Content of sorted list: "
strYes: .asciiz "Key found!"
strNo: .asciiz "Key not found!"

.text 

#This is the main program.
#It first asks user to enter the size of a list.
#It then asks user to input the elements of the list, one at a time.
#It then calls printList to print out content of the list.
#It then calls inSort to perform insertion sort
#It then asks user to enter a search key and calls bSearch on the sorted list.
#It then prints out search result based on return value of bSearch
main: 
	addi $sp, $sp -8
	sw $ra, 0($sp)
	li $v0, 4 
	la $a0, str0 
	syscall 
	li $v0, 5	#read size of list from user
	syscall
	move $s0, $v0
	move $t0, $0
	la $s1, original_list
loop_in:
	li $v0, 4 
	la $a0, str1 
	syscall 
	sll $t1, $t0, 2
	add $t1, $t1, $s1
	li $v0, 5	#read elements from user
	syscall
	sw $v0, 0($t1)
	addi $t0, $t0, 1
	bne $t0, $s0, loop_in
	move $a0, $s1
	move $a1, $s0
	
	jal inSort	#Call inSort to perform insertion sort in original list
	
	sw $v0, 4($sp)
	li $v0, 4 
	la $a0, str2 
	syscall 
	la $a0, original_list
	move $a1, $s0
	jal printList	#Print original list
	li $v0, 4 
	la $a0, str4 
	syscall 
	lw $a0, 4($sp)
	jal printList	#Print sorted list
	
	li $v0, 4 
	la $a0, str3 
	syscall 
	li $v0, 5	#read search key from user
	syscall
	move $a3, $v0
	lw $a0, 4($sp)
	jal bSearch	#call bSearch to perform binary search
	
	beq $v0, $0, notFound
	li $v0, 4 
	la $a0, strYes 
	syscall 
	j end
	
notFound:
	li $v0, 4 
	la $a0, strNo 
	syscall 
end:
	lw $ra, 0($sp)
	addi $sp, $sp 8
	li $v0, 10 
	syscall
	
	
#printList takes in a list and its size as arguments. 
#It prints all the elements in one line.
printList:
move $t3, $a0
addi $t0, $zero ,0
	#Your implementation of printList here	
looper:	sll $t5, $t0, 2
	add $t5, $t5, $t3
	lw $t5, 0($t5)
	li $v0, 1
	la $a0, ($t5)
	syscall 
	li $v0, 11
	li $a0, ' '
	syscall
	addi $t0,$t0, 1
	beq $t0 , $a1, ends
	j looper

ends:
	li $v0, 11
	addi $a0, $0, 0xA
	syscall 
	
	jr $ra
	
	
#inSort takes in a list and it size as arguments. 
#It performs INSERTION sort in ascending order and returns a new sorted list
#You may use the pre-defined sorted_list to store the result
inSort: la $v0, sorted_list
	move $t0, $v0
	addi $t1, $zero, 0

lop:	sll $t2, $t1, 2
	add $t3, $t2, $a0,
	lw $t3, 0($t3)
	add $t4, $t2, $t0
	sw $t3, 0($t4)
	addi $t1, $t1, 1
	beq $t1, $a1, next
	j lop
	
next: 	addi $t1, $zero, 1
	
	
lopp:	addi $t4, $t1, -1
	sll $t2, $t1, 2
	add $t3, $t2, $t0
	lw $t3, 0($t3)
	beq $t1, $a1, ending

	
lopper: 
	
	sll $t2, $t4, 2
	add $t5, $t2, $t0

	lw $t6, 0($t5)

	slt $at, $t3, $t6
	beq $at, $zero, almost

	addi $t7, $t5, 4
	

	sw $t6, 0($t7)
	addi $t7, $t7, -4
	sw $t3, 0($t7)
	addi $t4, $t4, -1
	slt $at, $t4, $zero
	bne $at, $zero, almost
	j lopper
	
almost:	
	addi $t1,$t1, 1
	
	j lopp

ending: 

	jr $ra
	
	
#bSearch takes in a list, its size, and a search key as arguments.
#It performs binary search RECURSIVELY to look for the search key.
#It will return a 1 if the key is found, or a 0 otherwise.
#Note: you MUST NOT use iterative approach in this function.
bSearch:
	addi $t9, $t9, 1 
	addi $s7, $a1, 1
	
	
	#Your implementation of bSearch here
	bgt $a3, $zero, pos
	#bgt $t9, $s7, negative
	
pos:	beq $t7, $t2, unfound

	#beq $t7, $zero, zero
	
	j jump
#negative:	blt $a3, $zero, unfound
		
zero:	addi $t8, $t3, 0
	lw $t4, 0($t8)
	beq $t4, $a3, exit
	
	move $t1, $a1
	
	srl $t2, $t1, 1
	sll $t5, $t2, 2
	add $t3, $a0, $t5
	lw $t4, 0($t3)
	beq $t4, $a3, exit
	beq $t2, $zero, unfound

jump:	move $t1, $a1
	srl $t2, $t1, 1
	sll $t5, $t2, 2
	add $t3, $a0, $t5
	lw $t4, 0($t3)
	beq $t1, $zero, unfound
	beq $t4, $a3, exit
	blt $a3, $t4, lower
	bgt $a3, $t4, upper
	
lower: 	move $t1, $t2
	#addi $a0, $a0, -4
	#addi $s5, $zero, -100000
	#sw $s5, 0($a0)
	move $a1, $t1
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	#addi $t0, $zero,1
	#srl $t7, $t2, 1
	jal bSearch
	j endz
	
upper:	
	addi $t3, $t3, 4
	lw $t4, 0($t3)
	beq $t4, $a3, exit
	
	move $a0, $t3
	move $a1, $t2
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	#addi $t0, $zero,1
	srl $t7, $t1, 1
	
	jal bSearch
	j endz
exit: addi $v0, $zero, 1
	j endz

unfound:addi $v0, $zero, 0
	j endz

endz:	lw $t6, 0($sp)
	beq $t6, $zero, heret
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra	

heret:	
	jr $ra

	
