@ defining the CPU (Raspberry Pi 4)

.cpu cortex-a72
.fpu neon-fp-armv8



@ text section (the code)
.text
.align 2
.global checkPrimeNumber
.type checkPrimeNumber, %function

checkPrimeNumber:
	push {fp, lr} @ store fp, lr onto stack
	add  fp, sp, #4 @reset fp to the bottom of function stack



	mov r5, #2 @ j = 2
	UDIV r4, r0, r5 @ n = n / 2 


	cmp r0, #4 @ checks if r0 = 4
	beq otherEXIT @ goes to the non-prime function version if r0 = 4.

	forLOOP:
	add r5, r5, #1 @ ++k in C
	cmp r5, r4 @ checks if r5 is greater than r4
	bgt EXIT @ goes to the prime version if this is the case

	@ if(n%j == 0) in C
	UDIV r6, r0, r5 @ r6 = r0 / r5
	MUL r6, r6, r5 @ r6 = r6 * r5 
	SUB  r6, r0, r6 @ r6 = r0 - r6
	cmp r6, #0 @ checks if r6 = 0
	beq otherEXIT @ goes to the non-prime function version if this is the case

	b forLOOP @ goes back to the begining of the loop


otherEXIT: @the non-prime function version
	mov r0, #0 @ gives r0 the value of 0
	sub sp, fp, #4 @ restore the value of sp and fp
	pop {fp, pc} @ returns to the calling function

EXIT:
	mov r0, #1 @ gives r0 the value of 1
	sub sp, fp, #4
	pop {fp, pc}
	