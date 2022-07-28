#include "stm8s.h"
#include "stm8s_it.h"
#define NOT_A_PORT 0
#define TIM4_PERIOD 63
#define SOFTPWM_MAXCHANNELS 12
#define portOutputRegister(P) ( (volatile uint8_t *)( port_to_output[(P)]) )
/*
  PORTA 
	 A1 -LED 2
	 A2 -LED 3
	 A3 -LED 12
  PORTB 
	Not used
	PORTC
	 C3 -LED 11
	 C4 -LED 10
	 C5 -LED  9
	 C6 -LED  8
	 C7 -LED  7
	 
	PORTD
   D1 -LED 6
	 D2 -LED 5
   D3 -LED 4
   D4 -LED 1 
   D5 -tx
   D6 -rx	 
	 void GPIO_Write(GPIO_TypeDef* GPIOx, uint8_t PortVal)
{
  GPIOx->ODR = PortVal;
}


*/

static volatile uint8_t _isr_count;


static volatile uint8_t _softpwm_channels[SOFTPWM_MAXCHANNELS];

static void CLK_Config(void); 
void GPIO_setup(void);
void SoftPWMBegin(void);
static void TIM4_Config(void);

void main (void)
{   int i,j,temp;

		GPIO_setup();
		TIM4_Config();
		SoftPWMBegin();
	 ITC_SetSoftwarePriority(ITC_IRQ_TIM4_OVF,ITC_PRIORITYLEVEL_1);
	 _isr_count=0xff;
   enableInterrupts(); 
    
		for(;;) 
		{
			
	//	disableInterrupts(); 	
	 /* for(i=0;i<(SOFTPWM_MAXCHANNELS-1);i++)
		{
			_softpwm_channels[i]=_softpwm_channels[i+1];
    }	_softpwm_channels[11]=_softpwm_channels[0];*/
		//_softpwm_channels[0]=0;
	/*	temp=_softpwm_channels[11];
		for(i=11;i>=0;i--)
		{
			_softpwm_channels[i]=_softpwm_channels[i-1];
    }	_softpwm_channels[0]=temp;
		enableInterrupts(); 
		delay_ms(20);*/
	}
}


void GPIO_setup()
{
	//PORTA
	GPIOA->DDR  = 0x0E; //not used
	GPIOA->CR1 |= 0x0E; //pullup
	GPIOA->CR2 |= 0x0E; //no interrupts
	//PORTB 
	GPIOB->DDR  = 0x00; //
	GPIOB->CR1 |= 0x00; //
	GPIOB->CR2 |= 0x00; //no interrupt
	//PORTC
	GPIOC->DDR  = 0xF8; //3,4,5,6,7
	GPIOC->CR1 |= 0xF8; //high/fast 
	GPIOC->CR2 |= 0xF8; //fast outputno interrupt
	//PORTD
	GPIOD->DDR  = 0x1E; //D.1 D.2 D.3 D.4  outputs
	GPIOD->CR1 |= 0x1E; //high/fast 
	GPIOD->CR2 |= 0x1E; //high fast 10Mhz 
	
	GPIOA->ODR = 0x00;
	GPIOD->ODR = 0x00;
	GPIOC->ODR = 0x00;
}	
static void CLK_Config(void)
{
   
		CLK_DeInit();
	
	CLK_HSECmd(DISABLE);
	CLK_LSICmd(DISABLE);
	CLK_HSICmd(ENABLE);
	while(CLK_GetFlagStatus(CLK_FLAG_HSIRDY) == FALSE);
	
	CLK_ClockSwitchCmd(ENABLE);
	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1);
	CLK_SYSCLKConfig(CLK_PRESCALER_CPUDIV1);
	
	CLK_ClockSwitchConfig(CLK_SWITCHMODE_AUTO, CLK_SOURCE_HSI, 
	DISABLE, CLK_CURRENTCLOCKSTATE_ENABLE);
	
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, DISABLE);
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_SPI, DISABLE);
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_UART1, ENABLE);
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_AWU, DISABLE);
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_ADC, DISABLE);
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER1, DISABLE);
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER2, DISABLE);
	CLK_PeripheralClockConfig(CLK_PERIPHERAL_TIMER4, ENABLE);
}

