s1: DC "Enter i>0:\0"
s1: DC "Enter i>0:\0"
s2: DC "Square Root:\0"
addi x5, x0, s1
ecall x1, x5, 4 ;prompt i
ecall x6, x0, 5 ;inp i
addi x5, x0, s2
fcvt.d.l f6, x6 ;long to double
fsqrt.d f7, f6 ;f7=sqrt(f6)
ecall x1, x5, 4 ;out recip
ecall x0, f7, 1 ;out recip value
add x7, x0, x6
addi x9, x0, 0
loop: rem x8, x6, x7
bne x8, x0, skip
sd x7, st(x9) ;store in memory
addi x9, x9, 8 ;double word
skip: addi x7, x7, -1
blt x0, x7, loop
st: ORG 0x300