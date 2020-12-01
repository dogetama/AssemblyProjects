@ defining the CPU (Raspberry Pi 4)

.cpu cortex-a72
.fpu neon-fp-armv8

@ data section (input and output)
.data 

inp1: .asciz "Enter Fibonacci term: " @ Input String 
inp2: .asciz "%d"  @ inputted number
output: .asciz "The %dth number is %d\n" @ Output String

@ text section (the code)
.text
.align 2
.global main
.type main, %function

@ defining main
main: 
	@ save lr register into a permanent register
    	mov r4, lr

	@ printf("Enter Fibonacci term: "); in C
	ldr r0, =inp1 @ memory is loaded into r0
	bl printf 
 	
	@ scanf("%d", &term); in C
	ldr r0, =inp2 @r0 receives the memory from inp2
	sub sp, sp, #4 @sp = sp - 4 @ goes up one mem location
	mov r1, sp @ user input will be stored at sp loc
	bl scanf 
	
	@ save input from sp into r5
	ldr r5, [sp] 
	
	add sp, sp, #4

	
	mov r7, #1 @ firstnumber = 1; in C
	mov r9, #1 @ secondnumber = 1; in C
	mov r8, #3 @ int k; in C (set to 3 in assembler instead of 0) 
	
	@ if (term < 3) { in C
	cmp r5, r8 @ compares user input to counter variable to see if the value is 1 or 2
	blt getoutFORLOOPtest @ the program proceeds to this function if the input is 1 or 2
	
	startFORLOOP: @ for (int k = 0; k < term - 2; k++) { in C
	cmp r8, r5 @ checks if user input is greater than k
	bgt getoutFORLOOP @stops loop if k > term
	add r6, r7, r9 @ helper = firstnumber + secondnumber; in C
	mov r7, r9  @ secondnumber = firstnumber; in C
	mov r9, r6 @ firstnumber = helper; in C
	add r8, r8, #1 @ k++ in C
		
	b startFORLOOP @goes back to the for loop


getoutFORLOOPtest: @ sets and prints 1 as the result if term is 1 or 2
	mov r6, #1 @ helper = 1; in C

	@ printf("The %dth Fibonacci number is %d\n", term, helper); in C
	ldr r0, =output @ the output string memory is loaded in r0
	mov r1, r5 @ r1 receives the value for nth term
	mov r2, r6 @ r2 receives the result value
	bl printf

	mov r0, #0 @ returns 0 
	mov lr, r4 @ restores lr
	bx lr @ returns from main

getoutFORLOOP: @ prints out the result if term > 2
	ldr r0, =output @ the output string memory is loaded in r0
	mov r1, r5 @ r1 receives the value for nth term
	mov r2, r6 @ r2 receives the result value
	bl printf
	mov r0, #0 @ returns 0 
	mov lr, r4 @ restores lr
	bx lr @ returns from main

	
