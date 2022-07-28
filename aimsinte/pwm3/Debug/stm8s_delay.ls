   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
  64                     ; 4 void delay_us(unsigned int  value)
  64                     ; 5 {
  66                     	switch	.text
  67  0000               _delay_us:
  69  0000 89            	pushw	x
  70       00000002      OFST:	set	2
  73                     ; 6 	register unsigned int loops =  (dly_const * value) ;
  75  0001 cd0000        	call	c_uitof
  77  0004 ae0000        	ldw	x,#L73
  78  0007 cd0000        	call	c_fmul
  80  000a cd0000        	call	c_ftoi
  82  000d 1f01          	ldw	(OFST-1,sp),x
  84  000f 2008          	jra	L74
  85  0011               L34:
  86                     ; 10 		_asm ("nop");
  89  0011 9d            nop
  91                     ; 11 		loops--;
  93  0012 1e01          	ldw	x,(OFST-1,sp)
  94  0014 1d0001        	subw	x,#1
  95  0017 1f01          	ldw	(OFST-1,sp),x
  96  0019               L74:
  97                     ; 8 	while(loops)
  99  0019 1e01          	ldw	x,(OFST-1,sp)
 100  001b 26f4          	jrne	L34
 101                     ; 13 }
 105  001d 85            	popw	x
 106  001e 81            	ret
 141                     ; 16 void delay_ms(unsigned int  value)
 141                     ; 17 {
 142                     	switch	.text
 143  001f               _delay_ms:
 145  001f 89            	pushw	x
 146       00000000      OFST:	set	0
 149  0020 200c          	jra	L37
 150  0022               L17:
 151                     ; 20 		delay_us(1000);
 153  0022 ae03e8        	ldw	x,#1000
 154  0025 add9          	call	_delay_us
 156                     ; 21 		value--;
 158  0027 1e01          	ldw	x,(OFST+1,sp)
 159  0029 1d0001        	subw	x,#1
 160  002c 1f01          	ldw	(OFST+1,sp),x
 161  002e               L37:
 162                     ; 18 	while(value)
 164  002e 1e01          	ldw	x,(OFST+1,sp)
 165  0030 26f0          	jrne	L17
 166                     ; 23 }
 170  0032 85            	popw	x
 171  0033 81            	ret
 184                     	xdef	_delay_ms
 185                     	xdef	_delay_us
 186                     .const:	section	.text
 187  0000               L73:
 188  0000 3e000000      	dc.w	15872,0
 189                     	xref.b	c_x
 209                     	xref	c_ftoi
 210                     	xref	c_fmul
 211                     	xref	c_uitof
 212                     	end