void SoftPWMBegin(void)
{ //porta=1 portb=2,portc=3,portd=4
	//led1
	/*
	_softpwm_channels[0].portname=4;
	_softpwm_channels[0].pinmask=(1<<4);
	_softpwm_channels[0].pwmvalue=10;
	//led2
	_softpwm_channels[1].portname=1;
	_softpwm_channels[1].pinmask=(1<<1);
	_softpwm_channels[1].pwmvalue=20;
	//led3
	_softpwm_channels[2].portname=1;
	_softpwm_channels[2].pinmask=(1<<2);
	_softpwm_channels[2].pwmvalue=30;
	//led4
	_softpwm_channels[3].portname=4;
	_softpwm_channels[3].pinmask=(1<<3);
	_softpwm_channels[3].pwmvalue=40;
	//led5
	_softpwm_channels[4].portname=4;
	_softpwm_channels[4].pinmask=(1<<2);
	_softpwm_channels[4].pwmvalue=50;
	//led6
	_softpwm_channels[5].portname=4;
	_softpwm_channels[5].pinmask=(1<<1);
	_softpwm_channels[5].pwmvalue=60;
	//led7 PC7
	_softpwm_channels[6].portname=3;
	_softpwm_channels[6].pinmask=(1<<7);
	_softpwm_channels[6].pwmvalue=70;
	//led8 PC6
	_softpwm_channels[7].portname=3;
	_softpwm_channels[7].pinmask=(1<<6);
	_softpwm_channels[7].pwmvalue=80;
	//led9 PC5
	_softpwm_channels[8].portname=3;
	_softpwm_channels[8].pinmask=(1<<5);
	_softpwm_channels[8].pwmvalue=90;
	//led10 PC4
	_softpwm_channels[9].portname=3;
	_softpwm_channels[9].pinmask=(1<<4);
	_softpwm_channels[9].pwmvalue=100;
	//led11 PC3
	_softpwm_channels[10].portname=3;
	_softpwm_channels[10].pinmask=(1<<3);
	_softpwm_channels[10].pwmvalue=200;
	//led12 PA3
	_softpwm_channels[11].portname=1;
	_softpwm_channels[11].pinmask=(1<<3);
	_softpwm_channels[11].pwmvalue=255;
	*/
	_softpwm_channels[0]=0;
	_softpwm_channels[1]=102;
	_softpwm_channels[2]=110;
	_softpwm_channels[3]=120;
	_softpwm_channels[4]=150;
	_softpwm_channels[5]=180;
	_softpwm_channels[6]=200;
	_softpwm_channels[7]=220;
	_softpwm_channels[8]=240;
	_softpwm_channels[9]=245;
	_softpwm_channels[10]=250;
	_softpwm_channels[11]=255;
}	



static void TIM4_Config(void)
{
  /* TIM4 configuration:
   - TIM4CLK is set to 16 MHz, the TIM4 Prescaler is equal to 16 so the TIM4 counter
   clock used is 16 MHz / 2 = 8000 000 Hz
  - With 8000 000 Hz we can generate time base:
      max time base is 32us  if TIM4_PERIOD = 255 --> (255 + 1) / 1000000 = 32 us
      min time base is 2 us if TIM4_PERIOD = 1   --> (  1 + 1) / 1000000 = 0.25 us
  - In this example we need to generate a time base equal to 256 us
   so TIM4_PERIOD = (0.001 * 125000 - 1) = 124 */

  /* Time base configuration */
  TIM4_TimeBaseInit(TIM4_PRESCALER_2, TIM4_PERIOD);
  /* Clear TIM4 update flag */
  TIM4_ClearFlag(TIM4_FLAG_UPDATE);
  /* Enable update interrupt */
  TIM4_ITConfig(TIM4_IT_UPDATE, ENABLE);
  
  /* enable interrupts */
 // enableInterrupts();

  /* Enable TIM4 */
  TIM4_Cmd(ENABLE);
}
void TIM4_UPD_OVF_IRQHandler(void)// RC5 pulse wirdth
 {  static volatile uint8_t i;
	
	//TIM4_Cmd(DISABLE);      limits 102----255
	//if(_isr_count>=63)   //max=153 pulse on i.e=102    ...102....|----153----|
	//_isr_count=0;        //min=0 pulse on i.e=0    ........................|
  ++_isr_count; 
 if(_isr_count==0)
	{
	 
	   GPIOA->ODR &= ~(0x0E);
		 GPIOC->ODR &= ~(0xF8);
		 GPIOD->ODR &= ~(0x1E); 
	  
	}
	else
   {	
	
	 if (_softpwm_channels[0] == _isr_count)  // if we have hit the width
      {
			GPIOD->ODR|=(uint8_t)(1<<4);//PD4	
			}	
	 if (_softpwm_channels[1] == _isr_count)  // if we have hit the width
      {
			GPIOA->ODR|=(uint8_t)(1<<1);//PA1	
					}		
   if (_softpwm_channels[2] == _isr_count)  // if we have hit the width
      {
			GPIOA->ODR|=(uint8_t)(1<<2);//PA2	
					}	
	 if (_softpwm_channels[3] == _isr_count)  // if we have hit the width
      {
				GPIOD->ODR|=(uint8_t)(1<<3);//PD3	
					}		
   if (_softpwm_channels[4] == _isr_count)  // if we have hit the width
      {
			GPIOD->ODR|=(uint8_t)(1<<2);//PD2	
					}	
	 if (_softpwm_channels[5] == _isr_count)  // if we have hit the width
      {
			GPIOD->ODR|=(uint8_t)(1<<1);//PD1	
					}					
	 if (_softpwm_channels[6] == _isr_count)  // if we have hit the width
      {
				GPIOC->ODR|=(uint8_t)(1<<7);//PC7	
					}							
		
	 if (_softpwm_channels[7] == _isr_count)  // if we have hit the width
      {
					GPIOC->ODR|=(uint8_t)(1<<6);//PC6	
					}	
	 if (_softpwm_channels[8] == _isr_count)  // if we have hit the width
      {
				 GPIOC->ODR|=(uint8_t)(1<<5);//PC5
					}		
   if (_softpwm_channels[9] == _isr_count)  // if we have hit the width
      {
				 GPIOC->ODR|=(uint8_t)(1<<4);//PC4
					}	
	 if (_softpwm_channels[10] == _isr_count)  // if we have hit the width
      {
				GPIOC->ODR|=(uint8_t)(1<<3);//PC3
					}		
   if (_softpwm_channels[11] == _isr_count)  // if we have hit the width
      {
				GPIOA->ODR|=(uint8_t)(1<<3);//PA3
					}	
	 }
 
	
	//TIM4_Cmd(ENABLE);
	 /* Cleat Interrupt Pending bit */
  TIM4_ClearITPendingBit(TIM4_IT_UPDATE);

	 
 }
 
 
 
 