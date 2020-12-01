@ defining the CPU (Raspberry Pi 4)

.cpu cortex-a72
.fpu neon-fp-armv8

@ data section (input and output)
.data 

inp1: .asciz "Enter two positive integers: " @ Input String 
inp2: .asciz "%d"  @ 1st inputted number
inp3: .asciz "%d"  @ 2nd inputted number
output: .asciz "Prime numbers between %d and %d are: " @ Output String
output2: .asciz "%d " @prints out the prime numbers between the inputted numbers

@ text section (the code)
.text
.align 2
.global main
.type main, %function

@ defining main
main: 
	push {fp, lr} @ store fp, lr onto stack
	add  fp, sp, #4 @reset fp to the bottom of function stack


	@ printf("Enter two positive integers: "); in C
	ldr r0, =inp1 @ memory is loaded into r0
	bl printf 
	
	@ scanf("%d %d", &n1, &n2); in C
	ldr r0, =inp2 @r0 receives the memory from inp2
	sub sp, sp, #4 @ goes up one mem location
	mov r1, sp @ user input will be stored at sp loc
	bl scanf 
	ldr r8, [sp] @ save input from sp into r8
	ldr r0, =inp3 @r0 receives the memory from inp2
	sub sp, sp, #4 @ goes up one mem location
	mov r1, sp @ user input will be stored at sp loc
	bl scanf 
	ldr r9, [sp] @ save input from sp into r9

	
	mov r7, r8 @ moves r8 value into r7

	@ printf("Prime numbers between %d and %d are: ", n1, n2); in C
	ldr r0, =output @ the output string memory is loaded in r0
	mov r1, r8 @ r1 displays 1st input
	mov r2, r9 @ r2 displays the 2nd input
	bl printf

	forLOOP: 
	add r7, r7, #1 @ ++i in C
	cmp r7, r9 @ checks if r7 >= r9
	bge getoutFORLOOP @ gets out of the for loop if this is the case
	mov r0, r7 @ moves the value of r7 into r0
	bl checkPrimeNumber @ calls the checkPrimeNumber function
	cmp r0, #1 @ checks if the returning value is equal to one
	beq print @ goes to the print function if this is the case
	b forLOOP @ goes back to the beginning of the for loop
	
	print: @ printf("%d ", i); in C
	ldr r0, =output2 @ loads the output string
	mov r1, r7 @ moves the value of r7 into r1
	bl printf
	b forLOOP

getoutFORLOOP:
	sub sp, fp, #4 @ restore the value of sp and fp
	pop {fp, pc} @ returns to the calling function
