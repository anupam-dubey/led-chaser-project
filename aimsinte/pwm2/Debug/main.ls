   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
  15                     .const:	section	.text
  16  0000               _port_to_output:
  17  0000 0000          	dc.w	0
  18  0002 5000          	dc.w	20480
  19  0004 5005          	dc.w	20485
  20  0006 500a          	dc.w	20490
  21  0008 500f          	dc.w	20495
  56                     ; 61 void main (void)
  56                     ; 62 {   int i;
  58                     	switch	.text
  59  0000               _main:
  63                     ; 64 		GPIO_setup();
  65  0000 ad13          	call	_GPIO_setup
  67                     ; 65 		TIM4_Config();
  69  0002 cd015a        	call	L5_TIM4_Config
  71                     ; 66 		SoftPWMBegin();
  73  0005 cd00c9        	call	_SoftPWMBegin
  75                     ; 67 	 ITC_SetSoftwarePriority(ITC_IRQ_TIM4_OVF,ITC_PRIORITYLEVEL_3);
  77  0008 ae1703        	ldw	x,#5891
  78  000b cd0000        	call	_ITC_SetSoftwarePriority
  80                     ; 68 	 _isr_count=0xff;
  82  000e 35ff0024      	mov	__isr_count,#255
  83                     ; 69    enableInterrupts(); 
  86  0012 9a            rim
  88  0013               L52:
  90  0013 20fe          	jra	L52
 113                     ; 89 void GPIO_setup()
 113                     ; 90 {
 114                     	switch	.text
 115  0015               _GPIO_setup:
 119                     ; 92 	GPIOA->DDR  = 0x0E; //not used
 121  0015 350e5002      	mov	20482,#14
 122                     ; 93 	GPIOA->CR1 |= 0x0E; //pullup
 124  0019 c65003        	ld	a,20483
 125  001c aa0e          	or	a,#14
 126  001e c75003        	ld	20483,a
 127                     ; 94 	GPIOA->CR2 |= 0x0E; //no interrupts
 129  0021 c65004        	ld	a,20484
 130  0024 aa0e          	or	a,#14
 131  0026 c75004        	ld	20484,a
 132                     ; 96 	GPIOB->DDR  = 0x00; //
 134  0029 725f5007      	clr	20487
 135                     ; 97 	GPIOB->CR1 |= 0x00; //
 137  002d c65008        	ld	a,20488
 138                     ; 98 	GPIOB->CR2 |= 0x00; //no interrupt
 140  0030 c65009        	ld	a,20489
 141                     ; 100 	GPIOC->DDR  = 0xF8; //3,4,5,6,7
 143  0033 35f8500c      	mov	20492,#248
 144                     ; 101 	GPIOC->CR1 |= 0xF8; //high/fast 
 146  0037 c6500d        	ld	a,20493
 147  003a aaf8          	or	a,#248
 148  003c c7500d        	ld	20493,a
 149                     ; 102 	GPIOC->CR2 |= 0xF8; //fast outputno interrupt
 151  003f c6500e        	ld	a,20494
 152  0042 aaf8          	or	a,#248
 153  0044 c7500e        	ld	20494,a
 154                     ; 104 	GPIOD->DDR  = 0x1E; //D.1 D.2 D.3 D.4  outputs
 156  0047 351e5011      	mov	20497,#30
 157                     ; 105 	GPIOD->CR1 |= 0x1E; //high/fast 
 159  004b c65012        	ld	a,20498
 160  004e aa1e          	or	a,#30
 161  0050 c75012        	ld	20498,a
 162                     ; 106 	GPIOD->CR2 |= 0x1E; //high fast 10Mhz 
 164  0053 c65013        	ld	a,20499
 165  0056 aa1e          	or	a,#30
 166  0058 c75013        	ld	20499,a
 167                     ; 108 	GPIOA->ODR = 0x00;
 169  005b 725f5000      	clr	20480
 170                     ; 109 	GPIOD->ODR = 0x00;
 172  005f 725f500f      	clr	20495
 173                     ; 110 	GPIOC->ODR = 0x00;
 175  0063 725f500a      	clr	20490
 176                     ; 111 }	
 179  0067 81            	ret
 212                     ; 112 static void CLK_Config(void)
 212                     ; 113 {
 213                     	switch	.text
 214  0068               L3_CLK_Config:
 218                     ; 115 		CLK_DeInit();
 220  0068 cd0000        	call	_CLK_DeInit
 222                     ; 117 	CLK_HSECmd(DISABLE);
 224  006b 4f            	clr	a
 225  006c cd0000        	call	_CLK_HSECmd
 227                     ; 118 	CLK_LSICmd(DISABLE);
 229  006f 4f            	clr	a
 230  0070 cd0000        	call	_CLK_LSICmd
 232                     ; 119 	CLK_HSICmd(ENABLE);
 234  0073 a601          	ld	a,#1
 235  0075 cd0000        	call	_CLK_HSICmd
 238  0078               L35:
 239                     ; 120 	while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
 241  0078 ae0102        	ldw	x,#258
 242  007b cd0000        	call	_CLK_GetFlagStatus
 244  007e 4d            	tnz	a
 245  007f 27f7          	jreq	L35
 246                     ; 122 	CLK_ClockSwitchCmd(ENABLE);
 248  0081 a601          	ld	a,#1
 249  0083 cd0000        	call	_CLK_ClockSwitchCmd
 251                     ; 123 	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
 253  0086 4f            	clr	a
 254  0087 cd0000        	call	_CLK_HSIPrescalerConfig
 256                     ; 124 	CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
 258  008a a680          	ld	a,#128
 259  008c cd0000        	call	_CLK_SYSCLKConfig
 261                     ; 126 	CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
 261                     ; 127 	DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
 263  008f 4b01          	push	#1
 264  0091 4b00          	push	#0
 265  0093 ae01e1        	ldw	x,#481
 266  0096 cd0000        	call	_CLK_ClockSwitchConfig
 268  0099 85            	popw	x
 269                     ; 129 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
 271  009a 5f            	clrw	x
 272  009b cd0000        	call	_CLK_PeripheralClockConfig
 274                     ; 130 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
 276  009e ae0100        	ldw	x,#256
 277  00a1 cd0000        	call	_CLK_PeripheralClockConfig
 279                     ; 131 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, ENABLE);
 281  00a4 ae0301        	ldw	x,#769
 282  00a7 cd0000        	call	_CLK_PeripheralClockConfig
 284                     ; 132 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
 286  00aa ae1200        	ldw	x,#4608
 287  00ad cd0000        	call	_CLK_PeripheralClockConfig
 289                     ; 133 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
 291  00b0 ae1300        	ldw	x,#4864
 292  00b3 cd0000        	call	_CLK_PeripheralClockConfig
 294                     ; 134 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
 296  00b6 ae0700        	ldw	x,#1792
 297  00b9 cd0000        	call	_CLK_PeripheralClockConfig
 299                     ; 135 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
 301  00bc ae0500        	ldw	x,#1280
 302  00bf cd0000        	call	_CLK_PeripheralClockConfig
 304                     ; 136 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
 306  00c2 ae0401        	ldw	x,#1025
 307  00c5 cd0000        	call	_CLK_PeripheralClockConfig
 309                     ; 137 }
 312  00c8 81            	ret
 336                     ; 139 void SoftPWMBegin(void)
 336                     ; 140 { //porta=1 portb=2,portc=3,portd=4
 337                     	switch	.text
 338  00c9               _SoftPWMBegin:
 342                     ; 142 	_softpwm_channels[0].portname=4;
 344  00c9 35040000      	mov	__softpwm_channels,#4
 345                     ; 143 	_softpwm_channels[0].pinmask=(1<<4);
 347  00cd 35100001      	mov	__softpwm_channels+1,#16
 348                     ; 144 	_softpwm_channels[0].pwmvalue=10;
 350  00d1 350a0002      	mov	__softpwm_channels+2,#10
 351                     ; 146 	_softpwm_channels[1].portname=1;
 353  00d5 35010003      	mov	__softpwm_channels+3,#1
 354                     ; 147 	_softpwm_channels[1].pinmask=(1<<1);
 356  00d9 35020004      	mov	__softpwm_channels+4,#2
 357                     ; 148 	_softpwm_channels[1].pwmvalue=20;
 359  00dd 35140005      	mov	__softpwm_channels+5,#20
 360                     ; 150 	_softpwm_channels[2].portname=1;
 362  00e1 35010006      	mov	__softpwm_channels+6,#1
 363                     ; 151 	_softpwm_channels[2].pinmask=(1<<2);
 365  00e5 35040007      	mov	__softpwm_channels+7,#4
 366                     ; 152 	_softpwm_channels[2].pwmvalue=30;
 368  00e9 351e0008      	mov	__softpwm_channels+8,#30
 369                     ; 154 	_softpwm_channels[3].portname=4;
 371  00ed 35040009      	mov	__softpwm_channels+9,#4
 372                     ; 155 	_softpwm_channels[3].pinmask=(1<<3);
 374  00f1 3508000a      	mov	__softpwm_channels+10,#8
 375                     ; 156 	_softpwm_channels[3].pwmvalue=40;
 377  00f5 3528000b      	mov	__softpwm_channels+11,#40
 378                     ; 158 	_softpwm_channels[4].portname=4;
 380  00f9 3504000c      	mov	__softpwm_channels+12,#4
 381                     ; 159 	_softpwm_channels[4].pinmask=(1<<2);
 383  00fd 3504000d      	mov	__softpwm_channels+13,#4
 384                     ; 160 	_softpwm_channels[4].pwmvalue=50;
 386  0101 3532000e      	mov	__softpwm_channels+14,#50
 387                     ; 162 	_softpwm_channels[5].portname=4;
 389  0105 3504000f      	mov	__softpwm_channels+15,#4
 390                     ; 163 	_softpwm_channels[5].pinmask=(1<<1);
 392  0109 35020010      	mov	__softpwm_channels+16,#2
 393                     ; 164 	_softpwm_channels[5].pwmvalue=60;
 395  010d 353c0011      	mov	__softpwm_channels+17,#60
 396                     ; 166 	_softpwm_channels[6].portname=3;
 398  0111 35030012      	mov	__softpwm_channels+18,#3
 399                     ; 167 	_softpwm_channels[6].pinmask=(1<<7);
 401  0115 35800013      	mov	__softpwm_channels+19,#128
 402                     ; 168 	_softpwm_channels[6].pwmvalue=70;
 404  0119 35460014      	mov	__softpwm_channels+20,#70
 405                     ; 170 	_softpwm_channels[7].portname=3;
 407  011d 35030015      	mov	__softpwm_channels+21,#3
 408                     ; 171 	_softpwm_channels[7].pinmask=(1<<6);
 410  0121 35400016      	mov	__softpwm_channels+22,#64
 411                     ; 172 	_softpwm_channels[7].pwmvalue=80;
 413  0125 35500017      	mov	__softpwm_channels+23,#80
 414                     ; 174 	_softpwm_channels[8].portname=3;
 416  0129 35030018      	mov	__softpwm_channels+24,#3
 417                     ; 175 	_softpwm_channels[8].pinmask=(1<<5);
 419  012d 35200019      	mov	__softpwm_channels+25,#32
 420                     ; 176 	_softpwm_channels[8].pwmvalue=90;
 422  0131 355a001a      	mov	__softpwm_channels+26,#90
 423                     ; 178 	_softpwm_channels[9].portname=3;
 425  0135 3503001b      	mov	__softpwm_channels+27,#3
 426                     ; 179 	_softpwm_channels[9].pinmask=(1<<4);
 428  0139 3510001c      	mov	__softpwm_channels+28,#16
 429                     ; 180 	_softpwm_channels[9].pwmvalue=100;
 431  013d 3564001d      	mov	__softpwm_channels+29,#100
 432                     ; 182 	_softpwm_channels[10].portname=3;
 434  0141 3503001e      	mov	__softpwm_channels+30,#3
 435                     ; 183 	_softpwm_channels[10].pinmask=(1<<3);
 437  0145 3508001f      	mov	__softpwm_channels+31,#8
 438                     ; 184 	_softpwm_channels[10].pwmvalue=200;
 440  0149 35c80020      	mov	__softpwm_channels+32,#200
 441                     ; 186 	_softpwm_channels[11].portname=1;
 443  014d 35010021      	mov	__softpwm_channels+33,#1
 444                     ; 187 	_softpwm_channels[11].pinmask=(1<<3);
 446  0151 35080022      	mov	__softpwm_channels+34,#8
 447                     ; 188 	_softpwm_channels[11].pwmvalue=255;
 449  0155 35ff0023      	mov	__softpwm_channels+35,#255
 450                     ; 190 }	
 453  0159 81            	ret
 480                     ; 194 static void TIM4_Config(void)
 480                     ; 195 {
 481                     	switch	.text
 482  015a               L5_TIM4_Config:
 486                     ; 206   TIM4_TimeBaseInit(TIM4_PRESCALER_2, TIM4_PERIOD);
 488  015a ae013f        	ldw	x,#319
 489  015d cd0000        	call	_TIM4_TimeBaseInit
 491                     ; 208   TIM4_ClearFlag(TIM4_FLAG_UPDATE);
 493  0160 a601          	ld	a,#1
 494  0162 cd0000        	call	_TIM4_ClearFlag
 496                     ; 210   TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);
 498  0165 ae0101        	ldw	x,#257
 499  0168 cd0000        	call	_TIM4_ITConfig
 501                     ; 216   TIM4_Cmd(ENABLE);
 503  016b a601          	ld	a,#1
 504  016d cd0000        	call	_TIM4_Cmd
 506                     ; 217 }
 509  0170 81            	ret
 549                     ; 218 void TIM4_UPD_OVF_IRQHandler(void)// RC5 pulse wirdth
 549                     ; 219  { volatile uint8_t *out;
 551                     	switch	.text
 552  0171               f_TIM4_UPD_OVF_IRQHandler:
 554  0171 8a            	push	cc
 555  0172 84            	pop	a
 556  0173 a4bf          	and	a,#191
 557  0175 88            	push	a
 558  0176 86            	pop	cc
 559       00000002      OFST:	set	2
 560  0177 3b0002        	push	c_x+2
 561  017a be00          	ldw	x,c_x
 562  017c 89            	pushw	x
 563  017d 3b0002        	push	c_y+2
 564  0180 be00          	ldw	x,c_y
 565  0182 89            	pushw	x
 566  0183 89            	pushw	x
 569                     ; 222   if(++_isr_count==0)
 571  0184 3c24          	inc	__isr_count
 572  0186 3d24          	tnz	__isr_count
 573  0188 2620          	jrne	L511
 574                     ; 225 	   out=portOutputRegister(_softpwm_channels[0].portname);
 576  018a b600          	ld	a,__softpwm_channels
 577  018c 5f            	clrw	x
 578  018d 97            	ld	xl,a
 579  018e 58            	sllw	x
 580  018f de0000        	ldw	x,(_port_to_output,x)
 581  0192 1f01          	ldw	(OFST-1,sp),x
 582                     ; 226 		*out |= (_softpwm_channels[0].pinmask);
 584  0194 1e01          	ldw	x,(OFST-1,sp)
 585  0196 f6            	ld	a,(x)
 586  0197 ba01          	or	a,__softpwm_channels+1
 587  0199 f7            	ld	(x),a
 588                     ; 227 		 out=portOutputRegister(_softpwm_channels[1].portname);
 590  019a b603          	ld	a,__softpwm_channels+3
 591  019c 5f            	clrw	x
 592  019d 97            	ld	xl,a
 593  019e 58            	sllw	x
 594  019f de0000        	ldw	x,(_port_to_output,x)
 595  01a2 1f01          	ldw	(OFST-1,sp),x
 596                     ; 228 		*out |= (_softpwm_channels[1].pinmask);
 598  01a4 1e01          	ldw	x,(OFST-1,sp)
 599  01a6 f6            	ld	a,(x)
 600  01a7 ba04          	or	a,__softpwm_channels+4
 601  01a9 f7            	ld	(x),a
 602  01aa               L511:
 603                     ; 233 	 if (_softpwm_channels[0].pwmvalue == _isr_count)  // if we have hit the width
 605  01aa b602          	ld	a,__softpwm_channels+2
 606  01ac b124          	cp	a,__isr_count
 607  01ae 2611          	jrne	L711
 608                     ; 235 				 out=portOutputRegister(_softpwm_channels[0].portname);
 610  01b0 b600          	ld	a,__softpwm_channels
 611  01b2 5f            	clrw	x
 612  01b3 97            	ld	xl,a
 613  01b4 58            	sllw	x
 614  01b5 de0000        	ldw	x,(_port_to_output,x)
 615  01b8 1f01          	ldw	(OFST-1,sp),x
 616                     ; 236 				*out &= ~(_softpwm_channels[0].pinmask);
 618  01ba 1e01          	ldw	x,(OFST-1,sp)
 619  01bc b601          	ld	a,__softpwm_channels+1
 620  01be 43            	cpl	a
 621  01bf f4            	and	a,(x)
 622  01c0 f7            	ld	(x),a
 623  01c1               L711:
 624                     ; 238 	if (_softpwm_channels[1].pwmvalue == _isr_count)  // if we have hit the width
 626  01c1 b605          	ld	a,__softpwm_channels+5
 627  01c3 b124          	cp	a,__isr_count
 628  01c5 2611          	jrne	L121
 629                     ; 240 				 out=portOutputRegister(_softpwm_channels[1].portname);
 631  01c7 b603          	ld	a,__softpwm_channels+3
 632  01c9 5f            	clrw	x
 633  01ca 97            	ld	xl,a
 634  01cb 58            	sllw	x
 635  01cc de0000        	ldw	x,(_port_to_output,x)
 636  01cf 1f01          	ldw	(OFST-1,sp),x
 637                     ; 241 				*out &= ~(_softpwm_channels[1].pinmask);
 639  01d1 1e01          	ldw	x,(OFST-1,sp)
 640  01d3 b604          	ld	a,__softpwm_channels+4
 641  01d5 43            	cpl	a
 642  01d6 f4            	and	a,(x)
 643  01d7 f7            	ld	(x),a
 644  01d8               L121:
 645                     ; 247   TIM4_ClearITPendingBit(TIM4_IT_UPDATE);
 647  01d8 a601          	ld	a,#1
 648  01da cd0000        	call	_TIM4_ClearITPendingBit
 650                     ; 250  }
 653  01dd 5b02          	addw	sp,#2
 654  01df 85            	popw	x
 655  01e0 bf00          	ldw	c_y,x
 656  01e2 320002        	pop	c_y+2
 657  01e5 85            	popw	x
 658  01e6 bf00          	ldw	c_x,x
 659  01e8 320002        	pop	c_x+2
 660  01eb 80            	iret
 735                     	xdef	_main
 736                     	xdef	_port_to_output
 737                     	xdef	_SoftPWMBegin
 738                     	xdef	_GPIO_setup
 739                     	switch	.ubsct
 740  0000               __softpwm_channels:
 741  0000 000000000000  	ds.b	36
 742                     	xdef	__softpwm_channels
 743  0024               __isr_count:
 744  0024 00            	ds.b	1
 745                     	xdef	__isr_count
 746                     	xdef	f_TIM4_UPD_OVF_IRQHandler
 747                     	xref	_TIM4_ClearITPendingBit
 748                     	xref	_TIM4_ClearFlag
 749                     	xref	_TIM4_ITConfig
 750                     	xref	_TIM4_Cmd
 751                     	xref	_TIM4_TimeBaseInit
 752                     	xref	_ITC_SetSoftwarePriority
 753                     	xref	_CLK_GetFlagStatus
 754                     	xref	_CLK_SYSCLKConfig
 755                     	xref	_CLK_HSIPrescalerConfig
 756                     	xref	_CLK_ClockSwitchConfig
 757                     	xref	_CLK_PeripheralClockConfig
 758                     	xref	_CLK_ClockSwitchCmd
 759                     	xref	_CLK_LSICmd
 760                     	xref	_CLK_HSICmd
 761                     	xref	_CLK_HSECmd
 762                     	xref	_CLK_DeInit
 763                     	xref.b	c_x
 764                     	xref.b	c_y
 784                     	end
