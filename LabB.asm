ORG 0x111000
src: DD 79, 21, -58, -12, -5, 242, 0 ;test sequence
lui x6, src>>12 ;x6=0x111000
ld x5, 0(x6) ;current min value
loop: ld x7, 0(x6) ;current value
beq x7, x0, swap ;0 marks the end
blt x5, x7, skip ;no min update
add x5, x0, x7 ;min update
add x8, x0, x6 ;min index update
skip: addi x6, x6, 8 ;next index
beq x0, x0, loop ;always taken
swap: ld x7, -8(x6) ;x7=last (just before the 0)
sd x7, 0(x8) ;min=x7 (last)
sd x5, -8(x6) ;last=min