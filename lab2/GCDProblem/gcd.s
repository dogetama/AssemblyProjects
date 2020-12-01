@ defining the CPU (Raspberry Pi 4)

.cpu cortex-a72
.fpu neon-fp-armv8

@ data section (input and output)
.data 

inp1: .asciz "Enter first positive term: " @input1 string
inp2: .asciz "%d" @first user input
inp3: .asciz "Enter second positive term: " @input 2 string
inp4: .asciz "%d" @second user input
output: .asciz "The GCD is %d\n" @output string

@ text section (the code)
.text
.align 2
.global main
.type main, %function

@ defining main
main: 
	@ save lr register into a permanent register
    	mov r4, lr
	
	@ printf("Enter first positive term: "); in C
	ldr r0, =inp1 @ memory is loaded into r0
	bl printf

	@ scanf("%d", &firstnumber); in C
	ldr r0, =inp2 @r0 receives the memory from inp2
	sub sp, sp, #4 @ goes up one mem location
	mov r1, sp @ user input will be stored at sp loc
	bl scanf
	
	@ save input from sp into r5
	ldr r5, [sp]

	ldr r0, =inp3 @ memory is loaded into r0
	bl printf

	@ printf("Enter second positive term: "); in C
	ldr r0, =inp4 @r0 receives the memory from inp2
	sub sp, sp, #4 @ goes up one mem location
	mov r1, sp @ user input will be stored at sp loc
	bl scanf

	@ save input from sp into r6
	ldr r6, [sp]

	cmp r5, r6 @ if (firstnumber < secondnumber) { in C
	blt switch @ goes to the switch function if r5 < r6

	b STARTLOOP @ goes to straight the STARTLOOP function if no switch is needed

	switch:
	mov r7, r5 @ helper = secondnumber; in C
	mov r5, r6 @ secondnumber = firstnumber; in C
	mov r6, r7 @ firstnumber = helper; in C
	b STARTLOOP @ goes to the startloop function once the switch is done


 	STARTLOOP: @ while (term == 1) { in C
	
	@ helper = firstnumber % secondnumber; in C
	mov r8, r5 @ r8 = r5
	mov r9, r6 @ r9 = 6
	UDIV r10, r8, r9 @ r10 = r8 / r9
	MUL r10, r10, r9 @ r10 = r10 * r9
	SUB  r10, r8, r10 @ r10 = r8 - r10

	@ if (helper == 0) { in C
	mov r8, r10 @ r8 = r10

	@ checks if r8 = 0 and the loop is broken if that is the case
	cmp r8, #0 
	beq endLOOP


	mov r5, r9 @ r5 = r9
	mov r6, r8 @ r6 = r8
	b STARTLOOP @goes back to the beginning of the loop



endLOOP:
	ldr r0, =output @ the output string memory is loaded in r0
	mov r1, r6 @ r1 receives the value for GCD
	bl printf
	mov r0, #0 @ returns 0
	mov lr, r4 @ restores lr
	bx lr @ returns from main

