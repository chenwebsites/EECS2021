addi x5,x0,7 ;use addi to put 7 in register x5, i.e. calculate x5=7
addi x5,x5,-8 ;subtract 8 from the value in x5, i.e. calculate x5=x5-8
slli x6,x5,2 ;calculate x6=x5*4
sub x5,x6,x5 ;calculate x5=x6-x5
lui x7,0x10 ;use the lui&addi method to load
addi x7,x7,0xff8 ; the value of 0xfff8 into x7
sub x8,x0,x7 ;calculate x8=-x7
srai x9,x8,1 ;calculate x9=x8/2 using signed arithmetic
ori x6,x6,0x00f ;set the 4 LSB (Least Significant Bits) of the x6 value to 1s (ones)