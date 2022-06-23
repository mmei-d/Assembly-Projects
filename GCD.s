        .global main, Stop, CodeEnd
        .global DataStart, DataEnd
        .global A, B, GCD
	.global	ifEnd, whileOuter, whileInner, innerWhileEnd, outerWhileEnd
	
main:
	// make sure A is the largest of the two numbers
	// if(B > A)
	movw	r0, #:lower16: B
	movt	r0, #:upper16: B
	ldr	r1, [r0]	// r1 = copy of B

	movw	r2, #:lower16: A
	movt	r2, #:upper16: A
	ldr	r3, [r2]	// r3 = copy of A

	cmp	r1, r3	// compare B and A
	ble	ifEnd	// if B <= A, skip if statement and go to ifEnd

	// swap A and B
	str	r3, [r0]	// var B in memory = copy of A in r3 --> r0 = A
	str	r1, [r2]	// var A in memory = copy of B in r1 --> r2 = B

// end of if --> continue to while loop
ifEnd:

whileOuter:
	// while (A != B)
	ldr	r3, [r2]	// r3 = copy of A
	ldr	r1, [r0]	// r1 = copy of B
	
	cmp	r3, r1	// compare A and B
	beq	outerWhileEnd	// if A == B, skip while statement and go to outerWhileEnd
	cmp	r1, #0	// compare B and 0
	beq	outerWhileEnd	// if B == 0, skip while statement and go to outerWhileEnd
	cmp	r3, #0	// compare A and 0
	beq	outerWhileEnd	// if A == 0, skip while statement and go to outerWhileEnd

whileInner:
	// while (B < A)
	cmp	r1, r3	// compare B and A
	bge	innerWhileEnd	// if B >= A, skip while statement and go to innerWhileEnd

	// inner while body
	
        sub     r3, r3, r1              // r3 = A - B
        str     r3, [r2]                // A = A - B;

	// end of inner while body
	b	whileInner	

// end of inner while loop
innerWhileEnd:

	// outer while body
	// swap A and B
	str	r3, [r0]	// var A in memory = copy of B in r3
	str	r1, [r2]	// var B in memory = copy of A in r1

	// end of outer while body
	b	whileOuter	

// end of outer while loop
outerWhileEnd:

	// GCD = B
	movw	r4, #:lower16: GCD
	movt	r4, #:upper16: GCD
	
	str	r3, [r4]	// GCD = B

Stop:   
	nop

CodeEnd:
	nop

	.data

DataStart:
A:      .4byte  168
B:      .4byte  651
GCD:    .skip  4

DataEnd:    
	nop

        .end
