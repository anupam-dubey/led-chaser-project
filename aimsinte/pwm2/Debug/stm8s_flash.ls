   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
  75                     ; 87 void FLASH_Unlock(FLASH_MemType_TypeDef FLASH_MemType)
  75                     ; 88 {
  77                     	switch	.text
  78  0000               _FLASH_Unlock:
  82                     ; 90   assert_param(IS_MEMORY_TYPE_OK(FLASH_MemType));
  84                     ; 93   if(FLASH_MemType == FLASH_MEMTYPE_PROG)
  86  0000 a1fd          	cp	a,#253
  87  0002 260a          	jrne	L73
  88                     ; 95     FLASH->PUKR = FLASH_RASS_KEY1;
  90  0004 35565062      	mov	20578,#86
  91                     ; 96     FLASH->PUKR = FLASH_RASS_KEY2;
  93  0008 35ae5062      	mov	20578,#174
  95  000c 2008          	jra	L14
  96  000e               L73:
  97                     ; 101     FLASH->DUKR = FLASH_RASS_KEY2; /* Warning: keys are reversed on data memory !!! */
  99  000e 35ae5064      	mov	20580,#174
 100                     ; 102     FLASH->DUKR = FLASH_RASS_KEY1;
 102  0012 35565064      	mov	20580,#86
 103  0016               L14:
 104                     ; 104 }
 107  0016 81            	ret
 142                     ; 112 void FLASH_Lock(FLASH_MemType_TypeDef FLASH_MemType)
 142                     ; 113 {
 143                     	switch	.text
 144  0017               _FLASH_Lock:
 148                     ; 115   assert_param(IS_MEMORY_TYPE_OK(FLASH_MemType));
 150                     ; 118   FLASH->IAPSR &= (uint8_t)FLASH_MemType;
 152  0017 c4505f        	and	a,20575
 153  001a c7505f        	ld	20575,a
 154                     ; 119 }
 157  001d 81            	ret
 180                     ; 126 void FLASH_DeInit(void)
 180                     ; 127 {
 181                     	switch	.text
 182  001e               _FLASH_DeInit:
 186                     ; 128   FLASH->CR1 = FLASH_CR1_RESET_VALUE;
 188  001e 725f505a      	clr	20570
 189                     ; 129   FLASH->CR2 = FLASH_CR2_RESET_VALUE;
 191  0022 725f505b      	clr	20571
 192                     ; 130   FLASH->NCR2 = FLASH_NCR2_RESET_VALUE;
 194  0026 35ff505c      	mov	20572,#255
 195                     ; 131   FLASH->IAPSR &= (uint8_t)(~FLASH_IAPSR_DUL);
 197  002a 7217505f      	bres	20575,#3
 198                     ; 132   FLASH->IAPSR &= (uint8_t)(~FLASH_IAPSR_PUL);
 200  002e 7213505f      	bres	20575,#1
 201                     ; 133   (void) FLASH->IAPSR; /* Reading of this register causes the clearing of status flags */
 203  0032 c6505f        	ld	a,20575
 204                     ; 134 }
 207  0035 81            	ret
 262                     ; 142 void FLASH_ITConfig(FunctionalState NewState)
 262                     ; 143 {
 263                     	switch	.text
 264  0036               _FLASH_ITConfig:
 268                     ; 145   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 270                     ; 147   if(NewState != DISABLE)
 272  0036 4d            	tnz	a
 273  0037 2706          	jreq	L711
 274                     ; 149     FLASH->CR1 |= FLASH_CR1_IE; /* Enables the interrupt sources */
 276  0039 7212505a      	bset	20570,#1
 278  003d 2004          	jra	L121
 279  003f               L711:
 280                     ; 153     FLASH->CR1 &= (uint8_t)(~FLASH_CR1_IE); /* Disables the interrupt sources */
 282  003f 7213505a      	bres	20570,#1
 283  0043               L121:
 284                     ; 155 }
 287  0043 81            	ret
 321                     ; 164 void FLASH_EraseByte(uint32_t Address)
 321                     ; 165 {
 322                     	switch	.text
 323  0044               _FLASH_EraseByte:
 325       00000000      OFST:	set	0
 328                     ; 167   assert_param(IS_FLASH_ADDRESS_OK(Address));
 330                     ; 170   *(PointerAttr uint8_t*) (MemoryAddressCast)Address = FLASH_CLEAR_BYTE; 
 332  0044 1e05          	ldw	x,(OFST+5,sp)
 333  0046 7f            	clr	(x)
 334                     ; 171 }
 337  0047 81            	ret
 380                     ; 181 void FLASH_ProgramByte(uint32_t Address, uint8_t Data)
 380                     ; 182 {
 381                     	switch	.text
 382  0048               _FLASH_ProgramByte:
 384       00000000      OFST:	set	0
 387                     ; 184   assert_param(IS_FLASH_ADDRESS_OK(Address));
 389                     ; 185   *(PointerAttr uint8_t*) (MemoryAddressCast)Address = Data;
 391  0048 7b07          	ld	a,(OFST+7,sp)
 392  004a 1e05          	ldw	x,(OFST+5,sp)
 393  004c f7            	ld	(x),a
 394                     ; 186 }
 397  004d 81            	ret
 431                     ; 195 uint8_t FLASH_ReadByte(uint32_t Address)
 431                     ; 196 {
 432                     	switch	.text
 433  004e               _FLASH_ReadByte:
 435       00000000      OFST:	set	0
 438                     ; 198   assert_param(IS_FLASH_ADDRESS_OK(Address));
 440                     ; 201   return(*(PointerAttr uint8_t *) (MemoryAddressCast)Address); 
 442  004e 1e05          	ldw	x,(OFST+5,sp)
 443  0050 f6            	ld	a,(x)
 446  0051 81            	ret
 489                     ; 212 void FLASH_ProgramWord(uint32_t Address, uint32_t Data)
 489                     ; 213 {
 490                     	switch	.text
 491  0052               _FLASH_ProgramWord:
 493       00000000      OFST:	set	0
 496                     ; 215   assert_param(IS_FLASH_ADDRESS_OK(Address));
 498                     ; 218   FLASH->CR2 |= FLASH_CR2_WPRG;
 500  0052 721c505b      	bset	20571,#6
 501                     ; 219   FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NWPRG);
 503  0056 721d505c      	bres	20572,#6
 504                     ; 222   *((PointerAttr uint8_t*)(MemoryAddressCast)Address)       = *((uint8_t*)(&Data));
 506  005a 7b07          	ld	a,(OFST+7,sp)
 507  005c 1e05          	ldw	x,(OFST+5,sp)
 508  005e f7            	ld	(x),a
 509                     ; 224   *(((PointerAttr uint8_t*)(MemoryAddressCast)Address) + 1) = *((uint8_t*)(&Data)+1); 
 511  005f 7b08          	ld	a,(OFST+8,sp)
 512  0061 1e05          	ldw	x,(OFST+5,sp)
 513  0063 e701          	ld	(1,x),a
 514                     ; 226   *(((PointerAttr uint8_t*)(MemoryAddressCast)Address) + 2) = *((uint8_t*)(&Data)+2); 
 516  0065 7b09          	ld	a,(OFST+9,sp)
 517  0067 1e05          	ldw	x,(OFST+5,sp)
 518  0069 e702          	ld	(2,x),a
 519                     ; 228   *(((PointerAttr uint8_t*)(MemoryAddressCast)Address) + 3) = *((uint8_t*)(&Data)+3); 
 521  006b 7b0a          	ld	a,(OFST+10,sp)
 522  006d 1e05          	ldw	x,(OFST+5,sp)
 523  006f e703          	ld	(3,x),a
 524                     ; 229 }
 527  0071 81            	ret
 572                     ; 237 void FLASH_ProgramOptionByte(uint16_t Address, uint8_t Data)
 572                     ; 238 {
 573                     	switch	.text
 574  0072               _FLASH_ProgramOptionByte:
 576  0072 89            	pushw	x
 577       00000000      OFST:	set	0
 580                     ; 240   assert_param(IS_OPTION_BYTE_ADDRESS_OK(Address));
 582                     ; 243   FLASH->CR2 |= FLASH_CR2_OPT;
 584  0073 721e505b      	bset	20571,#7
 585                     ; 244   FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NOPT);
 587  0077 721f505c      	bres	20572,#7
 588                     ; 247   if(Address == 0x4800)
 590  007b a34800        	cpw	x,#18432
 591  007e 2607          	jrne	L542
 592                     ; 250     *((NEAR uint8_t*)Address) = Data;
 594  0080 7b05          	ld	a,(OFST+5,sp)
 595  0082 1e01          	ldw	x,(OFST+1,sp)
 596  0084 f7            	ld	(x),a
 598  0085 200c          	jra	L742
 599  0087               L542:
 600                     ; 255     *((NEAR uint8_t*)Address) = Data;
 602  0087 7b05          	ld	a,(OFST+5,sp)
 603  0089 1e01          	ldw	x,(OFST+1,sp)
 604  008b f7            	ld	(x),a
 605                     ; 256     *((NEAR uint8_t*)((uint16_t)(Address + 1))) = (uint8_t)(~Data);
 607  008c 7b05          	ld	a,(OFST+5,sp)
 608  008e 43            	cpl	a
 609  008f 1e01          	ldw	x,(OFST+1,sp)
 610  0091 e701          	ld	(1,x),a
 611  0093               L742:
 612                     ; 258   FLASH_WaitForLastOperation(FLASH_MEMTYPE_PROG);
 614  0093 a6fd          	ld	a,#253
 615  0095 cd017d        	call	_FLASH_WaitForLastOperation
 617                     ; 261   FLASH->CR2 &= (uint8_t)(~FLASH_CR2_OPT);
 619  0098 721f505b      	bres	20571,#7
 620                     ; 262   FLASH->NCR2 |= FLASH_NCR2_NOPT;
 622  009c 721e505c      	bset	20572,#7
 623                     ; 263 }
 626  00a0 85            	popw	x
 627  00a1 81            	ret
 663                     ; 270 void FLASH_EraseOptionByte(uint16_t Address)
 663                     ; 271 {
 664                     	switch	.text
 665  00a2               _FLASH_EraseOptionByte:
 667  00a2 89            	pushw	x
 668       00000000      OFST:	set	0
 671                     ; 273   assert_param(IS_OPTION_BYTE_ADDRESS_OK(Address));
 673                     ; 276   FLASH->CR2 |= FLASH_CR2_OPT;
 675  00a3 721e505b      	bset	20571,#7
 676                     ; 277   FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NOPT);
 678  00a7 721f505c      	bres	20572,#7
 679                     ; 280   if(Address == 0x4800)
 681  00ab a34800        	cpw	x,#18432
 682  00ae 2603          	jrne	L762
 683                     ; 283     *((NEAR uint8_t*)Address) = FLASH_CLEAR_BYTE;
 685  00b0 7f            	clr	(x)
 687  00b1 2009          	jra	L172
 688  00b3               L762:
 689                     ; 288     *((NEAR uint8_t*)Address) = FLASH_CLEAR_BYTE;
 691  00b3 1e01          	ldw	x,(OFST+1,sp)
 692  00b5 7f            	clr	(x)
 693                     ; 289     *((NEAR uint8_t*)((uint16_t)(Address + (uint16_t)1 ))) = FLASH_SET_BYTE;
 695  00b6 1e01          	ldw	x,(OFST+1,sp)
 696  00b8 a6ff          	ld	a,#255
 697  00ba e701          	ld	(1,x),a
 698  00bc               L172:
 699                     ; 291   FLASH_WaitForLastOperation(FLASH_MEMTYPE_PROG);
 701  00bc a6fd          	ld	a,#253
 702  00be cd017d        	call	_FLASH_WaitForLastOperation
 704                     ; 294   FLASH->CR2 &= (uint8_t)(~FLASH_CR2_OPT);
 706  00c1 721f505b      	bres	20571,#7
 707                     ; 295   FLASH->NCR2 |= FLASH_NCR2_NOPT;
 709  00c5 721e505c      	bset	20572,#7
 710                     ; 296 }
 713  00c9 85            	popw	x
 714  00ca 81            	ret
 777                     ; 303 uint16_t FLASH_ReadOptionByte(uint16_t Address)
 777                     ; 304 {
 778                     	switch	.text
 779  00cb               _FLASH_ReadOptionByte:
 781  00cb 5204          	subw	sp,#4
 782       00000004      OFST:	set	4
 785                     ; 305   uint8_t value_optbyte, value_optbyte_complement = 0;
 787                     ; 306   uint16_t res_value = 0;
 789                     ; 309   assert_param(IS_OPTION_BYTE_ADDRESS_OK(Address));
 791                     ; 311   value_optbyte = *((NEAR uint8_t*)Address); /* Read option byte */
 793  00cd f6            	ld	a,(x)
 794  00ce 6b02          	ld	(OFST-2,sp),a
 795                     ; 312   value_optbyte_complement = *(((NEAR uint8_t*)Address) + 1); /* Read option byte complement */
 797  00d0 e601          	ld	a,(1,x)
 798  00d2 6b01          	ld	(OFST-3,sp),a
 799                     ; 315   if(Address == 0x4800)	 
 801  00d4 a34800        	cpw	x,#18432
 802  00d7 2608          	jrne	L523
 803                     ; 317     res_value =	 value_optbyte;
 805  00d9 7b02          	ld	a,(OFST-2,sp)
 806  00db 5f            	clrw	x
 807  00dc 97            	ld	xl,a
 808  00dd 1f03          	ldw	(OFST-1,sp),x
 810  00df 2023          	jra	L723
 811  00e1               L523:
 812                     ; 321     if(value_optbyte == (uint8_t)(~value_optbyte_complement))
 814  00e1 7b01          	ld	a,(OFST-3,sp)
 815  00e3 43            	cpl	a
 816  00e4 1102          	cp	a,(OFST-2,sp)
 817  00e6 2617          	jrne	L133
 818                     ; 323       res_value = (uint16_t)((uint16_t)value_optbyte << 8);
 820  00e8 7b02          	ld	a,(OFST-2,sp)
 821  00ea 5f            	clrw	x
 822  00eb 97            	ld	xl,a
 823  00ec 4f            	clr	a
 824  00ed 02            	rlwa	x,a
 825  00ee 1f03          	ldw	(OFST-1,sp),x
 826                     ; 324       res_value = res_value | (uint16_t)value_optbyte_complement;
 828  00f0 7b01          	ld	a,(OFST-3,sp)
 829  00f2 5f            	clrw	x
 830  00f3 97            	ld	xl,a
 831  00f4 01            	rrwa	x,a
 832  00f5 1a04          	or	a,(OFST+0,sp)
 833  00f7 01            	rrwa	x,a
 834  00f8 1a03          	or	a,(OFST-1,sp)
 835  00fa 01            	rrwa	x,a
 836  00fb 1f03          	ldw	(OFST-1,sp),x
 838  00fd 2005          	jra	L723
 839  00ff               L133:
 840                     ; 328       res_value = FLASH_OPTIONBYTE_ERROR;
 842  00ff ae5555        	ldw	x,#21845
 843  0102 1f03          	ldw	(OFST-1,sp),x
 844  0104               L723:
 845                     ; 331   return(res_value);
 847  0104 1e03          	ldw	x,(OFST-1,sp)
 850  0106 5b04          	addw	sp,#4
 851  0108 81            	ret
 925                     ; 340 void FLASH_SetLowPowerMode(FLASH_LPMode_TypeDef FLASH_LPMode)
 925                     ; 341 {
 926                     	switch	.text
 927  0109               _FLASH_SetLowPowerMode:
 929  0109 88            	push	a
 930       00000000      OFST:	set	0
 933                     ; 343   assert_param(IS_FLASH_LOW_POWER_MODE_OK(FLASH_LPMode));
 935                     ; 346   FLASH->CR1 &= (uint8_t)(~(FLASH_CR1_HALT | FLASH_CR1_AHALT)); 
 937  010a c6505a        	ld	a,20570
 938  010d a4f3          	and	a,#243
 939  010f c7505a        	ld	20570,a
 940                     ; 349   FLASH->CR1 |= (uint8_t)FLASH_LPMode; 
 942  0112 c6505a        	ld	a,20570
 943  0115 1a01          	or	a,(OFST+1,sp)
 944  0117 c7505a        	ld	20570,a
 945                     ; 350 }
 948  011a 84            	pop	a
 949  011b 81            	ret
1007                     ; 358 void FLASH_SetProgrammingTime(FLASH_ProgramTime_TypeDef FLASH_ProgTime)
1007                     ; 359 {
1008                     	switch	.text
1009  011c               _FLASH_SetProgrammingTime:
1013                     ; 361   assert_param(IS_FLASH_PROGRAM_TIME_OK(FLASH_ProgTime));
1015                     ; 363   FLASH->CR1 &= (uint8_t)(~FLASH_CR1_FIX);
1017  011c 7211505a      	bres	20570,#0
1018                     ; 364   FLASH->CR1 |= (uint8_t)FLASH_ProgTime;
1020  0120 ca505a        	or	a,20570
1021  0123 c7505a        	ld	20570,a
1022                     ; 365 }
1025  0126 81            	ret
1050                     ; 372 FLASH_LPMode_TypeDef FLASH_GetLowPowerMode(void)
1050                     ; 373 {
1051                     	switch	.text
1052  0127               _FLASH_GetLowPowerMode:
1056                     ; 374   return((FLASH_LPMode_TypeDef)(FLASH->CR1 & (uint8_t)(FLASH_CR1_HALT | FLASH_CR1_AHALT)));
1058  0127 c6505a        	ld	a,20570
1059  012a a40c          	and	a,#12
1062  012c 81            	ret
1087                     ; 382 FLASH_ProgramTime_TypeDef FLASH_GetProgrammingTime(void)
1087                     ; 383 {
1088                     	switch	.text
1089  012d               _FLASH_GetProgrammingTime:
1093                     ; 384   return((FLASH_ProgramTime_TypeDef)(FLASH->CR1 & FLASH_CR1_FIX));
1095  012d c6505a        	ld	a,20570
1096  0130 a401          	and	a,#1
1099  0132 81            	ret
1133                     ; 392 uint32_t FLASH_GetBootSize(void)
1133                     ; 393 {
1134                     	switch	.text
1135  0133               _FLASH_GetBootSize:
1137  0133 5204          	subw	sp,#4
1138       00000004      OFST:	set	4
1141                     ; 394   uint32_t temp = 0;
1143                     ; 397   temp = (uint32_t)((uint32_t)FLASH->FPR * (uint32_t)512);
1145  0135 c6505d        	ld	a,20573
1146  0138 5f            	clrw	x
1147  0139 97            	ld	xl,a
1148  013a 90ae0200      	ldw	y,#512
1149  013e cd0000        	call	c_umul
1151  0141 96            	ldw	x,sp
1152  0142 1c0001        	addw	x,#OFST-3
1153  0145 cd0000        	call	c_rtol
1155                     ; 400   if(FLASH->FPR == 0xFF)
1157  0148 c6505d        	ld	a,20573
1158  014b a1ff          	cp	a,#255
1159  014d 2611          	jrne	L354
1160                     ; 402     temp += 512;
1162  014f ae0200        	ldw	x,#512
1163  0152 bf02          	ldw	c_lreg+2,x
1164  0154 ae0000        	ldw	x,#0
1165  0157 bf00          	ldw	c_lreg,x
1166  0159 96            	ldw	x,sp
1167  015a 1c0001        	addw	x,#OFST-3
1168  015d cd0000        	call	c_lgadd
1170  0160               L354:
1171                     ; 406   return(temp);
1173  0160 96            	ldw	x,sp
1174  0161 1c0001        	addw	x,#OFST-3
1175  0164 cd0000        	call	c_ltor
1179  0167 5b04          	addw	sp,#4
1180  0169 81            	ret
1282                     ; 417 FlagStatus FLASH_GetFlagStatus(FLASH_Flag_TypeDef FLASH_FLAG)
1282                     ; 418 {
1283                     	switch	.text
1284  016a               _FLASH_GetFlagStatus:
1286  016a 88            	push	a
1287       00000001      OFST:	set	1
1290                     ; 419   FlagStatus status = RESET;
1292                     ; 421   assert_param(IS_FLASH_FLAGS_OK(FLASH_FLAG));
1294                     ; 424   if((FLASH->IAPSR & (uint8_t)FLASH_FLAG) != (uint8_t)RESET)
1296  016b c4505f        	and	a,20575
1297  016e 2706          	jreq	L325
1298                     ; 426     status = SET; /* FLASH_FLAG is set */
1300  0170 a601          	ld	a,#1
1301  0172 6b01          	ld	(OFST+0,sp),a
1303  0174 2002          	jra	L525
1304  0176               L325:
1305                     ; 430     status = RESET; /* FLASH_FLAG is reset*/
1307  0176 0f01          	clr	(OFST+0,sp)
1308  0178               L525:
1309                     ; 434   return status;
1311  0178 7b01          	ld	a,(OFST+0,sp)
1314  017a 5b01          	addw	sp,#1
1315  017c 81            	ret
1400                     ; 549 IN_RAM(FLASH_Status_TypeDef FLASH_WaitForLastOperation(FLASH_MemType_TypeDef FLASH_MemType)) 
1400                     ; 550 {
1401                     	switch	.text
1402  017d               _FLASH_WaitForLastOperation:
1404  017d 5203          	subw	sp,#3
1405       00000003      OFST:	set	3
1408                     ; 551   uint8_t flagstatus = 0x00;
1410  017f 0f03          	clr	(OFST+0,sp)
1411                     ; 552   uint16_t timeout = OPERATION_TIMEOUT;
1413  0181 aeffff        	ldw	x,#65535
1414  0184 1f01          	ldw	(OFST-2,sp),x
1416  0186 200e          	jra	L375
1417  0188               L765:
1418                     ; 578     flagstatus = (uint8_t)(FLASH->IAPSR & (FLASH_IAPSR_EOP | FLASH_IAPSR_WR_PG_DIS));
1420  0188 c6505f        	ld	a,20575
1421  018b a405          	and	a,#5
1422  018d 6b03          	ld	(OFST+0,sp),a
1423                     ; 579     timeout--;
1425  018f 1e01          	ldw	x,(OFST-2,sp)
1426  0191 1d0001        	subw	x,#1
1427  0194 1f01          	ldw	(OFST-2,sp),x
1428  0196               L375:
1429                     ; 576   while((flagstatus == 0x00) && (timeout != 0x00))
1431  0196 0d03          	tnz	(OFST+0,sp)
1432  0198 2604          	jrne	L775
1434  019a 1e01          	ldw	x,(OFST-2,sp)
1435  019c 26ea          	jrne	L765
1436  019e               L775:
1437                     ; 583   if(timeout == 0x00 )
1439  019e 1e01          	ldw	x,(OFST-2,sp)
1440  01a0 2604          	jrne	L106
1441                     ; 585     flagstatus = FLASH_STATUS_TIMEOUT;
1443  01a2 a602          	ld	a,#2
1444  01a4 6b03          	ld	(OFST+0,sp),a
1445  01a6               L106:
1446                     ; 588   return((FLASH_Status_TypeDef)flagstatus);
1448  01a6 7b03          	ld	a,(OFST+0,sp)
1451  01a8 5b03          	addw	sp,#3
1452  01aa 81            	ret
1515                     ; 598 IN_RAM(void FLASH_EraseBlock(uint16_t BlockNum, FLASH_MemType_TypeDef FLASH_MemType))
1515                     ; 599 {
1516                     	switch	.text
1517  01ab               _FLASH_EraseBlock:
1519  01ab 89            	pushw	x
1520  01ac 5206          	subw	sp,#6
1521       00000006      OFST:	set	6
1524                     ; 600   uint32_t startaddress = 0;
1526                     ; 610   assert_param(IS_MEMORY_TYPE_OK(FLASH_MemType));
1528                     ; 611   if(FLASH_MemType == FLASH_MEMTYPE_PROG)
1530  01ae 7b0b          	ld	a,(OFST+5,sp)
1531  01b0 a1fd          	cp	a,#253
1532  01b2 260c          	jrne	L536
1533                     ; 613     assert_param(IS_FLASH_PROG_BLOCK_NUMBER_OK(BlockNum));
1535                     ; 614     startaddress = FLASH_PROG_START_PHYSICAL_ADDRESS;
1537  01b4 ae8000        	ldw	x,#32768
1538  01b7 1f05          	ldw	(OFST-1,sp),x
1539  01b9 ae0000        	ldw	x,#0
1540  01bc 1f03          	ldw	(OFST-3,sp),x
1542  01be 200a          	jra	L736
1543  01c0               L536:
1544                     ; 618     assert_param(IS_FLASH_DATA_BLOCK_NUMBER_OK(BlockNum));
1546                     ; 619     startaddress = FLASH_DATA_START_PHYSICAL_ADDRESS;
1548  01c0 ae4000        	ldw	x,#16384
1549  01c3 1f05          	ldw	(OFST-1,sp),x
1550  01c5 ae0000        	ldw	x,#0
1551  01c8 1f03          	ldw	(OFST-3,sp),x
1552  01ca               L736:
1553                     ; 627     pwFlash = (PointerAttr uint32_t *)(MemoryAddressCast)(startaddress + ((uint32_t)BlockNum * FLASH_BLOCK_SIZE));
1555  01ca 1e07          	ldw	x,(OFST+1,sp)
1556  01cc a640          	ld	a,#64
1557  01ce cd0000        	call	c_cmulx
1559  01d1 96            	ldw	x,sp
1560  01d2 1c0003        	addw	x,#OFST-3
1561  01d5 cd0000        	call	c_ladd
1563  01d8 be02          	ldw	x,c_lreg+2
1564  01da 1f01          	ldw	(OFST-5,sp),x
1565                     ; 631   FLASH->CR2 |= FLASH_CR2_ERASE;
1567  01dc 721a505b      	bset	20571,#5
1568                     ; 632   FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NERASE);
1570  01e0 721b505c      	bres	20572,#5
1571                     ; 636     *pwFlash = (uint32_t)0;
1573  01e4 1e01          	ldw	x,(OFST-5,sp)
1574  01e6 a600          	ld	a,#0
1575  01e8 e703          	ld	(3,x),a
1576  01ea a600          	ld	a,#0
1577  01ec e702          	ld	(2,x),a
1578  01ee a600          	ld	a,#0
1579  01f0 e701          	ld	(1,x),a
1580  01f2 a600          	ld	a,#0
1581  01f4 f7            	ld	(x),a
1582                     ; 644 }
1585  01f5 5b08          	addw	sp,#8
1586  01f7 81            	ret
1690                     ; 655 IN_RAM(void FLASH_ProgramBlock(uint16_t BlockNum, FLASH_MemType_TypeDef FLASH_MemType, 
1690                     ; 656                         FLASH_ProgramMode_TypeDef FLASH_ProgMode, uint8_t *Buffer))
1690                     ; 657 {
1691                     	switch	.text
1692  01f8               _FLASH_ProgramBlock:
1694  01f8 89            	pushw	x
1695  01f9 5206          	subw	sp,#6
1696       00000006      OFST:	set	6
1699                     ; 658   uint16_t Count = 0;
1701                     ; 659   uint32_t startaddress = 0;
1703                     ; 662   assert_param(IS_MEMORY_TYPE_OK(FLASH_MemType));
1705                     ; 663   assert_param(IS_FLASH_PROGRAM_MODE_OK(FLASH_ProgMode));
1707                     ; 664   if(FLASH_MemType == FLASH_MEMTYPE_PROG)
1709  01fb 7b0b          	ld	a,(OFST+5,sp)
1710  01fd a1fd          	cp	a,#253
1711  01ff 260c          	jrne	L317
1712                     ; 666     assert_param(IS_FLASH_PROG_BLOCK_NUMBER_OK(BlockNum));
1714                     ; 667     startaddress = FLASH_PROG_START_PHYSICAL_ADDRESS;
1716  0201 ae8000        	ldw	x,#32768
1717  0204 1f03          	ldw	(OFST-3,sp),x
1718  0206 ae0000        	ldw	x,#0
1719  0209 1f01          	ldw	(OFST-5,sp),x
1721  020b 200a          	jra	L517
1722  020d               L317:
1723                     ; 671     assert_param(IS_FLASH_DATA_BLOCK_NUMBER_OK(BlockNum));
1725                     ; 672     startaddress = FLASH_DATA_START_PHYSICAL_ADDRESS;
1727  020d ae4000        	ldw	x,#16384
1728  0210 1f03          	ldw	(OFST-3,sp),x
1729  0212 ae0000        	ldw	x,#0
1730  0215 1f01          	ldw	(OFST-5,sp),x
1731  0217               L517:
1732                     ; 676   startaddress = startaddress + ((uint32_t)BlockNum * FLASH_BLOCK_SIZE);
1734  0217 1e07          	ldw	x,(OFST+1,sp)
1735  0219 a640          	ld	a,#64
1736  021b cd0000        	call	c_cmulx
1738  021e 96            	ldw	x,sp
1739  021f 1c0001        	addw	x,#OFST-5
1740  0222 cd0000        	call	c_lgadd
1742                     ; 679   if(FLASH_ProgMode == FLASH_PROGRAMMODE_STANDARD)
1744  0225 0d0c          	tnz	(OFST+6,sp)
1745  0227 260a          	jrne	L717
1746                     ; 682     FLASH->CR2 |= FLASH_CR2_PRG;
1748  0229 7210505b      	bset	20571,#0
1749                     ; 683     FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NPRG);
1751  022d 7211505c      	bres	20572,#0
1753  0231 2008          	jra	L127
1754  0233               L717:
1755                     ; 688     FLASH->CR2 |= FLASH_CR2_FPRG;
1757  0233 7218505b      	bset	20571,#4
1758                     ; 689     FLASH->NCR2 &= (uint8_t)(~FLASH_NCR2_NFPRG);
1760  0237 7219505c      	bres	20572,#4
1761  023b               L127:
1762                     ; 693   for(Count = 0; Count < FLASH_BLOCK_SIZE; Count++)
1764  023b 5f            	clrw	x
1765  023c 1f05          	ldw	(OFST-1,sp),x
1766  023e               L327:
1767                     ; 695     *((PointerAttr uint8_t*) (MemoryAddressCast)startaddress + Count) = ((uint8_t)(Buffer[Count]));
1769  023e 1e0d          	ldw	x,(OFST+7,sp)
1770  0240 72fb05        	addw	x,(OFST-1,sp)
1771  0243 f6            	ld	a,(x)
1772  0244 1e03          	ldw	x,(OFST-3,sp)
1773  0246 72fb05        	addw	x,(OFST-1,sp)
1774  0249 f7            	ld	(x),a
1775                     ; 693   for(Count = 0; Count < FLASH_BLOCK_SIZE; Count++)
1777  024a 1e05          	ldw	x,(OFST-1,sp)
1778  024c 1c0001        	addw	x,#1
1779  024f 1f05          	ldw	(OFST-1,sp),x
1782  0251 1e05          	ldw	x,(OFST-1,sp)
1783  0253 a30040        	cpw	x,#64
1784  0256 25e6          	jrult	L327
1785                     ; 697 }
1788  0258 5b08          	addw	sp,#8
1789  025a 81            	ret
1802                     	xdef	_FLASH_WaitForLastOperation
1803                     	xdef	_FLASH_ProgramBlock
1804                     	xdef	_FLASH_EraseBlock
1805                     	xdef	_FLASH_GetFlagStatus
1806                     	xdef	_FLASH_GetBootSize
1807                     	xdef	_FLASH_GetProgrammingTime
1808                     	xdef	_FLASH_GetLowPowerMode
1809                     	xdef	_FLASH_SetProgrammingTime
1810                     	xdef	_FLASH_SetLowPowerMode
1811                     	xdef	_FLASH_EraseOptionByte
1812                     	xdef	_FLASH_ProgramOptionByte
1813                     	xdef	_FLASH_ReadOptionByte
1814                     	xdef	_FLASH_ProgramWord
1815                     	xdef	_FLASH_ReadByte
1816                     	xdef	_FLASH_ProgramByte
1817                     	xdef	_FLASH_EraseByte
1818                     	xdef	_FLASH_ITConfig
1819                     	xdef	_FLASH_DeInit
1820                     	xdef	_FLASH_Lock
1821                     	xdef	_FLASH_Unlock
1822                     	xref.b	c_lreg
1823                     	xref.b	c_x
1824                     	xref.b	c_y
1843                     	xref	c_ladd
1844                     	xref	c_cmulx
1845                     	xref	c_ltor
1846                     	xref	c_lgadd
1847                     	xref	c_rtol
1848                     	xref	c_umul
1849                     	end
