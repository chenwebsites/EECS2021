s1: DC "n="
ld x18, s1(x0) ;saved register
lui sp, 0x200 ;initialize the sp
lp: ecall x10, x18, 5 ;input n in x12
beq x10, x0, end
jal x1, S
addi sp, sp, -8 ;push
fsd f10, 0(sp) ;push
beq x0, x0, lp
end: ebreak x0, x0, 0
c1: DF 1 ;1.0
S: fld f1, c1(x0) ;const 1.0
fsub.d f10, f1, f1 ;f10=0.0
addi x5, x0, 1 ;counter
addi x6, x0, 1 ;powers of 2
lp2: blt x10, x5, ret
fcvt.d.l f5, x6 ;long to double
fdiv.d f6, f1, f5 ;term
fadd.d f10, f10, f6 ;sum
addi x5, x5, 1 ;counter increase
slli x6, x6, 1 ;next power of 2
beq x0, x0, lp2
ret: jalr x0, 0(x1)