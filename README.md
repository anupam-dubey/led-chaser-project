# STM8S based ws2812 drive with relay for PLC
<img src="./1.jpg" width=300 />
<img src="./2.jpg" width=200 />   

### Details
Uses popular stm8s with arduino as IDE.
It also contain CAD for altium

### state machine
```c
State machine     description
 
 0                 all led's blue
 1                 input A  GND  incremental green (filler action) in color 1-20 leds 7 leds green and 7 leds red (relay group 1&2 NC)//latched action
 2                 IN 24 GND   all led's blue ( relay group 1&2 NO )
 3                 input B  GND  decremental green (filler action) in color 1-20 leds 7 leds red and 7 leds green (relay group 3&4 NC)//latched action
 4                 IN 24 GND   all led's blue ( relay group 3&4 NO )
```
FInal Codes new update/final for all types     
For cascaded boards new update/newfinal_v3      
Final CAD is in new update altium     
