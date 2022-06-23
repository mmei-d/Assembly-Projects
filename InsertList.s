	.global InsertList
	.global if, else, postLude

InsertList:

//   public static List InsertList(List head, List elem)
//   {
//   	if (head == null || head.value >= elem.value) {
//        	elem.next = head;
//        	return elem;
//     	} else {
//        	head.next = InsertList(head.next, elem);
//        	return head;
//     	}
//   }

        push    {lr}
        push    {fp}
        mov     fp, sp
        sub     sp, sp, #0      //no local variables

        //if (head == null || head.value >= elem.value)

	//if (head == null)
        ldr     r0, [fp, #8]    //r0 = head
        cmp     r0, #0
        beq     if	//if head == null, go to if

	//if (head.value >= elem.value)
	ldr     r0, [fp, #8]    //r0 = head
	ldr     r0, [r0, #0]	//r0 = head.value
	ldr     r1, [fp, #12]   //r1 = elem
	ldr     r1, [r1, #0]	//r1 = elem.value
	cmp     r0, r1
	blt     else	//if head.value < elem.value, go to else since neither statement is true

if:
	ldr     r0, [fp, #8]    //r0 = head
	ldr     r1, [fp, #12]   //r1 = elem
        str     r0, [r1, #4]	//elem.next = head;
       
	// return elem
        ldr     r0, [fp, #12]   //r0 = elem (return value)
	b       postLude

else:
	//head.next = InsertList(head.next, elem);

	//pass elem
	ldr     r0, [fp, #12]   //r0 = elem
	push    {r0}            //pass elem with stack

        //pass head.next
        ldr     r0, [fp, #8]    //r0 = head
        ldr     r0, [r0, #4]    //r0 = head.next
        push    {r0}            //pass head.next with stack

        bl      InsertList
        add     sp, sp, #8      //clean up 2 parameters

        //assign return value (in r0) to elem.next
        ldr     r1, [fp, #8]   	//r1 = head(can't use r0)
        str     r0, [r1, #4]   	//head.next = InsertList(head.next, elem)

        //return head
        ldr     r0, [fp, #8]    //r0 = head (return value) 

//clean up qnd return to caller
postLude:
        mov     sp, fp
        pop     {fp}
        pop     {pc}


	.end
