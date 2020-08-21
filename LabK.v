
/***************************************
* f= ~(~a~b~c)~c+~(~a~b~c)d
* f= b~c + a~c + cd
****************************************/
module bfg(f, a, b, c, d); //boolean function with gates
input a, b, c, d; // Inputs 1-bit wide
output f; // Outputs 1-bit wide
wire s1, s2, s3, s4; // Wires
// Structural Description
not(na, a); //~a
not(nb, b); //~b
not(nc, c); //~c
and(s1, na, nb, nc); //~a~b~c
not(s2, s1); //~(~a~b~c)
and(s3, s2, nc); //~(~a~b~c)~c
and(s4, s2, d); //~(~a~b~c)d
or(f, s3, s4); //~(~a~b~c)~c+~(~a~b~c)d
endmodule
module bfa(f, a, b, c, d); //boolean function with assign
input a, b, c, d; // Inputs 1-bit wide
output f; // Outputs 1-bit wide
// Functional Description
assign f = ~(~a&~b&~c)&~c|~(~a&~b&~c)&d;
endmodule
module tester;
// Test registers
reg a, b, c, d;
// Test ports
wire fa, fg;
// Instantiate bf for testing
bfg tfg(fg, a, b, c, d);
bfa tfa(fa, a, b, c, d);
integer ia, ib, ic, id; // Integers for loop
initial begin
$display("a b c d fg fa oracle");
for (ia = 0; ia <2; ia = ia + 1)
for (ib = 0; ib <2; ib = ib + 1)
for (ic = 0; ic <2; ic = ic + 1)
for (id = 0; id <2; id = id + 1) begin
a = ia; b = ib; c = ic; d = id;

if (fg === fa)
#1 $display("%b %b %b %d %d %d
PASS", a, b, c, d, fg, fa);
else
#1 $display("%b %b %b %d %d %d
FAIL", a, b, c, d, fg, fa);
end
end
endmodule