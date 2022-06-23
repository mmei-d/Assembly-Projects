        .global BubbleSort
	.global while, forLoop, ifEnd, forLoopEnd, whileEnd

BubbleSort:
//*****************************************************
//    BubbleSort: input  r0 = address of int array
//                       r1 = # elements in the array
//*****************************************************

	mov	r2, #0 //r2: Done = 0 --> 0 represents false (not sorted)

	mov	r3, #1 //r3: k = 1

//while(Done == 0) 
while:
	//while body
	cmp	r2, #0	// compare Done and 0
	bne	whileEnd	// if Done != 0, skip while statement and go to whileEnd

	mov	r2, #1	//Done = 1 --> 1 represents true (sorted)

//for (i = 0; i < N-k; i++)
	mov	r4, #0 //r4: i = 0

forLoop:
	//for loop body
	sub	r9, r1, r3	//r9 = N-k
	cmp	r4, r9	// compare i and N-k
	bge	forLoopEnd	// if i >= N-k, skip for statement and go to forLoopEnd
	
	//if (A[i] > A[i+1])
	//A[i]
	mov	r10, #4	//r10 (register for constant) = 4
	mul	r5, r4, r10        // r5 = i*4
	ldr	r6, [r0, r5]     // Load A[i] into r6

	//A[i+1]
	mov	r10, #1	//r10 (register for constant) = 1
	add	r7, r4, r10	//r7 = i + 1
	mov	r10, #4	//r10 (register for constant) = 4
	add	r7, r7, r7       // r7 = (i + 1)*4
	add	r7, r7, r7 
	ldr	r8, [r0, r7]     // Load A[i + 1] into r8

	cmp	r6, r8
	ble	ifEnd	// if A[i] <= A[i+1], skip if statement and go to ifEnd
	
	//Swap A[i] and A[i+1] --------------------------
	str	r6, [r0, r7]	// A[i+1] = A[i]
	str	r8, [r0, r5]	// A[i] = A[i+1]

	mov	r2, #0	//Done = 0 --> means not sorted

ifEnd:
	//i++
	mov	r10, #1	//r10 (register for constant) = 1
	add	r4, r4, r10	//i += 1
	// end of for loop body
	b	forLoop

forLoopEnd:
	mov	r10, #1	//r10 (register for constant) = 1
	add	r3, r3, r10	//k += 1

	// end of while body
	b	while

whileEnd:
	mov	pc, lr	//BubbleSort (callee) returns to main (caller)

	.data
// *************************************************************************
// If you need local variables, you can define them below this line
// *************************************************************************

        .end
