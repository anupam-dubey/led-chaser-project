#ifndef __STM8S_IT_H
#define __STM8S_IT_H
#include "stm8s.h"
@far @interrupt void TIM4_UPD_OVF_IRQHandler(void);
	
static volatile uint8_t _isr_count;
#endif
